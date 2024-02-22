import '../constants/app/app_constants.dart';

/// API
class APIUrls {
  /// Domain url
  /// Live Url
  static const BASE_URL = "https://mohraapp.com:9090";
  // static const BASE_URL = "https://mohraapp.com:8081";
  // static const BASE_URL = "https://staging-api.mohraapps.com";
  static const PRAYER_TIME_URL = "http://api.aladhan.com/v1/timings";
  static const NEARBY_SEARCH_URL =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json";
  static const FIND_PLACE_URL =
      "https://maps.googleapis.com/maps/api/place/findplacefromtext/json";
  static const API_REVERSE_GEOCODING =
      "https://maps.googleapis.com/maps/api/geocode/json";

  static const SPORT_API_URL = 'https://livescore-api.com/api-client/';

  /// Urls
  static const API_JP_COMMENTS = "comments";

  ///Notification
  static const API_AllNotification =
      "/api/services/app/Notification/GetAllMyNotification";
  static const API_CreateNotification =
      "/api/services/app/Notification/CreateNotification";
  static const DeleteNotificationById =
      "/api/services/app/Notification/DeleteNotificationById";
  static const DeleteAllMyNotification =
      "/api/services/app/Notification/DeleteAllMyNotification";
  static const GetCountUnread =
      "/api/services/app/Notification/HomePageNotificationsCounts";

  //news
  static const API_NEWS_CATEGORY = "/api/services/app/NewsCategory/GetAll";
  static const API_SINGLE_CATEGORY = "/api/services/app/NewsCategory/Get";
  static const API_NEWS_OF_SINGLE_CATEGORY = "/api/services/app/News/GetAll";
  static const API_SUMMERY_NEWS = "/api/services/app/News/GetCityRelatedNews";
  static const API_NEWS = "/api/services/app/News/Get";

  /// sport APIs
  static const getAllLiveScores =
      'https://livescore-api.com/api-client/scores/live.json&key=${AppConstants.SPORT_API_APP_KEY}&secret=${AppConstants.SPORT_API_APP_SECRET}';
  static const getMatchStatistics =
      'https://livescore-api.com/api-client/matches/stats.json';
  static const getMatchEvent =
      'https://livescore-api.com/api-client/scores/events.json';
  static const getMatchLineUp =
      'https://livescore-api.com/api-client/matches/lineups.json';

  ///store APIS  CreateReview
  static const SliderImages =
      "${APIUrls.BASE_URL}/api/services/app/SliderImage/GetAll";
  static const TopCategory =
      "${APIUrls.BASE_URL}/api/services/app/Category/GetAll?Sorting=Top";
  static const shopsList = "${APIUrls.BASE_URL}/api/services/app/Shop/GetAll";
  static const singleShop = "${APIUrls.BASE_URL}/api/services/app/Shop/Get";
  static const TopProducts =
      "${APIUrls.BASE_URL}/api/services/app/Product/GetAll?Sorting=TopSelling";
  static const productsList =
      "${APIUrls.BASE_URL}/api/services/app/Product/GetAll";
  static const StoreCategorys =
      "${APIUrls.BASE_URL}/api/services/app/Category/GetAll";
  static const Review = "${APIUrls.BASE_URL}/api/services/app/Review/GetAll";
  static const ProductItem = "${APIUrls.BASE_URL}/api/services/app/Product/Get";
  static const CreateReview =
      "${APIUrls.BASE_URL}/api/services/app/Review/Create";
  static const Feature = "${APIUrls.BASE_URL}/api/services/app/Product/Feature";
  static const UnFeature =
      "${APIUrls.BASE_URL}/api/services/app/Product/UnFeature";
  static const API_CHECK_COUPON_VALIDITY =
      "/api/services/app/Coupon/CheckCouponValidity";
  static const API_FOLLOW_SHOP = "/api/services/app/Shop/FollowShop";
  static const API_CREATE_ORDER = "/api/services/app/Order/Create";
  static const API_GET_ORDERS = "/api/services/app/Order/GetAll";
  static const API_DETAILS_ORDERS = "/api/services/app/Order/Get";
  static const API_UN_FOLLOW_SHOP = "/api/services/app/Shop/UnFollowShop";
  static const API_GET_FAVORITE_PRODUCTS =
      "/api/services/app/Favorite/GetAllFavoriteProduct";
  static const API_CREATE_SHIPPING_ADDRESS =
      "/api/services/app/ShippingAddress/Create";
  static const API_GET_SHIPPING_ADDRESSES =
      "/api/services/app/ShippingAddress/GetAll";
  static const API_UPDATE_SHIPPING_ADDRESS =
      "/api/services/app/ShippingAddress/Update";
  static const API_DELETE_SHIPPING_ADDRESS =
      "/api/services/app/ShippingAddress/Delete";
  static const API_CREATE_Product_FAVORITE =
      '/api/services/app/Product/AddToFavorite';
  static const API_DELETE_Product_FAVORITE =
      '/api/services/app/Product/RemoveFromFavorite';
  static const API_GetFeesPercentage =
      '/api/services/app/Configuration/GetFeesPercentage';

