import 'package:booking_system_flutter/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:starter_application/features/messages/domain/entity/messaging_entity.dart';

class LocationMessageWidget extends StatelessWidget {
  final MessagingLocationEntity messagingLocationEntity;

  const LocationMessageWidget({Key? key, required this.messagingLocationEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxWidth: 0.9.sw, maxHeight: 0.9.sw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(messagingLocationEntity.lat,
                        messagingLocationEntity.lng),
                    zoom: 15),
                scrollGesturesEnabled: false,
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
                zoomGesturesEnabled: false,
                mapToolbarEnabled: false,
                zoomControlsEnabled: false,
                markers: [
                  Marker(
                      markerId: const MarkerId('1'),
                      position: LatLng(messagingLocationEntity.lat,
                          messagingLocationEntity.lng))
                ].toSet(),
                onTap: (argument) {
                  openMap(
                      messagingLocationEntity.lat, messagingLocationEntity.lng);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(messagingLocationEntity.info)
          ],
        ));
  }
}
