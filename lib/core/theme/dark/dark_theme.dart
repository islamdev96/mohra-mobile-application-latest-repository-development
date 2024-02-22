part of '../theme_config.dart';

ThemeData _getDarkTheme() {
  return ThemeData(
    primaryColor: AppColors.primaryColorDark,
    // accentColor: AppColors.accentColorDark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColors.backgroundColorDark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.accentColorDark,
      secondary: AppColors.accentColorDark,
    ),

    /// Specifying fonts for application
    fontFamily: 'Inter-Regular',

    textTheme: TextTheme(
      bodyText1: AppColors.textDark.bodyText1,
      bodyText2: AppColors.textDark.bodyText2,
      button: AppColors.textDark.button,
      caption: AppColors.textDark.caption,
      headline1: AppColors.textDark.headline1,
      headline2: AppColors.textDark.headline2,
      headline3: AppColors.textDark.headline3,
      headline4: AppColors.textDark.headline4,
      headline5: AppColors.textDark.headline5,
      headline6: AppColors.textDark.headline6,
      overline: AppColors.textDark.overline,
      subtitle1: AppColors.textDark.subtitle1,
      subtitle2: AppColors.textDark.subtitle2,
    ),
  );
}
