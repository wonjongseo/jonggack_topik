import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:jonggack_topik/core/logger/logger_service.dart';
import 'package:jonggack_topik/features/auth/controllers/user_controller.dart';

/// Service to handle In-App Purchase logic and auto-revoke on logout
class InAppPurchaseService with WidgetsBindingObserver {
  InAppPurchaseService._internal();
  static final InAppPurchaseService instance = InAppPurchaseService._internal();

  final InAppPurchase _iap = InAppPurchase.instance;
  late final StreamSubscription<List<PurchaseDetails>> _subscription;

  /// The productId for premium upgrade
  static const String premiumProductId = 'premium_upgrade';

  /// Available products fetched from the store
  List<ProductDetails> products = [];

  /// Current purchase details
  List<PurchaseDetails> purchases = [];

  /// Initialize: listen to purchase updates, app lifecycle, and restore purchases
  Future<void> init() async {
    LogManager.info('InAppPurchaseService Init');
    WidgetsBinding.instance.addObserver(this);
    _subscription = _iap.purchaseStream.listen(
      _onPurchaseUpdated,
      onDone: () => _subscription.cancel(),
      onError: (e) => debugPrint('IAP Stream error: $e'),
    );
    // await restorePurchases();

    await restorePurchases();
  }

  /// Dispose: remove observer and cancel subscription
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _subscription.cancel();
  }

  /// Fetch product details
  Future<void> fetchProducts() async {
    final response = await _iap.queryProductDetails({premiumProductId});
    if (response.error != null)
      debugPrint('Product query error: ${response.error}');
    products = response.productDetails;
  }

  /// Buy non-consumable premium product
  Future<bool> buyPremium() async {
    if (products.isEmpty) await fetchProducts();
    final product = products.firstWhere((p) => p.id == premiumProductId);
    try {
      return await _iap.buyNonConsumable(
        purchaseParam: PurchaseParam(productDetails: product),
      );
    } on PlatformException catch (e) {
      if (e.code == 'userCancelled') {
        LogManager.info('User cancelled purchase');
        return false;
      }
      LogManager.error('Purchase failed: ${e.code}, ${e.message}');
      rethrow;
    }
  }

  /// Restore purchases
  Future<void> restorePurchases() async {
    await _iap.restorePurchases();
  }

  /// Handle app lifecycle changes
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // On resume, refresh purchases to detect logout and revokes
      restorePurchases();
    }
    super.didChangeAppLifecycleState(state);
  }

  /// Handle purchase updates
  void _onPurchaseUpdated(List<PurchaseDetails> detailsList) async {
    purchases = detailsList;

    // Only consider this productId
    final hasPremiumPurchase = purchases.any(
      (p) =>
          p.productID == premiumProductId &&
          (p.status == PurchaseStatus.purchased ||
              p.status == PurchaseStatus.restored),
    );

    if (hasPremiumPurchase) {
      UserController.to.grantPremiumToUser();
      debugPrint('Premium granted');
    } else {
      UserController.to.revokePremiumFromUser();
      debugPrint('Premium revoked');
    }

    // complete all pending purchases
    for (final purchase in detailsList) {
      if (purchase.pendingCompletePurchase) {
        await _iap.completePurchase(purchase);
      }
    }
  }
}
