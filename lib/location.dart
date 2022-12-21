import 'package:geolocator/geolocator.dart';

class LocationSrvc {
  static LocationSrvcStatus _status = LocationSrvcStatus.unknown;
  static LocationPermission? _perms = LocationPermission.denied;
  static bool _geoLocationEnabled = false;
  static bool isNotLinux = false;

  //run in initstate of the app
  static Future<LocationSrvcStatus> get initStatus async {
    _perms = await Geolocator.checkPermission();
    _geoLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_geoLocationEnabled) {
      _status = LocationSrvcStatus.disabled;
    } else if (_perms != LocationPermission.denied) {
      _status = LocationSrvcStatus.denied;
    } else if (_perms != LocationPermission.deniedForever) {
      _status = LocationSrvcStatus.deniedForever;
    } else {
      _status = LocationSrvcStatus.enabled;
    }
    return _status;
  }

  static Future<LocationSrvcStatus> getPerms() async {
    if (_status == LocationSrvcStatus.denied) {
      _perms = await Geolocator.requestPermission();
      if (_perms == LocationPermission.deniedForever) {
        _status = LocationSrvcStatus.deniedForever;
      } else if (_perms == LocationPermission.denied) {
        _status = LocationSrvcStatus.denied;
      } else {
        _status = LocationSrvcStatus.enabled;
      }
    }
    return _status;
  }

  static LocationSrvcStatus get status {
    return _status;
  }

  static Future<Position> get currentPos async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
  }
}

enum LocationSrvcStatus { enabled, disabled, denied, deniedForever, unknown }
