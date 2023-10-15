import 'package:chat/api/message_provider.dart';
import 'package:chat/models/chat_individual_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../constants.dart';
import '../models/chat_data_model.dart';
import 'auth_provider.dart';

enum SocketStatus { connecting, connected, disconnected }

class SocketProvider extends ChangeNotifier {
  io.Socket? socket;
  SocketStatus status = SocketStatus.disconnected;
  static SocketProvider instance = SocketProvider();
  SocketProvider();

  Future<void> establishSocketConnection() async {
    if (socket != null) {
      await destroy();
    }
    try {
      socket = io.io(
        Constants.chatHost,
        io.OptionBuilder()
            .setTransports(["websocket"])
            .disableAutoConnect()
            .setExtraHeaders({"ngrok-skip-browser-warning": "True"})
            .setQuery({
              "user_id": AuthProvider.instance.userId,
              "secure_token": AuthProvider.instance.token,
            })
            .build(),
      );
      status = SocketStatus.connecting;
      notifyListeners();
      socket!.connect();
      status = SocketStatus.connected;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  List<String> chatData = [];

  Future<void> joinChatroom(String roomId) async {
    if (socket == null) {
      await establishSocketConnection();
    }
    socket!.emit("joinRoom", [roomId, "3"]);
    socket!.on("messageRecieve", (data) {
      print("1- ${data[0]}");
      chatData.add(data[0]);
    });
  }

  Future<void> emitEvent(dynamic message, String roomId) async {
    if (socket == null) {
      await establishSocketConnection();
    }
    socket!.emit("messageSend", [message, "3", "Kshitiz", roomId]);
  }

  Future<void> destroy() async {
    if (socket != null) {
      socket!.clearListeners();
      socket!.dispose();
      socket = null;
      status = SocketStatus.disconnected;
      notifyListeners();
    }
  }
}
