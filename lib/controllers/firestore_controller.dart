import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:memes/constants/firebase_constant.dart';
import 'package:memes/controllers/chip_controller.dart';
import 'package:memes/models/models.dart';

class FirestoreController extends GetxController {
  //referance to firestore collection here laptop is collection name
  final CollectionReference _photosRef = firebaseFirestore.collection('memes');
  final CollectionReference _usersRef = firebaseFirestore.collection('users');
  final CollectionReference _updateUsersData =
      firebaseFirestore.collection('users');

  var photoList = <Photo>[].obs;
  var userList = <UserModel>[].obs;

  //dependency injection with getx
  ChipController _chipController = Get.put(ChipController());

  @override
  void onInit() {
    //binding to stream so that we can listen to realtime changes

    photoList
        .bindStream(getPhotos(PhotoTypes.values[_chipController.selectedChip]));
    userList.bindStream(getUsers());
    super.onInit();
  }

// this fuction retuns stream of Memes from firestore

  Stream<List<Photo>> getPhotos(PhotoTypes brand) {
    // using enum class PhotoType in switch case
    switch (brand) {
      case PhotoTypes.ALL:
        Stream<QuerySnapshot> stream = _photosRef.snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return Photo.fromSnapshot(snap);
            }).toList());
      case PhotoTypes.MEMES:
        Stream<QuerySnapshot> stream =
            _photosRef.where('category', isEqualTo: 'Memes').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return Photo.fromSnapshot(snap);
            }).toList());
      case PhotoTypes.CARTOONS:
        Stream<QuerySnapshot> stream =
            _photosRef.where('category', isEqualTo: 'Cartoons').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return Photo.fromSnapshot(snap);
            }).toList());
      case PhotoTypes.CELEBRITIES:
        Stream<QuerySnapshot> stream =
            _photosRef.where('category', isEqualTo: 'Celebrities').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return Photo.fromSnapshot(snap);
            }).toList());
    }
  }

  Stream<List<UserModel>> getUsers() {
    Stream<QuerySnapshot> stream =
        _usersRef.orderBy('point', descending: true).snapshots();
    return stream.map((snapshot) => snapshot.docs.map((snap) {
          print(snap);
          return UserModel.fromSnapshot(snap);
        }).toList());
  }

  void updatePointAndRank() async {
    final _currentUser =
        _updateUsersData.doc(FirebaseAuth.instance.currentUser?.uid);
    firebaseFirestore
        .runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(_currentUser);
          if (!snapshot.exists) {
            throw Exception("User does not exist!");
          }
          int newPoints = (snapshot.data() as dynamic)['point'] + 1;
          if (newPoints >= 0) {
            transaction.update(_currentUser, {'rank': 'Ant'});
          } else if (newPoints >= 50) {
            transaction.update(_currentUser, {'rank': 'Butterfly'});
          } else if (newPoints >= 150) {
            transaction.update(_currentUser, {'rank': 'Bird'});
          } else if (newPoints >= 300) {
            transaction.update(_currentUser, {'rank': 'Cat'});
          } else if (newPoints >= 500) {
            transaction.update(_currentUser, {'rank': 'Dog'});
          } else if (newPoints >= 800) {
            transaction.update(_currentUser, {'rank': 'Bull Dog'});
          } else if (newPoints >= 1500) {
            transaction.update(_currentUser, {'rank': 'Tiger'});
          } else if (newPoints >= 2500) {
            transaction.update(_currentUser, {'rank': 'Hippo'});
          } else if (newPoints >= 4000) {
            transaction.update(_currentUser, {'rank': 'Lion'});
          } else if (newPoints >= 6000) {
            transaction.update(_currentUser, {'rank': 'Gorilla'});
          } else if (newPoints >= 10000) {
            transaction.update(_currentUser, {'rank': 'Elephants'});
          } else if (newPoints >= 15000) {
            transaction.update(_currentUser, {'rank': 'War Elephants'});
          } else if (newPoints >= 20000) {
            transaction.update(_currentUser, {'rank': 'Godzilla'});
          }
          transaction.update(_currentUser, {'point': newPoints});
        })
        .then(
          (value) => Get.snackbar('Success', 'You got one point',
              snackPosition: SnackPosition.BOTTOM),
        )
        .catchError(
          (error) => Get.snackbar('Failed', 'No point is added',
              snackPosition: SnackPosition.BOTTOM),
        );
  }
}
