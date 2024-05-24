import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wajed_app/common/address/data/models/add_address_body_request.dart';
import 'package:wajed_app/core/common_widgets/custom_button.dart';
import 'package:wajed_app/core/constants/layout/app_fonts.dart';
import 'package:wajed_app/core/enums/loading_status.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/theming/container_styles.dart';
import 'package:wajed_app/core/utils/app_model.dart';

import '../../../../core/common_widgets/circular_progress.dart';
import '../../../../core/constants/layout/palette.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/strings.dart';
import '../../bloc/cubit/address_cubit.dart';
import '../../data/models/address_model.dart';

class MapScreen extends StatefulWidget {
  final AddressModel? addressModel;

  const MapScreen({
    super.key,
    this.addressModel,
  });
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(currentLat ?? 0.0, currentLng ?? 0.0),
    zoom: 14,
  );

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String location = "Search Location";

  // String detailsAddress = "";

  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllertext = TextEditingController();
  bool loading = false;

  late GoogleMapController? controllerMap;

  double lat = 0.0;
  double lng = 0.0;
  @override
  void initState() {
    super.initState();
    lat = currentLat!;
    lng = currentLng!;

 
 
  }

  void setInitialLocation({currentLat, currentLng}) async {
    CameraPosition cPosition = CameraPosition(
      zoom: 19,
      target: LatLng(currentLat, currentLng),
    );
    controllerMap = await _controller.future;

    controllerMap!
        .animateCamera(CameraUpdate.newCameraPosition(cPosition))
        .then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressCubit, AddressState>(
      listener: (context, state) {
        if (state.moveCameraState == RequestState.loaded) {
          _controllertext.text = AddressCubit.get(context).detailsAddress;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
           appBar: AppBar(
        title: Text(
         Strings.selectLocation.tr(),
          style: TextStyles.textStyleFontBold16BlackAppBar,
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              ///* ========================================= map widget
              Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: MapScreen._kGooglePlex,
                  myLocationButtonEnabled: false,
                  buildingsEnabled: true,
                  compassEnabled: true,
                  indoorViewEnabled: true,
                  mapToolbarEnabled: true,
                  rotateGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  tiltGesturesEnabled: true,
                  trafficEnabled: true,
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  // myLocationEnabled: true,
                  // markers: AddressCubit.get(context).markers.values.toSet(),
                  onCameraIdle: () {
                    AddressCubit.get(context).getAddressFromLatLng(lat, lng);
                  },
                  onCameraMove: (object) {
                    lat = object.target.latitude;
                    lng = object.target.longitude;
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    setInitialLocation(
                        currentLat: currentLat, currentLng: currentLng);
                  },
                ),
              ),

              ///* =========================================icon location
              const Center(
                child: Icon(Icons.location_pin,
                    color: Palette.mainColor, size: 55),
              ),

              ///* ========================================= name and desc location  widget
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        // height: 150,
                        width: double.infinity,
                        margin: const EdgeInsets.all(18),
                        padding: const EdgeInsets.all(10),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                 Icon(
                                  Icons.location_pin,
                                  color: Palette.mainColor,
                                  size: 55.w,
                                ),
                                 SizedBox(
                                  width: 10.h,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Strings.pickupLocation.tr(),
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                     Strings.moveMap.tr(),
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.4),
                                          fontSize: 11),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(),
                            TextField(
                              controller: _controllerName,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: AppFonts.stc,
                                  fontSize: 20.sp),
                              decoration: InputDecoration(
                                hintText: Strings.nameAddress.tr(),
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
                            const Divider(),
                            TextField(
                              controller: _controllertext,
                              style: const TextStyle(color: Colors.black),
                              keyboardType: TextInputType.multiline,
                              maxLines: 2,
                              
                              decoration: InputDecoration(
                                hintText: Strings.descAddress.tr(),
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
                          ],
                        ),
                      ),
                      state.moveCameraState == RequestState.loading
                          ? const CustomCircularProgress()
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: CustomButton(
                                onPressed: () {
                                  if (validate(context)) {
                                    AddressCubit.get(context).addAddress(
                                        AddAddressBodyReqquest(
                                          id: 0,
                                            userId: currentUser!.user.id,
                                            description: _controllertext.text,
                                            name: _controllerName.text,
                                            lat: lat,
                                            lng: lng,
                                            defaultAddress: false,),context: context);
                                  }
                                },
                                title:Strings.select.tr(),
                              ),
                            ),
                      verticalSpace(50.h)
                    ],
                  ),
                ),
              ),

              // getSearchWidget()

              /// search =================================================================
              Positioned(
                  top: 10.h,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   // Create the SelectionScreen in the next step.
                      //   MaterialPageRoute(
                      //       builder: (context) => SearchLocationScreen()),
                      // ).then((value) async {
                      //   List<Location> locations =
                      //       await locationFromAddress(value["description"]);
                      //   AddressCubit.get(context).lat = locations[0].latitude;
                      //   AddressCubit.get(context).lng = locations[0].longitude;

                      //   controllerMap!.animateCamera(CameraUpdate.newLatLngZoom(
                      //       LatLng(
                      //           locations[0].latitude, locations[0].longitude),
                      //       14));

                      //   _controllertext.text = value["description"];
                      //   AddressCubit.get(context).initMap(
                      //       context: context,
                      //       newLat: AddressCubit.get(context).lat,
                      //       newLng: AddressCubit.get(context).lng);
                      //   // AddressCubit.get(context).getAddresses(
                      //   //     AddressCubit.get(context).lat,
                      //   //     AddressCubit.get(context).lng);

                      //   setState(() {});
                      // });
                    },
                    child: Container(
                        height: 45,
                        margin:
                            const EdgeInsets.only(top: 26, left: 26, right: 26),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: ContainerStyles.decorationMap(
                            color: Colors.white, 10),
                        child: Row(children: [
                          Expanded(
                              child: Text(
                           Strings.searchOnMap.tr(),
                            textAlign: TextAlign.end,
                          )),
                          sizedWidth(20),
                          Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: Palette.mainColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 20.w,
                              ),
                            ),
                          )
                        ])),
                  )),
              Positioned(
                left: 20,
                bottom: 200,
                child: IconButton(
                  icon: const Icon(
                    Icons.my_location,
                    size: 30,
                  ),
                  onPressed: () {
                    // controllerMap!.animateCamera(CameraUpdate.newLatLngZoom(
                    //     LatLng(locData.latitude, locData.longitude), 14));

                    // AddressCubit.get(context).lat = locData.latitude;
                    // AddressCubit.get(context).lng = locData.longitude;

                    // AddressCubit.get(context).initMap(
                    //     context: context,
                    //     newLat: AddressCubit.get(context).lat,
                    //     newLng: AddressCubit.get(context).lng);
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  bool validate(context) {
    if (lat == 0.0 || lng == 0.0) {
      showToast(
        msg: Strings.selectAddress.tr(),
        color: Colors.red,
      );

      return false;
    } else if (_controllerName.text.isEmpty) {
      showToast(
        msg:Strings.inputName.tr(),
        color: Colors.red,
      );
      return false;
    } else if (_controllertext.text.isEmpty) {
      showToast(
        msg: Strings.inputDesc.tr(),
        color: Colors.red,
      );
      return false;
    } else {
      return true;
    }
  }
}
