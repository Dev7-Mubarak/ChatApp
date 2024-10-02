import 'package:chat_app/constants.dart';

class MessageModel {
  final String message;
  final String id;

  MessageModel({required this.id, required this.message});

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(id: jsonData['id'], message: jsonData[kMessage]);
  }
}
