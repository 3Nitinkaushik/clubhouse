import 'package:clubhouse/functions/authservice.dart';
import 'package:clubhouse/screens/loginoptionpage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class loginpage extends StatefulWidget {
  static String id = "login";
  static String pressedbutton = "";

  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final _formkey = GlobalKey<FormState>();
  String email = "";
  String name = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamedAndRemoveUntil(
            context, loginoptionpage.id, (Route<dynamic> route) => false);
        return Future(() => false);
      },
      child: SafeArea(
        child: Scaffold(
          body: Form(
            key: _formkey,
            child: Center(
              child: Container(
                height: 400,
                width: 300,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 3,
                          spreadRadius: 2),
                      BoxShadow(color: Colors.tealAccent)
                    ]),
                child: ListView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            loginpage.pressedbutton.toUpperCase(),
                            style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 30,
                                fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          loginpage.pressedbutton == "sign up"
                              ? TextFormField(
                                  key: const ValueKey("name"),
                                  decoration: const InputDecoration(
                                      hintText: "Enter Name"),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter Name';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      name = value;
                                    });
                                  },
                                )
                              : Container(),
                          TextFormField(
                            key: const ValueKey("email"),
                            decoration:
                                const InputDecoration(hintText: "Enter Email"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter email';
                              } else if (!(value!.contains('@'))) {
                                return 'Please enter a valid email';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                          ),
                          TextFormField(
                            key: const ValueKey("Password"),
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: (loginpage.pressedbutton == "sign up"
                                        ? "Set"
                                        : "Enter") +
                                    " Password"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Password';
                              } else if (value!.length < 6) {
                                return 'Password length should be greater then 6 characters';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                _formkey.currentState!.save();

                                loginpage.pressedbutton == "sign up"
                                    ? Authservice.signupuser(
                                        name: name,
                                        email: email,
                                        password: password,
                                        context: context)
                                    : Authservice.signinuser(
                                        email: email,
                                        password: password,
                                        context: context);
                              }
                            },
                            child: Text(loginpage.pressedbutton.toUpperCase()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          RawMaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            constraints: BoxConstraints(
                                minHeight: 50, maxWidth: 200, maxHeight: 100),
                            fillColor: Colors.teal.shade300,
                            onPressed: () {
                              Authservice.signinwithgoogle(context);

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(loginpage.pressedbutton == "sign up"
                                    ? "Sign in using Google"
                                    : "Login using Google"),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  FontAwesomeIcons.google,
                                  color: Colors.blueAccent,
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
