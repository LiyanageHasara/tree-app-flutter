import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treeapp/data/animation_page_route.dart';
import 'package:treeapp/data/firestore_service.dart';
import 'package:treeapp/data/model/tree.dart';
import 'package:treeapp/presentation/pages/about.dart';
import 'package:treeapp/presentation/pages/searchPage.dart';
import 'package:treeapp/presentation/pages/tree_details.dart';
import 'package:treeapp/screens/authenticate/sign_in.dart';
import 'package:treeapp/presentation/pages/constatncls.dart';

class MenuPage extends StatelessWidget {
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

    return Scaffold(
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
      //create StreamBuilder
      body: StreamBuilder(
          stream: MyFirestoreService().getTrees(),
          builder:
              (BuildContext treeContext, AsyncSnapshot<List<Tree>> snapshots) {
            if (snapshots.hasError || !snapshots.hasData)
              return CircularProgressIndicator();
            //create the list view for the tree details
            return ListView.builder(
              itemCount: snapshots.data.length,
              itemBuilder: (BuildContext treesContext, int index) {
                Tree tree = snapshots.data[index];
                //include a card view into the list items
                return Card(
                  elevation: 3.0,
                  color: Color(0xFFf7fff8),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0)),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => Navigator.push(
                          treesContext,
                          AnimationPageRoute(
                            'center',
                            widget: TreeDetailsPage(tree: tree),
                          ),
                        ),
                        child: new ClipRRect(
                          child: new Image.network(
                            tree.treeImage != null
                                ? tree.treeImage
                                : 'https://www.null.video/img/null-logo-new-small.jpg',
                            fit: BoxFit.fitWidth,
                            height: 200.0,
                            width: 700.0,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: new Radius.circular(15.0),
                            topRight: new Radius.circular(15.0),
                          ),
                        ),
                      ),
                      new Padding(
                        padding: new EdgeInsets.all(12.0),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text(
                                  tree.treeTitle.toUpperCase(),
                                  style: Theme.of(context).textTheme.title,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),

/*      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Color(0xFF196b69),
          size: 30,
        ),
        elevation: 10,
        backgroundColor: Color(0xFFf7fff8),
        onPressed: () {
          //navigated to the AddTree page when clicking floating action button
          Navigator.push(
            context,
            AnimationPageRoute(
              'bottomCenter',
              widget: AddTreePage(isTreeUpdating: null),
            ),
          );
        },
      ),*/
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
