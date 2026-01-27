import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kailasha/core/models/chat_messages_model/chat_message_model.dart';
import 'package:kailasha/core/utils/common_enums.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState.initial());

  Future<void> sendMessage({required String message}) async {
    final finalMessage = ChatMessage(
      chatSender: ChatSender.driver,
      message: message,
      sentTime: DateTime.now(),
      id: DateTime.now().toIso8601String(),
    );

    final newMessages = [...state.messages, finalMessage];

    emit(state.copyWith(messages: newMessages));
  }
}
