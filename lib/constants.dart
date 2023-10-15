class Constants {
  static String host = "http://192.168.237.230:8000";

  static String chatHost = "http://192.168.237.230:4000";

  static Uri getOtp = Uri.parse("$host/api/v1/user/get_otp");
  static Uri verifyOtp = Uri.parse("$host/api/v1/user/verify_otp");

  static Uri getChats = Uri.parse("$host/api/v1/user/my_chats");

  static Uri getIndividualChat(String roomId) {
    return Uri.parse("$host/api/v1/user/my_room_chat?room_id=$roomId");
  }
}
