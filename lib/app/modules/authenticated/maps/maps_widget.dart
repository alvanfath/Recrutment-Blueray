import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recrutment_blueray/app/core/core.dart';

class MapsWidget extends StatefulWidget {
  final double? lat;
  final double? long;
  const MapsWidget({
    super.key,
    this.lat,
    this.long,
  });

  @override
  State<MapsWidget> createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late LatLng currentLocation;
  late LatLng locationMarker;

  @override
  void initState() {
    super.initState();
    currentLocation = LatLng(
      widget.lat ?? -6.140410,
      widget.long ?? 106.890663,
    );
    locationMarker = LatLng(
      widget.lat ?? -6.140410,
      widget.long ?? 106.890663,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        isLeading: true,
        title: 'Pilih Lokasi',
        leadingAction: () {
          Navigator.pop(context);
        },
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: currentLocation,
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          Marker(
            markerId: MarkerId('marker_id'),
            position: currentLocation,
            draggable: true,
            onDrag: (value) {
              setState(() {
                locationMarker = value;
              });
            },
            infoWindow: InfoWindow(
              title: 'Lokasi yang dipilih',
              snippet: 'Tekan lalu geser untuk memindahkan',
            ),
          )
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  child: Button(
                    title: 'Tandai',
                    onPressed: () {
                      Navigator.pop(context, locationMarker);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Button(
                    title: 'Lokasi Saya',
                    onPressed: () async {
                      final location =
                          await LocationHelper.getCurrentLocation();
                      if (location != null) {
                        setState(() {
                          currentLocation = LatLng(
                            location.latitude!,
                            location.longitude!,
                          );
                          locationMarker = LatLng(
                            location.latitude!,
                            location.longitude!,
                          );
                        });
                        final GoogleMapController controller =
                            await _controller.future;
                        controller.animateCamera(
                          CameraUpdate.newLatLngZoom(currentLocation, 14.4746),
                        );
                      }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
