import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_mobile_app/story.dart';
import 'package:hexcolor/hexcolor.dart';

class Fragment1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Fragment1State();
  }
}

class Fragment1State extends State<Fragment1> {
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white70,
        child: FutureBuilder(
          future: firebaseCalls(databaseReference), // async work
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new Text('Press button to start');
              case ConnectionState.waiting:
                return new Text('Loading....');
              default:
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                else
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        color: HexColor("#FEF6FF"),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Story(
                                      title: snapshot.data[index].title,
                                      img: snapshot.data[index].url,
                                      descp: snapshot.data[index].description,
                                    )));
                          },
                          child: Card(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Image.network(
                                    snapshot.data[index].url,
                                    height:
                                        MediaQuery.of(context).size.width * 0.3,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      // color: Colors.blueAccent,
                                      width: 200,
                                      // padding: const EdgeInsets.only(right: 10),
                                      child: Text(
                                        '${snapshot.data[index].title} ',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 10),
                                      // color: Colors.lightBlue,
                                      width: 240,
                                      height: 50,
                                      child: Text(
                                        '${snapshot.data[index].description} ',
                                        style: TextStyle(fontSize: 15),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
            }
          },
        ),
      ),
    );
  }
}

class RecipeDetailListItem {
  String name;
  String url;
  String work;
  String title;
  String description;

  RecipeDetailListItem(
      {this.name, this.url, this.work, this.title, this.description});

  factory RecipeDetailListItem.fromJson(Map<dynamic, dynamic> parsedJson) {
    return RecipeDetailListItem(
        name: parsedJson['name'],
        url: parsedJson['url'],
        title: parsedJson['title'],
        description: parsedJson['description']);
  }
}

class RecipeList {
  List<RecipeDetailListItem> dataList;

  RecipeList({this.dataList});

  static List<RecipeDetailListItem> parserecipes(recipeJSON) {
    var rList = recipeJSON['apidata'] as List;
    print(rList);
    List<RecipeDetailListItem> recipeList = rList
        .map((data) => RecipeDetailListItem.fromJson(data))
        .toList(); //Add this
    return recipeList;
  }

  factory RecipeList.fromJSON(Map<dynamic, dynamic> json) {
    return RecipeList(dataList: parserecipes(json));
  }
}

// List<RecipeDetailListItem> listItems = [];

Future<List<RecipeDetailListItem>> firebaseCalls(
    DatabaseReference databaseReference) async {
  List<RecipeDetailListItem> listItems = [];
  RecipeList recipeList;
  DataSnapshot dataSnapshot = await databaseReference.once();
  Map<dynamic, dynamic> jsonResponse = dataSnapshot.value;
  recipeList = new RecipeList.fromJSON(jsonResponse);
  listItems.addAll(recipeList.dataList);

  return listItems;
}
