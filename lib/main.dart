// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:english_words/english_words.dart';
import './screens/home.dart';

void main() => runApp(ChatApp());


class ChatApp extends StatelessWidget {
  var chatAppBar = Scaffold(
    appBar: AppBar(title: Text("Chat App")),
    body: Home()
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hello Chat App",
      home: chatAppBar,
    );
  }
}
