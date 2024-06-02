import 'package:flutter/material.dart';
import 'package:wajed_app/core/enums/loading_status.dart';

class BodyWidget extends StatefulWidget {
  final Widget loadedWidget;
  final RequestState state;
  const BodyWidget(
      {super.key, required this.loadedWidget, required this.state});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  @override
  Widget build(BuildContext context) {
    switch (widget.state) {
      case RequestState.loading:
        return const Center(child: CircularProgressIndicator());
      case RequestState.loaded:
        return widget.loadedWidget;

      case RequestState.error:
        return const Center(child: Text("Error"));
      case RequestState.pagination:
        return const Center(child: Text("pagination"));
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}

Widget getBodyWidget({ state,  loadedWidget}) {
  switch (state) {
    case RequestState.loading:
      return const Center(child: CircularProgressIndicator());
    case RequestState.loaded:
      return loadedWidget;

    case RequestState.error:
      return const Center(child: Text("Error"));
    case RequestState.pagination:
      return const Center(child: Text("pagination"));
    default:
      return const Center(child: CircularProgressIndicator());
  }
}
