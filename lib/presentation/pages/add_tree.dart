import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:treeapp/api/tree_api.dart';
import 'package:treeapp/data/model/tree.dart';

//create AddTreePage class
class AddTreePage extends StatefulWidget {
  final Tree tree;

  final bool isTreeUpdating;

  //constructor
  AddTreePage({Key key, this.tree, @required this.isTreeUpdating}) : super(key: key);

  @override
  _AddTreePageState createState() => _AddTreePageState(tree);
}

class _AddTreePageState extends State<AddTreePage> {

  Tree tree;
  _AddTreePageState(this.tree);
  TextEditingController _treeTitleController;
  TextEditingController _treeDescriptionController;
  GlobalKey<FormState> _treeKey = GlobalKey<FormState>();
  FocusNode _treeDescriptionNode;
  File _treeImageFile;
  String _treeImageUrl;

  @override
  void initState(){
    super.initState();
    _treeTitleController = TextEditingController(text: isEditTree ? widget.tree.treeTitle : '');
    _treeDescriptionController = TextEditingController(text: isEditTree ? widget.tree.treeDescription : '');
    _treeDescriptionNode = FocusNode();
    _treeImageUrl = isEditTree ? tree.treeImage : null;
  }

  get isEditTree => widget.tree != null;

  //show tree image
  Widget _showTreeImage(){

    //when image file is not equal to null
    if(_treeImageFile != null){
      print("show the tree image from the local file");

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(
            _treeImageFile,
            height: 200.0,
            width: 350.0,
            fit: BoxFit.fitHeight,
          ),
          //button for change the image
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text('Change tree Image',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),),
            onPressed: () => _getLocalTreeImage(),
          )
        ],
      );
    }

    //when image url is not equal to null
    else if(_treeImageUrl != null){
      print("Show the tree image from the url");

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          //show image from the internet
          Image.network(
            _treeImageUrl,
            height: 240,
            fit: BoxFit.cover,
          ),
          //to change the image
          FlatButton(
            padding: EdgeInsets.all(15),
            color: Colors.black45,
            child: Text('Change Tree Image',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23, color: Colors.white),),
            onPressed: () => _getLocalTreeImage(),
          )
        ],
      );
    }
  }

  //get local tree image
  _getLocalTreeImage() async{
    File treeImageFile = await ImagePicker.pickImage(maxWidth: 400, source: ImageSource.gallery, imageQuality: 50);

    if(treeImageFile != null){
      setState(() {
        _treeImageFile = treeImageFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(isEditTree ? 'Edit Tree' : 'Add Tree'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _treeKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              _treeImageFile == null && _treeImageUrl == null ?
              //button for add new tree
              ButtonTheme(
                height: 50.0,
                buttonColor: Color(0xFF196b69),
                padding: const EdgeInsets.fromLTRB(135.0, 10.0, 135.0, 10.0),
                child: RaisedButton(
                  onPressed: () => _getLocalTreeImage(),
                  child: Text(
                    'Add Tree Image',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              )
              :_showTreeImage(),
              _treeImageFile == null && _treeImageUrl == null ?
                const SizedBox(height: 10.0)
                :const SizedBox(height: 12.0),
              //title
              TextFormField(
                textInputAction: TextInputAction.next,
                onEditingComplete: (){
                  //cursor goes to the description tab when clicked the next button on keyboard
                  FocusScope.of(context).requestFocus(_treeDescriptionNode);
                },
                controller: _treeTitleController,
                //validation for title
                validator: (text){
                  if(text==null || text.isEmpty)
                    return "Tree name is required";
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "tree name",
                ),
              ),
              const SizedBox(height: 12.0),
              //description
              TextFormField(
                focusNode: _treeDescriptionNode,
                controller: _treeDescriptionController,
                //validation for description tab
                validator: (text){
                  if(text==null || text.isEmpty)
                    return "Tree description is required";
                  return null;
                },
                maxLines: 5,
                decoration: InputDecoration(

                  labelText: "tree description",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15.0),
              //save and edit buttons
              RaisedButton(
                textColor: Colors.white,
                color: Color(0xFF196b69),
                child: Text(isEditTree ? "Update" : "Save"),
                onPressed: () async {
                  print('saveTree called');
                  if(!_treeKey.currentState.validate()){
                    return;
                  }
                  _treeKey.currentState.save();

                  //when tree object is not null
                  if(isEditTree){
                    Tree tree =Tree(treeDescription: _treeDescriptionController.text,
                      treeTitle: _treeTitleController.text,
                      treeImage:_treeImageUrl,
                      treeId: widget.tree.treeId,
                    );

                    uploadTreeAndImage(tree, isEditTree, _treeImageFile);

                    print('the form is saved');
                  }
                  //when tree object is null
                  else{
                    Tree tree =Tree(treeDescription: _treeDescriptionController.text,
                      treeTitle: _treeTitleController.text,
                    );

                    uploadTreeAndImage(tree, isEditTree, _treeImageFile);

                    print('the form is saved');
                  }

                  Navigator.pop(context);

                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
