import 'package:chat/api/chat_provider.dart';
import 'package:chat/api/message_provider.dart';
import 'package:chat/models/chat_individual_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/socket_provider.dart';

class ChatScreen extends StatefulWidget {
  final String roomId;

  const ChatScreen({super.key, required this.roomId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late SocketProvider _socketProvider;

  @override
  void initState() {
    super.initState();
    // ChatProvider.instance.getIndividualChat(widget.roomId);
    SocketProvider.instance.joinChatroom(widget.roomId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomId.toString()),
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: SocketProvider.instance),
        ],
        child: buildMainUI(),
      ),
    );
  }

  final TextEditingController _controller = TextEditingController();

  Widget buildMainUI() {
    return Builder(builder: (BuildContext innercontext) {
      _socketProvider = Provider.of<SocketProvider>(innercontext);

      return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 600,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _socketProvider.chatData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    child: Text(
                      _socketProvider.chatData[index].toString(),
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 40,
              width: 320,
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  SizedBox(
                    width: 260,
                    child: TextField(
                      controller: _controller,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        print(_controller.text);
                        _socketProvider.emitEvent(
                            _controller.text, widget.roomId);
                      },
                      icon: Icon(Icons.send))
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
