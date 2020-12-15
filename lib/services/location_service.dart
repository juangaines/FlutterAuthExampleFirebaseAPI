import 'package:firebase_api_example_auth/services/permission_services_location.dart';
import 'package:huawei_location/location/fused_location_provider_client.dart';
import 'package:huawei_location/location/hwlocation.dart';
import 'package:huawei_location/location/location.dart';
import 'package:huawei_location/location/location_request.dart';

class LocationServicesImpl {
  FusedLocationProviderClient locationService = FusedLocationProviderClient();
  PermissionServicesImpl _permissionServices = PermissionServicesImpl();

  Future<Location> getLocation() async {
    if (await _permissionServices.hasLocationPermission()) {
      FusedLocationProviderClient locationService =
          FusedLocationProviderClient();

      LocationRequest locationRequest = LocationRequest();
      final hwLocation = locationService.getLastLocation();
      return hwLocation;
    } else {
      try {
        bool status = await _permissionServices.requestLocationPermission();
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
