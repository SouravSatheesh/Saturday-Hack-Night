import 'dart:convert';
import 'package:fireflutters/model.dart';
import 'package:fireflutters/repoDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchResult extends StatefulWidget {
  final String search;
  SearchResult(this.search);

  @override
  _SearchResultState createState() => _SearchResultState();
}

Future<Model> getData(String query) async {
  var model;
  var response = await http.get(
    Uri.parse('https://api.github.com/search/repositories?q=$query'),
    headers: {"Accept": "application/json"},
  );
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
    model = getData(widget.search);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Results for \'${widget.search}\''),
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
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.totalCount > 20
                    ? 20
                    : snapshot.data!.totalCount,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            splashColor: Colors.white,
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>RepoDetails(snapshot.data!.items[index])));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.9),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 100,
                              width: MediaQuery.of(context).size.width - 50,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 10, 15, 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            snapshot.data!.items[index].name,
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            overflow: TextOverflow.fade,
                                            softWrap: false,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16),
                                          child: Row(
                                            children: [
                                              Text(
                                                '${snapshot.data!.items[index].rating}',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5),
                                                child: Text(
                                                  '★',
                                                  style:
                                                      TextStyle(fontSize: 22),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      snapshot.data!.items[index].owner,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
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
