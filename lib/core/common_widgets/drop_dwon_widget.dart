
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../theming/styles.dart';

class CustomDropDownWidget extends StatefulWidget {
  final List<DropdownMenuItem> list;
  final Function(dynamic) onSelect;
  final String hint;
  final dynamic currentValue;

  const CustomDropDownWidget(
      {super.key,
      required this.list,
      required this.onSelect, required this.currentValue,
      required this.hint});

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
 dynamic currentValue;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        items: widget.list,
        value: widget.currentValue,
        style: TextStyles.textStyleFontBold12kDarkGrey,

        onChanged: (v) {
          setState(() {
            currentValue = v!;
          });

          widget.onSelect(v!);
        },
        hint: Text(
          widget.hint,
          style: TextStyles.textStyleFontBold16White,
        ),
        iconStyleData: const IconStyleData(
            icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        )),
      ),
    );
  }
}
