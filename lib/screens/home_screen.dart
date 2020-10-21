import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import'dart:convert';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_app/screens/signup_screen.dart';
import 'package:json_annotation/json_annotation.dart';


class Home extends StatefulWidget {
  static const routeName = '/home';
  Home({Key key }) : super (key:key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future getData() async{
    var url=("https://jsonplaceholder.typicode.com/posts");
    var response = await http.get(url);
    var responsbody= jsonDecode(response.body);
    return responsbody;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar:AppBar(
              title:Text('Home page'),
            actions: <Widget>[
              FlatButton(
                child: Row(
                  children: <Widget>[

                    Icon(Icons.arrow_back_ios_outlined),
                    Text('Back')
                  ],
                ),
                textColor: Colors.white,
                onPressed:(){
                  Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);
                },
              ),

            ],
          ),
          body:FutureBuilder(
            future: getData(),

            builder: (BuildContext context, AsyncSnapshot snapshot)
            {
              if(snapshot.hasData) {
                return ListView.builder(itemCount:snapshot.data.length, itemBuilder :(context,i){
                  return Container(child: Text(snapshot.data[i]['title']),);
                });
              }
              return CircularProgressIndicator();
            },
          )

      ),
    );
  }
}
