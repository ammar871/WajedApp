import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:wajed_app/common/address/bloc/cubit/address_cubit.dart';
import 'package:wajed_app/common/address/data/models/address_model.dart';
import 'package:wajed_app/common/app/ui/location_on_map/location_on_map_screen.dart';
import 'package:wajed_app/core/common_widgets/custom_button.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';
import 'package:wajed_app/core/enums/loading_status.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/services/services_locator.dart';
import 'package:wajed_app/core/theming/styles.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';
import 'package:wajed_app/market/market/bloc/market_cubit/market_cubit.dart';
import 'package:wajed_app/market/market/data/models/add_market_body_request.dart';
import 'package:wajed_app/market/market/data/models/market_model.dart';
import 'package:wajed_app/market/market/data/models/update_market_model.dart';
import 'package:wajed_app/market/market/ui/create_market_screen/components/text_form_create_market_widget.dart';
import 'package:wajed_app/user/cart/ui/components/divider_widget.dart';
import 'package:wajed_app/user/home/data/models/field_model.dart';
import '../../../../common/auth/ui/reigister/registration_screen.dart';
import '../../../../core/common_widgets/drop_dwon_widget.dart';
import '../../../../core/helpers/helper_functions.dart';
import 'components/app_bar_widget.dart';
import 'components/row_upload_image_widget.dart';
import 'components/title_field_widget.dart';

class CreateMarketScreen extends StatefulWidget {
  final bool isUpdate;
  final MarketModel? marketModel;
  const CreateMarketScreen(
      {super.key, this.isUpdate = false, this.marketModel});

  @override
  State<CreateMarketScreen> createState() => _CreateMarketScreenState();
}

class _CreateMarketScreenState extends State<CreateMarketScreen> {
  final _titleArController = TextEditingController();

  final _ownerController = TextEditingController();
  final _titleEnController = TextEditingController();
  final _descArController = TextEditingController();
  final _descEnController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();

