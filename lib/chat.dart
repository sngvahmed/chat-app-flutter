import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

import 'package:orangechat/model.dart';

class ListDisplay extends StatefulWidget {
  @override
  State createState() => new ChatScreen();
}

Container buildtextListChat(DocumentSnapshot word) {
  print(word);
  return Container(
    padding: EdgeInsets.all(10.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
     children: <Widget>[
         Text(word["name"], textDirection: TextDirection.ltr, style: TextStyle(
              color: Colors.orange,
              fontSize: 15.0
         ),), 
         Text(word["msg"], textDirection: TextDirection.ltr, style: TextStyle(
              color: Colors.black,
              fontSize: 20.0
         ))
     ],
    ),
  );
}

class ChatScreen extends State<ListDisplay> {
  final textController = TextEditingController();
  CollectionReference dbReplies = Firestore.instance.collection('public_channel');

  String generateRandomName() {
    var rng = new Random();
    String name = "";
    for (var i = 0; i < 10; i++) {
      var numb = (65 + (rng.nextInt(100) % 26));
      name += String.fromCharCode(numb);
    }
    return name;
  }

  StreamBuilder buildMessaegList() {
    var stream = StreamBuilder(
      stream: dbReplies.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text("Loading ....");
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (BuildContext ctxt, int Index) =>
              buildtextListChat(snapshot.data.documents[snapshot.data.documents.length - Index - 1]),
        );
      },
    );
    return stream;
  }

  TextField buildChatTextInput() {
    return TextField(
      controller: textController,
      onSubmitted: (text) {
        PublicChannelMsg publicMsg = PublicChannelMsg(generateRandomName(), text);
        print("name: " + publicMsg.name + "with message: " + publicMsg.msg);
        Firestore.instance.runTransaction((Transaction tx) async {
          var _result = await dbReplies.add(publicMsg.toJson());
          textController.clear();
          setState(() {});
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var container = Column(
      children: <Widget>[
        Expanded(child: buildMessaegList()),
        buildChatTextInput()
      ],
    );

    return new Container(
      margin: EdgeInsets.only(right: 5.0, bottom: 10.0, left: 5.0, top: 0.0),
      alignment: Alignment.bottomCenter,
      child: container,
    );
  }
}
