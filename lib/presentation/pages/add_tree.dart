import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:treeapp/api/tree_api.dart';
import 'package:treeapp/data/firestore_service.dart';
import 'package:treeapp/data/model/tree.dart';
import 'package:path/path.dart';

class AddTreePage extends StatefulWidget {
  final Tree tree;

  final bool isUpdating;

  AddTreePage({Key key, this.tree, @required this.isUpdating}) : super(key: key);
  //AddTreePage({@required this.isUpdating});

  //const AddTreePage({Key key, this.tree}) : super(key: key);
  @override
  _AddTreePageState createState() => _AddTreePageState(tree);
}

class _AddTreePageState extends State<AddTreePage> {

  Tree tree;
  _AddTreePageState(this.tree);
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  FocusNode _descriptionNode;
  String _imageUrl;
  File _imageFile;



  @override
  void initState(){
    super.initState();
    _titleController = TextEditingController(text: isEditTree ? widget.tree.title : '');
    _descriptionController = TextEditingController(text: isEditTree ? widget.tree.description : '');
    _descriptionNode = FocusNode();
    _imageUrl = tree.image;
  }

  Widget _showImage(){
    //_imageUrl = tree.image;

    if(_imageFile != null){
      print("showing image from local file");

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(
            _imageFile,
            fit: BoxFit.fitHeight,
            //height: 250,
            width: 350.0,
            height: 200.0,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text('Change Image',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),),
            onPressed: () => _getLocalImage(),
          )
        ],
      );
    }

    else if(_imageUrl != null){
      print("Showing image from url");

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.network(
            _imageUrl,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text('Change Image',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),),
            onPressed: () => _getLocalImage(),
          )
        ],
      );
    }
  }

  _getLocalImage() async{
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxWidth: 400);

    if(imageFile != null){
      setState(() {
        _imageFile = imageFile;
      });
    }
  }

  get isEditTree => widget.tree != null;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(isEditTree ? 'Edit Tree' : 'Add Tree'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _showImage(),
              SizedBox(
                height: 16,
              ),
              _imageFile == null && _imageUrl == null ?
              ButtonTheme(
                child: RaisedButton(
                  onPressed: () => _getLocalImage(),
                  child: Text(
                    'Add Image',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              )
              :SizedBox(height: 0,),
              TextFormField(
                textInputAction: TextInputAction.next,
                onEditingComplete: (){
                  FocusScope.of(context).requestFocus(_descriptionNode);
                },
                controller: _titleController,
                validator: (value){
                  if(value==null || value.isEmpty)
                    return "Title cannot be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                focusNode: _descriptionNode,
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "description",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text(isEditTree ? "Update" : "Save"),
                onPressed: () async {
                  print('saveTree called');
                  if(!_key.currentState.validate()){

//                    try{
//                      if(isEditTree){
//                        Tree tree =Tree(description: _descriptionController.text,
//                        title: _titleController.text,
//                        id: widget.tree.id,
//                        );
//                        await FirestoreService().updateTree(tree);
//
//                        print("name: ${tree.title}");
//                        print("description: ${tree.description}");
//                        print("imageFile: ${_imageFile.toString()}");
//                        print("name: $_imageUrl");
//
//
//                      }else {
//                        Tree tree =Tree(description: _descriptionController.text,
//                        title: _titleController.text,
//                        );
//                        await FirestoreService().addTree(tree);
//                      }
//                      Navigator.pop(context);
//                    }catch(e){
//                      print(e);
//                    }
                    return;
                  }
                  _key.currentState.save();

                  print('form saved');

                  uploadTreeAndImage(tree, widget.isUpdating, _imageFile);

                  print("name: ${tree.title}");
                  print("description: ${tree.description}");
                  print("imageFile: ${_imageFile.toString()}");
                  print("name: $_imageUrl");
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
