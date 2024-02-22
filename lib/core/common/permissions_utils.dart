import 'package:permission_handler/permission_handler.dart';

Future<PermissionStatus> requestCameraPermission() async {
  bool isGranted = await Permission.camera.isGranted;
  if (!isGranted) {
    return await Permission.camera.request();
  }
  return PermissionStatus.granted;
}

Future<PermissionStatus> requestPhotosPermission() async {
  if (!await Permission.photos.isGranted) {
    return await Permission.photos.request();
  }
  return PermissionStatus.granted;
}

Future<PermissionStatus> requestStoragePermission() async {
  if (!await Permission.storage.isGranted) {
    return await Permission.storage.request();
  }
  return PermissionStatus.granted;
}


Future<PermissionStatus> requestStepPermission() async {
  if (!await Permission.activityRecognition.status.isGranted) {
    await Permission.activityRecognition.request();
  }
  return Permission.activityRecognition.status;
}
Future<dynamic> requestStepPermissionForIOS() async {
  if (!await Permission.sensors.status.isGranted) {
    await Permission.sensors.request();
  }
  return Permission.sensors.status;
}
