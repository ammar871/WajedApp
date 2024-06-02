import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wajed_app/core/helpers/helper_functions.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/user/home/bloc/home_cubit/home_cubit.dart';
import 'package:wajed_app/user/home/ui/home_screen/comonents/loaded_widget.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/helpers/firebase_manger.dart';
import '../../../../core/services/services_locator.dart';
import 'comonents/app_bar_home_widget.dart';
import '../../../../core/common_widgets/darwer_widget/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffolded = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    getLocation();
    FCMManger().getMessagesFCM();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()
        ..getHomeUser(
            context: context,
            userId: currentUser != null ? currentUser!.user.id : ""),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (ctx, state) {
          return Scaffold(
            key: scaffolded,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                title: AppBarHomeWidget(
                  onPressed: () {
                    scaffolded.currentState!.openDrawer();
                  },
                ),
              ),
            ),
            // * darwer
            drawer: DraweWidget(),
            body: getBody(state, ctx: ctx),
          );
        },
      ),
    );
  }

  Widget getBody(HomeState state, {ctx}) {
    switch (state.getHomeState) {
      case RequestState.loading:
        return const Center(child: CircularProgressIndicator());
      case RequestState.loaded:
        return LoadedWidget(context: ctx,state: state,);

      case RequestState.error:
        return const Center(child: Text("Error"));
      case RequestState.pagination:
        return const Center(child: Text("pagination"));
    }
  }
}

