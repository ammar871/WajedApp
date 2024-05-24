import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wajed_app/common/address/bloc/cubit/address_cubit.dart';
import 'package:wajed_app/common/address/data/models/address_model.dart';
import 'package:wajed_app/core/constants/layout/screen_size.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/constants/layout/app_assets.dart';
import '../../../../core/constants/layout/app_radius.dart';
import '../../../../core/constants/layout/app_sizes.dart';
import '../../../../core/constants/layout/palette.dart';
import '../../../../core/enums/loading_status.dart';

class LocationOnMapScreen extends StatefulWidget {
  const LocationOnMapScreen({super.key});

  @override
  State<LocationOnMapScreen> createState() => _LocationOnMapScreenState();
}

class _LocationOnMapScreenState extends State<LocationOnMapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _controllerDesc = TextEditingController();
  LatLng? _currentLatLng;

  @override
  void initState() {
    super.initState();
  }

  bool isMapVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("حدد العنوان على الخريطة"),
      ),
      body: BlocConsumer<AddressCubit, AddressState>(
        listener: (context, state) {
          if (state.moveCameraState == RequestState.loaded) {
            _controllerDesc.text = AddressCubit.get(context).detailsAddress;
          }
        },
        builder: (context, state) {
          return SafeArea(
            top: false,
            // bottom: false,
            child: Stack(
              children: [
                AnimatedOpacity(
                  curve: Curves.fastOutSlowIn,
                  opacity: isMapVisible == true ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  child: GoogleMap(
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                      zoom: 17.0,
                      target: LatLng(
                        currentLat!,
                        currentLng!,
                      ),
                    ),
                    onCameraMove: (position) {
                      _currentLatLng = position.target;
                    },
                    onCameraIdle: () {
                      AddressCubit.get(context).getAddressFromLatLng(
                        _currentLatLng!.latitude,
                        _currentLatLng!.longitude,
                      );
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      Future.delayed(
                        const Duration(milliseconds: 550),
                        () {
                          setState(
                            () {
                              isMapVisible = true;
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  bottom: AppSize.s30,
                  child: Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      AppAssets.marker,
                      width: AppSize.s50,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: AppSize.s1,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: context.wSize * 0.90,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                            ),
                          ),
                          Positioned(
                            child: FloatingActionButton(
                              backgroundColor: Palette.white,
                              onPressed: () {
                                _controller.future.whenComplete(
                                  () async {
                                    final GoogleMapController controller =
                                        await _controller.future;
                                    controller.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                          zoom: 17.0,
                                          target: LatLng(
                                            currentLat!,
                                            currentLng!,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Icon(
                                Icons.my_location,
                                color: Palette.restaurantColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.s10),
                      Container(
                        width: context.wSize,
                        height: AppSize.s120,
                        padding: const EdgeInsets.all(AppSize.s10),
                        margin: EdgeInsets.symmetric(
                          horizontal: context.getHorizontalPadding(),
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: AppRadius.r10,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: AppSize.s10,
                            )
                          ],
                        ),
                        child: TextField(
                          controller: _controllerDesc,
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "تفاصيل العنوان".tr(),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.only(
                                left: 15, bottom: 2, top: 11, right: 15),
                            hintStyle: const TextStyle(fontSize: 12),
                          ),
                          onChanged: (v) {},
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: CustomButton(
                          title: "اختيار",
                          onPressed: () {
                            if (validate()) {
                              Navigator.pop(
                                  context,
                                  AddressModel(
                                      id: 0,
                                      userId: "userId",
                                      description: _controllerDesc.text,
                                      name: "name",
                                      lat: _currentLatLng!.latitude,
                                      lng: _currentLatLng!.longitude,
                                      defaultAddress: false,
                                      createdAt: "createdAt"));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  bool validate() {
    if (_controllerDesc.text.isEmpty) {
      showToast(msg: "يجب اختيار موقع", color: Colors.red);
      return false;
    } else if (_currentLatLng == null) {
      showToast(msg: "يجب اختيار موقع", color: Colors.red);
      return false;
    } else {
      return true;
    }
  }
}
