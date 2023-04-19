

import 'package:clubhouse/screens/chatview.dart';
import 'package:clubhouse/screens/liveroom.dart';
import 'package:clubhouse/screens/login.dart';
import 'package:clubhouse/screens/loginoptionpage.dart';
import 'package:clubhouse/screens/roomview.dart';
import 'package:clubhouse/screens/userdetailimput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'firebase_options.dart';





void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,
  );



  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
  initialRoute: FirebaseAuth.instance.currentUser!=null?roomview.id:loginoptionpage.id,
  routes: {
    loginpage.id :(context)=>const loginpage(),
  chatview.id:(context)=>const chatview(),
  roomview.id:(context)=>const roomview(),
    userdetailinput.id:(context)=>const userdetailinput(),
    loginoptionpage.id:(context)=>const loginoptionpage(),
    LivePage.id:(context)=>const LivePage(),
  },
  builder: EasyLoading.init(),));
}