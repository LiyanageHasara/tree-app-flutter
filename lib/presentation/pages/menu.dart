import 'package:flutter/material.dart';
import 'package:treeapp/data/firestore_service.dart';
import 'package:treeapp/data/model/tree.dart';
import 'package:treeapp/presentation/pages/tree_details.dart';
import 'package:treeapp/screens/authenticate/sign_in.dart';

class MenuPage extends StatelessWidget{


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('ForestPARK'),
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Log Out'),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                );
              }
          )
        ],
      ),
      body: StreamBuilder(
          stream: MyFirestoreService().getTrees(),
          builder: (BuildContext context, AsyncSnapshot<List<Tree>>
          snapshot){
            if(snapshot.hasError || !snapshot.hasData)
              return CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                Tree tree = snapshot.data[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(
                      tree.treeImage != null ? tree.treeImage : 'https://www.null.video/img/null-logo-new-small.jpg',
                      width: 100.0,
                      fit: BoxFit.fitWidth,
                    ),
                    title: Text(tree.treeTitle),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                      ],
                    ),
                    onTap: ()=>Navigator.push(
                      context, MaterialPageRoute(
                      builder: (_) => TreeDetailsPage(tree: tree),
                    ),),
                  ),
                );
              },);
          }
      ),
    );
  }

}