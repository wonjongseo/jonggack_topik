import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class BugReportPage extends StatefulWidget {
  @override
  _BugReportPageState createState() => _BugReportPageState();
}

class _BugReportPageState extends State<BugReportPage> {
  String _appInfo = '';
  String _deviceInfo = '';

  @override
  void initState() {
    super.initState();
    _collectDeviceData();
  }

  Future<void> _collectDeviceData() async {
    final pkg = await PackageInfo.fromPlatform();
    final appInfo = '앱 버전: ${pkg.version} (build ${pkg.buildNumber})';

    // 2) 디바이스 정보 가져오기
    final di = DeviceInfoPlugin();
    String deviceInfo;
    if (Theme.of(context).platform == TargetPlatform.android) {
      final info = await di.androidInfo;
      deviceInfo =
          '기기: ${info.manufacturer} ${info.model}\nOS: Android ${info.version.release}';
    } else {
      final info = await di.iosInfo;
      deviceInfo =
          '기기: ${info.name} ${info.model}\nOS: iOS ${info.systemVersion}';
    }

    setState(() {
      _appInfo = appInfo;
      _deviceInfo = deviceInfo;
    });
  }

  Future<void> _sendBugReport() async {
    final subject = Uri.encodeComponent('【버그 제보】앱 오류 보고');
    final body = Uri.encodeComponent('''
안녕하세요.

발생한 문제를 아래에 간단히 적어주세요:


---

$_appInfo
$_deviceInfo
''');
    final mailto =
        'mailto:visionwill3322@gmail.com?subject=$subject&body=$body';

    if (await canLaunchUrl(Uri.parse(mailto))) {
      await launchUrl(Uri.parse(mailto));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('메일 앱을 열 수 없습니다.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('버그 제보')),
      body: Center(
        child: ElevatedButton(
          onPressed: _sendBugReport,
          child: Text('메일로 버그 제보하기'),
        ),
      ),
    );
  }
}
