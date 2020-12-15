import 'package:firebase_api_example_auth/services/location_service.dart';
import 'package:firebase_api_example_auth/utils_flutter.dart';
import 'package:flutter/material.dart';
import 'package:huawei_location/location/location.dart';
import 'package:huawei_map/map.dart';

class MapRoute extends StatefulWidget {
  MapRoute({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyMapPageState createState() => _MyMapPageState();
}

class _MyMapPageState extends State<MapRoute> {
  bool _isHms;
  HuaweiMapController _mapController;
  LocationServicesImpl _locationServicesImpl;
  Location location;
  void _getHmsOrGms() async {
    _isHms = await Utils.checkHms();

    if (_isHms) {
      _locationServicesImpl = LocationServicesImpl();
      var l = await _locationServicesImpl.getLocation();
      setState(() {
        location = l;
        var cameraUpdate = CameraUpdate.newLatLng(
            LatLng(location.latitude, location.longitude));
        this._mapController.moveCamera(cameraUpdate);
      });
    }
  }

  @override
  void initState() {
    _getHmsOrGms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
      ),
      body: Center(
          child: HuaweiMap(
        mapType: MapType.normal,
        onMapCreated: (_mapController) {
          this._mapController = _mapController;
        },
        tiltGesturesEnabled: true,
        buildingsEnabled: true,
        compassEnabled: true,
        zoomControlsEnabled: true,
        rotateGesturesEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        trafficEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(location?.latitude ?? 0, location?.longitude ?? 0),
          zoom: 12,
        ),
      )),
    );
  }
}
