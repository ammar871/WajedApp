import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wajed_app/common/complaints/bloc/cubit/complaint_cubit.dart';
import 'package:wajed_app/core/common_widgets/custom_button.dart';
import 'package:wajed_app/core/enums/loading_status.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import '../../../../core/common_widgets/text_field_widget.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/strings.dart';
import '../../../complaints/data/models/add_complaint_body.dart';

class CallUsScreen extends StatefulWidget {
  const CallUsScreen({super.key});

  @override
  State<CallUsScreen> createState() => _CallUsScreenState();
}

class _CallUsScreenState extends State<CallUsScreen> {
  final _subjectComtroller = TextEditingController();
  final _emailComtroller = TextEditingController();
  final _messageComtroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ComplaintCubit>(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          title: Text(
            Strings.callUs.tr(),
            style: TextStyles.textStyleFontBold16BlackAppBar,
          ),
        ),
        body: BlocBuilder<ComplaintCubit, ComplaintState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(30.0).w,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ContainerCallWidget(
                      icon: "assets/icons/whats.svg",
                      onTap: () {},
                      color: const Color(0xff53cb5e),
                      name: Strings.whatsApp.tr(),
                    ),
                    verticalSpace(20.h),
                    ContainerCallWidget(
                      icon: "assets/icons/telgram.svg",
                      onTap: () {},
                      color: const Color(0xff37AFE3),
                      name: Strings.telgram.tr(),
                    ),
                    verticalSpace(40.h),
                    Row(
                      children: [
                        Text(
                          Strings.sendMessageService.tr(),
                          style: TextStyles.textStyleFontReqular26kBlack,
                        ),
                      ],
                    ),
                    verticalSpace(20.h),
                    TextFieldWidget(
                      controller: _subjectComtroller,
                      hint: "الموضوع",
                    ),
                    verticalSpace(20.h),
                    TextFieldWidget(
                      controller: _emailComtroller,
                      hint: Strings.email.tr(),
                      type: null,
                    ),
                    verticalSpace(20.h),
                    TextFieldWidget(
                      hieght: 200.h,
                      lins: 7,
                      controller: _messageComtroller,
                      hint: Strings.sendMessageService.tr(),
                      type: null,
                    ),
                    verticalSpace(70.h),
                    state.addComplaintState == RequestState.loading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            title: Strings.send.tr(),
                            onPressed: () {
                              if (validate(context)) {
                                ComplaintCubit.get(context)
                                    .addComplainnt(
                                        AddCopmlaintBody(
                                          email: _emailComtroller.text,
                                          subject: _subjectComtroller.text,
                                          message: _messageComtroller.text,
                                        ),
                                        context: context)
                                    .then((value) {
                                  _emailComtroller.clear();
                                  _messageComtroller.clear();
                                  _subjectComtroller.clear();
                                  setState(() {
                                    
                                  });
                                });
                              }
                            })
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool validate(BuildContext context) {
    if (_subjectComtroller.text.isEmpty) {
      showToast(color: Colors.red, msg: Strings.inputSubject.tr());
      return false;
    } else if (_emailComtroller.text.isEmpty) {
      showToast(color: Colors.red, msg: Strings.inputEmail.tr());
      return false;
    } else if (_messageComtroller.text.isEmpty) {
      showToast(color: Colors.red, msg: Strings.inputMessage.tr());
      return false;
    } else {
      return true;
    }
  }
}

class ContainerCallWidget extends StatelessWidget {
  final String name, icon;
  final VoidCallback onTap;
  final Color color;
  const ContainerCallWidget({
    super.key,
    required this.name,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          color: color,
          boxShadow: const [
            BoxShadow(
              color: Color(0x29000000),
              offset: Offset(0, 3),
              blurRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(icon),
            horizontalSpace(30.w),
            Text(
              name,
              style: TextStyles.textStyleFontBold16White,
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 15.w,
            ),
            horizontalSpace(30.w),
          ],
        ),
      ),
    );
  }
}
