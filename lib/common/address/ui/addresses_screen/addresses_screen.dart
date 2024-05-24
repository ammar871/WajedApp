import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajed_app/common/address/bloc/cubit/address_cubit.dart';
import 'package:wajed_app/common/address/ui/map_screen/map_screen.dart';
import 'package:wajed_app/core/common_widgets/custom_button.dart';
import 'package:wajed_app/core/extension/extensions_routing.dart';
import 'package:wajed_app/core/helpers/spacing.dart';
import 'package:wajed_app/core/services/services_locator.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import '../../../../core/enums/loading_status.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/strings.dart';
import 'components/addresses_list_widget.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  @override
  void initState() {

    super.initState();
    AddressCubit.get(context).getAddress(userId: currentUser!.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
         Strings.selectAddress.tr(),
          style: TextStyles.textStyleFontBold16BlackAppBar,
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          switch (state.getAddressessStaet) {
            case RequestState.loading:
              return const Center(child: CircularProgressIndicator());
            case RequestState.loaded:
              return Column(
                children: [
                  verticalSpace(20.h),
                  // * button Add Address
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        width: context.width / 2,
                        child: CustomButtonWithIcon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) => sl<AddressCubit>(),
                                        child: const MapScreen(),
                                      )),
                            ).then((value) {
                              AddressCubit.get(context)
                                  .getAddress(userId: currentUser!.user.id);
                            });
                          },
                          title: Strings.addNewAddress.tr(),
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // * list Addresses
                  verticalSpace(30.h),
                  AddressesListWidget(
                    addresses: state.addresses,
                  ),
                  verticalSpace(30.h),

                  /// * button select Address
                  state.defulteAddressState ==
                  RequestState.loading
                      ? SizedBox(
                          height: 50.h,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: CustomButton(
                              title: Strings.select.tr(),
                              onPressed: () {
                                if (state.desfulteAddress != null) {
                                  AddressCubit.get(context).defulteAddress(
                                      state.desfulteAddress!,
                                      currentUser!.user.id,
                                      context: context);
                                }
                              }),
                        ),
                  verticalSpace(30.h),
                ],
              );
            case RequestState.error:
              return Container();
            default:
              return Container();
          }
        },
      ),
    );
  }
}
