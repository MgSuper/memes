import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:memes/constants/firebase_constant.dart';
import 'package:memes/controllers/chip_controller.dart';
import 'package:memes/models/models.dart';

class FirestoreController extends GetxController {
  //referance to firestore collection here laptop is collection name
  final CollectionReference _photosRef = firebaseFirestore.collection('memes');
  final CollectionReference usersRef = firebaseFirestore.collection('users');
  final DocumentReference currentUserRef = firebaseFirestore.collection('users').doc(auth.currentUser!.uid);

  var photoList = <Photo>[].obs;
  var userList = <User>[].obs;

  //dependency injection with getx
  ChipController _chipController = Get.put(ChipController());

  @override
  void onInit() {
    //binding to stream so that we can listen to realtime changes

    photoList.bindStream(getPhotos(PhotoTypes.values[_chipController.selectedChip]));
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
        Stream<QuerySnapshot> stream = _photosRef.where('category', isEqualTo: 'Memes').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return Photo.fromSnapshot(snap);
            }).toList());
      case PhotoTypes.CARTOONS:
        Stream<QuerySnapshot> stream = _photosRef.where('category', isEqualTo: 'Cartoons').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return Photo.fromSnapshot(snap);
            }).toList());
      case PhotoTypes.CELEBRITIES:
        Stream<QuerySnapshot> stream = _photosRef.where('category', isEqualTo: 'Celebrities').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return Photo.fromSnapshot(snap);
            }).toList());
      case PhotoTypes.OHNO:
        Stream<QuerySnapshot> stream = _photosRef.where('category', isEqualTo: 'Ohno').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return Photo.fromSnapshot(snap);
            }).toList());
    }
  }

  Stream<List<User>> getUsers() {
    Stream<QuerySnapshot> stream = usersRef.snapshots();
    return stream.map((snapshot) => snapshot.docs.map((snap) {
          print(snap);
          return User.fromSnapshot(snap);
        }).toList());
  }
}
