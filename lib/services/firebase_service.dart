import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telepatia_ai/states/uploading_state/uploading_state.dart';
import 'package:uuid/uuid.dart';

class FirebaseService {
  final _dbRef = FirebaseFirestore.instance;
  final _storageRef = FirebaseStorage.instance.ref();
  final _uuid = Uuid();

  Future<String> saveInBucket(
      String storagePath, String filePath, WidgetRef ref) async {
    try {
      final pathRef = _storageRef.child(storagePath);
      File file = File(filePath);
      UploadTask uploadTask = pathRef.putFile(file);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress = snapshot.bytesTransferred / snapshot.totalBytes;
        ref.read(uploadingProgressProvider.notifier).setState(progress);
      });

      await uploadTask;
      return await pathRef.getDownloadURL();
    } catch (e) {
      debugPrint("Error saving data: $e");
      return '';
    }
  }

  Future<void> saveInDatabase(
      String collection, String deviceId, Map<String, Object> data) async {
    await _dbRef
        .collection(collection)
        .doc(deviceId)
        .collection("files")
        .doc(_uuid.v4())
        .set(data, SetOptions(merge: true))
        .onError((e, _) => debugPrint("Error saving data: $e"));
  }

  Future<List<Map<String, dynamic>>> readSubCollection(
      String collection, String docId, String subCollection) async {
    try {
      QuerySnapshot querySnapshot = await _dbRef
          .collection(collection)
          .doc(docId)
          .collection(subCollection)
          .get();

      return querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } catch (e) {
      debugPrint("Error reading sub collection: $e");
      return [];
    }
  }
}
