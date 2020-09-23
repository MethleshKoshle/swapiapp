import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'userInfoDisplay.dart';

class People {
  final String url;

  People(this.url);
}

void main() {
  runApp(MaterialApp(
    title: 'Passing Data',
    home: PeopleScreen(
        apiUrl: "https://swapi.dev/api/people"
    ),
  ));
}

class PeopleScreen extends StatelessWidget {
  final String apiUrl;// = "https://swapi.dev/api/people";

  Future<List<dynamic>> fetchUsers() async {

    var result = await http.get(apiUrl);
    return json.decode(result.body)['results'];

  }

  String _name(dynamic user){
    return user['name'];
  }
  String _url(dynamic user){
    return user['url'];
  }

  PeopleScreen({Key key, @required this.apiUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: fetchUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    return
                      Card(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => secondScreen(people: _url(snapshot.data[index])),
                                  ),
                                );
                              },
                              title: Text(_name(snapshot.data[index])),
                            )
                          ],
                        ),

                      );
                  });
            }else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
