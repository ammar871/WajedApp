import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/driver/bloc/cubit/driver_cubit.dart';
import 'package:wajed_app/driver/data/models/add_driver_body.dart';
import 'package:wajed_app/market/market/ui/create_market_screen/components/text_form_create_market_widget.dart';
import '../../../common/address/bloc/cubit/address_cubit.dart';
import '../../../common/address/data/models/address_model.dart';
import '../../../common/app/ui/location_on_map/location_on_map_screen.dart';
import '../../../core/common_widgets/custom_button.dart';
import '../../../core/constants/layout/palette.dart';
import '../../../core/enums/loading_status.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/theming/styles.dart';
import '../../../core/utils/app_model.dart';
import '../../../market/market/ui/create_market_screen/components/row_upload_image_widget.dart';
import '../../../market/market/ui/create_market_screen/components/title_field_widget.dart';

class CreateDriverAccountScreen extends StatefulWidget {
  const CreateDriverAccountScreen({super.key});

  @override
  State<CreateDriverAccountScreen> createState() =>
      _CreateDriverAccountScreenState();
}

class _CreateDriverAccountScreenState extends State<CreateDriverAccountScreen> {
  // final _fullNameController = TextEditingController();

  final _addressController = TextEditingController();

  bool obscureText = true;
  AddressModel? address;

  @override
  void dispose() {
    super.dispose();
    // _fullNameController.dispose();
    _addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DriverCubit>(),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
             Strings.createDriverAccout.tr(),
              style: TextStyles.textStyleFontBold16BlackAppBar,
            ),
            automaticallyImplyLeading: false,
            elevation: 0,
          ),
          body: BlocBuilder<DriverCubit, DriverState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(30.0).w,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      /// * description market
                      // TitleFieldWidget(
                      //   title: "الاسم بالكامل".tr(),
                      // ),
                      // TextFormCreateMarketWidget(
                      //   controller: _fullNameController,
                      //   hint: "الاسم بالكامل"..tr(),
                      // ),
                      // verticalSpace(30.h),

                      // * address market
                      TitleFieldWidget(
                        title:Strings.address.tr(),
                      ),
                      TextFormCreateMarketWidget(
                        controller: _addressController,
                        hint:Strings.addressMarket,
                      ),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (context) =>
                                                sl<AddressCubit>(),
                                            child: const LocationOnMapScreen(),
                                          )),
                                ).then((value) {
                                  address = value as AddressModel;
                                  _addressController.text = value.description;
                                  setState(() {});
                                });
                              },
                              child: Text(
                               Strings.selectLocation.tr(),
                                style:
                                    TextStyles.textStyleFontBold16OrangeColor,
                              )),
                        ],
                      ),
                      verticalSpace(30.h),
                      RowUploadImageWidget(
                        title:Strings.photoProfile.tr(),
                        onTap: () {
                          DriverCubit.get(context).uploadImage(typeImage: 1);
                        },
                        image: state.imageProfile,
                        loading: state.uploadImageProfileState ==
                                RequestState.loading
                            ? true
                            : false,
                      ),
                      verticalSpace(20.h),

                      /// * ID image
                      RowUploadImageWidget(
                        title:Strings.photoId.tr(),
                        onTap: () {
                          DriverCubit.get(context).uploadImage(typeImage: 2);
                        },
                        image: state.imageId,
                        loading:
                            state.uploadImageIdState == RequestState.loading
                                ? true
                                : false,
                      ),
                      verticalSpace(20.h),

                      /// * ID image
                      RowUploadImageWidget(
                        title: Strings.photoCar.tr(),
                        onTap: () {
                          DriverCubit.get(context).uploadImage(typeImage: 3);
                        },
                        image: state.imageCar,
                        loading:
                            state.uploadImageCarState == RequestState.loading
                                ? true
                                : false,
                      ),
                      verticalSpace(30.h),

                      verticalSpace(30.h),
                      state.addDriverState == RequestState.loading
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                              title:Strings.regist.tr(),
                              backgroundColor: Palette.restaurantColor,
                              onPressed: () {
                                if (validate(
                                    imageId: state.imageId,
                                    profileImage: state.imageProfile,
                                    imageCar: state.imageCar)) {
                                 
                                  DriverCubit.get(context).addDriver(
                                      AddDriverBody(
                                          userId: currentUser!.user.id,
                                          addressName: address!.description,
                                          lat: address!.lat,
                                          lng: address!.lng,
                                          profileImage: state.imageProfile!,
                                          imageId: state.imageId!,
                                          imageCar: state.imageCar!,
                                          area: 0),
                                      context: context);
                                }
                              }),
                      verticalSpace(100.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  bool validate({profileImage, imageId, imageCar}) {
    if (_addressController.text.isEmpty) {
      showToast(color: Colors.red, msg:Strings.pickupLocation.tr());

      return false;
    } else if (profileImage == null) {
      showToast(color: Colors.red, msg: Strings.photoProfile.tr());

      return false;
    } else if (imageId == null) {
      showToast(color: Colors.red, msg: Strings.photoId.tr());

      return false;
    } else if (imageCar == null) {
      showToast(color: Colors.red, msg:Strings.selectPhotoCar.tr());

      return false;
    } else if (address == null) {
      showToast(color: Colors.red, msg:Strings.selectLocation.tr());

      return false;
    } else {
      return true;
    }
  }
}
