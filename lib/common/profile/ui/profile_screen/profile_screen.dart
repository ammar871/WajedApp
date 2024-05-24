import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/profile/data/models/update_peofile_body.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../core/common_widgets/circular_progress.dart';
import '../../../../core/common_widgets/image_network.dart';
import '../../../../core/constants/layout/palette.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/theming/colors.dart';
import '../../bloc/profile_cubit/profile_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEdite = false;
  String? image;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _cityController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _cityController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      color: Palette.mainColor,
      fontWeight: FontWeight.bold,
    );
    return BlocProvider(
      create: (context) => sl<ProfileCubit>()..getProfileDetails(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: Text(
                Strings.myAccount.tr(),
                textAlign: TextAlign.start,
                style: TextStyles.textStyleFontBold20Black,
              ),
              actions: [
                /// * button edit
                IconButton(
                    onPressed: () {
                      setState(() {
                        isEdite = !isEdite;
                      });
                      if (!isEdite) {
                        if (vaildate(context, state)) {
                          ProfileCubit.get(context).editProfile(
                              UpdateProfileBody(
                                  city: _cityController.text,
                                  email: _emailController.text,
                                  profileImage: state.imageProfile??state.user!.profileImage!,
                                  fullName: _nameController.text,
                                  userId: currentUser!.user.id),
                              context);
                        }
                      }
                    },
                    icon: Icon(
                      !isEdite ? Icons.edit : Icons.lock_open,
                      color: Palette.mainColor,
                    ))
              ],
            ),
            body: state.getUserState == RequestState.loaded
                ? Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                    alignment: Alignment.center,
                    child: Column(children: [
                      verticalSpace(10.h),
                      // image
                      GestureDetector(
                        onTap: () async {
                          if (isEdite) {
                            await ProfileCubit.get(context)
                                .uploadImageProfile();
                          }
                        },
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(1).w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Palette.mainColor, width: 2.w)),
                              child: state.user!.profileImage == null
                                  ? Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                      size: 100.w,
                                    )
                                  : state.uploadImageState ==
                                          RequestState.loading
                                      ? const CustomCircularProgress(
                                          color: ColorsApp.mainColor,
                                        )
                                      : Container(
                                          height: 100.w,
                                          width: 100.w,
                                          padding: const EdgeInsets.all(1).w,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.grey,
                                                  width: 2.w)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100.r),
                                            child: ImageNetworkWidget(
                                              imageUrl:state.imageProfile??
                                                  state.user!.profileImage!,
                                              errorWidget: Image.asset(
                                                "assets/images/e.png",
                                                width: 150.w,
                                                height: 150.w,
                                              ),
                                              width: 150.w,
                                              height: 150.w,
                                            ),
                                          )),
                            ),
                            !isEdite
                                ? const SizedBox()
                                : Positioned(
                                    left: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(8).w,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: Icon(
                                        Icons.edit,
                                        color: ColorsApp.mainColor,
                                        size: 20.w,
                                      ),
                                    ))
                          ],
                        ),
                      ),

                      verticalSpace(40.h),
                      // name
                      TextFormField(
                        controller: _nameController,
                        textCapitalization: TextCapitalization.words,
                        enabled: isEdite,
                        decoration: InputDecoration(
                          label: Text(
                            Strings.yourName.tr(),
                            style: textStyle,
                          ),
                        ),
                      ),

                      // email
                      TextFormField(
                        controller: _emailController,
                        enabled: isEdite,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          label: Text(
                            Strings.email.tr(),
                            style: textStyle,
                          ),
                        ),
                      ),
                      // city
                      TextFormField(
                        controller: _cityController,
                        enabled: isEdite,
                        decoration: InputDecoration(
                          label: Text(
                            Strings.city.tr(),
                            style: textStyle,
                          ),
                        ),
                      ),

                      verticalSpace(40.h),
                    ]),
                  )
                : const Center(child: CircularProgressIndicator()),
          );
        },
        listener: (BuildContext context, ProfileState state) {
          if (state.getUserState == RequestState.loaded) {
            _nameController.text = state.user!.fullName;
            _phoneController.text = state.user!.userName;
            _emailController.text = state.user!.email;
            _cityController.text = state.user!.city!;
            if (state.user!.profileImage != null) {


              // ProfileCubit.get(context)
              //     .getImageForeUpdateProfile(image:state.user!.profileImage!);
            }
          }
        },
      ),
    );
  }

  bool vaildate(BuildContext context, ProfileState state) {
    if (_nameController.text.isEmpty) {
      return false;
    } else if (_emailController.text.isEmpty) {
      return false;
    } else if (_cityController.text.isEmpty) {
      return false;
    } else if (state.imageProfile==state.user!.profileImage&&
        _emailController.text == state.user!.email &&
        _nameController.text == state.user!.fullName &&
        _cityController.text == state.user!.city) {
      return false;
    } else {
      return true;
    }
  }
}
