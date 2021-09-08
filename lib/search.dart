import 'package:fireflutters/Button.dart';
import 'package:fireflutters/searchResult.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool _validate = false;
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("FireFlutters"),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Image(
                image: AssetImage("lib/images/github.png"),
                height: 175,
                width: 175,
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: search,
                  autofocus: false,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    hintText: "Github Repository",
                    errorText: _validate ? "Search can't be null" : null,
                    errorStyle:
                        TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    hintStyle: TextStyle(
                      color: Colors.white60,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.blue, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.white, width: 1),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.red, width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red, width: 1),
                    ),
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  if (search.text.isEmpty) {
                    setState(() {});
                    _validate = true;
                  } else {
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    _validate = false;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchResult(search.text)));
                  }
                },
                child: buttonblue(context, "Search"),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
