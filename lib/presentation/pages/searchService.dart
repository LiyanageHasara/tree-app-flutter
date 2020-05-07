import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchByName(String searchField) {
    return Firestore.instance
        .collection('plant')
        .where('searchKey',
        isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }

/*
I referred the following tutorial about "Splash Screen" to build this widget
https://www.youtube.com/watch?v=0szEJiCUtMM
 */

}
