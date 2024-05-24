import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wajed_app/common/chate/data/models/conversation_response.dart';
import 'package:wajed_app/common/chate/data/models/messages_response.dart';
import 'package:wajed_app/common/chate/data/repo/chate_repo.dart';
import 'package:wajed_app/common/chate/ui/chate_screen/chate_screen.dart';
import 'package:wajed_app/core/enums/loading_status.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import '../../../../core/services/services_locator.dart';
import '../../data/models/message_model.dart';
part 'chate_state.dart';

class ChateCubit extends Cubit<ChateState> {
  /// * dependencies
  final BaseChate _chateRepo;

  /// * init cubit
  ChateCubit(this._chateRepo) : super(const ChateState());

  static ChateCubit get(context) => BlocProvider.of<ChateCubit>(context);

  /// * add message
  Future<void> sendMessage(MessageModel message, int page) async {
    emit(state.copyWith(addMessageState: RequestState.loading));
    final result = await _chateRepo.sendMessage(message);
    result.when(success: (message) {
      getMessagesByConversationId(convId: message.convId, page: page);
      emit(state.copyWith(addMessageState: RequestState.loaded));
    }, failure: (code, error) {
      emit(state.copyWith(addMessageState: RequestState.error));
    });
  }

  /// * get conversations BY USER ID
  Future<void> getConversationsByUserId({userId, page}) async {
    emit(state.copyWith(getConversationsState: RequestState.loading));
    final result =
        await _chateRepo.getConvsByUserId(userId: userId, page: page);
    result.when(success: (data) {
      emit(state.copyWith(getConversationsState: RequestState.loaded,conversationsResponse: data));
    }, failure: (code, error) {
      emit(state.copyWith(getConversationsState: RequestState.error));
    });
  }

  /// * get conversation BY USER ID
  
  Future<void> getConversationByUserId({userOne, userTwo, context}) async {
    emit(state.copyWith(getConvState: RequestState.loading));
    final result =
        await _chateRepo.getConvByUserId(userOne: userOne, userTwo: userTwo);
    result.when(success: (conversation) {
      if (conversation.status) {
        pushPage(
            context,
            BlocProvider(
              create: (context) => sl<ChateCubit>(),
              child: ChateScreen(
                  convId: conversation.conversation!.id, receiverId: userTwo),
            ));
      } else {
        pushPage(
            context,
            BlocProvider(
              create: (context) => sl<ChateCubit>(),
              child: ChateScreen(convId: 0, receiverId: userTwo),
            ));
      }
      emit(state.copyWith(
          getConvState: RequestState.loaded, conversationModel: conversation));
    }, failure: (code, error) {
      emit(state.copyWith(getConvState: RequestState.error));
    });
  }

  /// *  get Messages By user id
  Future<void> getMessagesByUserId({userOne, userTwo, page}) async {
    emit(state.copyWith(getMessagesState: RequestState.loading));
    final result = await _chateRepo.getMessagesByUserId(
        userOne: userOne, userTwo: userTwo, page: page);
    result.when(success: (messages) {
      emit(state.copyWith(
          getMessagesState: RequestState.loaded, messagesResponse: messages));
    }, failure: (code, error) {
      emit(state.copyWith(getMessagesState: RequestState.error));
    });
  }

  /// * get Messages By ConversationId

  Future<void> getMessagesByConversationId({convId, page}) async {
    emit(state.copyWith(getMessagesState: RequestState.loading));
    final result = await _chateRepo.getMessagesByConversationId(
        convId: convId, page: page);
    result.when(success: (messages) {
      emit(state.copyWith(
          getMessagesState: RequestState.loaded, messagesResponse: messages));
    }, failure: (code, error) {
      emit(state.copyWith(getMessagesState: RequestState.error));
    });
  }
}
