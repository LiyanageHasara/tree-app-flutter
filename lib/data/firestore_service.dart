import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:treeapp/data/model/tree.dart';

//create MyFirestoreService class using singleton
class MyFirestoreService {
  static final MyFirestoreService _myFirestoreService =
      MyFirestoreService._internal();
  Firestore _firestoreDb = Firestore.instance;

  MyFirestoreService._internal();

  factory MyFirestoreService() {
    return _myFirestoreService;
  }

  //to get the list of trees
  Stream<List<Tree>> getTrees() {
    //.collection("plant")
    //.orderBy("", "asc")
    return _firestoreDb
        .collection('plant')
        .orderBy("treeTitle")
        .snapshots()
        .map(
          (snapshots) => snapshots.documents
              .map(
                (docs) => Tree.fromMap(docs.data, docs.documentID),
              )
              .toList(),
        );
  }

  Stream<List<Tree>> searchTrees(String searchField) {
    return _firestoreDb
        .collection('plant')
        .where('searchKey',
        isEqualTo: searchField.substring(0, 1).toUpperCase())
        .snapshots()
        .map(
          (snapshots) => snapshots.documents
          .map(
            (docs) => Tree.fromMap(docs.data, docs.documentID),
      )
          .toList(),
    );

  }

  //to delete the tree
  Future<void> deleteTree(String treeId) {
    return _firestoreDb.collection('plant').document(treeId).delete();
  }
}
