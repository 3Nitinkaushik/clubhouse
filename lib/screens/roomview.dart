import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clubhouse/screens/liveroom.dart';
import 'package:clubhouse/screens/loginoptionpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class roomview extends StatefulWidget {
  static String id = "roomview";

  const roomview({Key? key}) : super(key: key);
  static const List<String> role = ["Listner", "Moderator", "Viewer"];
  @override
  State<roomview> createState() => _roomviewState();

}

class _roomviewState extends State<roomview> {
  String dropdownvalue = roomview.role.first;
  String roomidenter="";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "CLUBHOUSE",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, loginoptionpage.id, (Route<dynamic> route) => false);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(padding: EdgeInsets.only(top: 80),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    LivePage.isHost=true;
                    String roomid=DateTime.now().millisecondsSinceEpoch.toString();
                    LivePage.roomID=roomid;
                    print(roomid);
                    FirebaseFirestore.instance.collection("rooms").doc(roomid).set({'roomid':roomid});
                    Navigator.pushNamedAndRemoveUntil(context, LivePage.id, (route) => false);
                  },
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        boxShadow: [
                          BoxShadow(color: Colors.green),
                          BoxShadow(color: Colors.white)
                        ],
                        borderRadius: BorderRadius.circular(30),
                        shape: BoxShape.rectangle),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Create A Room",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20)),
                        SizedBox(
                          height: 20,
                        ),
                        Icon(FontAwesomeIcons.house)
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      boxShadow: [
                        BoxShadow(color: Colors.green),
                        BoxShadow(color: Colors.white)
                      ],
                      borderRadius: BorderRadius.circular(30),
                      shape: BoxShape.rectangle),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Enter A room \nby Entring room id",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20),),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: 150,
                          child: TextField(
                            decoration:
                                InputDecoration(labelText: "Enter Room id"),
                            onChanged: (value){
                              setState(() {
                                roomidenter=value;
                              });
                            },
                          )),
                      ElevatedButton(onPressed: ()async{
                        LivePage.isHost=false;
                        List roomlist=[];
                        final rooms=await FirebaseFirestore.instance.collection("rooms").where('roomid',isEqualTo: roomidenter).get();
                        for (var roomsid in rooms.docs){
                          print(roomsid.data());
                          roomlist.add(roomsid.data());
                        }
                        if(roomlist.isNotEmpty){
                          LivePage.isHost=false;
                          String roomid=roomidenter;
                          LivePage.roomID=roomid;
                          Navigator.pushNamedAndRemoveUntil(context, LivePage.id, (route) => false);
                        }
                        else{
                        }

                      }, child: Text("Join Room"),),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
