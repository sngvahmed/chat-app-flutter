import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orangechat/chat.dart';

class ChatAppBar extends StatelessWidget {
  var chatAppBar =
      Scaffold(appBar: AppBar(title: Center(child: Text('Orange Chat'))), body: ListDisplay());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orange Chat',
      home: chatAppBar,
    );
  }
}