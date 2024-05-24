import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wajed_app/common/chate/bloc/cubit/chate_cubit.dart';
import 'package:wajed_app/common/order/bloc/order_cubit/order_cubit.dart';
import 'package:wajed_app/common/order/ui/order_details_screen/components/stepper_widget.dart';
import 'package:wajed_app/core/common_widgets/custom_button.dart';
import 'package:wajed_app/core/common_widgets/image_network.dart';
import 'package:wajed_app/core/constants/layout/palette.dart';

import 'package:wajed_app/core/extension/global_extensions.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/core/utils/strings.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/theming/styles.dart';
import 'components/icon_back_traking_widget.dart';
import 'components/wating_driver_widget.dart';

class TrakingOrderScreen extends StatefulWidget {
  final int orderId;
  const TrakingOrderScreen({super.key, required this.orderId});

  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(currentLat ?? 0.0, currentLng ?? 0.0),
  //   zoom: 14,
  // );

  @override
  State<TrakingOrderScreen> createState() => _TrakingOrderScreenState();
}

class _TrakingOrderScreenState extends State<TrakingOrderScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  bool loading = false;

  late GoogleMapController? controllerMap;

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
    return BlocProvider(
      create: (context) => sl<OrderCubit>()..getOrderDetails(widget.orderId),
      child: Scaffold(
        body: BlocConsumer<OrderCubit, OrderState>(
          listener: (context, state) {
            if (state.getOrderDetailsState == RequestState.loaded) {
              if (state.orderDetailsResponse!.driver != null) {
                OrderCubit.get(context).drawMarkers(
                    context: context,
                    latDriver: state.orderDetailsResponse!.driver!.driver!.lat,
                    lngDriver: state.orderDetailsResponse!.driver!.driver!.lng,
                    latUser: state.orderDetailsResponse!.address.lat,
                    lngUser: state.orderDetailsResponse!.address.lng);
              }
            }
          },
          builder: (context, state) {
            switch (state.getOrderDetailsState) {
              case RequestState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case RequestState.loaded:
                return Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(state.orderDetailsResponse!.address.lat,
                            state.orderDetailsResponse!.address.lng),
                        zoom: 12,
                      ),
                      myLocationButtonEnabled: false,
                      buildingsEnabled: true,
                      compassEnabled: true,
                      indoorViewEnabled: true,
                      mapToolbarEnabled: true,
                      rotateGesturesEnabled: true,
                      scrollGesturesEnabled: true,
                      tiltGesturesEnabled: true,
                      trafficEnabled: true,
                      markers:
                          Set<Marker>.of(OrderCubit.get(context).listMarker),
                      zoomControlsEnabled: true,
                      zoomGesturesEnabled: true,
                      // myLocationEnabled: true,
                      // markers: AddressCubit.get(context).markers.values.toSet(),
                      // onCameraIdle: () {
                      //   AddressCubit.get(context).getAddressFromLatLng(lat, lng);
                      // },
                      // onCameraMove: (object) {
                      //   lat = object.target.latitude;
                      //   lng = object.target.longitude;
                      // },
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                        setInitialLocation(
                            currentLat: currentLat, currentLng: currentLng);
                      },
                    ),

                    /// * wating driver
                    state.orderDetailsResponse!.order.driverId == null ||
                            state.orderDetailsResponse!.order.driverId == 0
                        ? const WatingDriverWidget()
                        :

                        // * details Market
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: BlocProvider(
                              create: (context) => sl<ChateCubit>(),
                              child: BlocBuilder<ChateCubit, ChateState>(
                                builder: (context, stateChate) {
                                  return Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(30).w,
                                    margin: EdgeInsets.only(
                                        left: 25.w, right: 25.w, bottom: 50.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7.0),
                                      color: const Color(0xffffffff),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x29000000),
                                          offset: Offset(0, 3),
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // * market details
                                          CardDetailsTrackingOrderWidget(
                                            image: state.orderDetailsResponse!
                                                .market.imageLogo,
                                            name: state.orderDetailsResponse!
                                                .market.titleAr,
                                            subtitle: state
                                                .orderDetailsResponse!
                                                .market
                                                .addressName,
                                            onTap: () {
                                              ChateCubit.get(context)
                                                  .getConversationByUserId(
                                                      context: context,
                                                      userOne:
                                                          currentUser!.user.id,
                                                      userTwo: state
                                                          .orderDetailsResponse!
                                                          .market
                                                          .userId);
                                            },
                                          ),

                                          /// * driver details
                                          context.isDelivary(
                                                  currentUser!.user.role)
                                              ? const SizedBox()
                                              : CardDetailsTrackingOrderWidget(
                                                  image: state
                                                      .orderDetailsResponse!
                                                      .driver!
                                                      .driver!
                                                      .profilleImage,
                                                  name: state
                                                      .orderDetailsResponse!
                                                      .driver!
                                                      .user!
                                                      .fullName,
                                                  subtitle: state
                                                      .orderDetailsResponse!
                                                      .driver!
                                                      .driver!
                                                      .addressName,
                                                  onTap: () {
                                                    ChateCubit.get(context)
                                                        .getConversationByUserId(
                                                            context: context,
                                                            userOne:
                                                                currentUser!
                                                                    .user.id,
                                                            userTwo: state
                                                                .orderDetailsResponse!
                                                                .driver!
                                                                .driver!
                                                                .userId);
                                                  },
                                                ),

                                          /// * user details
                                          context.isCleint(
                                                  currentUser!.user.role)
                                              ? const SizedBox()
                                              : CardDetailsTrackingOrderWidget(
                                                  image: state
                                                          .orderDetailsResponse!
                                                          .user
                                                          .profileImage ??
                                                      "",
                                                  name: state
                                                      .orderDetailsResponse!
                                                      .user
                                                      .fullName,
                                                  subtitle: state
                                                      .orderDetailsResponse!
                                                      .user
                                                      .userName,
                                                  onTap: () {
                                                    ChateCubit.get(context)
                                                        .getConversationByUserId(
                                                            context: context,
                                                            userOne:
                                                                currentUser!
                                                                    .user.id,
                                                            userTwo: state
                                                                .orderDetailsResponse!
                                                                .user
                                                                .id);
                                                  },
                                                ),

                                          verticalSpace(20.h),
                                          StepperWidget(
                                              statuse: state
                                                  .orderDetailsResponse!
                                                  .order
                                                  .status),
                                          verticalSpace(20.h),
                                          context.isDelivary(
                                                      currentUser!.user.role) &&
                                                  state.orderDetailsResponse!
                                                          .order.status ==
                                                      2
                                              ? state.updateOrderState ==
                                                      RequestState.loading
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator())
                                                  : CustomButton(
                                                      title: Strings
                                                          .deliveryOfTheOrder
                                                          .tr(),
                                                      onPressed: () {
                                                        OrderCubit.get(context)
                                                            .updateOrderStatus(
                                                                orderId: state
                                                                    .orderDetailsResponse!
                                                                    .order
                                                                    .id,
                                                                status: 3);
                                                      })
                                              : const SizedBox()
                                        ]),
                                  );
                                },
                              ),
                            ),
                          ),
                    // * icon bcak
                    const IconBackTrakingWidget(),
                  ],
                );

              case RequestState.error:
                return const SizedBox();
              case RequestState.pagination:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class CardDetailsTrackingOrderWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String image, name, subtitle;
  const CardDetailsTrackingOrderWidget({
    super.key,
    required this.onTap,
    required this.image,
    required this.name,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // * image
        Container(
          height: 32.w,
          width: 32.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.r),
            child: ImageNetworkWidget(
              imageUrl: image,
              errorWidget: Icon(
                Icons.person,
                color: Colors.black,
                size: 30.w,
              ),
            ),
          ),
        ),

        horizontalSpace(10.w),
        // * name market
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 35.h,
                child: Text(
                  name,
                  style: TextStyles.textStyleFontBold20resturantColor,
                ),
              ),

              // * market address
              SizedBox(
                child: Text(
                  subtitle,
                  maxLines: 1,
                  style: TextStyles.textStyleFontLight12kDarkGrey,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onTap,
          icon: Icon(
            Icons.message,
            size: 25.w,
            color: Palette.mainColor,
          ),
        )
      ],
    );
  }
}
