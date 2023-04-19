import 'package:clubhouse/functions/saveusers.dart';
import 'package:clubhouse/screens/roomview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authservice{

  static signupuser({required String name,required String email,required String password,required BuildContext context})async{
    EasyLoading.show(status: "loading");
    try{
      UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
await FirebaseAuth.instance.currentUser!.updateEmail(email);
await firebaseservice.saveuser(name: name, email: email,uid:userCredential.user!.uid);
      context.mounted?ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registration sucessful"))):null;
      EasyLoading.dismiss();
      context.mounted?Navigator.pushNamedAndRemoveUntil(context, roomview.id, (Route<dynamic>route) => false):null;
    }catch(e){
      EasyLoading.dismiss();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));}
  }

  static signinuser({required String email, required String password,required BuildContext context})async{
    EasyLoading.show(status: "loading");
    try{await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    context.mounted?ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sucessful Login"))):null;
    EasyLoading.dismiss();
    context.mounted?Navigator.pushNamedAndRemoveUntil(context, roomview.id, (Route<dynamic>route) => false):null;

  }catch(e){
      EasyLoading.dismiss();
      context.mounted?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()))):null;
    }
  }

  static signinwithgoogle(@required BuildContext context) async{


    GoogleSignInAccount? googleuser= await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleauth=await googleuser?.authentication;
    AuthCredential credential =GoogleAuthProvider.credential(
      accessToken: googleauth?.accessToken,
      idToken: googleauth?.idToken,
    );
    try{
      EasyLoading.show(status: "loading");
      UserCredential userCredential=await FirebaseAuth.instance.signInWithCredential(credential);
    await firebaseservice.saveuser(name: userCredential.user!.displayName!, email: userCredential.user!.email!,uid:userCredential.user!.uid);
    context.mounted?ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Loged in sucessfully"))):null;
    EasyLoading.dismiss();
    context.mounted?Navigator.pushNamedAndRemoveUntil(context, roomview.id, (Route<dynamic>route) => false):null;}
        catch(e){
          EasyLoading.dismiss();

          context.mounted?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()))):null;
        }


  }

}