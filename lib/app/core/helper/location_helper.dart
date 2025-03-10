import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as per;
import 'package:geocoding/geocoding.dart' as geocoding;

class LocationHelper {
  static Future<LocationData?> getCurrentLocation() async {
    await Future.delayed(const Duration(milliseconds: 1));
    try {
      final Location location = Location();
      final checkService = await location.serviceEnabled();
      if (!checkService) {
        final serviceRequest = await location.requestService();
        if (!serviceRequest) {
          debugPrint(
            '========================= Service request denied ==========================',
          );
          return null;
        } else {
          debugPrint(
            '========================== Service request approved ==========================',
          );
        }
      }
      debugPrint(
        ' ========================== masuk permission ==========================',
      );
      await Future.delayed(const Duration(milliseconds: 100));
      final status = await per.Permission.location.status;
      if (!status.isGranted) {
        final requestStatus = await per.Permission.location.request();
        if (requestStatus.isPermanentlyDenied) {
          debugPrint('Permantent denied');
          await per.openAppSettings();
        }
      }
      debugPrint(
        '========================== done permission ==========================',
      );

      await Future.delayed(const Duration(milliseconds: 100));

      debugPrint(
        ' ========================== masuk get location ==========================',
      );

      await Future.delayed(const Duration(milliseconds: 100));
      final locationResult = await location.getLocation();
      debugPrint(
        '========================== done location: ==========================',
      );
      return locationResult;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<String?> getNamedLocation(LatLng latLng) async {
    try {
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      geocoding.Placemark place = placemarks[0];
      String locationDetail =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
      debugPrint(
        'Response location:\n'
        'latitude: ${latLng.latitude.toString()}\n'
        'longitude: ${latLng.longitude.toString()}\n'
        'location detail: $locationDetail\n'
        'placemarks: $placemarks\n',
      );
      return locationDetail;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
