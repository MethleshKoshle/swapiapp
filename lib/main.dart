import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'userInfoDisplay.dart';

class People {
  final String url;

  People(this.url);
}

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PeopleScreen(apiUrl: "https://swapi.dev/api/people"),
    );
  }
}

class PeopleScreen extends StatefulWidget {
  PeopleScreen({Key key, this.apiUrl}) : super(key: key);

  final String apiUrl;

  @override
  _PeopleScreen createState() => _PeopleScreen();
}
class _PeopleScreen extends State<PeopleScreen>{
  List<dynamic> userList;
  bool _finished=false;

  @override
  void initState() {
    super.initState();
    this.getPeopleList();
  }

  void getPeopleList() async{
      var result = await http.get(
          Uri.encodeFull(widget.apiUrl),
          headers: {"Accept":"Application/json"}
      );
      var _result = jsonDecode(result.body);

      setState(() {
        userList = _result['results'];
      });
      _finished=true;
  }

  String _name(dynamic user){
    return user['name'];
  }
  String _url(dynamic user){
    return user['url'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('User List'),
      ),

      body: _finished ? ListView.builder(

        padding: const EdgeInsets.all(8),
        itemCount: userList.length,
        itemBuilder: (BuildContext context, int index) {

          return Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => secondScreen(people: _url(userList[index])),
                      ),
                    );
                  },
                  title: Text(_name(userList[index])),
                  )
              ],
            ),
          );
        }
      ):Center(child: Text('Loading..'),)
    );
  }
}
