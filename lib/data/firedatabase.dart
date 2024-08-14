import 'package:path/path.dart' as p;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MyFirebase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addData(String collectionPath, Map<String, dynamic> data) {
    return _firestore.collection(collectionPath).add(data);
  }

  // ignore: non_constant_identifier_names
  Future<void> updateData(
      String Colliction, String documentId, Map<String, dynamic> data) {
    return _firestore.collection(Colliction).doc(documentId).update(data);
  }

  Future<void> deleteData(String documentId, String colliction) {
    return _firestore.collection(colliction).doc(documentId).delete();
  }

  Future<DocumentSnapshot> getData(String documentId) {
    return _firestore.collection('product').doc(documentId).get();
  }

  Stream<QuerySnapshot> getDataStream(String collectionPath) {
    return _firestore.collection(collectionPath).snapshots();
  }

  Future<String> uploadImage(var imagePath) async {
    try {
      var rfe = _storage.ref().child(p.basename(imagePath.path));
      var uploadTask = rfe.putFile(imagePath);
      var snapTask = uploadTask.snapshot;
      String url = await snapTask.ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Error uploading image: $e');
      rethrow;
    }
  }
}