  bool obscureText = true;
  AddressModel? address;
  FieldModel? fieldModel;
  bool acceptePraivacy = true;
  @override
  void initState() {
    super.initState();
    MarketCubit.get(context).getFieldsForAddMarket().then((value) {
      fieldModel = fields.firstWhere(
          (element) => element.id == widget.marketModel!.fieldId,
          orElse: () => fieldModel!);
    });
    if (widget.isUpdate) {
      MarketCubit.get(context).getImagesForUpdateMarket(
          imageLogo: widget.marketModel!.imageLogo,
          imagePass: widget.marketModel!.imageCommercial);
      _titleArController.text = widget.marketModel!.titleAr;
      _titleEnController.text = widget.marketModel!.titleEng;
      _descArController.text = widget.marketModel!.descAr;
      _descEnController.text = widget.marketModel!.descEng;

      _passwordController.text = widget.marketModel!.password;
      _ownerController.text = widget.marketModel!.nameOwner;
      _addressController.text = widget.marketModel!.addressName;

      address = AddressModel(
          id: 0,
          userId: "",
          description: widget.marketModel!.addressName,
          name: "",
          lat: widget.marketModel!.lat,
          lng: widget.marketModel!.lng,
          defaultAddress: false,
          createdAt: "");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleArController.dispose();
    _ownerController.dispose();
    _titleEnController.dispose();
    _descArController.dispose();
    _descEnController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(130.h),
          child: AppBarWidget(isUpdate: widget.isUpdate)),
      body: BlocBuilder<MarketCubit, MarketState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(30).w,
            child: SingleChildScrollView(
              child: Form(
                child: Column(children: [
                  /// *select field
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        color: Palette.restaurantColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: CustomDropDownWidget(
                      currentValue: fieldModel,
                      list: state.fields
                          .map((e) => DropdownMenuItem<FieldModel>(
                              value: e,
                              child: Text(
                                isAraic() ? e.nameAr : e.nameEng,
                                style:
                                    TextStyles.textStyleFontBold16OrangeColor,
                              )))
                          .toList(),
                      onSelect: (val) {
                        fieldModel = val;
                        setState(() {});
                      },
                      hint: Strings.selctCategory.tr(),
                    ),
                  ),

                  /// * name Market
                  TitleFieldWidget(
                    title: Strings.nameStoreAr.tr(),
                  ),
                  TextFormCreateMarketWidget(
                    controller: _titleArController,
                    hint: Strings.nameStoreAr.tr(),
                  ),
                  verticalSpace(30.h),
                  TitleFieldWidget(
                    title: Strings.nameStoreEng.tr(),
                  ),
                  TextFormCreateMarketWidget(
                    controller: _titleEnController,
                    hint: Strings.nameStoreEng.tr(),
                  ),
                  verticalSpace(30.h),

                  /// * description market
                  TitleFieldWidget(
                    title: Strings.descMarketAr.tr(),
                  ),
                  TextFormCreateMarketWidget(
                    controller: _descArController,
                    hint: Strings.descMarketAr.tr(),
                  ),
                  verticalSpace(30.h),
                  TitleFieldWidget(
                    title: Strings.descMarketEng.tr(),
                  ),
                  TextFormCreateMarketWidget(
                    controller: _descEnController,
                    hint: Strings.descMarketEng.tr(),
                  ),
                  verticalSpace(30.h),

                  /// * Name of the restaurant owner
                  TitleFieldWidget(
                    title: Strings.nameOwner.tr(),
                  ),
                  TextFormCreateMarketWidget(
                    controller: _ownerController,
                    hint: Strings.nameOwner.tr(),
                  ),

                  /// *passwword
                  verticalSpace(30.h),
                  // * Password market
                  TitleFieldWidget(
                    title: Strings.password.tr(),
                  ),
                  TextFormCreateMarketWidget(
                    controller: _passwordController,
                    obscureText: obscureText,
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Palette.fontGreyColor,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    ),
                    hint: Strings.password.tr(),
                  ),
                  verticalSpace(30.h),
                  // * address market
                  TitleFieldWidget(
                    title: Strings.addressMarket.tr(),
                  ),
                  TextFormCreateMarketWidget(
                    controller: _addressController,
                    hint: Strings.addressMarket.tr(),
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) => sl<AddressCubit>(),
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
                            style: TextStyles.textStyleFontBold16OrangeColor,
                          )),
                    ],
                  ),
                  verticalSpace(30.h),

                  /// * Required personal documents
                  TitleFieldWidget(
                    title: Strings.fillsId.tr(),
                  ),
                  verticalSpace(20.h),
                  const DividerWidget(
                      hieght: .8, color: Palette.restaurantColor),
                  verticalSpace(30.h),

                  /// * logo image
                  RowUploadImageWidget(
                    title: Strings.logoMarket.tr(),
                    onTap: () {
                      MarketCubit.get(context).uploadImage(typeImage: 1);
                    },
                    image: state.imageLogoMarket,
                    loading: state.uploadLogoMarketState == RequestState.loading
                        ? true
                        : false,
                  ),
                  verticalSpace(20.h),

                  /// * ID image
                  RowUploadImageWidget(
                    title: Strings.imagePassport.tr(),
                    onTap: () {
                      MarketCubit.get(context).uploadImage(typeImage: 2);
                    },
                    image: state.imageIdMarket,
                    loading:
                        state.uploadimageIdMarketState == RequestState.loading
                            ? true
                            : false,
                  ),
                  verticalSpace(30.h),
                  CheckBoxWidget(
                      onChanged: (vall) {
                        acceptePraivacy = !acceptePraivacy;
                        setState(() {});
                      },
                      acceptePraivacy: acceptePraivacy,
                      style: TextStyles.textStyleFontRegular12greyColor
                          .copyWith(height: 1),
                      title: Strings.policyRegister.tr(),
                      backgroundColor: Palette.restaurantColor),

                  verticalSpace(30.h),
                  state.addMarketState == RequestState.loading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          title: widget.isUpdate
                              ? Strings.update.tr()
                              : Strings.regist.tr(),
                          backgroundColor: Palette.restaurantColor,
                          onPressed: () {
                            if (validate(
                                imageId: state.imageIdMarket,
                                logoImage: state.imageLogoMarket)) {
                              if (widget.isUpdate) {
                                MarketCubit.get(context).emitUpdateMarket(
                                    UpdateMarketModel(
                                        marketId: widget.marketModel!.id,
                                        fieldId: fieldModel!.id,
                                        titleAr: _titleArController.text,
                                        titleEng: _titleEnController.text,
                                        descAr: _descArController.text,
                                        descEng: _descEnController.text,
                                        password: _passwordController.text,
                                        imageLogo: state.imageLogoMarket!,
                                        imageCommercial: state.imageIdMarket!,
                                        addressName: address!.description,
                                        lat: address!.lat,
                                        lng: address!.lng,
                                        nameOwner: _ownerController.text),
                                    context: context);
                              } else {
                                MarketCubit.get(context).emitAddMarket(
                                    AddMarketBodyRequest(
                                        fieldId: fieldModel!.id,
                                        titleAr: _titleArController.text,
                                        titleEng: _titleEnController.text,
                                        descAr: _descArController.text,
                                        descEng: _descEnController.text,
                                        userId: currentUser!.user.id,
                                        nameOwner: _ownerController.text,
                                        password: _passwordController.text,
                                        imageLogo: state.imageLogoMarket!,
                                        imageCommercial: state.imageIdMarket!,
                                        addressName: address!.description,
                                        lat: address!.lat,
                                        lng: address!.lng),
                                    context: context);
                              }
                            }
                          }),
                  verticalSpace(100.h),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }

  bool validate({logoImage, imageId}) {
    if (_titleArController.text.isEmpty) {
      showToast(color: Colors.red, msg: Strings.inputNameAr.tr());
      return false;
    } else if (_titleEnController.text.isEmpty) {
      showToast(color: Colors.red, msg: Strings.inputNameEng.tr());

      return false;
    } else if (_descArController.text.isEmpty) {
      showToast(color: Colors.red, msg: Strings.inputDescAr.tr());

      return false;
    } else if (_descEnController.text.isEmpty) {
      showToast(color: Colors.red, msg: Strings.inputDescEng.tr());

      return false;
    } else if (_ownerController.text.isEmpty) {
      showToast(color: Colors.red, msg: Strings.inputNameOwner.tr());

      return false;
    } else if (_passwordController.text.isEmpty) {
      showToast(color: Colors.red, msg: Strings.password.tr());

      return false;
    } else if (_addressController.text.isEmpty) {
      showToast(color: Colors.red, msg: Strings.selectAddress.tr());

      return false;
    } else if (logoImage == null) {
      showToast(color: Colors.red, msg: Strings.selectLogo.tr());

      return false;
    } else if (imageId == null) {
      showToast(color: Colors.red, msg: Strings.selectPasport.tr());

      return false;
    } else if (fieldModel == null) {
      showToast(color: Colors.red, msg: Strings.selctCategory.tr());

      return false;
    } else if (address == null) {
      showToast(color: Colors.red, msg: Strings.selectLocation.tr());

      return false;
    } else {
      return true;
    }
  }
}
