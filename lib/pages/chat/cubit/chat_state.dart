part of 'chat_cubit.dart';

class ChatState extends Equatable {
  const ChatState({required this.messages});
  final List<ChatMessage> messages;

  factory ChatState.initial() {
    return ChatState(messages: []);
  }

  ChatState copyWith({List<ChatMessage>? messages}) {
    return ChatState(messages: messages ?? this.messages);
  }

  @override
  List<Object?> get props => [messages];
}
