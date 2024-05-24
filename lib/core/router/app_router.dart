//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:wajed_app/common/app/ui/splash/splash_screen.dart';
// import 'package:wajed_app/common/auth/bloc/cubit/auth_cubit/auth_cubit.dart';
// import 'package:wajed_app/common/auth/ui/choose_login_register_screen/choose_login_register_screen.dart';
// import 'package:wajed_app/common/auth/ui/choose_user_type_screen/choose_user_type_screen.dart';
// import 'package:wajed_app/core/router/routes.dart';
//
//
// import '../extension/app_extensions.dart';
//
// class AppRouter {
//   Route generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case Routes.splashScreen:
//         return MaterialPageRoute(builder: (_) => const SplashScreen());
//       case Routes.chooseLoginSignUp:
//         return MaterialPageRoute(
//             builder: (_) => const BlocProvider(create: sl<AuthCubit>(),child: ChooseLoginRegisterScreen(),));
//
//       case Routes.navTeacher:
//         return MaterialPageRoute(
//             builder: (_) => const NavigationTeacherScreen());
//
//       case Routes.navStudent:
//         return MaterialPageRoute(
//             builder: (_) => const NavigationStudentScreen());
//       case Routes.navParent:
//         return MaterialPageRoute(builder: (_) => NavigationParentsScreen());
//       case Routes.homeStudent:
//         return MaterialPageRoute(builder: (_) => const HomeScreenStudent());
//       case Routes.favScreen:
//         return MaterialPageRoute(builder: (_) => const FavLessonsScreen());
//       case Routes.homeTeacher:
//         return MaterialPageRoute(builder: (_) => const HomeTeacherScreen());
//       default:
//         return CupertinoPageRoute(
//             builder: (context) => const Scaffold(
//                   body: Center(
//                     child: Text('404'),
//                   ),
//                 ));
//     }
//   }
// }
