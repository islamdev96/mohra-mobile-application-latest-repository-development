import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/params/screen_params/buy_ticket_screen_params.dart';
import 'package:starter_application/core/params/screen_params/challenge_details_screen_params.dart';
import 'package:starter_application/core/params/screen_params/event_details_screen_params.dart';
import 'package:starter_application/core/params/screen_params/event_gallery_screen_params.dart';
import 'package:starter_application/core/params/screen_params/event_location_screen_params.dart';
import 'package:starter_application/core/params/screen_params/group_details_screen_param.dart';
import 'package:starter_application/core/params/screen_params/group_screen_params.dart';
import 'package:starter_application/core/params/screen_params/live_location_screen_params.dart';
import 'package:starter_application/core/params/screen_params/personality_result_screen_params.dart';
import 'package:starter_application/core/params/screen_params/remove_group_member_params.dart';
import 'package:starter_application/core/params/screen_params/shared_qrcode_screen_params.dart';
import 'package:starter_application/core/params/screen_params/single_message_screen_params.dart';
import 'package:starter_application/core/params/screen_params/story_details_screen_params.dart';
import 'package:starter_application/core/params/screen_params/surah_details_screen_params.dart';
import 'package:starter_application/core/params/screen_params/ticket_details_screen_params.dart';
import 'package:starter_application/core/params/screen_params/video_audio_chat_screen_params.dart';
import 'package:starter_application/core/params/screen_params/visit_user_profile_screen_params.dart';
import 'package:starter_application/core/ui/mansour/onboarding_screen.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/account/data/model/request/register_request.dart';
import 'package:starter_application/features/account/presentation/screen/confirmPassword_screen.dart';
import 'package:starter_application/features/account/presentation/screen/forgetPassword_screen.dart';
import 'package:starter_application/features/account/presentation/screen/login_screen.dart';
import 'package:starter_application/features/account/presentation/screen/register_screen1.dart';
import 'package:starter_application/features/account/presentation/screen/register_screen2.dart';
import 'package:starter_application/features/account/presentation/screen/register_with_google_screen.dart';
import 'package:starter_application/features/account/presentation/screen/set_username_screen.dart';
import 'package:starter_application/features/account/presentation/screen/start_personality_test.dart';
import 'package:starter_application/features/account/presentation/screen/verify_code_screen.dart';
import 'package:starter_application/features/challenge/presentation/screen/challenge_screen.dart';
import 'package:starter_application/features/event/presentation/screen/buy_ticket_screen.dart';
import 'package:starter_application/features/event/presentation/screen/event_details_screen.dart';
import 'package:starter_application/features/event/presentation/screen/event_gallery_screen.dart';
import 'package:starter_application/features/event/presentation/screen/event_home_screen.dart';
import 'package:starter_application/features/event/presentation/screen/event_location_screen.dart';
import 'package:starter_application/features/event/presentation/screen/my_running_events_screen.dart';
import 'package:starter_application/features/event/presentation/screen/my_ticket_screen.dart';
import 'package:starter_application/features/event/presentation/screen/terms_and_conditions_screen.dart';
import 'package:starter_application/features/event/presentation/screen/ticket_details_screen.dart';
import 'package:starter_application/features/event/presentation/screen/ticket_qrCode_screen.dart';
import 'package:starter_application/features/event_orginizer/domain/entity/event_tickets_entity.dart';
import 'package:starter_application/features/event_orginizer/domain/entity/my_running_events_entity.dart'
    as runningEvent;
import 'package:starter_application/features/event_orginizer/presentation/screen/event_organizer_details_screen.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';
import 'package:starter_application/features/friend/presentation/screen/select_friends_screen.dart';
import 'package:starter_application/features/health/domain/entity/session_entity.dart';
import 'package:starter_application/features/health/presentation/logic/profile_info/info_temp_model.dart';
import 'package:starter_application/features/health/presentation/screen/browse_exrecise_screen.dart';
import 'package:starter_application/features/health/presentation/screen/calculating_health_result_screen.dart';
import 'package:starter_application/features/health/presentation/screen/create_calories/create_calories_screen.dart';
import 'package:starter_application/features/health/presentation/screen/create_food/create_food_screen.dart';
import 'package:starter_application/features/health/presentation/screen/eating_habits_screen.dart';
import 'package:starter_application/features/health/presentation/screen/edit_health_profile_screen.dart';
import 'package:starter_application/features/health/presentation/screen/favorite_session_screen.dart';
import 'package:starter_application/features/health/presentation/screen/food_categories_screen.dart';
import 'package:starter_application/features/health/presentation/screen/food_category_details_screen.dart';
import 'package:starter_application/features/health/presentation/screen/food_details_screen.dart';
import 'package:starter_application/features/health/presentation/screen/food_favorite_screen.dart';
import 'package:starter_application/features/health/presentation/screen/food_screen.dart';
import 'package:starter_application/features/health/presentation/screen/health_count_screen.dart';
import 'package:starter_application/features/health/presentation/screen/health_home_screen.dart';
import 'package:starter_application/features/health/presentation/screen/health_info_screen.dart';
import 'package:starter_application/features/health/presentation/screen/health_intro_screen.dart';
import 'package:starter_application/features/health/presentation/screen/health_main_screen.dart';
import 'package:starter_application/features/health/presentation/screen/health_profile_screen.dart';
import 'package:starter_application/features/health/presentation/screen/health_result_screen.dart';
import 'package:starter_application/features/health/presentation/screen/health_video_player_screen_screen.dart';
import 'package:starter_application/features/health/presentation/screen/reciepe_details_screen.dart';
import 'package:starter_application/features/health/presentation/screen/weight_summary_screen.dart';
import 'package:starter_application/features/health/presentation/screen/workout_details_screen.dart';
import 'package:starter_application/features/health/presentation/state_m/provider/health_main_screen_notifier.dart';
import 'package:starter_application/features/help/presentation/screen/about_us_screen.dart';
import 'package:starter_application/features/help/presentation/screen/contact_us_screen.dart';
import 'package:starter_application/features/help/presentation/screen/faq_screen.dart';
import 'package:starter_application/features/help/presentation/screen/help_screen.dart';
import 'package:starter_application/features/home/presentation/screen/app_main_screen.dart';
import 'package:starter_application/features/home/presentation/screen/home_screen/home_screen.dart';
import 'package:starter_application/features/home/presentation/screen/home_screen/qrCode_screen.dart';
import 'package:starter_application/features/home/presentation/screen/shared_qrcode_screen.dart';
import 'package:starter_application/features/messages/presentation/messages_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/add_friends_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/blocked_people_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/broadcast_message_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/create_event_2_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/create_event_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/create_poll_intro_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/event_intro_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/friends_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/group_details_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/group_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/live_location_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/message_location_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/my_contact_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/nearby_clients_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/poll_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/remove_group_members_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/send_contact_message_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/single_message_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/video_audio_chat_screen.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart'
    as MyMoment;
