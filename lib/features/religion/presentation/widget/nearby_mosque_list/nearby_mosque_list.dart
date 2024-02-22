import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as lat2;
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/entities/nearby_places_entity.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/religion/presentation/screen/mosque_map/mosque_map_screen.dart';
import 'package:starter_application/features/religion/presentation/state_m/provider/mosque_map_screen_notifier.dart';
import 'package:starter_application/features/religion/presentation/widget/nearby_mosque_list/nearby_mosque_card.dart';

class NearbyMosqueList extends StatelessWidget {
  final List<PlaceEntity> mosques;
  final LatLng userLocation;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  NearbyMosqueList(
      {Key? key,
      required this.mosques,
      required this.userLocation,
      this.physics,
      this.shrinkWrap = false})
      : super(key: key);

  final lat2.Distance distance = const lat2.Distance();

  @override
  Widget build(BuildContext context) {
    double cardHeight = 300.h;

    return ListView.separated(
      padding: EdgeInsets.only(
        bottom: 64.h,
      ),
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemBuilder: (context, index) {
        final mosque = mosques[index];
        return NearbyMosqueCard(
          height: cardHeight,
          address: mosque.vicinity,
          image: mosque.photos.length == 0
              ? mosque.icon
              : getPlacePhotoUrl(mosque.photos[0].photoReference),
          isOpenNow: mosque.openingHours?.openNow,
          //todo (Check if current day close period )
          isOpenAllDay: false,
          location: mosque.geometry!.location!.latLng!,
          distance: "${distance(
            lat2.LatLng(userLocation.latitude, userLocation.longitude),
            lat2.LatLng(mosque.geometry!.location!.lat!,
                mosque.geometry!.location!.lng!),
          )}m",
          name: mosque.name,
          onTap: () => Nav.to(
            MosqueMapScreen.routeName,
            arguments: MosqueMapScreenParam(
                mosqueLocation: mosque.geometry!.location!.latLng!,
                mosqueName: mosque.name),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Gaps.vGap64;
      },
      itemCount: mosques.length,
    );
  }
}
