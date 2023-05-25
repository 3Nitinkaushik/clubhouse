import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clubhouse/functions/saveusers.dart';
import 'package:clubhouse/screens/liveroom.dart';
import 'package:clubhouse/screens/loginoptionpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';

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

                    setState(() {
                      roomidenter="${FirebaseAuth.instance.currentUser!.uid}guest";
                    });
                    // LivePage.isHost=true;
                    // String roomid=DateTime.now().millisecondsSinceEpoch.toString();
                    // LivePage.roomID=roomid;
                    // print(roomid);
                    // FirebaseFirestore.instance.collection("rooms").doc(roomid).set({'roomid':roomid});
                    _joinMeeting();
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
                      Text("Enter A room \nby Entring room link",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20),),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: 150,
                          child: TextField(
                            decoration:
                                InputDecoration(labelText: "Enter Room Link"),
                            onChanged: (value){
                              setState(() {
                                roomidenter=value;
                              });
                            },
                          )),
                      ElevatedButton(onPressed: ()async{
                        _joinMeeting();
                        // LivePage.isHost=false;
                        // List roomlist=[];
                        // final rooms=await FirebaseFirestore.instance.collection("rooms").where('roomid',isEqualTo: roomidenter).get();
                        // for (var roomsid in rooms.docs){
                        //   print(roomsid.data());
                        //   roomlist.add(roomsid.data());
                        // }
                        // if(roomlist.isNotEmpty){
                        //   LivePage.isHost=false;
                        //   String roomid=roomidenter;
                        //   LivePage.roomID=roomid;


                          // Navigator.pushNamedAndRemoveUntil(context, LivePage.id, (route) => false);
                        // }
                        // else{
                        // }

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


  _joinMeeting() async {
    String? serverUrl = null ;

    Map<FeatureFlag, Object> featureFlags = {};

    // Define meetings options here
    var options = JitsiMeetingOptions(
      roomNameOrUrl: roomidenter,
      serverUrl: null,
      subject: "Clubhouse",
      isAudioMuted: false,
      isAudioOnly: false,
      isVideoMuted: false,
      userDisplayName: FirebaseAuth.instance.currentUser?.displayName,
      userEmail: FirebaseAuth.instance.currentUser?.email,
      featureFlags: featureFlags,
    );

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeetWrapper.joinMeeting(
      options: options,
      listener: JitsiMeetingListener(
        onOpened: () => debugPrint("onOpened"),
        onConferenceWillJoin: (url) {
          debugPrint("onConferenceWillJoin: url: $url");
        },
        onConferenceJoined: (url) {
          debugPrint("onConferenceJoined: url: $url");
        },
        onConferenceTerminated: (url, error) {
          debugPrint("onConferenceTerminated: url: $url, error: $error");
        },
        onAudioMutedChanged: (isMuted) {
          debugPrint("onAudioMutedChanged: isMuted: $isMuted");
        },
        onVideoMutedChanged: (isMuted) {
          debugPrint("onVideoMutedChanged: isMuted: $isMuted");
        },
        onScreenShareToggled: (participantId, isSharing) {
          debugPrint(
            "onScreenShareToggled: participantId: $participantId, "
                "isSharing: $isSharing",
          );
        },
        onParticipantJoined: (email, name, role, participantId) {
          debugPrint(
            "onParticipantJoined: email: $email, name: $name, role: $role, "
                "participantId: $participantId",
          );
        },
        onParticipantLeft: (participantId) {
          debugPrint("onParticipantLeft: participantId: $participantId");
        },
        onParticipantsInfoRetrieved: (participantsInfo, requestId) {
          debugPrint(
            "onParticipantsInfoRetrieved: participantsInfo: $participantsInfo, "
                "requestId: $requestId",
          );
        },
        onChatMessageReceived: (senderId, message, isPrivate) {
          debugPrint(
            "onChatMessageReceived: senderId: $senderId, message: $message, "
                "isPrivate: $isPrivate",
          );
        },
        onChatToggled: (isOpen) => debugPrint("onChatToggled: isOpen: $isOpen"),
        onClosed: () => debugPrint("onClosed"),
      ),
    );
  }
}
