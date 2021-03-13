import 'package:flutter/material.dart';
import 'package:sales_snap_dashboard/utils/constants.dart';

class SearchWidget extends StatelessWidget {
  final controller;
  SearchWidget({Key key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12, top: 12),
      child: TextField(
        controller: controller,
        onChanged: (value) {},
        decoration: InputDecoration(
          hintText: "Search",
          fillColor: kBgLightColor,
          filled: true,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(kDefaultPadding * 0.75), //15
            child: Icon(Icons.search),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
