import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/layout/palette.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/styles.dart';
import '../../../bloc/cubit/address_cubit.dart';
import '../../../data/models/address_model.dart';
import 'container_check_address.dart';


class AddressesListWidget extends StatelessWidget {
  final List<AddressModel> addresses;
  const AddressesListWidget({
    super.key,
    required this.addresses,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          return ListView.builder(
              itemCount: addresses.length,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemBuilder: (context, index) {
                AddressModel addressModel = addresses[index];
                return GestureDetector(
                  onTap: () {
                    AddressCubit.get(context)
                        .changeDefulteAddressState(addressModel.id);
                  },
                  child: Container(
                    height: 100.h,
                    margin: EdgeInsets.only(bottom: 20.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0.r),
                      color: const Color(0xffffffff),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /// * check is Defulte Address
                          ContainerCheckAddress(
                            color:( state.desfulteAddress == addressModel.id || addressModel.defaultAddress)
                                ? Palette.mainColor
                                : Palette.fontGreyColor,
                          ),
                          horizontalSpace(15.h),

                          Expanded(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text(
                                  addressModel.name,
                                  style:
                                      TextStyles.textStyleFontBold16OrangeColor,
                                ),
                                Text(
                                  addressModel.description,
                                  style: TextStyles
                                      .textStyleFontRegular14greyColor,
                                )
                              ]))
                        ]),
                  ),
                );
              });
        },
      ),
    );
  }
}
