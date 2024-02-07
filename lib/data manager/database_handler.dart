import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:nft_marketplace/model/blockchain_model.dart';
import 'package:nft_marketplace/model/nft_model.dart';
import 'package:nft_marketplace/model/wallet_model.dart';
import 'package:nft_marketplace/wallet/net/wallet_data_manager.dart';

import '../data_variables.dart';
import '../model/collection_model.dart';
import '../model/user_model.dart';

class DataBase {
  static Future<bool> userExist() async {
    return (await firestore.collection("users").doc(user.uid).get()).exists;
  }

  static Future<void> createUser() async {
    final date = DateTime.now().toString();
    final username = user.displayName!.split(" ");
    final userModel = UserModel(
      id: user.uid,
      name: user.displayName.toString(),
      username: username[0].toLowerCase(),
      email: user.email.toString(),
      imageUrl: user.photoURL!,
      collected: [],
      createdAt: date,
      updatedAt: date,
    );

    return await firestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toJson());
  }

  static Future<UserModel> getUser(String id) async {
    DocumentSnapshot data = await firestore.collection('users').doc(id).get();

    if (data.exists) {
      return UserModel.fromJson(data.data() as Map<String, dynamic>);
    } else {
      throw Exception('user not found');
    }
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
    } else if (type == ImageType.BACKGROUND_IMAGE) {
      ref = storage.ref().child(
          'background_image/${collectionModel!.name}/${DateTime.now().toString()}.$ext');
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

  static Future<void> createCollection(CollectionModel collectionModel) async {
    String imageUrl = await addImageToFirebaseStorage(
        collectionModel.thumbnail, ImageType.THUMBNAIL, collectionModel, null);
    String bg_url = await addImageToFirebaseStorage(collectionModel.bgImage!,
        ImageType.BACKGROUND_IMAGE, collectionModel, null);

    debugPrint("URL of thumbnail is => $imageUrl");
    final result = firestore.collection("collections").doc();
    collectionModel.id = result.id;
    collectionModel.thumbnail = imageUrl;
    collectionModel.bgImage = bg_url;
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

  static Future<CollectionModel> getNamedCollection(String id) async {
    DocumentSnapshot snapshot =
        await firestore.collection("collections").doc(id).get();
    if (snapshot.exists) {
      return CollectionModel.fromJson(snapshot.data() as Map<String, dynamic>);
    } else {
      throw Exception("Collection not found");
    }
  }

  static Stream<List<NftModel>> getMoreInCollection(
      String collectionId, String nftId) {
    return firestore
        .collection("NFTs")
        .where("collectionId", isEqualTo: collectionId)
        .where("id", isNotEqualTo: nftId)
        .snapshots()
        .map((event) =>
            event.docs.map((doc) => NftModel.fromJson(doc.data())).toList());
  }

  static Future<void> addNft(NftModel nftModel) async {
    final imageUrl = await addImageToFirebaseStorage(
        nftModel.imageUrl!, ImageType.NFTs, null, nftModel);
    final collection = firestore.collection("NFTs").doc();
    nftModel.id = collection.id;
    nftModel.imageUrl = imageUrl;
    collection.set(nftModel.toJson());
    if (nftModel.collectionId != null) {
      firestore.collection("collections").doc(nftModel.collectionId).update(
        {
          "items": FieldValue.arrayUnion(
            [nftModel.id],
          )
        },
      );
    }
  }

  static Stream<List<NftModel>> getNft() {
    return firestore
        .collection("NFTs")
        .where("createdBy", isEqualTo: user.uid)
        .where("collectionId", isEqualTo: null)
        .snapshots()
        .map((event) =>
            event.docs.map((doc) => NftModel.fromJson(doc.data())).toList());
  }

  static Stream<List<NftModel>> getCreatedNFTs(String id) {
    return firestore
        .collection("NFTs")
        .where("createdBy", isEqualTo: id)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (doc) => NftModel.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  static Future<void> deleteNft(NftModel nftModel) async {
    firestore.collection("NFTs").doc(nftModel.id).delete();
  }

  static Stream<List<NftModel>> getNftInCollections(String collectionId) {
    return firestore
        .collection("NFTs")
        .where("collectionId", isEqualTo: collectionId)
        .snapshots()
        .map((event) =>
            event.docs.map((doc) => NftModel.fromJson(doc.data())).toList());
  }

  static Future<void> buyNft(NftModel nftModel) async {
    final blockchainModel = BlockchainModel(
        id: "${user.uid}_${nftModel.currentOwner}",
        from: user.uid,
        to: nftModel.currentOwner!,
        amount: nftModel.rate!,
        nftId: nftModel.id!,
        createdAt: DateTime.now().toLocal().toString());
    firestore.collection("NFTs").doc(nftModel.id).update(
      {
        "currentOwner": user.uid,
        "rate": null,
        "owners": FieldValue.arrayUnion(
          [user.uid],
        ),
        "blockchain": FieldValue.arrayUnion([
          blockchainModel.toJson(),
        ])
      },
    );
    final transaction = TransactionList(
      coinType: nftModel.chain!,
      amount: double.parse(nftModel.rate!),
      from: user.uid,
      to: nftModel.currentOwner,
      transactedAt: DateTime.now().toLocal().toString(),
    );
    WalletDataManager.makeTransaction(transaction);

    firestore.collection("users").doc(nftModel.currentOwner).update({
      "collected": FieldValue.arrayRemove([nftModel.id])
    });
    firestore.collection("users").doc(user.uid).update({
      "collected": FieldValue.arrayUnion([nftModel.id])
    });
  }

  static Future<void> setToSell(NftModel nftModel) async {
    firestore.collection("NFTs").doc(nftModel.id).update(
      {
        "rate": nftModel.rate,
      },
    );
  }

  static Stream<List<NftModel>> getCollectedNft(String id) {
    debugPrint("Id is => $id");
    return firestore
        .collection("NFTs")
        .where("currentOwner", isEqualTo: id)
        .limit(1000)
        .snapshots()
        .map(
          (event) => event.docs
              .where((doc) =>
                  doc["createdBy"] != id ||
                  doc["blockchain"] != null &&
                      (doc["blockchain"] as List).isNotEmpty)
              .map(
                (doc) => NftModel.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  static Future<List<String>> getSearchList() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    CollectionReference collections =
        FirebaseFirestore.instance.collection('collections');

    QuerySnapshot userQuerySnapshot = await users.get();
    QuerySnapshot collectionQuerySnapshot = await collections.get();

    List<String> names = [];
    for (var doc in userQuerySnapshot.docs) {
      String name = doc.get('name');
      names.add(name);
    }
    for (var doc in collectionQuerySnapshot.docs) {
      String name = doc.get('name');
      names.add(name);
    }
    return names;
  }

  static Stream<List<CollectionModel>> getCategorizedCollections(
      String category) {
    return firestore
        .collection("collections")
        .where("category", isEqualTo: category)
        .snapshots()
        .map((event) => event.docs
            .map((doc) => CollectionModel.fromJson(doc.data()))
            .toList());
  }

  static Future<void> follow(String userId) async {
    firestore.collection("users").doc(user.uid).update(
      {
        "following": FieldValue.arrayUnion([userId])
      },
    );
    firestore.collection("users").doc(userId).update(
      {
        "followers": FieldValue.arrayUnion([user.uid])
      },
    );
  }

  static Stream<List<NftModel>> getOnSellNFTs() {
    return firestore
        .collection("NFTs")
        .where("rate", isNotEqualTo: null)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => NftModel.fromJson(e.data())).toList());
  }
}

enum ImageType {
  NFTs,
  THUMBNAIL,
  BACKGROUND_IMAGE,
}
