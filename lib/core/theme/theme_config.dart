import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/extensions/text_style_extension.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';

import '../../main.dart';

part 'light/light_theme.dart';

part 'dark/dark_theme.dart';

@lazySingleton
class ThemeConfig {
  // final ThemeData _lightTheme = _getLightTheme();
  // final ThemeData _darkTheme = _getDarkTheme();

  ThemeData get lightTheme => _getLightTheme();

  ThemeData get darkTheme => _getDarkTheme();
}
