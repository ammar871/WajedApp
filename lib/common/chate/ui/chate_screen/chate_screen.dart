import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/enums/loading_status.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';

import '../../../../core/common_widgets/circular_progress.dart';
import '../../../../core/constants/layout/palette.dart';
import '../../../../core/theming/styles.dart';
import '../../bloc/cubit/chate_cubit.dart';
import '../../data/models/message_model.dart';

class ChateScreen extends StatefulWidget {
  final int convId;
  final String receiverId;
  const ChateScreen(
      {super.key, required this.convId, required this.receiverId});

  @override
  State<ChateScreen> createState() => _ChateScreenState();
}

class _ChateScreenState extends State<ChateScreen> {
  final _messageController = TextEditingController();
  int page = 1;
  @override
  void initState() {

    super.initState();
    ChateCubit.get(context)
        .getMessagesByConversationId(convId: widget.convId, page: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.chate.tr(),
          style: TextStyles.textStyleFontBold16BlackAppBar,
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: BlocBuilder<ChateCubit, ChateState>(
        builder: (context, state) {
          switch (state.getMessagesState) {
            case RequestState.loading:
              return const CustomCircularProgress();
            case RequestState.loaded:
              return Column(
                children: [
                  /// * messages
                  Expanded(
                      child: ListView.builder(
                          itemCount: state.messagesResponse!.items.length,
                          itemBuilder: (context, index) {
                            MessageModel message =
                                state.messagesResponse!.items[index];
                            return _buildMessageItem(message);
                          })),
                  _fieldSendMessage(onTap: () {
                  
                    _sendMessage(
                      context: context,
                      convId: state.messagesResponse!.items.isNotEmpty
                          ? state.messagesResponse!.items[0].convId
                          : widget.convId,
                    );
                  })
                ],
              );
            case RequestState.error:
              return const Text("error");
            default:
              return const Text("error");
          }
        },
      ),
    );
  }

  Widget _buildMessageItem(
    MessageModel message,
  ) {
    return Padding(
      padding:  EdgeInsets.only(left: 20.w,right: 20.w,top: 10.h),
      child: Row(
        mainAxisAlignment: message.senderId == currentUser!.user.id
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(20.0).w,
            decoration: BoxDecoration(
              color: message.senderId == currentUser!.user.id
                  ? Palette.restaurantColor
                  : Palette.kStepperLineInactiveColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0.r),
                bottomRight: Radius.circular(30.0.r),
                topLeft: message.senderId == currentUser!.user.id
                    ? Radius.circular(30.0.r)
                    : const Radius.circular(0.0),
                topRight: message.senderId == currentUser!.user.id
                    ? const Radius.circular(0.0)
                    : Radius.circular(30.0.r),
              ),
            ),
            child: Text(
              message.text!,
              style: TextStyles.textStyleFontRegular14greyColor.copyWith(
                  color: message.senderId == currentUser!.user.id
                      ? Colors.white
                      : Palette.kDarkGrey),
            ),
          ),
        ],
      ),
    );
  }

  Container _fieldSendMessage({onTap}) {
    return Container(
      padding: const EdgeInsets.all(20.0).w,
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: Color(0x29000000),
            offset: Offset(0, -3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 60.h,
              padding: const EdgeInsets.symmetric(horizontal: 13),
              alignment: Alignment.center,
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: Strings.inputTextChat.tr(),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.send,
              size: 35,
              color: Palette.restaurantColor,
            ),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }

  void _sendMessage({context, convId}) {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      MessageModel messageModel = MessageModel(
          id: 0,
          convId: convId,
          type: 1,
          text: messageText,
          senderId: currentUser!.user.id,
          receiverId: widget.receiverId,
          status: 0,
          createdAt: DateTime.now().toString(),
          isReading: false);
      ChateCubit.get(context).sendMessage(messageModel, page);
      _messageController.clear();
    }
  }
}
