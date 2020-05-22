import 'package:cloud_firestore/cloud_firestore.dart';

test() {
  Firestore.instance
      .collection('books')
      .document()
      .setData({'title': 'title', 'author': 'author'});
}
