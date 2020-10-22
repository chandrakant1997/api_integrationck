import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      title: "api interation by ck",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final String url = "https://swapi.co/api/people";
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

//https://reactnative.dev/movies.json
  Future<String> getJsonData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "Application/json"});
    print(response.body);

    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['results'];
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return new Scaffold(
      appBar: AppBar(
        title: Text('retrieve json data via HTTP Get'),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: width * 0.3,
                          child: Text(
                            data[index]['name'],
                            style: TextStyle(color: Colors.pink),
                          ),
                          padding: EdgeInsets.all(20.0),
                        ),
                        Container(
                          width: width * 0.2,
                          child: Text(
                            data[index]['height'],
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          padding: EdgeInsets.all(20.0),
                        ),
                        Container(
                          width: width * 0.3,
                          child: Text(
                            data[index]['skin_color'],
                            style: TextStyle(color: Colors.green),
                          ),
                          padding: EdgeInsets.all(20.0),
                        ),
                        Container(
                          width: width * 0.10,
                          child: Text(
                            data[index]['mass'],
                            style: TextStyle(color: Colors.purple),
                          ),
                          padding: EdgeInsets.all(10.0),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
