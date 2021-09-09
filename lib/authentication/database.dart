import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  uploadUser(userMap) {
    FirebaseFirestore.instance.collection('users').add(userMap);
  }

  uploadPoints(email, name, int points) async {
    return await FirebaseFirestore.instance
        .collection('points')
        .doc('${name}_$email')
        .set({'points': points, 'name': name})
        .then((_) => print('Added Points'))
        .catchError((error) => print('Add failed: $error'));
  }

  getPoints(email, name) async {
    return await FirebaseFirestore.instance
        .collection('points')
        .doc('${name}_$email')
        .get()
        .then((DocumentSnapshot document) {
      print("document_build:$document");
      return document['points'];
    }).onError((error, stackTrace) => null);
  }

  updatePoints(email, name, int points) {
    FirebaseFirestore.instance
        .collection('points')
        .doc('${name}_$email')
        .update({'points': points});
  }

  increasePoints(email, name, int points) async {
    FirebaseFirestore.instance
        .collection('points')
        .doc('${name}_$email')
        .update({'points': (await getPoints(email, name) + points)});
  }

  decreasePoints(email, name, int points) async {
    FirebaseFirestore.instance
        .collection('points')
        .doc('${name}_$email')
        .update({'points': (await getPoints(email, name) - points)});
  }

  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: username)
        .get();
  }

  getUserByEmail(String email) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
  }
}
