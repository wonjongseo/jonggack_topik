import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_dialog.dart';
import 'package:jonggack_topik/core/utils/app_function.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportService {
  static const _supportEmail = 'visionwill3322@gmail.com';
  static String _appInfo = '';
  static String _deviceInfo = '';

  /// 앱·디바이스 정보 초기화 및 보고서 전송을 한번에 수행
  static Future<void> report(BuildContext context) async {
    await init();
    await sendReport(context);
  }

  /// 앱 버전 및 디바이스 정보 로드
  static Future<void> init() async {
    await Future.wait([_loadAppInfo(), _loadDeviceInfo()]);
  }

  static Future<void> _loadAppInfo() async {
    final pkg = await PackageInfo.fromPlatform();
    _appInfo = 'App Version: ${pkg.version} (build ${pkg.buildNumber})';
  }

  static Future<void> _loadDeviceInfo() async {
    final plugin = DeviceInfoPlugin();

    if (GetPlatform.isAndroid) {
      final info = await plugin.androidInfo;
      _deviceInfo =
          'Device: ${info.manufacturer} ${info.model}\n'
          'OS: Android ${info.version.release}';
    } else {
      final info = await plugin.iosInfo;
      _deviceInfo =
          'Device: ${info.name} ${info.model}\n'
          'OS: iOS ${info.systemVersion}';
    }
  }

  /// 이메일 앱을 통해 보고서 전송
  static Future<void> sendReport(BuildContext context) async {
    final email = Email(
      body: _composeBody(),
      subject: _subject,
      recipients: [_supportEmail],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } on PlatformException catch (e) {
      if (e.code == 'not_available') _handleEmailNotAvailable();
    }
  }

  static Future<void> _handleEmailNotAvailable() async {
    final fallback = await _launchFallback();
    if (!fallback) {
      final copy = await AppDialog.errorNoEnrolledEmail();
      if (copy) AppFunction.copyWord(_supportEmail);
    }
  }

  static Future<bool> _launchFallback() async {
    final uri = Uri(
      scheme: 'mailto',
      path: _supportEmail,
      queryParameters: {'subject': _subject, 'body': _composeBody()},
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
      return true;
    }
    return false;
  }

  static String get _subject =>
      '[${AppString.appName.tr}] ${AppString.fnOrErorreport.tr}';
  static String _composeBody() => '''${AppString.reportMsgContect.tr}

---
$_appInfo
$_deviceInfo
''';
}
