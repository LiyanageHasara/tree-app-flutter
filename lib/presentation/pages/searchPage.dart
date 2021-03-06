import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:treeapp/presentation/pages/about.dart';
import 'package:treeapp/presentation/pages/searchService.dart';
import 'package:treeapp/presentation/pages/constatncls.dart';
import 'package:treeapp/screens/authenticate/sign_in.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  var queryResultSet = [];
  var tempSearchStore = [];

  /*
I referred the following tutorial to build the search functinality
 https://www.youtube.com/watch?v=0szEJiCUtMM
 */

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['treeTitle'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    void choiceAction(String choice){
      if(choice == Constatnts.Help){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AboutPage())
        );
      }

      else if(choice == Constatnts.Search){
        //Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchPage())
        );
      }

      else if(choice == Constatnts.Logout){
        //Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignIn())
        );
      }
    }

    return new Scaffold(
        appBar: AppBar(
          title: Text('ForestPARK'),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: choiceAction,
              itemBuilder: (BuildContext context){
                return Constatnts.choices.map((String choices){
                  return PopupMenuItem<String>(
                    value: choices,
                    child: Text(choices),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (val) {
                initiateSearch(val);
              },
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.arrow_back),
                    iconSize: 20.0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  contentPadding: EdgeInsets.only(left: 25.0),
                  hintText: 'Search tree',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0))),
            ),
          ),
           //SizedBox(height: 10.0),
          ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: tempSearchStore.map((element) {
                return buildResultCard(element);
              }).toList())
        ]));
  }
}
Widget buildResultCard(data) {

  return Card(
    color: Color(0xFFbddfee4),
            child: Column(
              children: <Widget>[
                  Text(
                      data['treeTitle'],
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      color: Color(0xFF196b69),
                    ),
                  ),
              Padding(
                padding: EdgeInsets.all(8.0),
               ),
              Container(
                height: 210.0,
                width: 352.0,
                decoration: new BoxDecoration(
                image: new DecorationImage(
                image: NetworkImage(data['treeImage'] != null
                    ? data['treeImage']
                  : 'https://www.null.video/img/null-logo-new-small.jpg'),
                fit: BoxFit.cover)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
              Text(
                data['treeDescription'],
                style: TextStyle(fontSize: 15.0),
              ),
              ],
            ),
            );

}
