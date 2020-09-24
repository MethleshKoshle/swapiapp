import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class secondScreen extends StatefulWidget {
  secondScreen({Key key, this.people}) : super(key: key);

  final String people;

  @override
  _secondScreen createState() => _secondScreen();
}
class _secondScreen extends State<secondScreen> {
  dynamic userInfo;
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    this.getPeopleList();
  }

  void getPeopleList() async {
    var result = await http.get(
        Uri.encodeFull(widget.people),
        headers: {"Accept": "Application/json"}
    );
    var _result = jsonDecode(result.body);

    setState(() {
      userInfo = _result;
    });
    _finished = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text('User Info'),
        ),

        body: Card(
          child: Column(
            children: <Widget>[
              _finished ? ListTile(title: Text(userInfo['height']), ) : ListTile(title: Text('Loading..'),)
            ],
          ),
        )
    );
  }
}
