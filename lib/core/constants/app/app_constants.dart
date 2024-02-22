import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:starter_application/core/class/feeling.dart';

/// Centralizing application constants
class AppConstants {
  AppConstants._();

  static const TITLE_APP_NAME = 'Mohra';
  static int serviceProviderNotificationCount = 0;

  //Todo create app vPadding and add it to screenPadding
  static final hPadding = 35.h;
  static EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: hPadding,
  );
  static final bottomNavigationBarHeight = 0.12.sh;
  static final songControlHeight = 170.h;

  // static final appBarHeight = 70.0;

  /// Shared Preference keys
  static const KEY_LANGUAGE = 'language';
  static const KEY_TOKEN = 'token';
  static const KEY_USERID = 'userId';
  static const KEY_CARD = 'CARD';
  static const KEY_FIREBASE_TOKEN = 'firebase_token';
  static const KEY_FIRST_START = 'First_start';
  static const KEY_APP_THEME = 'appTheme';
  static const KEY_CHAT_ID = 'chatId';
  static const KEY_RELIGION_LAST_READ = 'religion_last_read';
  static const KEY_SPOTIFY_AUTH = 'KEY_SPOTIFY_AUTH';
  static const KEY_CART = 'KEY_CART';
  static const KEY_HANDYMAN_SERVICE = 'KEY_HANDYMAN_SERVICE';
  static const KEY_Event_Quantity = 'Event_Free';

  static const FONT_FAMILY = '';

  /// if health profile setup before
  static const HEALTH_PROFILE_DONE = 'health_profile_done';
  static const HEALTH_QUESTION_ANSWER_DONE = 'question_answer_done';

  /// if personality done
  static const HAS_PERSONALITY_AVATAR = 'has_avatar';

  ///dynamic links
  static const KEY_DYNAMIC_LINKS_PREFIX = 'https://mohra.page.link';
  static const KEY_DYNAMIC_LINKS_BASE_URL = 'https://www.m0hra.com/';
  static const KEY_PACKAGE_NAME = 'app.mohraapp.com.android';
  static const KEY_IOS_BUNDLE_ID = 'app.mohraapp.com.ios';
  static const KEY_DYNAMIC_LINKS_TYPE = 'type';

  ///dynamic links url type
  static const KEY_DYNAMIC_LINKS_EVENT = 'EVENT';
  static const KEY_DYNAMIC_LINKS_TICKET = 'TICKET';
  static const KEY_DYNAMIC_LINKS_NEWS = 'NEWS';
  static const KEY_DYNAMIC_LINKS_SINGLE_NEWS = 'NEWS';
  static const KEY_DYNAMIC_LINKS_PRODUCTSTORE = 'PRODUCTSTORE';
  static const KEY_DYNAMIC_LINKS_STORY = "VIIDEO";
  static const KEY_DYNAMIC_LINKS_PERSONALITY = "PERSONALITY";
  static const KEY_DYNAMIC_LINKS_QRCODE = "QRCODE";

  /// agora
  static const AGORA_APP_ID = '32e8858e560843749f03bf0c5fd76652';
  static const AGORA_APP_KEY = '61482359#1043827';
  static const AGORA_APP_TEST_TOKEN =
      '00632e8858e560843749f03bf0c5fd76652IACyy2LmfEPW8ZShOeLlcBcnFVnDyDoPvAR4I1YagurL1vAQi9AAAAAAEADctlcFHSSTYwEA6AMdJJNj';
  static const AGORA_APP_ID_NO_CERT = 'f4eb2e4be4b54b3f886518bcbe0a5091';
  static const GROUP_ID_PREFIX = 'g_';

  /// Payment
  static const PublishableTestKey =
      'pk_test_rD6ZY21Nk8VRHfggRtq4nDm2UiGqLQUN1VT2aGB5';
  static const PublishableLiveKey =
      'pk_live_AvUZJxsAEhfuWANkV6v1vgod43rwqTgVVQpMkAJa';
  static const MerchantIDKey = 'merchant.app.mohraapp.com.ios';

  /// Headers
  static const HEADER_AUTH = 'authorization';
  static const HEADER_APP_VERSION = 'appversion';
  static const HEADER_OS = 'os';
  static const HEADER_SESSION = 'session';
  static const HEADER_LANGUAGE = 'Accept-Language';
  static const QUERY_PARAM_LANGUAGE = 'culture';

  /// Animations

  /// ERROR ANIMATIONS
  static const ANIM_LOTTIE_ERROR =
      "assets/anim/lottie/error/general_error_placeholder.json";
  static const ANIM_LOTTIE_ERROR_403_401 =
      "assets/images/png/error/403-error.png";
  static const ANIM_LOTTIE_ERROR_EMPTY =
      "assets/images/png/error/empty_placeholder.png";
  static const ANIM_LOTTIE_ERROR_INVALID =
      "assets/images/png/error/invalid_error.png";
  static const ANIM_LOTTIE_ERROR_SERVER =
      "assets/images/png/error/500-error.png";
  static const ANIM_LOTTIE_ERROR_TIMEOUT =
      "assets/images/png/error/timout_error.png";
  static const ANIM_LOTTIE_ERROR_UNKNOWING =
      "assets/images/png/error/unknown_error.png";

  // connection, not found

  /// Image
  static const LOGIN_BACKGROUND = "assets/png/login_background.jpg";
  static const REGISTER_BACKGROUND = "assets/png/register_background.png";
  static const IMG_APP_LOGO = "assets/images/png/app_logo.png";
  static const IMG_MARKER1 = "assets/images/png/marker1.png";
  static const IMG_NULL = "assets/images/png/error/NULL.jpg";
  static const NO_IMAGE_NULL = "assets/images/png/error/noImage.png";

  /// Intro Images
  static const IMG_SHOPPING_INTRO = "assets/images/png/shopping_intro.png";
  static const IMG_FINANCE_INTRO = "assets/images/png/finance_intro.png";
  static const IMG_HEALTH_INTRO = "assets/images/png/health_intro.png";
  static const IMG_ALL_IN_ONE_APP_INTRO =
      "assets/images/png/all_in_one_app_intro.png";

  /// Personality Images
  static const IMG_PERSONALITY_FEMALE =
      "assets/images/png/Personality_female.png";
  static const IMG_PERSONALITY_MALE = "assets/images/png/Personality_male.png";
  static const IMG_PERSONALITY_MALE_GREY_1 =
      "assets/images/png/personality_male_grey_1.png";
  static const IMG_PERSONALITY_RESULT_1 =
      "assets/images/png/personality_result_1.png";
  static const IMG_PERSONALITY_RESULT_2 =
      "assets/images/png/personality_result_2.png";
  static const IMG_START_PERSONALITY_CHECK_1 =
      "assets/images/png/start_personality_check_1.png";
  static const IMGE_PERSONALITY_CELEBRITIES =
      "assets/images/png/personality_celebrities.png";
  static const IMGE_PERSONALITY_MUSIC =
      "assets/images/png/personality_music.png";
  static const IMGE_PERSONALITY_TRAVEL =
      "assets/images/png/personality_travel.png";

  /// HomeScreen Images
  static const IMG_HOME_NIGHT = "assets/images/png/Home-Night.png";
  static const IMG_HOME_MORNING = "assets/images/png/home-morning.png";
  static const IMG_HOME_AFTERNOON = "assets/images/png/home-afternoon.png";
  static const IMG_HOME_EVENING = "assets/images/png/home-evening.png";
  static const IMG_EVENTS = "assets/images/png/event.png";
  static const IMG_HOME_EVENT = "assets/images/png/home_event.png";
  static const IMG_HEALTH = "assets/images/png/Health.png";
  static const IMG_SERVICE = "assets/images/png/Services.png";
  static const IMG_MUSIC = "assets/images/png/Music.png";
  static const IMG_NEWS = "assets/images/png/News.png";
  static const IMG_RELIGION = "assets/images/png/religion.png";
  static const IMG_SPORTS = "assets/images/png/sports.png";
  static const no_data = "assets/images/svg/no_data.svg";

  /// Challenge Images
  static const IMG_HOME_CHALLENGE = "assets/images/png/challenge_image.png";
  static const IMG_HOME_CHALLENGE_2 = "assets/images/png/challenge_image_2.png";
  static const IMG_COIN = "assets/images/png/coin.png";
  static const IMG_ONGOING_CHALLENGE_BACKGROUND =
      "assets/images/png/ongoing_challenge_background.png";
  static const IMG_ONGOING_CHALLENGE_BACKGROUND_2 =
      "assets/images/png/ongoing_challenge_background_2.png";

  /// Health Images
  static const IMG_HEALTH_INTRO2 = "assets/images/png/health_intro2.png";
  static const IMG_SPLIT_INTRO = "assets/images/png/SplitBill.png";
  static const IMG_EVENT_INTRO = "assets/images/png/event.png";
  static const IMG_POLL_INTRO = "assets/images/png/poll.png";
  static const IMG_HEALTH_FEMALE_BODY_SPECTS =
      "assets/images/png/female_body_spects.png";
  static const IMG_HEALTH_MALE_BODY_SPECTS =
      "assets/images/png/male_body_spects.png";
  static const IMG_HEALTH_CALCULATING_RESULT =
      "assets/images/png/health_calculating_result.png";
  static const IMG_HEALTH_COUNT_BACKGROUND =
      "assets/images/png/health_count_background.png";
  static const IMG_YOU_ROCK = "assets/images/png/you_rock_image.png";
  static const PNG_moment_details = "assets/images/png/PNG_moment_details.png";
  static const error_image = "assets/images/png/error_image.png";
  static const check_image = "assets/images/png/check_image.png";

  /// Religion Images
  static const IMG_RELIGION1 = "assets/images/png/religion1.png";
  static const IMG_RELIGION2 = "assets/images/png/religion2.png";
  static const IMG_RELIGION3 = "assets/images/png/religion3.png";
  static const IMG_FAJR = "assets/images/png/fajr.png";
  static const IMG_DHUHR = "assets/images/png/dhuhr.png";
  static const IMG_ASR = "assets/images/png/asr.png";
  static const IMG_MAGRHIB = "assets/images/png/magrhib.png";
  static const IMG_ISHA = "assets/images/png/isha.png";
  static const IMG_barcode = "assets/images/png/barcode.png";
  static const IMG_qrcode = "assets/images/png/qrcode.png";

  static const IMG_QUEAN = "assets/images/png/quran.png";
  static const IMG_QURAN_BORDER = "assets/images/png/quran_border.png";

  //Messages Images
  static const IMG_PERSONS = "assets/images/png/peopleFill.png";

  //Event Images
  static const IMG_MY_TICKET = "assets/images/png/my_ticket_icon.png";
  static const IMG_FILTER = "assets/images/png/filter_icon.png";
  static const filter = "assets/images/svg/filtter.svg";
  static const IMG_EVENT_DATE = "assets/images/png/event_date_img.png";
  static const IMG_EVENT_LOCATION = "assets/images/png/event_location_img.png";
  static const IMG_EVENT_TICKET = "assets/images/png/event_ticket_img.png";
  static const IMG_EVENT_ROOF = "assets/images/png/event_roof_image.png";
  static const IMG_EVENT_CANCEL = "assets/images/png/cancel_img.png";
  static const IMG_EVENT_EDIT = "assets/images/png/edit_img.png";
  static const IMG_EVENT_CIRCLED_ARROW_UP =
      "assets/images/png/circled_arrow_up.png";
  static const IMG_EVENT_PROCESSING =
      "assets/images/png/event_processing_img.png";
  static const IMG_EVENT_PROCESS_SUCCESS =
      "assets/images/png/event_success_img.png";

  /// Feelings Png

  // static const IMAGE_FEELING_AMAZING =
  //     "assets/images/png/feelings/001Amazed@3x.png";
  static const IMAGE_FEELING_Angry =
      "assets/images/png/feelings/002Angry@3x.png";
  static const IMAGE_FEELING_DIZZY =
      "assets/images/png/feelings/003Dizzy@3x.png";
  static const IMAGE_FEELING_UNHAPPY =
      "assets/images/png/feelings/004Unhappy@3x.png";
  static const IMAGE_FEELING_CHEEKY =
      "assets/images/png/feelings/005Cheeky@3x.png";
  static const IMAGE_FEELING_SERIOUS =
      "assets/images/png/feelings/006Serious@3x.png";
  static const IMAGE_FEELING_COOL = "assets/images/png/feelings/007Cool@3x.png";
  static const IMAGE_FEELING_STUPID =
      "assets/images/png/feelings/008Stupid@3x.png";
  static const IMAGE_FEELING_CRYING =
      "assets/images/png/feelings/009Crying@3x.png";
  static const IMAGE_FEELING_SAD =
      "assets/images/png/feelings/010Crying@3x.png";
  static const IMAGE_FEELING_WINK = "assets/images/png/feelings/011Wink@3x.png";
  static const IMAGE_FEELING_ANGRY =
      "assets/images/png/feelings/002Angry@3x.png";
  static const IMAGE_FEELING_BAD = "assets/images/png/feelings/012Bad@3x.png";
  static const IMAGE_FEELING_DISGUSTED =
      "assets/images/png/feelings/013Disgusted@3x.png";
  static const IMAGE_FEELING_PENSIVE =
      "assets/images/png/feelings/014Pensive@3x.png";
  static const IMAGE_FEELING_DROOLING =
      "assets/images/png/feelings/015Drooling@3x.png";
  static const IMAGE_FEELING_SILLY =
      "assets/images/png/feelings/016Silly@3x.png";
  static const IMAGE_FEELING_SATISFIED =
      "assets/images/png/feelings/017Satisfy@3x.png";
  static const IMAGE_FEELING_DEAD = "assets/images/png/feelings/018Dead@3x.png";
  static const IMAGE_FEELING_AMAZED =
      "assets/images/png/feelings/019Amazed@3x.png";
  static const IMAGE_FEELING_CONFUSED =
      "assets/images/png/feelings/020Confused@3x.png";
  static const IMAGE_FEELING_GREED =
      "assets/images/png/feelings/021Greed@3x.png";
  static const IMAGE_FEELING_GRINNING =
      "assets/images/png/feelings/022Grinning@3x.png";
  static const IMAGE_FEELING_SHOCKED =
      "assets/images/png/feelings/023Shock@3x.png";
  static const IMAGE_FEELING_HAPPY =
      "assets/images/png/feelings/024Happy@3x.png";
  static const IMAGE_FEELING_SAD2 = "assets/images/png/feelings/025Sad@3x.png";
  static const IMAGE_FEELING_TIRED =
      "assets/images/png/feelings/026Tired@3x.png";
  static final feelings = [
    // const Feeling(
    //   IMAGE_FEELING_AMAZING,
    //   "amazed",
    // ),
    const Feeling(IMAGE_FEELING_Angry, "angry"),
    const Feeling(IMAGE_FEELING_DIZZY, "dizzy"),
    const Feeling(IMAGE_FEELING_UNHAPPY, "unhappy"),
    /*    Feeling(
      IMAGE_FEELING_CHEEKY,
      Translation.current.cheeky,
    ), */
    const Feeling(IMAGE_FEELING_SERIOUS, "serious"),
    const Feeling(
      IMAGE_FEELING_COOL,
      "cool",
    ),
    const Feeling(IMAGE_FEELING_STUPID, "stupid"),
    const Feeling(IMAGE_FEELING_CRYING, "crying"),
    const Feeling(IMAGE_FEELING_SAD, "sad"),
    const Feeling(IMAGE_FEELING_WINK, "wink"),
    const Feeling(IMAGE_FEELING_BAD, "bad"),
    /* Feeling(
      IMAGE_FEELING_PENSIVE,
      Translation.current.pensive,
    ), */
    /* Feeling(
      IMAGE_FEELING_DROOLING,
      Translation.current.drooling,
    ), */
    const Feeling(IMAGE_FEELING_SILLY, "silly"),
    const Feeling(IMAGE_FEELING_SATISFIED, "satisfied"),
    /*  Feeling(
      IMAGE_FEELING_DEAD,
      Translation.current.dead,
    ), */
    const Feeling(IMAGE_FEELING_AMAZED, "amazed"),
    const Feeling(IMAGE_FEELING_CONFUSED, "confused"),
    const Feeling(
      IMAGE_FEELING_GREED,
      "greed",
    ),
    const Feeling(
      IMAGE_FEELING_GRINNING,
      "grinning",
    ),
    const Feeling(
      IMAGE_FEELING_SHOCKED,
      "shocked",
    ),
    const Feeling(
      IMAGE_FEELING_HAPPY,
      "happy",
    ),
    const Feeling(
      IMAGE_FEELING_TIRED,
      "tired",
    ),
  ];

  // static const IMAGE_FEELING_ =
  //     "assets/images/png/feelings/027Kiss@3x.png";
  // static const IMAGE_FEELING_Angry =
  //     "assets/images/png/feelings/028Kiss@3x.png";

  static const IMAGE_WINK_REACTION = "assets/images/png/NEW_WINK_PNG.png";
  static const IMAGE_LIKE_REACTION = "assets/images/png/NEW_LIKE_PNG.png";
  static const IMAGE_DISLIKE_REACTION = "assets/images/png/NEW_DISLIKE_PNG.png";
  static const IMAGE_LOVE_REACTION = "assets/images/png/NEW_LOVE_PNG.png";
  static const IMAGE_SAD_REACTION = "assets/images/png/NEW_SAD_PNG.png";
  static const IMAGE_CUDDLY_REACTION = "assets/images/png/NEW_CUDDLY_PNG.png";
  static const IMAGE_NASTY_REACTION = "assets/images/png/NEW_NASTY_PNG.png";
  static const IMAGE_SHOP = "assets/images/png/shop.png";
  static const Qr = "assets/images/png/Qr.png";

  /// Svg
  static const SVG_Love = 'assets/images/svg/love.svg';
  static const SVG_iconsCamera = 'assets/icons/camera.svg';
  static const SVG_consStar = 'assets/icons/star.svg';
  static const SVG_booking_images = "assets/images/svg/booking_images.svg";
  static const SVG_booking_list = "assets/images/svg/booking_list.svg";
  static const SVG_booking_info = "assets/images/svg/booking_info.svg";
  static const SVG_booking_stars = "assets/images/svg/booking_stars.svg";
  static const SVG_lampQR = "assets/images/svg/lampQR.svg";
  static const SVG_CAMERA_FILL = "assets/images/svg/camera-fill.svg";
  static const SVG_CAMERA_FILL2 = "assets/images/svg/camera-fill2.svg";
  static const SVG_CAMERA_MESSAGE = "assets/images/svg/messageImage.svg";
  static const SVG_SHARE_FILL = "assets/images/svg/share-fill.svg";
  static const SVG_PHONE_2 = "assets/images/svg/phone-2.svg";
  static const SVG_EMAIL = "assets/images/svg/email.svg";
  static const SVG_GRID_FILL = "assets/images/svg/grid-fill.svg";
  static const SVG_MY_LIFE = "assets/images/svg/my-life.svg";
  static const SVG_BARCODE = "assets/images/svg/barcode.svg";
  static const SVG_SCAN = "assets/images/svg/scan.svg";
  static const SVG_CONTACT_US = "assets/images/svg/contact-us.svg";
  static const SVG_MY_WALLET = "assets/images/svg/mywallet.svg";
  static const SVG_SETTINGS_2_FILL = "assets/images/svg/settings-2-fill.svg";
  static const SVG_LOG_OUT_1 = "assets/images/svg/log-out-1.svg";
  static const SVG_MORE_HORIZONTAL = "assets/images/svg/more-horizontal.svg";
  static const SVG_MORE_VERTICAL = "assets/images/svg/more2.svg";
  static const SVG_LIKE_FILL = "assets/images/svg/like-fill.svg";
  static const SVG_LIKE = "assets/images/svg/like.svg";
  static const SVG_UN_LIKE = "assets/images/svg/uhlike.svg";
  static const SVG_LIKE_MY_LIFE = "assets/images/svg/likeMy.svg";
  static const SVG_MESSAGE_SQUARE = "assets/images/svg/message-square.svg";
  static const SVG_HOME_FILL = "assets/images/svg/home-fill.svg";
  static const SVG_HOME = "assets/images/svg/home.svg";
  static const SVG_MESSAGE = "assets/images/svg/messages.svg";
  static const SVG_MOMENT_FILL = "assets/images/svg/moment-fill.svg";
  static const SVG_MERHANT = "assets/images/svg/merhant.svg";
  static const SVG_MY_LIFE_3 = "assets/images/svg/my-life3.svg";
  static const SVG_CALENDAR = "assets/images/svg/calendar.svg";
  static const SVG_PIN = "assets/images/svg/pin.svg";
  static const SVG_CHECK_MARK = "assets/images/svg/checkmark.svg";
  static const SVG_HAND = "assets/images/svg/hand.svg";
  static const SVG_IMAGE_2 = "assets/images/svg/image_2.svg";
  static const SVG_COMMENT = "assets/images/svg/comment.svg";
  static const SVG_SAD = "assets/images/svg/new_sad_reaction.svg";
  static const SVG_LOVE = "assets/images/svg/new_love_reaction.svg";
  static const SVG_LAUGH = "assets/images/svg/laugh.svg";
  static const SVG_DISLIKE = "assets/images/svg/new_dislike_reaction.svg";
  static const SVG_New_LIKE = "assets/images/svg/new_like_reaction.svg";
  static const SVG_New_NASTY = "assets/images/svg/new_nasty_reaction.svg";
  static const SVG_New_WINK = "assets/images/svg/new_wink_reaction.svg";
  static const SVG_New_CUDDLY = "assets/images/svg/new_cuddly_reaction.svg";
  static const SVG_WOW = "assets/images/svg/wow.svg";
  static const SVG_ANGRY = "assets/images/svg/angry3.svg";
  static const SVG_CLOSE = "assets/images/svg/close.svg";
  static const SVG_SEAECH = "assets/images/svg/search.svg";

  static const SVG_CHECKMARK_CIRCLE_FILL =
      "assets/images/svg/checkmark-circle-fill.svg";
  static const SVG_RADIO_BUTTON_OFF = "assets/images/svg/radio-button-off.svg";
  static const SVG_CAMERA = "assets/images/svg/camera.svg";
  static const SVG_IMAGE_FILL = "assets/images/svg/image-fill.svg";
  static const SVG_IMAGE_MESSAGE = "assets/images/svg/image.svg";
  static const SVG_MAP = "assets/images/svg/map.svg";
  static const SVG_ARROW_IOS_RIGHT = "assets/images/svg/arrow-ios-right.svg";
  static const SVG_ARROW_IOS_LEFT = "assets/images/svg/arrow-ios-left.svg";
  static const SVG_ARROW_IOS_UP = "assets/images/svg/arrow-ios-up.svg";
  static const SVG_ARROW_IOS_DOWN = "assets/images/svg/arrow-ios-down.svg";
  static const SVG_AT = "assets/images/svg/at.svg";
  static const SVG_AT_FILL = "assets/images/svg/at-fill.svg";
  static const SVG_INFO = "assets/images/svg/info.svg";
  static const SVG_INFO2 = "assets/images/svg/info2.svg";
  static const SVG_PERSON = "assets/images/svg/person.svg";
  static const SVG_FOOD = "assets/images/svg/food.svg";
  static const SVG_DUMBLES = "assets/images/svg/dumbles.svg";
  static const SVG_PLUS = "assets/images/svg/plus.svg";
  static const SVG_BAR_CHART_3 = "assets/images/svg/bar-chart-3.svg";
  static const SVG_PLUS_CIRCLE = "assets/images/svg/plus_circle.svg";
  static const SVG_DINNER = "assets/images/svg/dinner.svg";
  static const SVG_CLIPBOARD_CHECK = "assets/images/svg/clipboardCheck.svg";
  static const SVG_HEART = "assets/images/svg/heart.svg";
  static const SVG_HEART_FILL = "assets/images/svg/heart-fill.svg";
  static const SVG_HEART_SYNC = "assets/images/svg/Sync.svg";
  static const SVG_CALORIES = "assets/images/svg/calories.svg";
  static const SVG_FOOTPRINT = "assets/images/svg/footprint.svg";
  static const SVG_GLASS_OF_WATER = "assets/images/svg/glass-of-water.svg";
  static const SVG_SALAD = "assets/images/svg/salad.svg";
  static const SVG_DUMBELL = "assets/images/svg/dumbbell.svg";
  static const SVG_DUMBELL_FILL = "assets/images/svg/dumbell-fill.svg";
  static const SVG_BREAKFAST = "assets/images/svg/breakfast.svg";
  static const SVG_DINNER2 = "assets/images/svg/dinner2.svg";
  static const SVG_LUNCH = "assets/images/svg/lunch.svg";
  static const SVG_SNACKS = "assets/images/svg/snacks.svg";
  static const SVG_DUMBBELL3 = "assets/images/svg/dumbbell3.svg";
  static const SVG_VEGAN_FOOD = "assets/images/svg/vegan-food.svg";
  static const SVG_MEAL = "assets/images/svg/meal.svg";
  static const SVG_RECIPE = "assets/images/svg/recipe-book.svg";
  static const SVG_PLAY_CIRCLE_FILL = "assets/images/svg/play-circle-fill.svg";
  static const SVG_BELL = "assets/images/svg/bell.svg";
  static const SVG_VOLUME_DOWN_FILL = "assets/images/svg/volume-down-fill.svg";
  static const SVG_BOOK_WITH_MARK = "assets/images/svg/bookWithMark.svg";
  static const SVG_SHOP_ORDER = "assets/images/svg/shopOrder.svg";
  static const SVG_SHOP_CART = "assets/images/svg/shopCart.svg";
  static const SVG_SHOP_FOLLOWING = "assets/images/svg/shopFollowing.svg";
  static const SVG_SHOP_FAVOURITE = "assets/images/svg/favourite.svg";
  static const SVG_SHOP_VENDOR = "assets/images/svg/vendor.svg";
  static const SVG_SHOP_STAR = "assets/images/svg/StarFill.svg";
  static const SVG_CHAT = "assets/images/svg/chat.svg";
  static const SVG_BOOK_MARK = "assets/images/svg/bookmark.svg";
  static const SVG_BOOK_MARK_FILL = "assets/images/svg/bookmark-fill.svg";
  static const SVG_GPS = "assets/images/svg/gps.svg";
  static const SVG_SEARCH = "assets/images/svg/search.svg";
  static const SVG_MAN_FASHION = "assets/images/svg/manFashion.svg";
  static const SVG_FEMALE_FASHION = "assets/images/svg/femaleFashion.svg";
  static const SVG_KIDS_FASHION = "assets/images/svg/kidsFashion.svg";
  static const SVG_PHONE_TABLET = "assets/images/svg/phoneTablet.svg";
  static const SVG_ELECTRONIC = "assets/images/svg/electronic.svg";
  static const SVG_BOOK = "assets/images/svg/bookCategory.svg";
  static const SVG_INTERIOR = "assets/images/svg/interior.svg";
  static const SVG_KITCHEN = "assets/images/svg/kitchen.svg";
  static const SVG_OTHER = "assets/images/svg/other.svg";
  static const SVG_SINGLE_CATEGORY_APPBAR =
      "assets/images/svg/singleCategoryAppBar.svg";
  static const SVG_FILTER = "assets/images/svg/filter.svg";
  static const SVG_SORT = "assets/images/svg/sort.svg";
  static const SVG_FOLLOWING_TAG = "assets/images/svg/followingTag.svg";
  static const SVG_Points = "assets/images/svg/threePoints.svg";
  static const SVG_CHECKED = "assets/images/svg/checked.svg";
  static const SVG_UNCHECKED = "assets/images/svg/uncheck.svg";
  static const SVG_TRASH = "assets/images/svg/trash-2-fill.svg";
  static const SVG_BOX = "assets/images/svg/Box.svg";
  static const SVG_ORDER_PROCESS = "assets/images/svg/noCreditCard.svg";
  static const SVG_ORDER_DONE = "assets/images/svg/done.svg";
  static const SVG_QURAN_BORDER = "assets/images/svg/quran_border.svg";
  static const SVG_ARROW_LEFT = "assets/images/svg/arrow-left.svg";
  static const SVG_ARROW_RIGHT = "assets/images/svg/arrow-right-1.svg";
  static const SVG_SCHEDULE = "assets/images/svg/Schedule.svg";
  static const SVG_PATH = "assets/images/svg/news.svg";
  static const SVG_TABLE_SPORT = "assets/images/svg/TableSport.svg";
  static const SVG_PIN_MESSAGE = "assets/images/svg/pin_message.svg";
  static const SVG_NOTIFICATION_MESSAGE = "assets/images/svg/bellOffFill.svg";
  static const NOTIFICATION_ICON = "assets/images/svg/notification_icon.svg";
  static const SVG_DRIVE_MESSAGE = "assets/images/svg/hardDriveFill.svg";
  static const SVG_PEOPLE_MESSAGE = "assets/images/svg/peopleFill.svg";
  static const SVG_MY_CONTACTS = "assets/images/svg/my_contacts.svg";
  static const SVG_FRIENDS_ICON = "assets/images/svg/friendsIconMsg.svg";
  static const SVG_QR_MESSAGE = "assets/images/svg/recieveqrmessage.svg";
  static const SVG_QR_CONTACT = "assets/images/svg/bookFill.svg";
  static const SVG_QR_BLOCK = "assets/images/svg/block.svg";
  static const SVG_QR_Message = "assets/images/svg/qrMessage.svg";
  static const SVG_COMPASS2 = "assets/images/svg/compass_2.svg";
  static const SVG_COMPASS_NEEDLE = "assets/images/svg/compass_needle.svg";
  static const SVG_MENU_MESSAGE = "assets/images/svg/menu.svg";
  static const SVG_MIC = "assets/images/svg/mic.svg";
  static const SVG_ICON_MESSAGE = "assets/images/svg/iconsMessage.svg";
  static const SVG_FILE = "assets/images/svg/file-fill.svg";
  static const SVG_ADDRESS_CARD = "assets/images/svg/addressCard.svg";
  static const SVG_MARKER = "assets/images/svg/marker2.svg";
  static const SVG_POLL_MESSAGE = "assets/images/svg/thunderMove.svg";
  static const SVG_SPLIT_MESSAGE = "assets/images/svg/splitbill.svg";
  static const SVG_EVENT_MESSAGE = "assets/images/svg/message_event.svg";
  static const SVG_VIDEO_MESSAGE = "assets/images/svg/video.svg";
  static const SVG_SONG = "assets/images/svg/song.svg";
  static const SVG_PLAY_LIST = "assets/images/svg/playlist.svg";
  static const SVG_PLAY_LIST2 = "assets/images/svg/playlist2.svg";
  static const SVG_DOWNLOAD2 = "assets/images/svg/download2.svg";
  static const SVG_CAMERA2 = "assets/images/svg/camera2.svg";
  static const SVG_PAUSE_CIRCLE_FILL =
      "assets/images/svg/pause-circle-fill.svg";
  static const SVG_PAUSE = "assets/images/svg/pause.svg";
  static const SVG_ARROW_CIRCLE =
      "assets/images/svg/arrow-circle-right-fill.svg";
  static const SVG_Lock = "assets/images/svg/lock.svg";
  static const SVG_REPEAT2 = "assets/images/svg/repeat2.svg";
  static const SVG_SONG_BACK = "assets/images/svg/song_back.svg";
  static const SVG_SONG_NEXT = "assets/images/svg/song_next.svg";
  static const SVG_SHUFFLE3 = "assets/images/svg/shuffle3.svg";
  static const SVG_REFRESH = "assets/images/svg/refresh.svg";
  static const SVG_Picture_In_Picture =
      "assets/images/svg/picture_in_picture.svg";
  static const SVG_LOCATION = "assets/images/svg/Location.svg";
  static const SVG_lIVE_LOCATION = "assets/images/svg/currentLocation.svg";
  static const SVG_SETTINGS = "assets/images/svg/outlined.svg";
  static const SVG_FORMAT_MY_LIFE = "assets/images/svg/format.svg";
  static const SVG_POSITIVITY_MY_LIFE = "assets/images/svg/positivity.svg";
  static const SVG_DREAMS_MY_LIFE = "assets/images/svg/dreams.svg";
  static const SVG_APPOINTMENT_MY_LIFE = "assets/images/svg/appointment.svg";
  static const SVG_TO_DO_PLIST_MY_LIFE = "assets/images/svg/toDo.svg";
  static const SVG_STORY_PLIST_MY_LIFE = "assets/images/svg/story.svg";
  static const SVG_FACEBOOK = "assets/images/svg/facebookBacground.svg";
  static const SVG_INSTAGRAM = "assets/images/svg/Instagrsm.svg";
  static const SVG_QR_CODE_SCAN = "assets/images/svg/qrcode_scan.svg";
  static const SVG_MUSIC_FILL = "assets/images/svg/music-fill.svg";
  static const SVG_PIN_FILL = "assets/images/svg/pin-fill.svg";
  static const SVG_LEFT_QUOTES_SIGN = "assets/images/svg/left-quotes-sign.svg";
  static const SVG_SMILE_FILL = "assets/images/svg/smile-fill.svg";
  static const loading = "assets/images/svg/loading.svg";
  static const launcher_icon = "assets/images/png/launcher_icon.png";

  /// MY LIFE Svg
  static const SVG_AppointmentToday = "assets/images/svg/AppointmentToday.svg";
  static const SVG_ToDoListToday = "assets/images/svg/ToDoListToday.svg";
  static const SVG_DREAM = "assets/images/svg/goals.svg";

  /// profile health svg
  static const SVG_editProfile = "assets/images/svg/edit_profile.svg";
  static const SVG_sideMenu = "assets/images/svg/side_menu.svg";

  /// ERROR IMAGES
  static const ERROR_403_401 = "assets/images/png/error/403.png";
  static const ERROR_EMPTY = "assets/images/png/error/empty.png";
  static const ERROR_INVALID = "assets/images/png/error/invalid.png";
  static const ERROR_SERVER = "assets/images/png/error/server_error.png";
  static const ERROR_TIMEOUT = "assets/images/png/error/time_out.png";
  static const ERROR_UNKNOWING = "assets/images/png/error/unknowing_error.png";

  /// Languages
  static const LANG_AR = 'ar';
  static const LANG_EN = 'en';

  /// Languages code & output
  static const LANG_AR_CODE = 'AR';
  static const LANG_EN_CODE = 'EN';

  static const LANG_AR_OUTPUT = 'العربية';
  static const LANG_EN_OUTPUT = 'English';

  /// APP constants
  static const MENU_CHANGE_LANG = "assets/png/menu/change_lang.png";
  static const MENU_LOGOUT = "assets/png/menu/logout.png";

  /// Mock Json API Token
  static late int shipping = -1;

  /// Google Map
  static const API_MAP_DISTANCE = "";
  static const API_KEY_GOOGLE_MAPS = "AIzaSyDySfX1lMgwJqgptq44BrdwEAuUOsGj_jQ";
  static const MAP_DEFAULT_LOCATION = LatLng(24.774265, 46.738586);

  ///Sport Api Key and secret
  static const SPORT_API_APP_KEY = '24tw4xbOOAgLndzg';
  static const SPORT_API_APP_SECRET = 'Obhjd5iGpBc7I6jKbNgfkr481lUpytFm';

  // temp for testing
  static const TOKEN_VALUE =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjMiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiY2xpZW50IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoiY2xpZW50QGJpYWxhaC5jb20iLCJBc3BOZXQuSWRlbnRpdHkuU2VjdXJpdHlTdGFtcCI6IjVmYTE4YzVjLWZhZWItOTEzNy00NzhlLTNhMDFjYzk1MzBjYyIsImh0dHA6Ly93d3cuYXNwbmV0Ym9pbGVycGxhdGUuY29tL2lkZW50aXR5L2NsYWltcy90ZW5hbnRJZCI6IjEiLCJzdWIiOiIzIiwianRpIjoiYTVlOGNkNWUtZjA1NC00ODJiLWI0MmUtMTNiYzRhNTgyYTE4IiwiaWF0IjoxNjQ4MDU1MzAzLCJuYmYiOjE2NDgwNTUzMDMsImV4cCI6MTY1MDY0NzMwMywiaXNzIjoiTW9ocmEiLCJhdWQiOiJNb2hyYSJ9.NgzTVA7ydZpurzTgDGt9MxbpOBTfYHBoyU7SyNTDRbA';

  /// Spotify
  static const SPOTIFY_CLIENT_ID = "7953e976216d4bd1847eebcc1be221f9";
  static const SPOTIFY_REDIRECT_URL =
      "http://app.mohraapp.com.android/callback";
  static const IOS_SPOTIFY_REDIRECT_URL = "mohraios://";

  /// -------------- type function sorting ----------------
  String ASC = "ASC"; //from 0  --> 100
  String DESC = "DESC"; //from 100  --> 0

  /// -------------- type sorting ----------------
  String Price = "Price";
  String Rate = "Rate";
  String CreationTime = "CreationTime";
  String MostRequested = "MostRequested";

  /// notifications constants
  static const BASIC_CHANNEL = 'basic_channel';

  /// Salary count
  static const WATCH_IMG = "assets/images/png/watch_img.png";
  static const PLUS_ICON = "assets/images/png/plus_icon.png";
  static const MENU_ICON = "assets/images/png/menu_icon.png";

  static String checkTimeValue(int input) {
    if (input <= 9) {
      return '0${input.toString()}';
    } else {
      return input.toString();
    }
  }

  static IconData getIconBack() {
    if (Platform.isIOS) {
      return Icons.arrow_back_ios;
    } else {
      return Icons.arrow_back_outlined;
    }
  }

  /// --------------- function sort ------------------------
  String sortFunction(bool? price, bool? rate, bool? date) {
    String sort = "";
    if (price != null) {
      if (price)
        sort += Price + " " + DESC;
      else
        sort += Price + " " + ASC;
    } else if (rate != null) {
      if (rate)
        sort += Rate + " " + DESC;
      else
        sort += Rate + " " + ASC;
    } else if (date != null) {
      if (date)
        sort += CreationTime + " " + DESC;
      else
        sort += CreationTime + " " + ASC;
    } else
      sort = "";
    return sort;
  }

  static int calcAvgOfferPrice(double price, double priceOffer) {
    int calcAvgOffer = 0;
    if (priceOffer == null || priceOffer == 0 || priceOffer == price) {
      return int.tryParse("$price") ??
          int.tryParse("$priceOffer") ??
          calcAvgOffer;
    } else {
      calcAvgOffer = (100 - ((priceOffer * 100) / price)).toInt();
      return calcAvgOffer;
    }
  }
}
