// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';


// final GoRouter appRoutes = GoRouter(
//   initialLocation: GlobalPath.splash,
//   redirect: (context, state) {
//     final authProvider = context.read<AuthCubit>();
//     final state = authProvider.state;
//     // state.map(
//     //   initial: (val) {},
//     //   loading: (val) {},
//     //   verify: (val) {},
//     //   register: (val) {},
//     //   error: (val) {},
//     //   getUserData: (val) {},
//     // );
//     return null;
//   },
//   routes: <GoRoute>[
//     GoRoute(
//       path: GlobalPath.splash,
//       builder: (BuildContext context, GoRouterState state) {
//         final bool? isRefresh = state.extra as bool?;
//         return SplashScreen(refresh: isRefresh);
//       },
//     ),
//     GoRoute(
//       path: ClientPath.home,
//       builder: (BuildContext context, GoRouterState state) {
//         final int? addressId = state.extra as int?;
//         return ClientHomeScreen(addressId: addressId);
//       },
//     ),
//     GoRoute(
//       path: GlobalPath.chooseLanguage,
//       // path: '/chooseLanguage',
//       builder: (BuildContext context, GoRouterState state) {
//         return const ChooseLanguageScreen();
//       },
//     ),
//     // GoRoute(
//     //   path: '/storeHome',
//     //   builder: (BuildContext context, GoRouterState state) {
//     //     return const ClientHomeScreen();
//     //   },
//     // ),
//     GoRoute(
//       path: DealerPath.home,
//       builder: (BuildContext context, GoRouterState state) {
//         return const DealerHomeScreen();
//       },
//     ),
//     GoRoute(
//       path: ClientPath.loginWithPhone,
//       builder: (BuildContext context, GoRouterState state) {
//         return const LoginWithPhoneScreen();
//       },
//     ),
//     GoRoute(
//       path: ClientPath.phoneVerification,
//       builder: (BuildContext context, GoRouterState state) {
//         final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
//         return VerificationScreen(
//           phoneNumber: data['phoneNumber'],
//           verificationCode: data['verificationCode'],
//         );
//       },
//     ),
//     GoRoute(
//       path: '/dealerRegistration',
//       builder: (BuildContext context, GoRouterState state) {
//         return const DealerRegistrationScreen();
//       },
//     ),

//     GoRoute(
//       path: DealerPath.pickLocation,
//       builder: (BuildContext context, GoRouterState state) {
//         return const DealerPickLocationScreen();
//       },
//     ),
//     GoRoute(
//       path: ClientPath.registration,
//       builder: (BuildContext context, GoRouterState state) {
//         final String phoneNumber = state.extra as String;
//         return ClientRegistrationScreen(
//           phoneNumber: phoneNumber,
//         );
//       },
//     ),
//     GoRoute(
//       path: ClientPath.notifications,
//       builder: (BuildContext context, GoRouterState state) {
//         return const NotificationsScreen();
//       },
//     ),
//     GoRoute(
//       path: ClientPath.usagePolicy,
//       builder: (BuildContext context, GoRouterState state) {
//         return const UsagePolicyScreen();
//       },
//     ),
//     GoRoute(
//       path: '/userAddresses',
//       builder: (BuildContext context, GoRouterState state) {
//         return const ClientAddressesScreen();
//       },
//     ),
//     GoRoute(
//       path: ClientPath.pickNewAddress,
//       builder: (BuildContext context, GoRouterState state) {
//         Map<String, dynamic>? data = state.extra as Map<String, dynamic>?;
//         return AddNewAddressScreen(
//           isFirstAddress: data?['isFirstAddress'] ?? false,
//         );
//       },
//     ),
//     GoRoute(
//       path: ClientPath.marketDetails,
//       builder: (BuildContext context, GoRouterState state) {
//         final MarketsModel market = state.extra as MarketsModel;
//         return MarketDetailsScreen(market: market);
//       },
//     ),
//     GoRoute(
//       path: '/previousOrders',
//       builder: (BuildContext context, GoRouterState state) {
//         return const PreviousOrdersScreen();
//       },
//     ),
//     GoRoute(
//       path: '/dealerPreviousOrders',
//       builder: (BuildContext context, GoRouterState state) {
//         return const DealerPreviousOrdersScreen();
//       },
//     ),
//     GoRoute(
//       path: '/dealerMessages',
//       builder: (BuildContext context, GoRouterState state) {
//         return const DealerMessagesScreen();
//       },
//     ),
//     GoRoute(
//       path: '/dealerConversation',
//       builder: (BuildContext context, GoRouterState state) {
//         return const DealerConversationScreen();
//       },
//     ),
//     GoRoute(
//       path: ClientPath.trackOrder,
//       builder: (BuildContext context, GoRouterState state) {
//         final receiptNumber = state.extra as Map<dynamic, String>;
//         return TrackOrderScreen(receiptNumber: receiptNumber['receiptNumber']);
//       },
//     ),
//     GoRoute(
//       path: ClientPath.cart,
//       builder: (BuildContext context, GoRouterState state) {
//         return const CartScreen();
//       },
//     ),
//     GoRoute(
//       path: ClientPath.orderConfirmation,
//       builder: (BuildContext context, GoRouterState state) {
//         final CartDataModel cart = state.extra as CartDataModel;
//         return OrderConfirmationScreen(cartDataModel: cart);
//       },
//     ),
//     GoRoute(
//       path: '/congrats',
//       builder: (BuildContext context, GoRouterState state) {
//         final orderId = state.extra as int;
//         return CongratsScreen(orderId: orderId);
//       },
//     ),
//     GoRoute(
//       path: '/customerService',
//       builder: (BuildContext context, GoRouterState state) {
//         return const CustomServiceScreen();
//       },
//     ),
//     GoRoute(
//       path: '/dealerCustomerService',
//       builder: (BuildContext context, GoRouterState state) {
//         return const DealerCustomServiceScreen();
//       },
//     ),
//     GoRoute(
//       path: '/contactUs',
//       builder: (BuildContext context, GoRouterState state) {
//         return const ContactUsScreen();
//       },
//     ),
//     GoRoute(
//       path: '/userSettings',
//       builder: (BuildContext context, GoRouterState state) {
//         return const UserSettingsScreen();
//       },
//     ),
//     GoRoute(
//       path: GlobalPath.chooseLoginRegister,
//       builder: (BuildContext context, GoRouterState state) {
//         return const ChooseLoginRegisterScreen();
//       },
//     ),
//     GoRoute(
//       path: GlobalPath.chooseUserType,
//       builder: (BuildContext context, GoRouterState state) {
//         return const ChooseUserTypeScreen();
//       },
//     ),
//     GoRoute(
//       path: '/registrationStatus',
//       builder: (BuildContext context, GoRouterState state) {
//         return const RegistrationStatusScreen();
//       },
//     ),
//     GoRoute(
//       path: '/dealerOrderDetails',
//       builder: (BuildContext context, GoRouterState state) {
//         return const DealerOrderDetailsScreen();
//       },
//     ),

//     GoRoute(
//       path: ClientPath.viewMarkets,
//       builder: (BuildContext context, GoRouterState state) {
//         final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
//         return ViewMarketsScreen(
//           marketTitle: data['marketTitle'],
//           fieldId: data['fieldId'],
//         );
//       },
//     ),
//   ],
// );
