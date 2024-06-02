import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wajed_app/core/enums/loading_status.dart';
import 'package:wajed_app/core/utils/app_model.dart';
import 'package:wajed_app/user/offers/bloc/offer_cubit/offer_cubit.dart';
import 'package:wajed_app/user/offers/data/models/offfer_model.dart';
import 'components/loaded_offers_widget.dart';

class OffersScreen extends StatefulWidget {
  final OfferModel offer;
  const OffersScreen({super.key, required this.offer});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  void initState() {
    super.initState();
    OfferCubit.get(context).getMarketsByOfferId(
        offerId: widget.offer.id,
        addressId: currentDefulteAddress!.id,
        page: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<OfferCubit, OfferState>(
          builder: (context, state) {
      switch (state.getMarketsByOfferIdState) {
        case RequestState.loading:
          return const Center(child: CircularProgressIndicator());
        case RequestState.loaded:
          return LoadedOffersWidget(state: state,offer: widget.offer,);

        case RequestState.error:
          return const Center(child: Text("Error"));
        case RequestState.pagination:
          return const Center(child: Text("pagination"));
        default:
          return const Center(child: CircularProgressIndicator());
      }
    }));
  }
}

