import 'package:url_launcher/url_launcher.dart';

class Launcher {
  static launchURL(String url) async {
    if(url == null) return;
    if (await canLaunch(url ?? "")) {
      await launch(url ?? "");
    } else {
      throw 'Could not launch $url';
    }
  }

  static  Future<void> launchurl(Uri uri) async {
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}
