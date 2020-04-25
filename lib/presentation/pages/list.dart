import 'package:flutter/material.dart';
import 'package:treeapp/data/firestore_service.dart';
import 'package:treeapp/data/model/tree.dart';
import 'package:treeapp/presentation/pages/add_tree.dart';
import 'package:treeapp/presentation/pages/tree_details.dart';
import 'package:treeapp/screens/authenticate/sign_in.dart';

class ListPage extends StatelessWidget{

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
      //create StreamBuilder
      body: StreamBuilder(
        stream: MyFirestoreService().getTrees(),
        builder: (BuildContext treeContext, AsyncSnapshot<List<Tree>>
        snapshots){
          if(snapshots.hasError || !snapshots.hasData)
            return CircularProgressIndicator();
          //create the list view for the tree details
          return ListView.builder(
            itemCount: snapshots.data.length,
            itemBuilder: (BuildContext treesContext, int index){
              Tree tree = snapshots.data[index];
              //include a card view into the list items
              return Card(
                child: ListTile(
                  //get image from the internet
                  leading: Image.network(
                    tree.treeImage != null ? tree.treeImage : 'https://www.null.video/img/null-logo-new-small.jpg',
                    fit: BoxFit.fitWidth,
                    width: 100.0,
                  ),
                  //show title of the tree
                  title: Text(tree.treeTitle),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      //edit icon
                      IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.black87,
                          onPressed: () => Navigator.push(treesContext,
                            MaterialPageRoute(
                              builder: (_) => AddTreePage(tree: tree,isTreeUpdating: true),
                            ))
                      ),
                      //delete icon
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.redAccent,
                        onPressed: () => _deleteTree(treesContext, tree.treeId),
                      ),
                    ],
                  ),
                  //navigate to the TreeDetails page when clicking
                  onTap: ()=>Navigator.push(
                      treesContext, MaterialPageRoute(
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
          //navigated to the AddTree page when clicking floating action button
          Navigator.push(context, MaterialPageRoute(
            builder: (_) => AddTreePage(isTreeUpdating: null),
          ));
        },
      ),
    );
  }

  //delete tree function
  void _deleteTree(BuildContext deleteContext,String treeId) async{
    if(await _showDeleteConfirmation(deleteContext)){
      try{
        await MyFirestoreService().deleteTree(treeId);
      }catch(e){
        print(e);
      }
    }
  }

  //show the confirmation dialog box when deleting the tree details
  Future<bool> _showDeleteConfirmation(BuildContext treeContext) async{
    return showDialog(
      barrierDismissible: true,
      context: treeContext,
      builder: (delContext) => AlertDialog(
        content: Text("Do you want to delete?"),
        actions: <Widget>[
          FlatButton(
            child: Text("Delete"),
            textColor: Colors.red,
            onPressed: () => Navigator.pop(delContext, true),
          ),
          FlatButton(
            child: Text("No"),
            textColor: Colors.black,
            onPressed: () => Navigator.pop(delContext, false),
          ),
        ],
      )
    );
  }
}