import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:nft_marketplace/model/nft_model.dart';

import '../model/collection_model.dart';
import '../model/user_model.dart';

class DataBase {
  static final auth = FirebaseAuth.instance;
  static final firestore = FirebaseFirestore.instance;
  static final storage = FirebaseStorage.instance;

  static User get user => auth.currentUser!;

  static Future<bool> userExist() async {
    return (await firestore.collection("users").doc(user.uid).get()).exists;
  }

  static Future<String> addImageToFirebaseStorage(
      String imagePath,
      ImageType type,
      CollectionModel? collectionModel,
      NftModel? nftModel) async {
    final ext = imagePath.split('.').last;
    Reference ref;

    if (type == ImageType.THUMBNAIL) {
      ref = storage.ref().child(
          'thumbnails/${collectionModel!.name}/${DateTime.now().toString()}.$ext');
    } else if (type == ImageType.NFTs) {
      ref = storage.ref().child(
          "NFTs/${user.uid}/${nftModel!.title}/${DateTime.now().toString()}.$ext'");
    } else {
      ref = storage
          .ref()
          .child("images/${user.uid}/${DateTime.now().toString()}.$ext'");
    }
    await ref
        .putFile(File(imagePath), SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      debugPrint('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    final imageUrl = await ref.getDownloadURL();
    return imageUrl;
  }

  static Future<void> createUser() async {
    final date = DateTime.now().toString();
    final userModel = UserModel(
      id: user.uid,
      name: user.displayName.toString(),
      email: user.email.toString(),
      imageUrl: user.photoURL,
      createdAt: date,
      updatedAt: date,
    );

    return await firestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toJson());
  }

  static Future<UserModel> getUser() async {
    DocumentSnapshot data =
        await firestore.collection('users').doc(user.uid).get();

    if (data.exists) {
      return UserModel.fromJson(data.data() as Map<String, dynamic>);
    } else {
      throw Exception('user not found');
    }
  }

  static Future<void> createCollection(CollectionModel collectionModel) async {
    String imageUrl = await addImageToFirebaseStorage(
        collectionModel.thumbnail, ImageType.THUMBNAIL, collectionModel, null);
    debugPrint("URL of thumbnail is => $imageUrl");
    final result = firestore.collection("collections").doc();
    collectionModel.id = result.id;
    collectionModel.thumbnail = imageUrl;
    result.set(
      collectionModel.toJson(),
    );
  }

  static Stream<List<CollectionModel>> getCollections() {
    return firestore
        .collection("collections")
        .where("createdBy", isEqualTo: user.uid)
        .snapshots()
        .map((event) => event.docs
            .map((doc) => CollectionModel.fromJson(doc.data()))
            .toList());
  }

  static Stream<List<CollectionModel>> getAllCollections() {
    return firestore.collection("collections").snapshots().map((event) =>
        event.docs.map((doc) => CollectionModel.fromJson(doc.data())).toList());
  }

  static Future<void> addItemsToTheCollection(
      CollectionModel collectionModel, NftModel nftModel) async {
    addImageToFirebaseStorage(
        nftModel.imageUrl!, ImageType.NFTs, collectionModel, nftModel);
    firestore
        .collection("collections")
        .doc(collectionModel.id)
        .collection("items")
        .doc()
        .set(nftModel.toJson());
  }

  static Future<void> addNft(NftModel nftModel) async {
    final imageUrl = await addImageToFirebaseStorage(
        nftModel.imageUrl!, ImageType.NFTs, null, nftModel);
    final collection = firestore.collection("single_nft").doc();
    nftModel.id = collection.id;
    nftModel.imageUrl = imageUrl;
    collection.set(nftModel.toJson());
  }

  static Stream<List<NftModel>> getNft() {
    return firestore
        .collection("single_nft")
        .where("createdBy", isEqualTo: user.uid)
        .where("collectionId", isEqualTo: null)
        .snapshots()
        .map((event) =>
            event.docs.map((doc) => NftModel.fromJson(doc.data())).toList());
  }

  static Stream<List<NftModel>> getNftInCollections(String collectionId) {
    return firestore
        .collection("single_nft")
        .where("createdBy", isEqualTo: user.uid)
        .where("collectionId", isEqualTo: collectionId)
        .snapshots()
        .map((event) =>
            event.docs.map((doc) => NftModel.fromJson(doc.data())).toList());
  }
}

enum ImageType {
  NFTs,
  THUMBNAIL,
}
