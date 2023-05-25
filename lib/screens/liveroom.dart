import 'package:clubhouse/screens/roomview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

class LivePage extends StatelessWidget {
  static final String id = "LivePage";
  static String roomID = "";
  static bool isHost = false;

  const LivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ZegoLiveAudioRoomController zegoLiveAudioRoomController =
        ZegoLiveAudioRoomController();
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.pushNamedAndRemoveUntil(
              context, roomview.id, (route) => false);
          return Future(() => false);
        },
        child: Scaffold(
            appBar: AppBar(
              title: Center(child: Text("Room id:$roomID")),
            ),
            body: ZegoUIKitPrebuiltLiveAudioRoom(

              appID:
                  1030592619, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
              appSign:
                  'ya2d03f8837661573f787f715a25dc4c0f6ab8cd89da28a4eb13ab77368173d47', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
              userID: '${FirebaseAuth.instance.currentUser!.uid}',
              userName: '${FirebaseAuth.instance.currentUser!.displayName!}',
              roomID: roomID,
              config: isHost
                  ? ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
                  : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience()
                ..onLeaveConfirmation = (BuildContext context) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, roomview.id, (route) => false);
                  return Future(() => false);
                },
            )),
      ),
    );
  }
}