  ///event APIs
  //static const API_GET_ALL_EVENTS = '/api/services/app/Event/GetAllForMobile';
  static const API_GET_ALL_EVENTS = '/api/services/app/Event/GetAll';
  static const API_GET_EVENT_CATEGORIES =
      '/api/services/app/EventCategory/GetAll';
  static const API_GET_EVENT = '/api/services/app/Event/Get';
  static const API_CREATE_EVENT_TICKET =
      '/api/services/app/TicketTicket/CreateListTicket';
  static const API_GET_EVENT_TICKETS = '/api/services/app/TicketTicket/GetList';
  static const API_GET_EVENT_TICKET = '/api/services/app/TicketTicket/Get';
  static const API_GET_MY_RUNNING_EVENT =
      '/api/services/app/Event/GetMyRunningEvent';
  static const getTicketsByEventId =
      "/api/services/app/TicketTicket/GetTicketByEventIdForMobileApp";
  static const API_TICKET_SCANNED_QR_CODE =
      '/api/services/app/TicketTicket/ScannedQRCode';
  static const API_CHECK_IF_CAN_PAY =
      '/api/services/app/TicketTicket/CanPurchaseTickets';
  static const API_CHECK_IF_CAN_CREATE_ORDER =
      '/api/services/app/Order/CanOrder';

  static const API_CREATE_PAYMENT = '/api/services/app/Payment/Create';
  static const manualCheckTicket =
      '/api/services/app/TicketTicket/ManualChangeScanned';
  static const getTicketReportByEventId =
      '/api/services/app/TicketTicket/GetTicketReportByEventId';

  //relgion
  static const API_AZKAR_OF_CATEGORY = "/api/services/app/Azkar/GetAll";

  /// health food end points
  static const getAllFoodCategories = "/api/services/app/FoodCategory/GetAll";
  static const createDailyFood = "/api/services/app/DailyDish/Create";
  static const getDailyDishList = "/api/services/app/DailyDish/GetAll";
  static const getDishListByCategory = "/api/services/app/Dish/GetAll";
  static const getRecipeListByCategory = "/api/services/app/Recipe/GetAll";
  static const getDishById = "/api/services/app/Dish/Get";
  static const getFavoriteDishes =
      "/api/services/app/Favorite/GetAllFavoriteDish";
  static const getFavoriteRecipes =
      "/api/services/app/Favorite/GetAllFavoriteRecipe";
  static const getFavoriteSessions =
      "/api/services/app/Favorite/GetAllFavoriteSession";
  static const getRecommendedFood = "/api/services/app/Dish/GetRecommendedFood";
  static const getDailySessions = "/api/services/app/DailySession/GetAll";
  static const createDailySession = "/api/services/app/DailySession/Create";
  static const getRecommendedSession =
      "/api/services/app/Session/GetRecommendedSession";
  static const updateGoal = "/api/services/app/HealthProfile/UpdateGoalWeight";
  static const updateDailyWater =
      "/api/services/app/HealthProfile/UpdateDailyCupsOfWater";
  static const getHealthDashboard =
      "/api/services/app/HealthProfile/GetDailyHealthInfo";
  static const checkHealthProfile =
      "/api/services/app/HealthProfile/GetHealthProfileInfo";
  static const getUserResults =
      "/api/services/app/HealthProfile/GetHealthyResultScreen";
  static const updateDailySteps =
      "/api/services/app/HealthProfile/UpdateDailyStepsWalk";

