class ChatDataModel {
  int? id;
  int? roomId;
  bool? isGroup;
  String? groupName;
  List<ChatName>? chatName;

  ChatDataModel(
      {this.id, this.roomId, this.isGroup, this.groupName, this.chatName});

  ChatDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomId = json['room_id'];
    isGroup = json['is_group'];
    groupName = json['group_name'];
    if (json['chat_name'] != null) {
      chatName = <ChatName>[];
      json['chat_name'].forEach((v) {
        chatName!.add(new ChatName.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['room_id'] = this.roomId;
    data['is_group'] = this.isGroup;
    data['group_name'] = this.groupName;
    if (this.chatName != null) {
      data['chat_name'] = this.chatName!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatName {
  int? id;
  String? name;

  ChatName({this.id, this.name});

  ChatName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
