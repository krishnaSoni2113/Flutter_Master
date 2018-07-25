
import 'MasterConstant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/models/location_accuracy.dart';
import 'package:geolocator/models/position.dart';
import 'package:geolocator/models/placemark.dart';
import 'package:geolocator/models/location_options.dart';

/*
  geolocator: '^1.3.1'
  https://pub.dartlang.org/packages/geolocator#-readme-tab-
*/




class MILocationManager{
  static final MILocationManager shared = new MILocationManager._init();

  factory MILocationManager(){
    return shared;
  }

  Position updatePosition;

  MILocationManager._init(){
   didUpdateLocation();
  }



  void didUpdateLocation(){

    Geolocator().getPositionStream(LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10)).listen((_position){
      updatePosition = _position;
//      print(updatePosition == null ? 'Unknown' : updatePosition.latitude.toString() + ', ' + updatePosition.longitude.toString());
    });
  }



  Future<Position> currentLocation() async {
    Position position = await Geolocator().getPosition(LocationAccuracy.high);
    return position;
  }

  Future<Placemark> convertAddressIntoLatLong(String address) async {
    List<Placemark> arrPlacemark = await Geolocator().toPlacemark(address);
    if (arrPlacemark.length > 0)   {
      return arrPlacemark[0];
    } else {
      return null;
    }
  }

  Future<Placemark> convertLatLongIntoAddress(double lat, double long) async {
    List<Placemark> arrPlacemark = await new Geolocator().fromPlacemark(lat, long);

    if (arrPlacemark.length > 0)   {
      return arrPlacemark[0];
    } else {
      return null;
    }
  }

  Future<double> calculateDistanceBetweenTwoCoordination(double firstLat, double firstLong,double secondLat, double secondLong) async{
//    double distanceInMeters = await new Geolocator().distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
    double distanceInMeters = await new Geolocator().distanceBetween(firstLat, firstLong, secondLat, secondLong);
    return distanceInMeters;
  }

}