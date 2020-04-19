
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:treeapp/data/model/tree.dart';
import 'package:uuid/uuid.dart';

uploadTreeAndImage(Tree tree, bool isUpdating, File localFile) async{
  if(localFile != null){
    print("uploading image");
    //print (isUpdating);
    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = Uuid().v4();

    final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('trees/images/$uuid$fileExtension');

    await firebaseStorageRef.putFile(localFile).onComplete.catchError((onError){
      print(onError);
      return false;
    });

    String url = await firebaseStorageRef.getDownloadURL();
    print("download url: $url");
    _uploadTree(tree, isUpdating, imageUrl: url);

  }else{
    print('skipping image upload');
    _uploadTree(tree, isUpdating);
  }
}

_uploadTree(Tree tree, bool isUpdating, {String imageUrl}) async{
  CollectionReference treeRef = Firestore.instance.collection('plant');

  if(imageUrl != null){
    tree.image = imageUrl;
  }

  if(isUpdating){
    await treeRef.document(tree.id).updateData(tree.toMap());
    print('update tree with id: ${tree.id}');

  }else{
    DocumentReference documentRef = await treeRef.add(tree.toMap());
    tree.id =documentRef.documentID;
    print('uploaded tree successfully: ${tree.toString()}');
    await documentRef.setData(tree.toMap(), merge: true);

  }
}