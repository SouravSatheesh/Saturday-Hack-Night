import 'dart:convert';
import 'package:fireflutters/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchResult extends StatefulWidget {
  final String search;
  SearchResult(this.search);

  @override
  _SearchResultState createState() => _SearchResultState();
}

Future<Model> getData() async {
  var model;
  var response = await http.get(
      Uri.parse("https://api.github.com/search/repositories?q=robocet"),
      headers: {"Accept": "application/json"});
  if (response.statusCode == 200) {
    var jsonString = response.body;
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    model = Model.fromJson(jsonMap);
    return model;
  } else {
    throw Exception('Failed to fetch repos!');
  }
}

class _SearchResultState extends State<SearchResult> {
  late Future<Model> model;

  @override
  void initState() {
    super.initState();
    model = getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FireFlutters"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: FutureBuilder<Model>(
          future: model,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 40,
                              width: 300,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                                child: Text(
                                  snapshot.data!.items[index].name,
                                  style: TextStyle(
                                    
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
                itemCount: snapshot.data!.totalCount,
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(
                child: const CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: Colors.black,
            ));
          },
        ),
      ),
    );
  }
}
