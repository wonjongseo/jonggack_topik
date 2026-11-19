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
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  bool _initialized = false;
  bool _initializing = false;

  /// The productId for premium upgrade
  static const String premiumProductId = 'premium_upgrade';

  /// Available products fetched from the store
  List<ProductDetails> products = [];

  /// Current purchase details
  List<PurchaseDetails> purchases = [];

  /// Initialize: listen to purchase updates, app lifecycle, and restore purchases
  Future<void> init() async {
    if (_initialized || _initializing) return;
    _initializing = true;
    LogManager.info('InAppPurchaseService Init');
    try {
      WidgetsBinding.instance.addObserver(this);
      _subscription = _iap.purchaseStream.listen(
        _onPurchaseUpdated,
        onDone: () => _subscription?.cancel(),
        onError: (Object e, StackTrace stack) {
          LogManager.error('IAP stream error: $e');
        },
      );
      _initialized = true;
      await restorePurchases();
    } finally {
      _initializing = false;
    }
  }

  /// Dispose: remove observer and cancel subscription
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _subscription?.cancel();
    _subscription = null;
    _initialized = false;
  }

  /// Fetch product details
  Future<void> fetchProducts() async {
    if (!await _iap.isAvailable()) {
      LogManager.error('IAP store is unavailable');
      products = [];
      return;
    }

    try {
      final response = await _iap.queryProductDetails({premiumProductId});
      if (response.error != null) {
        LogManager.error('Product query error: ${response.error}');
      }
      if (response.notFoundIDs.contains(premiumProductId)) {
        LogManager.error('IAP product not found: $premiumProductId');
      }
      products = response.productDetails;
    } catch (e) {
      LogManager.error('Product query failed: $e');
      products = [];
    }
  }

  /// Buy non-consumable premium product
  Future<bool> buyPremium() async {
    if (products.isEmpty) await fetchProducts();
    final matchingProducts = products.where((p) => p.id == premiumProductId);
    if (matchingProducts.isEmpty) {
      LogManager.error('Premium product is unavailable');
      return false;
    }
    final product = matchingProducts.first;
    try {
      return await _iap.buyNonConsumable(
        purchaseParam: PurchaseParam(productDetails: product),
      );
    } on PlatformException catch (e) {
      if (_isPurchaseCancelled(e.code)) {
        LogManager.info('User cancelled purchase');
        return false;
      }
      LogManager.error('Purchase failed: ${e.code}, ${e.message}');
      rethrow;
    }
  }

  bool _isPurchaseCancelled(String code) {
    return code == 'userCancelled' ||
        code == 'storekit2_purchase_cancelled' ||
        code == 'storekit_purchase_cancelled' ||
        code == 'SKErrorPaymentCancelled';
  }

  /// Restore purchases
  Future<void> restorePurchases() async {
    try {
      if (await _iap.isAvailable()) {
        await _iap.restorePurchases();
      }
    } catch (e) {
      LogManager.error('Restore purchases failed: $e');
    }
  }

  /// Handle app lifecycle changes
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // On resume, refresh the store state.
      unawaited(restorePurchases());
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
    }

    // complete all pending purchases
    for (final purchase in detailsList) {
      if (purchase.pendingCompletePurchase) {
        try {
          await _iap.completePurchase(purchase);
        } catch (e) {
          LogManager.error('Complete purchase failed: $e');
        }
      }
    }
  }
}
