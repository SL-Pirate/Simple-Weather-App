import 'package:geolocator/geolocator.dart';

class LocationSrvc {
  static bool _status = false;
  static LocationPermission? _perms = LocationPermission.denied;
  static bool _geoLocationEnabled = false;
  static bool isNotLinux = false;

  //run in initstate of the app
  static Future<bool> get initStatus async {
//    _perms = await Geolocator.checkPermission();
    _geoLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (_geoLocationEnabled) {
      _perms = await Geolocator.checkPermission();
      if (_perms == LocationPermission.always ||
          _perms == LocationPermission.whileInUse) {
        _status = true;
        return _status;
      } else {
        _status = false;
        return _status;
      }
    } else {
      _status = false;
      return _status;
    }
  }

  static Future<bool> getPerms() async {
    _perms = await perms;
    if (await Geolocator.isLocationServiceEnabled()) {
      if (_perms != LocationPermission.always ||
          _perms != LocationPermission.whileInUse) {
        _perms = await Geolocator.requestPermission();
      }
      if (_perms == LocationPermission.always ||
          _perms == LocationPermission.whileInUse) {
        _status = true;
        return _status;
      } else {
        _status = false;
        return _status;
      }
    } else {
      _status = false;
      return _status;
    }
  }

  static Future<LocationPermission> get perms async {
    return Geolocator.checkPermission();
  }

  static bool get status {
    return _status;
  }

  static Future<bool> get geoLocationEnabled async{
    return Geolocator.isLocationServiceEnabled();
  }

  static Future<Position> get currentPos async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
  }
}
