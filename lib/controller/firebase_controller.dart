import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:memes/controller/chip_controller.dart';
import 'package:memes/models/photo.dart';

class FirestoreController extends GetxController {
  //referance to firestore collection here laptop is collection name
  final CollectionReference _photosRef =
      FirebaseFirestore.instance.collection('memes');

  var photoList = <Photo>[].obs;

  //dependency injection with getx
  ChipController _chipController = Get.put(ChipController());

  @override
  void onInit() {
    //binding to stream so that we can listen to realtime cahnges

    photoList
        .bindStream(getPhotos(PhotoTypes.values[_chipController.selectedChip]));
    super.onInit();
  }

// this fuction retuns stream of laptop lsit from firestore

  Stream<List<Photo>> getPhotos(PhotoTypes brand) {
    //using enum class LaptopBrand in switch case
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
      case PhotoTypes.OHNO:
        Stream<QuerySnapshot> stream =
            _photosRef.where('category', isEqualTo: 'Ohno').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return Photo.fromSnapshot(snap);
            }).toList());
    }
  }
}
