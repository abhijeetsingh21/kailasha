import 'package:kailasha/core/utils/common_enums.dart';

class ChatMessage {
  String id;
  String message;
  ChatSender chatSender;
  DateTime sentTime;
  ChatMessage({
    required this.chatSender,
    required this.message,
    required this.sentTime,
    required this.id,
  });
}