import 'package:starter_application/features/moment/presentation/screen/check_in/check_in_screen.dart';
import 'package:starter_application/features/moment/presentation/screen/check_in_clients/check_in_clients_screen.dart';
import 'package:starter_application/features/moment/presentation/screen/create_feeling_screen.dart';
import 'package:starter_application/features/moment/presentation/screen/create_post_screen.dart';
import 'package:starter_application/features/moment/presentation/screen/moment_screen.dart';
import 'package:starter_application/features/moment/presentation/screen/place_map/place_map_screen.dart';
import 'package:starter_application/features/moment/presentation/screen/select_place_screen.dart';
import 'package:starter_application/features/moment/presentation/screen/view_post_comments_screen.dart';
import 'package:starter_application/features/moment/presentation/screen/view_post_interactions_screen.dart';
import 'package:starter_application/features/moment/presentation/state_m/provider/place_map_screen_notifier.dart';

// import 'package:starter_application/features/music/presentation/screen/add_tracks_to_playlist_screen.dart';
// import 'package:starter_application/features/music/presentation/screen/album_details/album_details_screen.dart';
// import 'package:starter_application/features/music/presentation/screen/artist_albums_screen.dart';
// import 'package:starter_application/features/music/presentation/screen/create_playlist_screen.dart';
// import 'package:starter_application/features/music/presentation/screen/music_home/music_home_screen.dart';
// import 'package:starter_application/features/music/presentation/screen/music_main_screen.dart';
// import 'package:starter_application/features/music/presentation/screen/music_search_screen.dart';
// import 'package:starter_application/features/music/presentation/screen/my_library/my_library_screen.dart';
// import 'package:starter_application/features/music/presentation/screen/play_song_screen.dart';
// import 'package:starter_application/features/music/presentation/screen/playlist_details/playlist_details_screen.dart';
// import 'package:starter_application/features/music/presentation/screen/select_tracks_screen/select_tracks_screen.dart';
import 'package:starter_application/features/mylife/presentation/screen/appointment_screen.dart';
import 'package:starter_application/features/mylife/presentation/screen/dream_screen.dart';
import 'package:starter_application/features/mylife/presentation/screen/my_life_video_screen.dart';
import 'package:starter_application/features/mylife/presentation/screen/mylife_audio_screen.dart';
import 'package:starter_application/features/mylife/presentation/screen/mylife_home_screen.dart';
import 'package:starter_application/features/mylife/presentation/screen/positivity_screen.dart';
import 'package:starter_application/features/mylife/presentation/screen/single_story_screen.dart';
import 'package:starter_application/features/mylife/presentation/screen/todo_screen.dart';
import 'package:starter_application/features/news/data/model/request/news_single_params.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/features/news/presentation/screen/news_home_screen.dart';
import 'package:starter_application/features/news/presentation/screen/news_main_screen_screen.dart';
import 'package:starter_application/features/news/presentation/screen/news_single_screen.dart';
import 'package:starter_application/features/news/presentation/screen/news_sub_category_screen.dart';
import 'package:starter_application/features/news/presentation/screen/news_summery_screen.dart';
import 'package:starter_application/features/news/presentation/screen/see_all_news_page.dart';
import 'package:starter_application/features/notification/presentation/screen/notification_list_screen.dart';
import 'package:starter_application/features/personality/domain/entity/avatar_entity.dart';
import 'package:starter_application/features/personality/presentation/screen/check_personality_screen.dart';
import 'package:starter_application/features/personality/presentation/screen/personality_details_screen.dart';
import 'package:starter_application/features/personality/presentation/screen/presonality_result_screen.dart';
import 'package:starter_application/features/personality/presentation/screen/visit_user_personality_page_screen.dart';
import 'package:starter_application/features/religion/presentation/logic/quran_classes.dart';
import 'package:starter_application/features/religion/presentation/screen/azkar/azkar_screen.dart';
import 'package:starter_application/features/religion/presentation/screen/find_mosque/find_mosque_screen.dart';
import 'package:starter_application/features/religion/presentation/screen/juz_details_screen.dart';
import 'package:starter_application/features/religion/presentation/screen/mosque_map/mosque_map_screen.dart';
import 'package:starter_application/features/religion/presentation/screen/prayer_times_screen.dart';
import 'package:starter_application/features/religion/presentation/screen/quran_screen.dart';
import 'package:starter_application/features/religion/presentation/screen/religion_screen.dart';
import 'package:starter_application/features/religion/presentation/screen/surah_details_screen.dart';
import 'package:starter_application/features/religion/presentation/state_m/provider/mosque_map_screen_notifier.dart';
import 'package:starter_application/features/salary_count/presentation/screen/all_count_down_screen.dart';
import 'package:starter_application/features/settings/presentation/logic/single_setting_option_arguments.dart';
import 'package:starter_application/features/settings/presentation/screen/blocked_accounts_screen.dart';
import 'package:starter_application/features/settings/presentation/screen/muted_accounts_screen.dart';
import 'package:starter_application/features/settings/presentation/screen/privacy_option_setting_screen.dart';
import 'package:starter_application/features/settings/presentation/screen/setting_main_screen.dart';
import 'package:starter_application/features/settings/presentation/screen/setting_privacy_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/add_edit_shipping_address/add_edit_shipping_address_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/categories_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/favorite_products/favorite_products_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/following_shop_comments_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/shop_main_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/shop_screen/shoe_home_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/cart_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/checkout_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/create_reviewProduct/reviewProduct_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/create_reviewStore/reviewStore_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/following_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/home_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/myaddress_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/order_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/search_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_category_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_product_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_store_screen.dart';
import 'package:starter_application/features/splash/presentation/screen/splash_screen.dart';
import 'package:starter_application/features/sports/domain/entity/match_entity.dart';
import 'package:starter_application/features/sports/presentation/screen/all_live_matches_screen.dart';
import 'package:starter_application/features/sports/presentation/screen/home/sport_home_screen.dart';
import 'package:starter_application/features/sports/presentation/screen/match/match_live_screen.dart';
import 'package:starter_application/features/sports/presentation/screen/schedule_screen.dart';
import 'package:starter_application/features/sports/presentation/screen/sport_main_screen.dart';
import 'package:starter_application/features/sports/presentation/screen/table_details_screen.dart';
import 'package:starter_application/features/sports/presentation/screen/table_screen.dart';
import 'package:starter_application/features/user/domain/entity/addresses_entity.dart';
import 'package:starter_application/features/user/presentation/screen/change_email_confirm_screen.dart';
import 'package:starter_application/features/user/presentation/screen/change_email_screen.dart';
import 'package:starter_application/features/user/presentation/screen/change_email_success_screen.dart';
import 'package:starter_application/features/user/presentation/screen/change_name_screen.dart';
import 'package:starter_application/features/user/presentation/screen/change_password_screen.dart';
import 'package:starter_application/features/user/presentation/screen/edit_address_screen.dart';
import 'package:starter_application/features/user/presentation/screen/all_addresses_screen.dart';
import 'package:starter_application/features/user/presentation/screen/add_new_address_screen.dart';
import 'package:starter_application/features/user/presentation/screen/delete_account_confirm_screen.dart';
import 'package:starter_application/features/user/presentation/screen/delete_account_select_reason_screen.dart';
import 'package:starter_application/features/user/presentation/screen/delete_account_write_reason_screen.dart';
import 'package:starter_application/features/user/presentation/screen/delete_account_success_screen.dart';
import 'package:starter_application/features/user/presentation/screen/edit_profile_screen.dart';
import 'package:starter_application/features/user/presentation/screen/view_friend_moments_screen.dart';
import 'package:starter_application/features/user/presentation/screen/view_profile_screen.dart';
import 'package:starter_application/features/user/presentation/screen/visit_user_profile_screen.dart';

