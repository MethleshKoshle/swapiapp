import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class secondScreen extends StatelessWidget {
  // Declare a field that holds the People.
  final String people;

  Future<dynamic> fetchInfo() async {

    var result = await http.get(people);
    return json.decode(result.body);

  }

  String _name(dynamic user){
    return user['name'];
  }
  String _height(dynamic user){
    return user['height'];
  }

  // In the constructor, require a People.
  secondScreen({Key key, @required this.people}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the People to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text("User Info"),
      ),
      body: Container(
        child: FutureBuilder<dynamic>(
          future: fetchInfo(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: 1,//snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    return new Container(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Name: "+_name(snapshot.data)),
                              Text("Height: "+_height(snapshot.data)),
                            ]
                        )

                    );
                  });
            }else {
              return Center(child: CircularProgressIndicator());
            }
          },


        ),
      ),
      // body: Padding(
      //   padding: EdgeInsets.all(16.0),
      //   child: Text(people),
      //
      // ),
    );
  }
}