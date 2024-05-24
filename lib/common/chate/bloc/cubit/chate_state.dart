part of 'chate_cubit.dart';


class ChateState extends Equatable {
  final RequestState? addMessageState;
   final RequestState? getMessagesState;
  final MessagesResponse? messagesResponse;
   final RequestState getConversationsState;
  final ConversationResponsePage? conversationsResponse;


   final RequestState? getConvState;
   final ConversationResponseSuccess? conversationModel;
  const ChateState({
    this.addMessageState,
    this.getMessagesState,
    this.messagesResponse,
    this.getConversationsState=RequestState.loading,
    this.conversationsResponse,
    this.getConvState,
    this.conversationModel
  });


  // * copy with 

  ChateState copyWith({
    RequestState? addMessageState,
    RequestState? getMessagesState,
    MessagesResponse? messagesResponse,
    RequestState? getConversationsState,
   ConversationResponsePage? conversationsResponse,
        RequestState? getConvState,
    ConversationResponseSuccess? conversationModel


  }) {
    return ChateState(
      addMessageState: addMessageState ?? this.addMessageState,
      getMessagesState: getMessagesState ?? this.getMessagesState,
      messagesResponse: messagesResponse ?? this.messagesResponse,
      getConversationsState: getConversationsState ?? this.getConversationsState,
      conversationsResponse: conversationsResponse ?? this.conversationsResponse,
      getConvState: getConvState ?? this.getConvState,
      conversationModel: conversationModel ?? this.conversationModel
    );
  }
  
  



  @override
 
  List<Object?> get props =>[addMessageState, getMessagesState, messagesResponse,
  getConversationsState, conversationsResponse,
  getConvState,conversationModel
  ];

}
