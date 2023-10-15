import 'dart:convert';

import 'package:chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  static AuthProvider instance = AuthProvider();
  AuthProvider();

  int? otpId;

  String? token;
  String? userId;
  String? orgId;

  Future<int?> sendOTP(int phonenumber) async {
    http.Response response = await http.post(
      Constants.getOtp,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "country_code": 91,
          "phone_no": phonenumber,
        },
      ),
    );

    print(jsonDecode(response.body));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['otp_id'];
    }
    return null;
  }

  Future<bool> verifyOTP(
    int otp,
    int otpId,
  ) async {
    bool islogin = false;
    http.Response response = await http.post(
      Constants.verifyOtp,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {"otp": otp, "otp_id": otpId},
      ),
    );

    print(jsonDecode(response.body));

    if (response.statusCode == 200) {
      islogin = true;
      token = jsonDecode(response.body)['token'];
      userId = jsonDecode(response.body)['user_id'].toString();
      orgId = jsonDecode(response.body)['org_id'].toString();
      return islogin;
    }
    return islogin;
  }
}
