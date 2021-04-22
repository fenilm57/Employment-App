import 'package:employment_app/style/Style.dart';
import 'package:flutter/material.dart';

Widget craeteDrawerBodyItems(
    {IconData icons, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: [
        Icon(icons),
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              text,
              style: regularBlackColorRegular(),
            ))
      ],
    ),
    onTap: onTap,
  );
}
