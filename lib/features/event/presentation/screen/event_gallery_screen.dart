import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/params/screen_params/event_gallery_screen_params.dart';
import 'package:starter_application/features/event/presentation/widget/event_transparent_appbar.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/event_gallery_screen_notifier.dart';
import 'event_gallery_screen_content.dart';

class EventGalleryScreen extends StatefulWidget {
  static const String routeName = "/EventGalleryScreen";
  final EventGalleryScreenParams params;

  const EventGalleryScreen({Key? key, required this.params}) : super(key: key);

  @override
  _EventGalleryScreenState createState() => _EventGalleryScreenState();
}

class _EventGalleryScreenState extends State<EventGalleryScreen> {
  final sn = EventGalleryScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.images = widget.params.images;
    sn.imageToDisplay = widget.params.chosenImageIndex ?? 0;
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventGalleryScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: EventTransparentAppbar(
          title: Translation.of(context).event_gallery,
        ),
        backgroundColor: AppColors.black,
        body: EventGalleryScreenContent(),
      ),
    );
  }
}
