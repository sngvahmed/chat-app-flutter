// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(ChatScreen());

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Screen',
      home: Scaffold(
        appBar: AppBar(title: const Center(child: Text('Chat Flutter'))),
        body: Center(child: RandomWords()),
      ),
    );
  }
}

class RandomWordState extends State<RandomWords> {
  final _suggestions = <WordPair>[];

  @override
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0), 
		itemBuilder: (context, i) {
			if (i.isEven) return Divider();
			final idx = i ~/ 2;
			if (idx >= _suggestions.length) {
				_suggestions.addAll(generateWordPairs().take(10));
			}
			return ListTile(
				title: Center( child: Text(
					_suggestions[idx].asPascalCase,
					style: const TextStyle(fontSize: 18.0),
				)),
			);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Center( child: Text('Startup Name Generator'),),
      ),
      body: _buildSuggestions(),
    );
  }

}

class RandomWords extends StatefulWidget {
  @override
  RandomWordState createState() => new RandomWordState();
}