import '../../features/Event Organizer/pages/home/home.dart';
import '../../features/booking/presentation/screen/all_booking_screen/all_booking_screen.dart';
import '../../features/booking/presentation/screen/home_screen/booking_services_screen.dart';
import '../../features/booking/presentation/screen/profile_booking_member_screen/porfile_booking_screen_content.dart';
import '../../features/booking/presentation/screen/profile_booking_member_screen/profile_booking_screen.dart';
import '../../features/booking/presentation/screen/services_detalis/services_details_screen.dart';
import '../../features/event_orginizer/presentation/screen/attendance_screen.dart';
import '../../features/event_orginizer/presentation/screen/event_organizer_screen.dart';
import '../../features/home_services/presentation/screen/home_screen/home_services_screen.dart';
import '../ui/screens/view_video_screen.dart';
import 'animations/animated_route.dart';
import 'animations/fade_route.dart';

@lazySingleton
class NavigationRoute {
  Route<dynamic> generateRoute(RouteSettings settings) {
    /// Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case AppMainScreen.routeName:
        return CupertinoRoute(page: AppMainScreen(), settings: settings);
      case TermsandConditionsScreen.routeName:
        return CupertinoRoute(
            page: TermsandConditionsScreen(), settings: settings);
        // case AddTracksToPlaylistScreen.routeName:
        //   if (args != null && args is AddTracksToPlaylistScreenParam)
        //     return CupertinoRoute(
        //         page: AddTracksToPlaylistScreen(
        //           param: args,
        //         ),
        //         settings: settings);
        return errorRoute();
      case AttendanceScreen.routeName:
        if (args != null && args is EventTickettEntity)
          return CupertinoRoute(
              page: AttendanceScreen(
                eventTickettEntity: args,
              ),
              settings: settings);
        return errorRoute();
        // case SelectTracksScreen.routeName:
        //   if (args != null && args is SelectTracksScreenParam)
        //     return CupertinoRoute(
        //         page: SelectTracksScreen(
        //           param: args,
        //         ),
        //         settings: settings);
        return errorRoute();
      case SelectPlaceScreen.routeName:
        if (args != null && args is SelectPlaceScreenParam)
          return CupertinoRoute(
              page: SelectPlaceScreen(
                param: args,
              ),
              settings: settings);
        return errorRoute();
      case LoginScreen.routeName:
        return CupertinoRoute(page: LoginScreen(), settings: settings);
      case AzkarScreen.routeName:
        return CupertinoRoute(page: const AzkarScreen(), settings: settings);
      case MosqueMapScreen.routeName:
        if (args != null && args is MosqueMapScreenParam)
          return CupertinoRoute(
              page: MosqueMapScreen(
                param: args,
              ),
              settings: settings);
        return errorRoute();
      case PlaceMapScreen.routeName:
        if (args != null && args is PlaceMapScreenParam)
          return CupertinoRoute(
              page: PlaceMapScreen(
                param: args,
              ),
              settings: settings);
        return errorRoute();
        // case MusicMainScreen.routeName:
        //   if (args == null || args is MusicMainScreenParam)
        //     return CupertinoRoute(
        //         page: MusicMainScreen(
        //           param: args == null
        //               ? MusicMainScreenParam()
        //               : args as MusicMainScreenParam,
        // ),
        // settings: settings);
        return errorRoute();
      // case MusicHomeScreen.routeName:
      //   return CupertinoRoute(page: const MusicHomeScreen(), settings: settings);
      // case MyLibraryScreen.routeName:
      //   return CupertinoRoute(page: const MyLibraryScreen(), settings: settings);
      // case MusicSearchScreen.routeName:
      //   return CupertinoRoute(
      //       page: const MusicSearchScreen(), settings: settings);
      // case PlayListDetailsScreen.routeName:
      //   if (args != null && args is PlaylistDetailsScreenParam)
      //     return CupertinoRoute(
      //         page: PlayListDetailsScreen(
      //           param: args,
      //         ),
      //         settings: settings);
      //   return errorRoute();
      // case AlbumDetailsScreen.routeName:
      //   if (args != null && args is AlbumDetailsScreenParam)
      //     return CupertinoRoute(
      //         page: AlbumDetailsScreen(
      //           param: args,
      //         ),
      //         settings: settings);
      //   return errorRoute();
      // case ArtistAlbumsScreen.routeName:
      //   if (args != null && args is ArtistAlbumsScreenParam)
      //     return CupertinoRoute(
      //         page: ArtistAlbumsScreen(
      //           param: args,
      //         ),
      //         settings: settings);
      //   return errorRoute();
      // case CreatePlaylistScreen.routeName:
      //   if (args != null && args is CreatePlaylistScreenParam)
      //     return CupertinoRoute(
      //         page: CreatePlaylistScreen(
      //           param: args,
      //         ),
      //         settings: settings);
      //   return errorRoute();
      // case PlaySongScreen.routeName:
      //   if (args != null && args is PlaySongScreenParam)
      //     return CupertinoRoute(
      //         page: PlaySongScreen(
      //           param: args,
      //         ),
      //         settings: settings);
      //   return errorRoute();
      case RegisterScreen1.routeName:
        return CupertinoRoute(page: RegisterScreen1(), settings: settings);
      case RegisterScreen2.routeName:
        if (args != null && args is RegisterRequest)
          return CupertinoRoute(
              page: RegisterScreen2(
                registerRequest: args,
              ),
              settings: settings);
        return errorRoute();
      case RegisterWithGoogleScreen.routeName:
        return CupertinoRoute(
            page: RegisterWithGoogleScreen(), settings: settings);
      case VerifyCodeScreen.routeName:
        if (args != null && args is List)
          return CupertinoRoute(
              page: VerifyCodeScreen(
                registerRequest: args[0],
                signUpProcess: args[1],
              ),
              settings: settings);
        return errorRoute();
      case SetUserNameScreen.routeName:
        if (args != null && args is RegisterRequest)
          return CupertinoRoute(
              page: SetUserNameScreen(
                registerRequest: args,
              ),
              settings: settings);
        return errorRoute();
      case ConfirmPasswordScreen.routeName:
        if (args != null && args is RegisterRequest)
          return CupertinoRoute(
              page: ConfirmPasswordScreen(
                registerRequest: args,
              ),
              settings: settings);
        return errorRoute();
      case StartPersonalityTest.routeName:
        return CupertinoRoute(page: StartPersonalityTest(), settings: settings);
      case SettingMainScreen.routeName:
        return CupertinoRoute(page: SettingMainScreen(), settings: settings);
      case SettingPrivacyScreen.routeName:
        return CupertinoRoute(page: SettingPrivacyScreen(), settings: settings);
      case PrivacyOptionSettingScreen.routeName:
        return CupertinoRoute(
            page: PrivacyOptionSettingScreen(
              settingOptionArguments: args as SingleSettingOptionArguments,
            ),
            settings: settings);
      case MutedAccountsScreen.routeName:
        return CupertinoRoute(page: MutedAccountsScreen(), settings: settings);
      case BlockedAccountsScreen.routeName:
        return CupertinoRoute(
            page: BlockedAccountsScreen(), settings: settings);
      case OnBoardingScreen.routeName:
        return CupertinoRoute(page: OnBoardingScreen(), settings: settings);
      case CheckPersonalityScreen.routeName:
        return CupertinoRoute(
            page: CheckPersonalityScreen(), settings: settings);
      case PersonalityResultScreen.routeName:
        return CupertinoRoute(
            page: PersonalityResultScreen(
              params: settings.arguments == null
                  ? null
                  : settings.arguments as PersonalityResultScreenParams,
            ),
            settings: settings);
      case VisitUserPersonalityPageScreen.routeName:
        return CupertinoRoute(
            page: VisitUserPersonalityPageScreen(
              params: args as PersonalityResultScreenParams,
            ),
            settings: settings);
      case HomeScreen.routeName:
        return CupertinoRoute(page: HomeScreen(), settings: settings);
      case QrCodeScreen.routeName:
        if (args != null && args is QrCodeScreenParam)
          return CupertinoRoute(
              page: QrCodeScreen(
                param: args,
              ),
              settings: settings);
        return errorRoute();
      case TicketQrCodeScreen.routeName:
        if (args != null && args is TicketQrCodeScreenParam)
          return CupertinoRoute(
              page: TicketQrCodeScreen(
                param: args,
              ),
              settings: settings);
        return errorRoute();
      case ForgetPasswordScreen.routeName:
        return CupertinoRoute(page: ForgetPasswordScreen(), settings: settings);
      case ChallengeScreen.routeName:
        return CupertinoRoute(
            page: ChallengeScreen(
              params: settings.arguments as ChallengeDetailsScreenParams,
            ),
            settings: settings);
      case MomentScreen.routeName:
        return CupertinoRoute(page: const MomentScreen(), settings: settings);
      case MessagesScreen.routeName:
        return CupertinoRoute(
            page: MessagesScreen(
              params: (settings.arguments is SingleMessageScreenParams)
                  ? (settings.arguments as SingleMessageScreenParams)
                  : null,
            ),
            settings: settings);
      case SelectFriendsScreen.routeName:
        if (args != null && args is SelectFriendsScreenParam)
          return CupertinoRoute(
              page: SelectFriendsScreen(
                param: args,
              ),
              settings: settings);
        return errorRoute();
      case VideoScreen.routeName:
        if (args != null && args is String)
          return CupertinoRoute(
              page: VideoScreen(
                videoUrl: args,
              ),
              settings: settings);
        return errorRoute();
      case CreatePostScreen.routeName:
        if (args != null && args is CreatePostScreenParam)
          return CupertinoRoute(
              page: CreatePostScreen(param: args), settings: settings);
        return errorRoute();
      case CreateFeelingScreen.routeName:
        if (args != null && args is CreateFeelingScreenParam)
          return CupertinoRoute(
              page: CreateFeelingScreen(param: args), settings: settings);
        return errorRoute();
      case CheckInScreen.routeName:
        if (args != null && args is CheckInScreenParam)
          return CupertinoRoute(
              page: CheckInScreen(param: args), settings: settings);
        return errorRoute();
      case CheckInClientsScreen.routeName:
        if (args != null && args is CheckInClientsScreenParam)
          return CupertinoRoute(
              page: CheckInClientsScreen(param: args), settings: settings);
        return errorRoute();
      case HealthIntroScreen.routeName:
        return CupertinoRoute(
            page: const HealthIntroScreen(), settings: settings);
      case HealthInfoScreen.routeName:
        return CupertinoRoute(
            page: const HealthInfoScreen(), settings: settings);
      case WeightSummaryScreen.routeName:
        if (args != null && args is HealthProfileInfoTempModel)
          return CupertinoRoute(
            page: WeightSummaryScreen(
              healthProfileInfoTempModel: args,
            ),
            settings: settings,
          );
        return errorRoute();
      case EatingHabitsScreen.routeName:
        return CupertinoRoute(
            page: const EatingHabitsScreen(), settings: settings);
      case CalculatingHealthResultScreen.routeName:
        return CupertinoRoute(
            page: const CalculatingHealthResultScreen(), settings: settings);
      case HealthHomeScreen.routeName:
        return CupertinoRoute(
            page: const HealthHomeScreen(), settings: settings);
      case HealthMainScreen.routeName:
        if (args is BottomNavBarInitIndex)
          return CupertinoRoute(
              page: HealthMainScreen(
                initIndex: args,
              ),
              settings: settings);
        return CupertinoRoute(
          page: HealthMainScreen(initIndex: BottomNavBarInitIndex(index: 0)),
          settings: settings,
        );
      case FoodCategoriesScreen.routeName:
        if (args != null)
          return CupertinoRoute(
              page: FoodCategoriesScreen(
                foodType: args as int,
              ),
              settings: settings);
        return errorRoute();
      case EventOrganizerScreen.routeName:
        return CupertinoRoute(page: EventOrganizerScreen(), settings: settings);
      case EventOrganizerDetailsScreen.routeName:
        if (args != null)
          return CupertinoRoute(
              page: EventOrganizerDetailsScreen(eventItemEntity: args),
              settings: settings);
        return errorRoute();

      case FoodCategoryDetailsScreen.routeName:
        if (args != null && args is List)
          return CupertinoRoute(
            page: FoodCategoryDetailsScreen(
              foodCategoryEntity: args[0],
              foodType: args[1],
            ),
            settings: settings,
          );
        return errorRoute();
      case SplashScreen.routeName:
        return CupertinoRoute(
          page: SplashScreen(),
          settings: settings,
        );
      case ContactUsScreen.routeName:
        return CupertinoRoute(
          page: ContactUsScreen(),
          settings: settings,
        );
      case AboutUsScreen.routeName:
        return CupertinoRoute(
          page: AboutUsScreen(),
          settings: settings,
        );
      case HelpScreen.routeName:
        return CupertinoRoute(
          page: HelpScreen(),
          settings: settings,
        );
      case FaqScreen.routeName:
        return CupertinoRoute(
          page: FaqScreen(),
          settings: settings,
        );
      case FoodFavoriteScreen.routeName:
        if (args != null)
          return CupertinoRoute(
            page: FoodFavoriteScreen(
              foodType: args as int,
            ),
            settings: settings,
          );
        return errorRoute();

      case FoodDetailsScreen.routeName:
        if (args != null && args is List)
          return CupertinoRoute(
            page: FoodDetailsScreen(
              dishEntity: args[0],
              foodType: args[1],
            ),
            settings: settings,
          );
        return errorRoute();
      case HealthResultScreen.routeName:
        return CupertinoRoute(
            page: const HealthResultScreen(), settings: settings);
      case ReciepeDetailsScreen.routeName:
        if (args != null && args is List)
          return CupertinoRoute(
            page: ReciepeDetailsScreen(
              recipeEntity: args[0],
              foodType: args[1],
            ),
            settings: settings,
          );
        return errorRoute();
      case BrowseExreciseScreen.routeName:
        return CupertinoRoute(
          page: const BrowseExreciseScreen(),
          settings: settings,
        );
      case WorkoutDetailsScreen.routeName:
        if (args != null && args is OneSessionEntity)
          return CupertinoRoute(
              page: WorkoutDetailsScreen(
                oneSessionEntity: args,
              ),
              settings: settings);
        return errorRoute();

      case ReviewProductScreen.routeName:
        return CupertinoRoute(
            page: const ReviewProductScreen(), settings: settings);
      case ReviewStorScreen.routeName:
        return CupertinoRoute(
            page: const ReviewStorScreen(), settings: settings);
      case HealthCountScreen.routeName:
        return CupertinoRoute(
            page: HealthCountScreen(
              url: args as String,
            ),
            settings: settings);
      case CreateCaloriesScreen.routeName:
        if (args != null)
          return CupertinoRoute(
            page: CreateCaloriesScreen(
              foodType: args as int,
            ),
            settings: settings,
          );
        return errorRoute();
      case CreateFoodScreen.routeName:
        return CupertinoRoute(
            page: const CreateFoodScreen(), settings: settings);
      case ReligionScreen.routeName:
        return CupertinoRoute(page: const ReligionScreen(), settings: settings);

      case ViewPostInteractionsScreen.routeName:
        return CupertinoRoute(
            page: ViewPostInteractionsScreen(
              momentItemEntity: args as MyMoment.MomentItemEntity,
            ),
            settings: settings);
      case ViewPostCommentsScreen.routeName:
        return CupertinoRoute(
            page: ViewPostCommentsScreen(
              momentItemEntity: args as MyMoment.MomentItemEntity,
            ),
            settings: settings);
      case PrayerTimesScreen.routeName:
        return CupertinoRoute(
            page: const PrayerTimesScreen(), settings: settings);
      case QuranScreen.routeName:
        return CupertinoRoute(page: const QuranScreen(), settings: settings);
      case ShopHomeScreen.routeName:
        return CupertinoRoute(page: const ShopHomeScreen(), settings: settings);
      case ShopMainScreen.routeName:
        if (args != null) {
          return CupertinoRoute(
              page: const ShopMainScreen(toOrderScreen: true),
              settings: settings);
        }
        return CupertinoRoute(page: const ShopMainScreen(), settings: settings);
      case HomeServicesScreen.routeName:
        return CupertinoRoute(
            page: const HomeServicesScreen(), settings: settings);
      case BookingServicesScreen.routeName:
        return CupertinoRoute(
            page: const BookingServicesScreen(), settings: settings);
      case AllBookingsScreen.routeName:
        return CupertinoRoute(
            page: const AllBookingsScreen(), settings: settings);
      case ProfileBookingScreen.routeName:
        return CupertinoRoute(
            page: const ProfileBookingScreen(), settings: settings);
      case ServicesDetailsScreen.routeName:
        return CupertinoRoute(
            page: const ServicesDetailsScreen(), settings: settings);
      case StoreHomePage.routeName:
        return CupertinoRoute(page: const StoreHomePage(), settings: settings);
      case SearchPage.routeName:
        return CupertinoRoute(page: const SearchPage(), settings: settings);
      case SingleStorePage.routeName:
        if (args != null && args is SingleStorePageParam)
          return CupertinoRoute(
              page: SingleStorePage(
                param: args,
              ),
              settings: settings);
        return errorRoute();
      case CategoriesScreen.routeName:
        return CupertinoRoute(
            page: const CategoriesScreen(), settings: settings);
      case FindMosqueScreen.routeName:
        return CupertinoRoute(
            page: const FindMosqueScreen(), settings: settings);
      case SurahDetailsScreen.routeName:
        if (args != null && args is SurahDetailsScreenParams)
          return CupertinoRoute(
              page: SurahDetailsScreen(
                params: args,
              ),
              settings: settings);
        return errorRoute();
      case SingleCategoryScreen.routeName:
        if (args != null && args is int)
          return CupertinoRoute(
              page: SingleCategoryScreen(
                categoryId: args,
              ),
              settings: settings);
        return CupertinoRoute(
            page: const SingleCategoryScreen(), settings: settings);
      case SingleProductScreen.routeName:
        if (args != null && args is SingleProductScreenParam)
          return CupertinoRoute(
              page: SingleProductScreen(
                param: args,
              ),
              settings: settings);
        return errorRoute();
      case CartScreen.routeName:
        return CupertinoRoute(page: const CartScreen(), settings: settings);
      case OrderScreen.routeName:
        return CupertinoRoute(page: const OrderScreen(), settings: settings);
      case FollowingScreen.routeName:
        return CupertinoRoute(
            page: const FollowingScreen(), settings: settings);
      case FollowingShopCommentsScreen.routeName:
        return CupertinoRoute(
            page: FollowingShopCommentsScreen(
              shopId: args as int,
            ),
            settings: settings);
      case CheckoutScreen.routeName:
        return CupertinoRoute(page: const CheckoutScreen(), settings: settings);
      case MyAddressScreen.routeName:
        if (args != null && args is MyAddressScreenParam)
          return CupertinoRoute(
              page: MyAddressScreen(
                param: args,
              ),
              settings: settings);
        return errorRoute();
      case JuzDetailsScreen.routeName:
        if (args != null && args is JuzInfo)
          return CupertinoRoute(
              page: JuzDetailsScreen(
                juzInfo: args,
              ),
              settings: settings);
        return errorRoute();
      case SportMainScreen.routeName:
        return CupertinoRoute(page: SportMainScreen(), settings: settings);
      case MatchLiveScreen.routeName:
        if (args != null && args is MatchEntity)
          return CupertinoRoute(
            page: MatchLiveScreen(
              args: args,
            ),
            settings: settings,
          );
        return errorRoute();
      case PersonalityDetailsScreen.routeName:
        if (args != null && args is PersonalityResultScreenParams)
          return CupertinoRoute(
            page: PersonalityDetailsScreen(
              params: args,
            ),
            settings: settings,
          );
        return errorRoute();
      case AddEditShippingAddressScreen.routeName:
        if (args != null && args is AddEditShippingAddressScreenParam)
          return CupertinoRoute(
            page: AddEditShippingAddressScreen(
              param: args,
            ),
            settings: settings,
          );
        return errorRoute();
      case SportHomeScreen.routeName:
        return CupertinoRoute(
            page: const SportHomeScreen(), settings: settings);
      case NotificationListScreen.routeName:
        return CupertinoRoute(
            page: const NotificationListScreen(), settings: settings);
      case ViewProfileScreen.routeName:
        return CupertinoRoute(
            page: const ViewProfileScreen(), settings: settings);
      case EditProfileScreen.routeName:
        return CupertinoRoute(
            page: const EditProfileScreen(), settings: settings);
      case EditAddressScreen.routeName:
        return CupertinoRoute(page: EditAddressScreen(), settings: settings);
      case DeleteAccountSelectReasonScreen.routeName:
        return CupertinoRoute(
            page: const DeleteAccountSelectReasonScreen(), settings: settings);
      case DeleteAccountWriteReasonScreen.routeName:
        return CupertinoRoute(
            page: DeleteAccountWriteReasonScreen(valueSelected: args as String),
            settings: settings);
      case DeleteAccountConfirmScreen.routeName:
        return CupertinoRoute(
            page: DeleteAccountConfirmScreen(
              values: args as List<String>,
            ),
            settings: settings);
      case DeleteAccountSuccessScreen.routeName:
        return CupertinoRoute(
            page: const DeleteAccountSuccessScreen(), settings: settings);

      case ChangeEmailScreen.routeName:
        return CupertinoRoute(
            page: ChangeEmailScreen(
              type: args as int,
            ),
            settings: settings);
      case ChangeEmailConfirmScreen.routeName:
        return CupertinoRoute(
            page: ChangeEmailConfirmScreen(
              args: args as Map<String, dynamic>,
            ),
            settings: settings);
      case ChangeEmailSuccessScreen.routeName:
        return CupertinoRoute(
            page: ChangeEmailSuccessScreen(
              type: args as int,
            ),
            settings: settings);
      case AllAddressesScreen.routeName:
        return CupertinoRoute(
            page: const AllAddressesScreen(), settings: settings);
      case ChangePasswordScreen.routeName:
        return CupertinoRoute(
            page: const ChangePasswordScreen(), settings: settings);
      case ChangeNameScreen.routeName:
        return CupertinoRoute(
            page: const ChangeNameScreen(), settings: settings);
      case AddNewAddressScreen.routeName:
        return CupertinoRoute(
            page: const AddNewAddressScreen(), settings: settings);
      case VisitUserProfileScreen.routeName:
        return CupertinoRoute(
            page: VisitUserProfileScreen(
              params: settings.arguments as VisitUserProfileScreenParams,
            ),
            settings: settings);
      case ViewFriendMomentsScreen.routeName:
        return CupertinoRoute(
            page: ViewFriendMomentsScreen(
              clientEntity: settings.arguments as ClientEntity,
            ),
            settings: settings);
      case ScheduleScreen.routeName:
        return CupertinoRoute(page: const ScheduleScreen(), settings: settings);
      case TableScreen.routeName:
        return CupertinoRoute(page: const TableScreen(), settings: settings);
      case TableDetailsScreen.routeName:
        return CupertinoRoute(
            page: const TableDetailsScreen(), settings: settings);
      case AllLiveMatchesScreen.routeName:
        return CupertinoRoute(
            page: AllLiveMatchesScreen(
              url: settings.arguments as String,
            ),
            settings: settings);
      case BroadcastMessageScreen.routeName:
        return CupertinoRoute(
            page: const BroadcastMessageScreen(), settings: settings);
      case GroupScreen.routeName:
        return CupertinoRoute(
            page: GroupScreen(
              params: settings.arguments as GroupScreenParams,
            ),
            settings: settings);
      case GroupDetailsScreen.routeName:
        return CupertinoRoute(
            page: GroupDetailsScreen(
              params: settings.arguments as GroupDetailsScreenParams,
            ),
            settings: settings);
      case SingleMessageScreen.routeName:
        return CupertinoRoute(
            page: SingleMessageScreen(
              params: settings.arguments as SingleMessageScreenParams,
            ),
            settings: settings);
      case CreatePollIntroScreen.routeName:
        return CupertinoRoute(
            page: const CreatePollIntroScreen(), settings: settings);
      case PollScreen.routeName:
        return CupertinoRoute(page: const PollScreen(), settings: settings);
      case EventIntroScreen.routeName:
        return CupertinoRoute(
            page: const EventIntroScreen(), settings: settings);
      case EventScreen.routeName:
        return CupertinoRoute(page: const EventScreen(), settings: settings);
      case EventScreen2.routeName:
        return CupertinoRoute(page: const EventScreen2(), settings: settings);
      case LocationMessageScreen.routeName:
        return CupertinoRoute(
            page: const LocationMessageScreen(), settings: settings);
      case MyLifeHomeScreen.routeName:
        return CupertinoRoute(
            page: const MyLifeHomeScreen(), settings: settings);
      case PositivityScreen.routeName:
        return CupertinoRoute(
            page: const PositivityScreen(), settings: settings);
      case DreamScreen.routeName:
        return CupertinoRoute(page: const DreamScreen(), settings: settings);
      case MyLifeVideoScreen.routeName:
        return CupertinoRoute(page: MyLifeVideoScreen(), settings: settings);
      case MylifeAudioScreen.routeName:
        return CupertinoRoute(page: MylifeAudioScreen(), settings: settings);
      case AppointmentScreen.routeName:
        return CupertinoRoute(
            page: const AppointmentScreen(), settings: settings);
      case TodoScreen.routeName:
        return CupertinoRoute(page: const TodoScreen(), settings: settings);
      case SingleStoryScreen.routeName:
        return CupertinoRoute(
            page: const SingleStoryScreen(), settings: settings);
      case NewsMainScreen.routeName:
        return CupertinoRoute(page: const NewsMainScreen(), settings: settings);
      case NewsHomeScreen.routeName:
        return CupertinoRoute(page: const NewsHomeScreen(), settings: settings);
      case NewsSubCategoryScreen.routeName:
        return CupertinoRoute(
            page: NewsSubCategoryScreen(
                entity: settings.arguments as SingleCategoryParams),
            settings: settings);
      case SingleNewsScreen.routeName:
        return CupertinoRoute(
            page: SingleNewsScreen(
                entity: settings.arguments as SingleNewsParams),
            settings: settings);
      case NewsSummeryScreen.routeName:
        return CupertinoRoute(
            page: const NewsSummeryScreen(), settings: settings);
      case SeeAllNewsPage.routeName:
        return CupertinoRoute(
            page: SeeAllNewsPage(
              id: settings.arguments as String,
            ),
            settings: settings);
      case EditHealthProfileScreen.routeName:
        return CupertinoRoute(
            page: const EditHealthProfileScreen(), settings: settings);
      case HealthProfileScreen.routeName:
        return CupertinoRoute(
            page: const HealthProfileScreen(), settings: settings);
      case EventHomeScreen.routeName:
        return CupertinoRoute(
            page: const EventHomeScreen(), settings: settings);
      case EventDetailsScreen.routeName:
        return CupertinoRoute(
            page: EventDetailsScreen(
              params: settings.arguments as EventDetailsScreenParams,
            ),
            settings: settings);
      case EventGalleryScreen.routeName:
        return CupertinoRoute(
            page: EventGalleryScreen(
              params: settings.arguments as EventGalleryScreenParams,
            ),
            settings: settings);
      case BuyTicketScreen.routeName:
        return CupertinoRoute(
            page: BuyTicketScreen(
              params: settings.arguments as BuyTicketScreenParams,
            ),
            settings: settings);
      case TicketDetailsScreen.routeName:
        return CupertinoRoute(
            page: TicketDetailsScreen(
              params: settings.arguments as TicketDetailsScreenParams,
            ),
            settings: settings);

      case MyTicketScreen.routeName:
        return CupertinoRoute(page: const MyTicketScreen(), settings: settings);
      case MyRunningEventsScreen.routeName:
        return CupertinoRoute(
            page: const MyRunningEventsScreen(), settings: settings);
      case EventLocationScreen.routeName:
        return CupertinoRoute(
            page: EventLocationScreen(
                params: settings.arguments as EventLocationScreenParams),
            settings: settings);
      case FoodScreen.routeName:
        return CupertinoRoute(page: const FoodScreen(), settings: settings);
      case VideoAudioChatScreen.routeName:
        return CupertinoRoute(
            page: VideoAudioChatScreen(
              params: settings.arguments as VideoAudioChatScreenParams,
            ),
            settings: settings);
      case FavoriteSessionScreen.routeName:
        return CupertinoRoute(
            page: const FavoriteSessionScreen(), settings: settings);
      case AddFriendsScreen.routeName:
        return CupertinoRoute(
            page: const AddFriendsScreen(), settings: settings);
      case FriendsScreen.routeName:
        return CupertinoRoute(page: const FriendsScreen(), settings: settings);
      case BlockedPeopleScreen.routeName:
        return CupertinoRoute(
            page: const BlockedPeopleScreen(), settings: settings);
      case MyContactsScreen.routeName:
        return CupertinoRoute(
            page: const MyContactsScreen(), settings: settings);
      case RemoveGroupMembersScreen.routeName:
        return CupertinoRoute(
            page: RemoveGroupMembersScreen(
                params: settings.arguments as RemoveGroupMemberParams),
            settings: settings);
      case SendContactMessageScreen.routeName:
        return CupertinoRoute(
            page: const SendContactMessageScreen(), settings: settings);
      case NearbyClientsScreen.routeName:
        return CupertinoRoute(
            page: const NearbyClientsScreen(), settings: settings);
      case FavoriteProductsScreen.routeName:
        return CupertinoRoute(
            page: const FavoriteProductsScreen(), settings: settings);
      case SharedQrcodeScreen.routeName:
        return CupertinoRoute(
            page: SharedQrcodeScreen(
              params: settings.arguments as SharedQRCodeScreenParams,
            ),
            settings: settings);
      case LiveLocationScreen.routeName:
        return CupertinoRoute(
            page: LiveLocationScreen(
              params: settings.arguments as LiveLocationScreenParams,
            ),
            settings: settings);
      case AllCountDownScreen.routeName:
        return CupertinoRoute(
            page: const AllCountDownScreen(), settings: settings);
      case HealthVideoPlayerScreenScreen.routeName:
        return CupertinoRoute(
          page: HealthVideoPlayerScreenScreen(
            link: args as String,
          ),
          settings: settings,
        );

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return errorRoute();
    }
  }
}

Route<dynamic> errorRoute() {
  return MaterialPageRoute(
    builder: (_) {
      return Scaffold(
        backgroundColor: Theme.of(
                getIt<NavigationService>().getNavigationKey.currentContext!)
            .scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ROUTE ERROR CHECK THE ROUTE GENERATOR'),
        ),
      );
    },
  );
}
