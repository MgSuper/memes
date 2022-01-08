import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:memes/constants/firebase_constant.dart';
import 'package:memes/screens/bottom_tab_bar/bottom_tab_bar.dart';
import 'package:memes/screens/sign_in/sign_in.dart';

class AuthController extends GetxController {
  static AuthController authInstance = Get.find();
  late Rx<User?> firebaseUser;

  // User? get userProfile => auth.currentUser;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());

    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user != null) {
      // user is logged in
      Get.offAll(() => BottomTabBar());
    } else {
      // user is null as in user is not available or not logged in
      Get.offAll(() => const SignIn());
    }
  }

  void register(String name, String email, String password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        auth.currentUser!.updateDisplayName(name);
        FirebaseFirestore.instance
            .collection('users')
            .doc(auth.currentUser!.uid)
            .set({
          'name': name,
          'email': auth.currentUser!.email,
          'creation_time': auth.currentUser!.metadata.creationTime,
          'point': '0',
          'rank': 'Newbie',
          'is_dark_theme': false,
        });
      });
    } on FirebaseAuthException catch (e) {
      // this is solely for the Firebase Auth Exception
      // for example : password did not match
      // Get.snackbar("Error", e.message!);
      Get.snackbar(
        "Error",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      // this is temporary. you can handle different kinds of activities
      //such as dialogue to indicate what's wrong
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // this is solely for the Firebase Auth Exception
      // for example : password did not match
      print(e.message);
    } catch (e) {
      print(e.toString());
    }
  }

  void signOut() {
    try {
      auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