  /// personality
  static const getPersonalityQuestions = "/api/services/app/Question/GetAll";
  static const getMyAvatar = "/api/services/app/Avatar/GetMyAvatar";
  static const hasAvatar = "/api/services/app/Avatar/HasAvatar";
  static const saveAnswers =
      "/api/services/app/Question/SavePersonalityAnswers";
  static const openApp = "/api/services/app/Client/OpenMohraApp";
  static const closeApp = "/api/services/app/Client/CloseMohraApp";

  /// settings
  static const getSettings = "/api/services/app/Client/GetSettingForClient";
  static const updateUserSettings = "/api/services/app/Client/UpdateSetting";
  static const updateCommentsSettings =
      "/api/services/app/Client/UpdateCommentPrivacySetting";
  static const updateMomentsSettings =
      "/api/services/app/Client/UpdateMomentPrivacySetting";

  /// salary count
  static const getAllTimeTable =
      "/api/services/app/TimeTable/GetAllTimeTableForClient";
  static const changeSelectedTimeTable =
      "/api/services/app/TimeTable/ChangeIsSelected";
  static const createTimeTable = "/api/services/app/TimeTable/Create";
  static const deleteTimeTable = "/api/services/app/TimeTable/Delete";
  static const updateTimeTable = "/api/services/app/TimeTable/Update";
  static const changeOrder = "/api/services/app/TimeTable/ChangeIsSelected";
  static const customizeTimeTable =
      "/api/services/app/TimeTable/CustomizeTimeTable";

  ///health exercise and session endpoint
  static const getAllExercises = "/api/services/app/Exercise/GetAll";
  static const getAllSessions = "/api/services/app/Session/GetAll";

  //my life
  static const getAllTodoTasks = "/api/services/app/ToDoTask/GetAll";
  static const createTask = "/api/services/app/ToDoTask/Create";
  static const checkTask = "/api/services/app/ToDoTask/Check";
  static const checkAppointment = "/api/services/app/Appointment/Check";
  static const getAllAppointments = "/api/services/app/Appointment/GetAll";
  static const getAllPositives = "/api/services/app/PositiveHabit/GetAll";
  static const createAppointments = "/api/services/app/Appointment/Create";
  static const getClients = "/api/services/app/User/GetAllLite?Type=1&MaxResultCount=100";
  static const createPositive = "/api/services/app/PositiveHabit/Create";
  static const updatePositive = "/api/services/app/PositiveHabit/Update";
  static const deletePositive = "/api/services/app/PositiveHabit/Delete";
  static const getQuote = "/api/services/app/Index/GetQuoteRandomly";
  static const getAllStories = "/api/services/app/Story/GetAll";
  static const deleteAppointment = "/api/services/app/Appointment/Delete";
  static const deleteToDo = "/api/services/app/ToDoTask/Delete";
  static const updateAppointment = "/api/services/app/Appointment/Update";

  // health profile
  static const getQuestions =
      "/api/services/app/HealthProfile/GetHealthProfileQuestions";
  static const createProfile = "/api/services/app/HealthProfile/Create";
  static const updateProfile = "/api/services/app/HealthProfile/Update";
  static const answerQuestions = "/api/services/app/HealthProfile/Answer";

// moments
  static const getMoments = "/api/services/app/Moment/GetAll";
  static const getPoints = "/api/services/app/Client/GetClientPoints";
  static const createPost = "/api/services/app/Moment/Create";
  static const editPost = "/api/services/app/Moment/Update";
  static const deletePost = "/api/services/app/Moment/Delete";
  static const reportPost = "/api/services/app/Report/Create";

  /// my life - dreams
  static const getAllDreams = "/api/services/app/LifeDream/getAll";
  static const createDream = "/api/services/app/LifeDream/Create";
  static const checkDream = "/api/services/app/LifeDream/Check";
  static const unCheckDream = "/api/services/app/LifeDream/UnCheck";
  static const deleteDream = "/api/services/app/LifeDream/Delete";

  /// upload image
  static const uploadImage = '/api/services/app/Image/UploadImage';
  static const uploadVideo = '/api/services/app/Image/UploadVideo';
  static const uploadAudio = '/api/services/app/Image/UploadVoice';
  static const uploadDoc = '/api/services/app/Image/UploadDoc';

  static const uploadImageMahmoud = '/api/services/app/Image/UploadImages';

