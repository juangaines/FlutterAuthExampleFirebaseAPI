import 'package:huawei_location/permission/permission_handler.dart';

class PermissionServicesImpl {
  PermissionHandler _permissionHandler = PermissionHandler();

  Future<bool> hasLocationPermission() async {
    return _permissionHandler.hasLocationPermission();
  }

  Future<bool> requestLocationPermission() async {
    return _permissionHandler.requestLocationPermission();
  }
}
