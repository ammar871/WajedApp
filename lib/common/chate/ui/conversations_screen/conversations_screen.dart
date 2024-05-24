import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/address/ui/addresses_screen/components/container_check_address.dart';
import 'package:wajed_app/common/chate/bloc/cubit/chate_cubit.dart';
import 'package:wajed_app/common/chate/data/models/conversation_response.dart';
import 'package:wajed_app/common/chate/ui/chate_screen/chate_screen.dart';
import 'package:wajed_app/core/common_widgets/image_network.dart';
import 'package:wajed_app/core/common_widgets/text_list_empty.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/extension/global_extensions.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/services/services_locator.dart';
import 'package:wajed_app/core/theming/styles.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';


import '../../../../core/common_widgets/circular_progress.dart';
import '../../../../core/enums/loading_status.dart';

class ConversationsScreen extends StatelessWidget {
  const ConversationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ChateCubit>()
        ..getConversationsByUserId(userId: currentUser!.user.id, page: 1),
      child: Scaffold(
          appBar: AppBar(
            title: Text(
             Strings.conversations.tr(),
              style: TextStyles.textStyleFontBold16BlackAppBar,
            ),
            automaticallyImplyLeading: true,
            elevation: 0,
          ),
          body: BlocBuilder<ChateCubit, ChateState>(
            builder: (context, state) {
              switch (state.getConversationsState) {
                case RequestState.loading:
                  return const CustomCircularProgress();
                case RequestState.loaded:
                  return state.conversationsResponse!.items.isEmpty
                      ? TextListEmpty(text: Strings.noMessages.tr())
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25.w, vertical: 25.h),
                          itemCount: state.conversationsResponse!.items.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            ConversationResponse conversationResponse =
                                state.conversationsResponse!.items[index];
                            return GestureDetector(
                              onTap: () {
                                context.navigatePush(BlocProvider(
                                  create: (context) => sl<ChateCubit>(),
                                  child: ChateScreen(
                                    convId:
                                        conversationResponse.conversation.id,
                                    receiverId: conversationResponse
                                                .lastMessage.receiverId ==
                                            currentUser!.user.id
                                        ? conversationResponse
                                            .lastMessage.senderId!
                                        : conversationResponse
                                            .lastMessage.receiverId!,
                                  ),
                                ));
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 20.h),
                                height: 110.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x26000000),
                                      offset: Offset(0, 3),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ContainerCheckAddress(
                                        color: conversationResponse
                                                .lastMessage.isReading
                                            ? Palette.restaurantColor
                                            : Colors.transparent),
                                    horizontalSpace(20.w),
                                    Container(
                                      height: 40.w,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(9.r)),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(9.r),
                                          child: ImageNetworkWidget(
                                            imageUrl: conversationResponse
                                                    .otherUser.profileImage ??
                                                "",
                                            height: 40.w,
                                            width: 40.w,
                                            errorWidget: Icon(
                                              Icons.person,
                                              color: Colors.black,
                                              size: 30.w,
                                            ),
                                          )),
                                    ),
                                    horizontalSpace(18.w),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //* name USER And Date Message
                                          Text(
                                            conversationResponse
                                                .otherUser.fullName,
                                            style: TextStyles
                                                .textStyleFontBold16OrangeColor,
                                          ),
                                          // * text message
                                          Text(
                                            conversationResponse
                                                .lastMessage.text!,
                                            maxLines: 2,
                                            style: TextStyles
                                                .textStyleFontReqluar12kDarkGrey
                                                .copyWith(
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            context.convertDate(
                                                conversationResponse
                                                    .lastMessage.createdAt),
                                            style: TextStyles
                                                .textStyleFontRegular12greyColor,
                                          ),
                                          verticalSpace(10.h),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            size: 15.w,
                                            color: Colors.black.withOpacity(.5),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                case RequestState.error:
                  return TextListEmpty(text: "لا توجد رسائل".tr());
                case RequestState.pagination:
                  return const SizedBox();
              }
            },
          )),
    );
  }
}
