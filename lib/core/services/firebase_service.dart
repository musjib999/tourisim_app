import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future getAllDoc(String collection,
      {String? filter, String? isEqualTo}) async {
    // List<QueryDocumentSnapshot<Map<String, dynamic>>>? documets;
    dynamic documents;
    try {
      final docs = await _firestore
          .collection(collection)
          // .where(filter!, isEqualTo: isEqualTo)
          .orderBy('name')
          .get();
      documents = docs.docs;
    } on FirebaseException catch (e) {
      documents = e.message;
    }
    return documents;
  }

  Future getAllDocBy(String collection,
      {required Object filter, Object? isEqualTo}) async {
    // List<QueryDocumentSnapshot<Map<String, dynamic>>>? documets;
    dynamic documents;
    try {
      final docs = await _firestore
          .collection(collection)
          .where(filter, isEqualTo: isEqualTo)
          .get();
      documents = docs.docs;
    } on FirebaseException catch (e) {
      documents = e.message;
    }
    return documents;
  }

  Future getOneDoc({required String collection, required String id}) async {
    DocumentSnapshot<Map<String, dynamic>>? document;
    try {
      await _firestore.collection(collection).doc(id).get().then((value) {
        document = value;
      });
    } catch (e) {
      throw 'Error occured $e';
    }
    return document;
  }

  Future<dynamic> addDoc(
      {required String collection,
      required Map<String, dynamic> data,
      String? id}) async {
    dynamic document;
    try {
      await _firestore.collection(collection).doc(id).set(data).then((value) {
        document = data;
      });
    } on FirebaseException catch (e) {
      document = e.message.toString();
    }
    return document;
  }

  Future<bool?> updateDoc(
      {required String collection,
      required String id,
      required Map<String, dynamic> data}) async {
    bool? isUpdated;
    try {
      await _firestore
          .collection(collection)
          .doc(id)
          .update(data)
          .then((value) {
        isUpdated = true;
      });
    } catch (e) {
      isUpdated = false;
      throw 'Error occured $e';
    }
    return isUpdated;
  }

  Stream<QuerySnapshot> getDocStream(String collection) {
    Stream<QuerySnapshot>? snapshot;
    try {
      snapshot = _firestore.collection(collection).snapshots();
    } catch (e) {
      throw 'Error occured $e';
    }
    return snapshot;
  }

  Future<bool?> deleteDoc(
      {required String collection, required String id}) async {
    bool? isDeleted;
    try {
      await _firestore.collection(collection).doc(id).delete().then((value) {
        isDeleted = true;
      });
    } catch (e) {
      isDeleted = false;
      throw 'Error occured $e';
    }
    return isDeleted;
  }

  Future<dynamic> savedImage({required String path, required File file}) async {
    dynamic totalBytes;
    try {
      await _storage.ref(path).putFile(file).then((p0) {
        totalBytes = p0.totalBytes;
      });
    } on FirebaseException catch (e) {
      totalBytes = e.message;
    }
    return totalBytes;
  }

  Future<String?> getImageUrl(String path) async {
    String? url;
    await _storage.ref(path).getDownloadURL().then((value) {
      url = value;
    });
    return url;
  }

  Stream<QuerySnapshot> getLikesStream(String placeId) {
    Stream<QuerySnapshot>? snapshot;
    try {
      snapshot = _firestore
          .collection('favourite')
          .where('id', isEqualTo: placeId)
          .snapshots();
    } catch (e) {
      throw 'Error occured $e';
    }
    return snapshot;
  }
}
