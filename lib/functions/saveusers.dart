
import 'package:cloud_firestore/cloud_firestore.dart';

class firebaseservice{
static saveuser({required String name,required String email,required String uid})async{
  await FirebaseFirestore.instance.collection("users").doc(uid).set({'email':email,'name':name});

}}