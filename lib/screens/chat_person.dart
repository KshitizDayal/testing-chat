import 'package:chat/api/chat_provider.dart';
import 'package:chat/models/chat_data_model.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/socket_provider.dart';

class ChatPerson extends StatefulWidget {
  const ChatPerson({super.key});

  @override
  State<ChatPerson> createState() => _ChatPersonState();
}

class _ChatPersonState extends State<ChatPerson> {
  late ChatProvider _chatProvider;

  @override
  void initState() {
    super.initState();
    ChatProvider.instance.getChatData();
    SocketProvider.instance.establishSocketConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chatting"),
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: ChatProvider.instance),
        ],
        child: buildMainUI(),
      ),
    );
  }

  Widget buildMainUI() {
    return Builder(
      builder: (BuildContext innercontext) {
        _chatProvider = Provider.of<ChatProvider>(innercontext);

        List<ChatDataModel> chatlist = _chatProvider.chatData;

        return ListView.builder(
          itemCount: chatlist.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(
                      roomId: chatlist[index].roomId!.toString(),
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      chatlist[index].roomId.toString(),
                      style: const TextStyle(
                        fontSize: 26,
                        color: Color(0xFF000000),
                      ),
                    ),
                    for (int i = 0; i < chatlist[index].chatName!.length; i++)
                      // check using with the current id stored in local storage
                      if (chatlist[index].chatName![i].id != 3)
                        Text(
                          chatlist[index].chatName![i].name.toString(),
                          style: const TextStyle(
                            fontSize: 26,
                            color: Color(0xFF000000),
                          ),
                        ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
