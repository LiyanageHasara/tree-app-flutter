import 'package:flutter/material.dart';
import 'package:treeapp/data/firestore_service.dart';
import 'package:treeapp/data/model/tree.dart';
import 'package:treeapp/presentation/pages/add_tree.dart';
import 'package:treeapp/presentation/pages/tree_details.dart';
import 'package:treeapp/screens/authenticate/sign_in.dart';

class HomePage extends StatelessWidget{


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
        stream: FirestoreService().getTrees(),
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
                    tree.image != null ? tree.image : 'https://www.null.video/img/null-logo-new-small.jpg',
                    width: 100.0,
                    fit: BoxFit.fitWidth,
                  ),
                  title: Text(tree.title),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        color: Colors.black,
                        icon: Icon(Icons.edit),
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(
                              builder: (_) => AddTreePage(tree: tree,isUpdating: true),
                            ))
                      ),
                      IconButton(
                        color: Colors.red,
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteTree(context, tree.id),
                      ),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (_) => AddTreePage(isUpdating: null),
          ));
        },
      ),
    );
  }

  void _deleteTree(BuildContext context,String id) async{
    if(await _showConfirmationDialog(context)){
      try{
        await FirestoreService().deleteTree(id);
      }catch(e){
        print(e);
      }
    }

  }

  Future<bool> _showConfirmationDialog(BuildContext context) async{
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        content: Text("Do you want to delete?"),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.red,
            child: Text("Delete"),
            onPressed: () => Navigator.pop(context, true),
          ),
          FlatButton(
            textColor: Colors.black,
            child: Text("No"),
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      )
    );
  }
}