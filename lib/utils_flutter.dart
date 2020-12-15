import 'package:flutter_hms_gms_availability/flutter_hms_gms_availability.dart';

class Utils {
  static Future<bool> checkHms() async {
    final iHms = await FlutterHmsGmsAvailability.isHmsAvailable;
    return iHms;
  }

  static Future<bool> checkGms() async {
    final isGms = await FlutterHmsGmsAvailability.isGmsAvailable;
    return isGms;
  }
}
