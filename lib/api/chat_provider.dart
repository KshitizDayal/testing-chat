import 'dart:convert';

import 'package:chat/models/chat_data_model.dart';
import 'package:chat/models/chat_individual_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class ChatProvider extends ChangeNotifier {
  static ChatProvider instance = ChatProvider();
  ChatProvider();

  List<ChatDataModel> chatData = [];
  // List<ChatIndividualData> chatindividualData = [];

  final String authtoken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjozfQ.-qCfN_YlI-oYg2LfkZjjJeCz4TrjFEwaMf5trUQjcLY";
  final String userid = "3";
  final String orgid = "1";

  Future<List<ChatDataModel>?> getChatData() async {
    http.Response response = await http.get(
      Constants.getChats,
      headers: {
        "Content-Type": "application/json",
        "secure-token": authtoken,
        "user-id": userid
      },
    );

    print(jsonDecode(response.body));

    if (response.statusCode == 200) {
      List<dynamic> tempdata = jsonDecode(response.body)['chats'];
      chatData = tempdata.map((e) => ChatDataModel.fromJson(e)).toList();
      return chatData;
    }
    return null;
  }

  // Future<List<ChatIndividualData>?> getIndividualChat(String roomId) async {
  //   http.Response response = await http.get(
  //     Constants.getIndividualChat(roomId),
  //     headers: {
  //       "Content-Type": "application/json",
  //       "secure-token": authtoken,
  //       "user-id": userid
  //     },
  //   );

  //   print(jsonDecode(response.body));

  //   if (response.statusCode == 200) {
  //     List<dynamic> tempdata = jsonDecode(response.body)['chat'];
  //     chatindividualData =
  //         tempdata.map((e) => ChatIndividualData.fromJson(e)).toList();
  //     return chatindividualData;
  //   }
  //   return null;
  // }
}
