import 'dart:convert';
import 'package:fireflutters/LangColors.dart';
import 'package:fireflutters/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RepoDetails extends StatefulWidget {
  final Item repo;
  RepoDetails(this.repo);
  @override
  _RepoDetailsState createState() => _RepoDetailsState();
}

Future<User> getData(String name) async {
  var user;
  var response = await http.get(
    Uri.parse('https://api.github.com/users/$name'),
    headers: {"Accept": "application/json"},
  );
  if (response.statusCode == 200) {
    var jsonString = response.body;
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    user = User.fromJson(jsonMap);
    return user;
  } else {
    throw Exception('Failed to fetch repos!');
  }
}

class _RepoDetailsState extends State<RepoDetails> {
  late final user;

  @override
  void initState() {
    super.initState();
    user = getData(widget.repo.owner);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('${widget.repo.name}'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: FutureBuilder<User>(
            future: user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            '${widget.repo.avatar}',
                            height: 60,
                            width: 60,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 125,
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        snapshot.data?.name == null
                                            ? '${widget.repo.owner}'
                                            : '${snapshot.data?.name}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  '@${widget.repo.owner}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (widget.repo.language != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20,),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Color(int.parse(
                                      langColors[widget.repo.language]!
                                          .replaceAll('#', '0xff'))),
                                ),
                              ),
                            ),
                            Text(
                              '${widget.repo.language}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            )
                          ],
                        ),
                      )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(
                  '${snapshot.error}',
                  style: TextStyle(color: Colors.white),
                );
              }
              return Center(
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.black,
                ),
              );
            }),
      ),
    );
  }
}
