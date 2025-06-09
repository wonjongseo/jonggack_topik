import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  void requestLiberyPermisson() async {
    print('requestPermisson');
    if (await Permission.mediaLibrary.isDenied &&
        !await Permission.mediaLibrary.isPermanentlyDenied) {
      await [Permission.mediaLibrary].request();
    }
  }

  void requestCameraPermisson() async {
    print('requestPermisson');
    if (await Permission.camera.isDenied &&
        !await Permission.camera.isPermanentlyDenied) {
      await [Permission.camera].request();
    }
  }

  void permissionWithNotification() async {
    print('permissionWithNotification');
    if (await Permission.notification.isDenied &&
        !await Permission.notification.isPermanentlyDenied) {
      await [Permission.notification].request();
    }
  }
}