  ///// account
  static const CreateRegister =
      "${APIUrls.BASE_URL}/api/services/app/Account/Register";
  static const Verify =
      "${APIUrls.BASE_URL}/api/services/app/Account/VerifyAccount";
  static const Login = "${APIUrls.BASE_URL}/api/TokenAuth/Authenticate";
  static const Logout = "${APIUrls.BASE_URL}/api/TokenAuth/Logout";
  static const ForgetPassword =
      "${APIUrls.BASE_URL}/api/services/app/Account/ForgotPassword";
  static const ConfirmPassword =
      "${APIUrls.BASE_URL}/api/services/app/Account/ConfirmForgotPassword";
  static const verifyPasswordCode =
      "/api/services/app/Account/VerifyForgotPasswordCode";

  static const GET_ALL_CLIENTS = "/api/services/app/Client/GetAll";
  static const GET_CLIENT_PROFILE = "/api/services/app/Client/GetClientProfile";
  static const UPDATE_LOCATION = "/api/services/app/Client/UpdateLocation";
  static const GET_NEARBY_CLIENTS =
      "/api/services/app/Client/GetClientNearByMe";
  static const UPDATE_FIREBASE_TOKEN =
      "/api/services/app/Account/UpdateUserFirebaseToken";
  static const ChangeLang = "/api/services/app/Client/ChageLaguageProfile";

  ///likes and comments
  static const API_GET_COMMENTS = '/api/services/app/Comment/GetAll';
  static const API_COMMENT = '/api/services/app/Comment/Create';
  static const API_LIKE = '/api/services/app/Like/Create';
  static const API_UNLIKE = '/api/services/app/Like/Delete';
  static const API_INTERACT = '/api/services/app/Interaction/Create';
  static const API_DELETE_INTERACT = '/api/services/app/Interaction/Delete';
  static const getInteraction = '/api/services/app/Interaction/GetAll';

  /// favorites
  static const API_GET_FAVORITES = '/api/services/app/Favorite/GetAll';
  static const API_CREATE_FAVORITE = '/api/services/app/Favorite/Create';
  static const API_DELETE_FAVORITE = '/api/services/app/Favorite/Delete';
  static const API_DELETE_FAVORITE_BY_REF_TYPE_ID =
      '/api/services/app/Favorite/DeleteByRefTypeAndRefId';

  /// Messaging
  static const API_ADD_FRIEND_BY_QR_CODE =
      '/api/services/app/Friend/AddFriendByQRCodet';

  /// Help
  static const getAllFaqs = '/api/services/app/FAQ/GetAll';
  static const getAboutUs = '/api/services/app/About/Get?id=1';
  static const getAllReasons = '/api/services/app/ConnectUsTicketType/GetAll';
  static const createContactUsTicket =
      '/api/services/app/ConnectUsTicket/Create';

  /// friend
  static const API_SEND_FRIEND_REQUEST =
      '/api/services/app/Friend/SendFriendRequest';
  static const API_APPROVE_FRIEND_REQUEST =
      '/api/services/app/Friend/ApprovFriendRequest';
  static const API_REJECT_FRIEND_REQUEST =
      '/api/services/app/Friend/RejectFriendRequest';
  static const API_GET_CLIENTS = '/api/services/app/Client/GetAll';
  static const API_GET_CLIENTS_WITHOUT_MY_FRIENDS =
      '/api/services/app/Client/GetClientWithoutMyFriends';
  static const API_GET_FRIEND_REQUESTS =
      '/api/services/app/Friend/GetMyFrinedRequest';
  static const API_GET_MY_FRIENDS = '/api/services/app/Friend/GetMyFrined';
  static const API_GET_MY_FRIENDS_TO_CHALLENGE =
      '/api/services/app/Challenge/GetAllFriendsForChallenge';
  static const API_DELETE_FRIEND = '/api/services/app/Friend/Delete';
  static const API_BLOCK_FRIEND = '/api/services/app/Friend/Block';
  static const API_UNBLOCK_FRIEND = '/api/services/app/Friend/UnBock';
  static const API_CHANGE_MUTE = '/api/services/app/Friend/ChangeMuteStatus';
  static const API_CANCEL_FRIEND_REQUEST =
      '/api/services/app/Friend/CancelFriendRequest';
  static const API_Get_Frined_Status =
      '/api/services/app/Friend/GetFrinedStatus';

