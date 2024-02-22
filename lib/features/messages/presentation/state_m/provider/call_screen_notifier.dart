import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';

class CallScreenNotifier extends ScreenNotifier {
  RtcEngine? engine;
  int? userId;
  bool? withVideo;
  @override
  void closeNotifier() {
    this.dispose();
  }
}
