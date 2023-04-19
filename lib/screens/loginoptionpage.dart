import 'package:clubhouse/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

class loginoptionpage extends StatefulWidget {
  static String id = "loginoption";
  const loginoptionpage({Key? key}) : super(key: key);

  @override
  State<loginoptionpage> createState() => _loginoptionpageState();
}

class _loginoptionpageState extends State<loginoptionpage> {

  @override

  void initState() {


    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            "Clubhouse",
            style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          )),
          SizedBox(
            height: 100,
          ),
          Roundbuttton(
            text: "Sign up",
            icon: Icons.arrow_forward_rounded,
            onpressed: (){
              loginpage.pressedbutton="sign up";
              Navigator.pushNamedAndRemoveUntil(context, loginpage.id, (Route<dynamic>route) => false);
            },
          ),
          SizedBox(
            height: 30,
          ),
          Roundbuttton(
            onpressed: (){
              loginpage.pressedbutton="login";
            Navigator.pushNamedAndRemoveUntil(context, loginpage.id, (Route<dynamic>route) => false);


            },
            text: "Login",
            icon: Icons.login_rounded,
          )
        ],
      ),
    ));
  }
}

class Roundbuttton extends StatelessWidget {
  final void Function()? onpressed;
  final String text;
  final IconData? icon;
  const Roundbuttton({
    this.onpressed,
    required this.text,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.blueAccent,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: onpressed,
      child: Container(
        width: 140,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              icon,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
