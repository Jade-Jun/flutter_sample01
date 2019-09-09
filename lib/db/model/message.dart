import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message message) => json.encode(message.toJson());

class Message {
  int idx;
  String userName;
  String msg;

  Message({
    this.idx,
    this.userName,
    this.msg
  });

  factory Message.fromJson(Map<String, dynamic> json) => new Message(
    idx: json['idx'],
    userName: json['user_name'],
    msg: json['msg']
  );

  Map<String, dynamic> toJson() => {
    "user_name": userName,
    "msg" : msg
  };
}