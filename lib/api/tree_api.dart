
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:treeapp/data/model/tree.dart';
import 'package:uuid/uuid.dart';

//function for upload the Tree and Image
uploadTreeAndImage(Tree tree, bool isTreeUpdating, File localTreeFile) async{
  if(localTreeFile != null){
    print("upload tree image");
    //create file extension
    var treeFileExtension = path.extension(localTreeFile.path);
    print(treeFileExtension);

    var treeUuid = Uuid().v4();

    //working with firebase storage and set its path
    final StorageReference firebaseStorageReference = FirebaseStorage.instance.ref().child('trees/images/$treeUuid$treeFileExtension');

    await firebaseStorageReference.putFile(localTreeFile).onComplete.catchError((onTreeError){
      print(onTreeError);
      return false;
    });

    //get tree url
    String treeUrl = await firebaseStorageReference.getDownloadURL();
    print("downloading tree url: $treeUrl");
    _uploadTree(tree, isTreeUpdating, treeImageUrl: treeUrl);

  }else{
    print('skip the image upload');
    _uploadTree(tree, isTreeUpdating);
  }
}


//upload the tree
_uploadTree(Tree tree, bool isTreeUpdating, {String treeImageUrl}) async{
  CollectionReference treeRef = Firestore.instance.collection('plant');

  //when image url is not null
  if(treeImageUrl != null){
    tree.treeImage = treeImageUrl;
  }

  //when isTreeUpdating is true
  if(isTreeUpdating){
    await treeRef.document(tree.treeId).updateData(tree.toMap());
    print('updating tree with the id: ${tree.treeId}');

  }
  //when isTreeUpdating is false
  else{
    DocumentReference documentReference = await treeRef.add(tree.toMap());
    tree.treeId =documentReference.documentID;
    print('the tree was uploaded successfully: ${tree.toString()}');
    await documentReference.setData(tree.toMap(), merge: true);
  }
}