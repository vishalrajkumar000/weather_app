import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude, longitude;

  Future<void> getLocation() async {
    try {
      Position _position = await Geolocator.getCurrentPosition();
      latitude = _position.latitude;
      longitude = _position.longitude;
    } catch (e) {
      print(e);
    }
  }

  Future<Address> getCityName(double lat, double lon) async {
    var address = await Geocoder.local
        .findAddressesFromCoordinates(Coordinates(lat, lon));
    return address.first;
  }

  Future<Coordinates?> getCoordinates(String cityName) async {
    try {
      var addresses = await Geocoder.local.findAddressesFromQuery(cityName);
      var first = addresses.first;
      return first.coordinates;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
