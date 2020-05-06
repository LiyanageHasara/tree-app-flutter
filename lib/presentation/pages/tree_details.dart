import 'package:flutter/material.dart';
import 'package:treeapp/data/model/tree.dart';

//create TreeDetailsPage class
class TreeDetailsPage extends StatelessWidget {
  final Tree tree;

  //constructor
  const TreeDetailsPage({Key key, @required this.tree}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title for details page
        title: Text('Tree Details'),
      ),
      //https://www.youtube.com/watch?v=BOztHbCIn0M&t=252s
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //show the title of the selected tree
            Text(
              tree.treeTitle,
              style: Theme.of(context).textTheme.title.copyWith(
                  color: Color(0xFF196b69),
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 18.0,
            ),
            //Show the image of the selected tree
            Container(
              height: 210.0,
              width: 352.0,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: NetworkImage(tree.treeImage != null
                          ? tree.treeImage
                          : 'https://www.null.video/img/null-logo-new-small.jpg'),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
            //show the description of selected tree
            Text(
              tree.treeDescription,
              style: TextStyle(fontSize: 15.0),
            ),
          ],
        ),
      ),
    );
  }
}
