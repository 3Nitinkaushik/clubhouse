import 'package:flutter/material.dart';

class chatview extends StatefulWidget {
  static String id="chatview";
  const chatview({Key? key}) : super(key: key);

  @override
  State<chatview> createState() => _chatviewState();
}

class _chatviewState extends State<chatview> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.pink,);
  }
}
