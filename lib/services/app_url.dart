class ApiUrl {
  ///=================================This is baseUrl==============================================>
  // static const baseUrl = "http://192.168.10.116:7000"; //Local
  // static const socketUrl = "http://192.168.10.116:7000";// Local

  static const baseUrl = "http://143.198.3.51:8000"; //Live
  static const socketUrl = "http://143.198.3.51:8000"; //Live

  ///=================================Authentication url==========================
  static const signupAuth = "/auth/register";
  static const otpVerificationEndPoint = "/auth/activate-user";
  static const logIn = "/auth/login";
  static const forgetOtp = "/auth/forgot-password";
  static const forgetOtpVerify = "/auth/verify-otp";
  static const resetPassword = "/auth/reset-password";
  static const resetOtpSignUp = "/auth/resend"; //state problem

  ///===================================Profile url===============================
  static const getProfile = "/auth/profile/"; //not complete
  static const editProfile = "/auth/edit-profile/"; //not complete

  ///====================================Settings url================================
  static const changePassword = "/auth/change-password"; //not complete
  static const deleteAccount = "/auth/delete-account"; //not complete

  ///==================================== Home Screen ================================
  static const banner = "/auth/forgot-password";
  static const trainingPrograms = "/training/all";
  static trainingDetails({required String id}) =>
      "/program-article/program-articles/$id";

  static const communityPost = "/post/community-posts";

  static singleCommunityPost({required String id}) => "/post/single-post/$id";

  static const postComments = "/post/add-comment";
  static const trainingProgramAll = "/program-article/all";

  ///=====================================Post Screen======================
  static const postEndpoint = "/post/add-post";
  static const getPostEndPoint = "/post/my-posts";
  static const deletePost = "/post/delete-post";
  static editPost({required String id}) => "/post/edit-post/$id";

  ///============================= Message Screen ==============================
  static getConversations({required String id}) => "/message/get-message/$id";
  static const sendMessage = "/message/send-message";
  static const createConversation = "/message/create-conversation";

  ///============================= Content Screen ==============================
  static const aboutUs = "/manage/get-about-us";

  static const privacy = "/manage/get-privacy-policy";

  static const terms = "/manage/get-terms-conditions";
  static const faq = "/manage/get-faq";

  ///============================= Notification Screen ==============================
  static const notifications = "/notification/my-notifications";
  static const notificationRead = "/notification/update-notification";

  ///===========================Subscription==========================
  static const subscriptionPlanAll = "/subscription-plan";
  static const promoCode = "/promo/unlock";
  static const getPromoPackage = "/promo-package/all";
  static const createPaymentIntent = "/payment/payment-intent";
  static const makeOrder = "/subscriptions/upgrade-plan";
  static const myPlan = "/subscriptions/my-plan";

  ///==================================Schedule Screen======================
  static const schedule = '/schedule/my-schedule';

  ///=============================Other profile============================
  static otherProfile({required String id}) => "/auth/others-profile/$id";
}
