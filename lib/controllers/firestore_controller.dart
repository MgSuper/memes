import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:memes/constants/firebase_constant.dart';
import 'package:memes/controllers/controllers.dart';
import 'package:memes/models/models.dart';

class FirestoreController extends GetxController {
  final CollectionReference _photosRef = firebaseFirestore.collection('memes');
  final CollectionReference _usersRef = firebaseFirestore.collection('users');
  final CollectionReference _updateUsersData =
      firebaseFirestore.collection('users');

  var photoList = <Photo>[].obs;
  var userList = <UserModel>[].obs;
  final _chip = Get.find<ChipController>();

  @override
  void onInit() {
    //binding to stream so that we can listen to realtime changes
    photoList.bindStream(getPhotos(PhotoTypes.values[_chip.selectedChip]));
    userList.bindStream(getUsers());
    super.onInit();
  }

  Stream<List<Photo>> getPhotos(PhotoTypes brand) {
    switch (brand) {
      case PhotoTypes.All:
        Stream<QuerySnapshot> stream = _photosRef.snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return Photo.fromSnapshot(snap);
            }).toList());
      case PhotoTypes.Memes:
        Stream<QuerySnapshot> stream =
            _photosRef.where('category', isEqualTo: 'Memes').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return Photo.fromSnapshot(snap);
            }).toList());
      case PhotoTypes.Cartoons:
        Stream<QuerySnapshot> stream =
            _photosRef.where('category', isEqualTo: 'Cartoons').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return Photo.fromSnapshot(snap);
            }).toList());
      case PhotoTypes.Gaming:
        Stream<QuerySnapshot> stream =
            _photosRef.where('category', isEqualTo: 'Gaming').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return Photo.fromSnapshot(snap);
            }).toList());
      case PhotoTypes.Programming:
        Stream<QuerySnapshot> stream =
            _photosRef.where('category', isEqualTo: 'Programming').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return Photo.fromSnapshot(snap);
            }).toList());
    }
  }

  Stream<List<UserModel>> getUsers() {
    Stream<QuerySnapshot> stream =
        _usersRef.orderBy('point', descending: true).snapshots();
    return stream.map((snapshot) => snapshot.docs.map((snap) {
          return UserModel.fromSnapshot(snap);
        }).toList());
  }

  void updatePointAndRank() async {
    final _currentUser = _updateUsersData.doc(auth.currentUser?.uid);
    firebaseFirestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(_currentUser);
      if (!snapshot.exists) {
        throw Exception("User does not exist!");
      }
      int updatedPoints = (snapshot.data() as dynamic)['point'] + 1;
      if (updatedPoints > 0 && updatedPoints <= 50) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Buggy'});
      } else if (updatedPoints > 50 && updatedPoints <= 100) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Ussop'});
      } else if (updatedPoints > 100 && updatedPoints <= 200) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Chopper'});
      } else if (updatedPoints > 200 && updatedPoints <= 300) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Nami'});
      } else if (updatedPoints > 300 && updatedPoints <= 400) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Brook'});
      } else if (updatedPoints > 400 && updatedPoints <= 500) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Franky'});
      } else if (updatedPoints > 500 && updatedPoints <= 600) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Robin'});
      } else if (updatedPoints > 600 && updatedPoints <= 700) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Moria'});
      } else if (updatedPoints > 700 && updatedPoints <= 800) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Kuma'});
      } else if (updatedPoints > 800 && updatedPoints <= 900) {
        transaction.update(
            _currentUser, {'point': updatedPoints, 'rank': 'Crocodile'});
      } else if (updatedPoints > 900 && updatedPoints <= 1000) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Robin'});
      } else if (updatedPoints > 1000 && updatedPoints <= 1200) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Mingo'});
      } else if (updatedPoints > 1200 && updatedPoints <= 1400) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Yamato'});
      } else if (updatedPoints > 1400 && updatedPoints <= 1600) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Jinbe'});
      } else if (updatedPoints > 1600 && updatedPoints <= 1800) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Sanji'});
      } else if (updatedPoints > 1800 && updatedPoints <= 2000) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Zoro'});
      } else if (updatedPoints > 2000 && updatedPoints <= 2250) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Mihawk'});
      } else if (updatedPoints > 2250 && updatedPoints <= 2500) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Kizaru'});
      } else if (updatedPoints > 2500 && updatedPoints <= 2750) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Kuzan'});
      } else if (updatedPoints > 2750 && updatedPoints <= 3000) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Akainu'});
      } else if (updatedPoints > 3000 && updatedPoints <= 3250) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Big Mom'});
      } else if (updatedPoints > 3250 && updatedPoints <= 3500) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Kaido'});
      } else if (updatedPoints > 3500 && updatedPoints <= 3750) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Shank'});
      } else if (updatedPoints > 3750 && updatedPoints <= 4000) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Sangoku'});
      } else if (updatedPoints > 4000 && updatedPoints <= 4500) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Hancock'});
      } else if (updatedPoints > 4500 && updatedPoints <= 5000) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Luffy'});
      } else if (updatedPoints > 5000) {
        transaction
            .update(_currentUser, {'point': updatedPoints, 'rank': 'Garp'});
      }
    }).then((value) {
      Get.snackbar('Success', 'You got a reward !',
          snackPosition: SnackPosition.BOTTOM);
    }).catchError(
      (error) => Get.snackbar('Failed', 'No point is added',
          snackPosition: SnackPosition.BOTTOM),
    );
  }
}
