// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class Applink {
  // static String host = myServices.sharedPreferences.getString('server') ?? "";
  static String host = "https://api.alrafidain-iq.com/";
  // static String host = "http://4.1.9.147:5000/";

  static String server = "${host}api/";
  static String serverImage = host;
  static String sendOtp = "${server}auth/send-otp";
  static String verifyOtp = "${server}auth/verify-otp";
  static String register = "${server}auth/register";
  static String login = "${server}auth/login";
  static String resetPassword = "${server}auth/reset-password";
  //================customer====================================
  static String customer = "${server}customer/";
  //================InfluencerData==============================
  static String influencer = "${server}influencer/";
  //================Agent==============================
  static String agent = "${server}agent/";
  static String merchant = "${server}merchant/";
}
