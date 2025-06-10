// import 'package:permission_handler/permission_handler.dart';

// class PermissionService {
//   static void requestLiberyPermisson() async {
//     print('requestPermisson');
//     if (await Permission.mediaLibrary.isDenied &&
//         !await Permission.mediaLibrary.isPermanentlyDenied) {
//       await [Permission.mediaLibrary].request();
//     }
//   }

//   static void requestCameraPermisson() async {
//     print('requestPermisson');
//     if (await Permission.camera.isDenied &&
//         !await Permission.camera.isPermanentlyDenied) {
//       await [Permission.camera].request();
//     }
//   }

//   static Future<bool> permissionWithNotification() async {
//     await [Permission.notification].request();

//     if (await Permission.notification.isDenied &&
//         !await Permission.notification.isPermanentlyDenied) {
//       await [Permission.notification].request();
//     }

//     return !await Permission.notification.isDenied;
//   }
// }
