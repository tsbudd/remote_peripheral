// ignore_for_file: prefer_const_constructors
// ignore_for_file: lowercase_with_underscores
import 'package:flutter/material.dart';

// app colors
const burgundy = Color(0xffa5514f);
const orange = Color(0xfffdae38);
const blue = Color(0xff4fa3a5);
const background = Color(0xff264248);
const text = Color(0xFFFEFEFE);

class CustNavBar extends StatelessWidget implements PreferredSizeWidget {
  const CustNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: orange,
      title: const Text(
        'PENNY PUSHER',
        style: TextStyle(
          fontSize: 35.0,
          fontFamily: "Futura Medium",
          fontStyle: FontStyle.normal,
          color: text,
        ),
      ),
      actions: <Widget>[
        IconButton(
          padding: const EdgeInsets.only(right: 30.0),
          icon: const Icon(
            Icons.account_circle_outlined,
            size: 35.0,
            // location too far to right
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Register User // TODO')));
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