  /// Messages
  static const API_GET_MY_CONVERSATIONS =
      '/api/services/app/Conversation/GetAll';
  static const API_MAKE_CALL_NOTIFICATION =
      '/api/services/app/Conversation/Call';
  static const API_Create_Current_Opened_Chat =
      '/api/services/app/Conversation/CreateCurrentOpenedChat';
  static const API_CREATE_MESSAGE =
      '/api/services/app/Conversation/CreateMessages';
  static const API_CREATE_BRODCAST_MESSAGE =
      '/api/services/app/Conversation/CreateBroadcastMessages';
  static const API_GET_MESSAGES = '/api/services/app/Conversation/GetMessages';
  static const API_GET_RTM_TOKEN = '/api/services/app/Agora/GetRtmToken';
  static const API_GET_TOKEN = '/api/services/app/Agora/GetToken';
  static const API_GET_GROUPS = '/api/services/app/Group/GetAll';
  static const API_UPDATE_GROUP = '/api/services/app/Group/Update';
  static const API_DELETE_GROUP = '/api/services/app/Group/Delete';
  static const API_ADD_FRIEND_TO_GROUP =
      '/api/services/app/Group/AddFriendToGroup';
  static const API_DELETE_FRIEND_FROM_GROUP =
      '/api/services/app/Group/DeleteFriendFromGroup';
  static const API_CLEAR_GROUP_MESSAGES =
      '/api/services/app/Group/ClearMessagesGroup';
  static const API_READ_ALL_MESSAGES =
      '/api/services/app/Conversation/ReadAllMessages';
  static const API_Change_Mute_Status =
      '/api/services/app/Group/ChangeMuteStatus';
  static const API_Get_Group_Status = '/api/services/app/Group/GetGroupStatus';

  //Home&&Challenge
  static const getAllBanners = '/api/services/app/Banner/GetAll';
  static const API_GET_CHALLENGE = '/api/services/app/Challenge/GetAll';
  static const API_JOIIN_CHALLENGE = '/api/services/app/Challenge/Join';
  static const API_UNJOIIN_CHALLENGE = '/api/services/app/Challenge/UnJoin';
  static const API_CLAIMREWARDS_CHALLENGE =
      '/api/services/app/Challenge/ClaimRewards';
  static const API_INVITE_FRIENDS_CHALLENGE =
      '/api/services/app/Challenge/InviteFriends';
  static const API_CLEAR_CONVERSATION_MESSAGES =
      '/api/services/app/Conversation/ClearMessagesConversation';
  static const API_CREATE_GROUP = '/api/services/app/Group/Create';
  static const API_GET_CHALLENGE_DETAILS = '/api/services/app/Challenge/Get';
  static const API_VERIFY_CHALLENGE =
      '/api/services/app/Challenge/VerifyCreateMoment';

  /// Locations
  static const API_GET_LOCATIONS_LITE = '/api/services/app/Location/GetAllLite';

  // user and account
  static const updateUserProfile = '/api/services/app/Client/UpdateProfile';
  static const getAllCities = '/api/services/app/Location/GetAll';
  static const updateAddress = '/api/services/app/Client/UpdateAddress';
  static const createAddress = '/api/services/app/Client/CreateAddress';
  static const getAllAddresses =
      '/api/services/app/Client/GetAddressesForClient';
  static const getUserProfile = '/api/services/app/Client/GetProfile';
  static const changePassword = '/api/services/app/User/ChangePassword';
  static const deleteAddress = '/api/services/app/Client/DeleteAddress';
  static const deleteAccount = '/api/services/app/Client/DeleteMyAccount';
  static const getStory = '/api/services/app/Story/Get';
  static const changeEmail = '/api/services/app/Account/ChangeEmail';
  static const selectAddress = '/api/services/app/Client/SetDefaultAddress';
  static const loginWithGoogle = '/api/TokenAuth/CheckGoogleAccount';
  static const registerWithGoogle = '/api/TokenAuth/RegisterUsingGoogle';
  static const confirmPhoneNumber =
      '/api/services/app/Client/ConfirmPhoneNumber';
  static const getMyFriendMoments =
      '/api/services/app/Moment/GetMyFriendMoments';
  static const checkPhoneNumberIfExist =
      '/api/services/app/Account/CheckPhoneNumberIfExist';
  static const checkEmailIfExist =
      '/api/services/app/Account/CheckEmailIfExist';
  static const checkUsernameIfExist =
      '/api/services/app/Account/CheckUserNameIfExist';
  static const checkDeviceId = '/api/services/app/Account/CheckDeviceIdAsuync';
}
