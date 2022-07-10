import 'package:flutter/material.dart';
import 'package:todo/utils/pallet.dart';
import 'package:todo/utils/style.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final String hint;
  final List<DropdownMenuItem<T>>? items;
  final T? selectedItem;
  final Function voidCallack;
  final bool small;

  const CustomDropdownButton(
      {Key? key,
      required this.hint,
      required this.items,
      required this.selectedItem,
      required this.voidCallack,
      this.small = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.fromLTRB(15, 15, small ? 0 : 15, 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          border: Border.all(color: Pallet.grey)),
      child: DropdownButtonHideUnderline(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: DropdownButton<T>(
              iconEnabledColor: Pallet.primaryBlue,
              hint: Center(
                child: Text(
                  hint,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              style: const TextStyle(fontSize: 16),
              value: selectedItem,
              items: items,
              onChanged: (value) {
                voidCallack(value);
              }),
        ),
      ),
    );
  }
}