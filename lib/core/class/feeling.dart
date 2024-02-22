import 'package:intl/intl.dart';
import 'package:starter_application/generated/l10n.dart';

class Feeling {
  final String path;
  final String translationKey;

  String get name => Intl.message(translationKey);

  const Feeling(this.path, this.translationKey);
}
