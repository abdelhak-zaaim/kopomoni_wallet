class Images {
  // static const String logo = 'assets/image/logo.png';
  static const String saudi = 'assets/image/arabic.png';
  static const String english = 'assets/image/english.png';

  //
   static const String logo = 'assets/image/logo.png';
  static const String logo_splash = 'assets/image/logo_splash.png';
  static const String avatar = 'assets/image/avatar.jpg';
  static const String kopomoni_logo = 'assets/image/kopomoni.png';
  static const String onboardImage2 = 'assets/image/onboard_image_2.png';
  static const String onboardImage3 = 'assets/image/onboard_image_3.png';
  static const String onboardImage1 = 'assets/image/onboard_image_1.png';

  static const String onboardBackground1 = 'assets/image/onboard_background_1.png';
  static const String onboardBackground2 = 'assets/image/onboard_background_2.png';
  static const String onboardBackground3 = 'assets/image/onboard_background_3.png';
  static const String onboardBackground4 = 'assets/image/onboard_background_4.png';

  static const String homeIconBold = 'assets/image/home_bold.png';
  static const String homeIcon = 'assets/image/home.png';
  static const String clockIcon = 'assets/image/clock.png';
  static const String clockIconBold = 'assets/image/clock_bold.png';
  static const String scannerIcon = 'assets/image/Scan.png';
  static const String notificationIcon = 'assets/image/Notification.png';
  static const String notificationIconBold = 'assets/image/Notification_bold.png';
  static const String profileIcon = 'assets/image/Profile.png';
  static const String profileIconBold = 'assets/image/Profile_bold.png';
  static const String boldNotificationIcon ='assets/image/Notification_bold.png';
  static const String walletLogo = 'assets/image/wolet.png';
  static const String speak_icon = 'assets/image/speek.ico';

  static const String text2speak = 'assets/image/text2speak.png';
  static const String sendMoneyLogo = 'assets/image/send_money.png';
  static const String cashOutLogo = 'assets/image/cash_out.png';
  static const String receivedMoneyLogo = 'assets/image/received_money.png';
  static const String qrCode = 'assets/image/qr_code.png';
  static const String sendMoneyLogo3 = 'assets/image/sendMoney3.png';
  static const String cashOutLogo3 = 'assets/image/cashout3.png';
  static const String addMoneyLogo3 = 'assets/image/add_money.png';
  static const String requestMoneyLogo = 'assets/image/req_money.png';
  static const String pinChangeLogo = 'assets/image/pinChange.png';
  static const String privacy = 'assets/image/Privacy.png';
  static const String languageLogo = 'assets/image/Language.png';
  static const String questionLogo = 'assets/image/faq.png';
  static const String supportLogo = 'assets/image/Support.png';
  static const String aboutUs = 'assets/image/about_us.png';
  static const String terms = 'assets/image/terms.png';
  static const String failedLogo = 'assets/image/failed.png';
  static const String editProfile = 'assets/image/edit_profile.png';
  static const String requestListImage2 = 'assets/image/request_list_image2.png';
  static const String myRequestedListImage = 'assets/image/my_requested_list_image.png';
  static const String sendMoneyImage = 'assets/image/send_money.png';
  static const String logOut = 'assets/image/log_out.png';
  static const String changeTheme = 'assets/image/change_theme.png';
  static const String twoFactorAuthentication = 'assets/image/two_factor_authentication.png';
  static const String cameraIcon = 'assets/image/camera_icon.png';
  static const String eyeIcon = 'assets/image/eye_icon.gif';

  static const String failedIcon = 'assets/image/failed_icon.png';
  static const String successIcon = 'assets/image/success_icon.png';
  static const String supportImage = 'assets/image/support_image.png';

  static const String onSelect = 'assets/image/on_select.png';
  static const String slideRightIcon = 'assets/image/slide_right_icon.png';
  static const String withdraw = 'assets/image/withdraw.png';
  static const String payment = 'assets/image/payment.png';
  static const String transactionLimit = 'assets/image/transaction_limit.png';

  static String getTransactionImage(transactionType) => 'assets/image/${
      transactionType == 'cash_in' ? 'send_money' : transactionType
  }.png';

  //other info
  static const String male = 'assets/image/Male.png';
  static const String female = 'assets/image/Female.png';
  static const String other = 'assets/image/Other_gender.png';



  static const String editIcon = 'assets/image/Edit.png';
  static const String inputStackDesing = 'assets/image/design.png';
  static const String placeholder = 'assets/image/placeholder.jpg';
  static const String bannerPlaceHolder = 'assets/image/banner_place_holder.png';
  static const String webLinkPlaceHolder = 'assets/image/web_link_place_holder.png';
  static const String noData = 'assets/image/no_data.png';
  static const String fingerprint = 'assets/image/fingerprint.png';

  //animation
  static const String failedAnimation = 'assets/animationFile/failed_animation.json';
  static const String successAnimation = 'assets/animationFile/success_animation.json';
  static const String contactPermissionDeniAnimation = 'assets/animationFile/contact_denied_animation.json';
  static const String customerSupport = 'assets/animationFile/customer_support_animation.json';
  static const String qrScanAnimation = 'assets/image/qr_scan.gif';

  static String getPaymentImage(String name) => 'assets/payment/$name.png';

}
