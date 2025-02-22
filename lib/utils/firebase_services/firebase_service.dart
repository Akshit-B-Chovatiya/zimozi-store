import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zimozi_store/firebase_options.dart';
import 'package:zimozi_store/utils/common/log_services.dart';

class FirebaseService {

  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  static initFirebase() async {
    await Firebase.initializeApp(name: "zimozi-store", options: DefaultFirebaseOptions.currentPlatform);
  }

  static String? getErrorSpecificMessage({required String code}) {
    showLogs(message: "FIREBASE ERROR CODE : $code");
    String? errorMessage;
    if (code == "email-already-in-use") {
      errorMessage = "This email is already registered!";
    } else if (code == "invalid-email") {
      errorMessage = "Please enter a valid email!";
    } else if (code == "invalid-credential") {
      errorMessage = "Incorrect Email or Password!";
    } else if (code == "weak-password") {
      errorMessage = "Your password must be at least 6 characters!";
    } else if (code == "user-not-found") {
      errorMessage = "No user found for that email!";
    } else if (code == "wrong-password") {
      errorMessage = "Incorrect password. Please try again!";
    } else if (code == "network-request-failed") {
      errorMessage = "Check your internet connection!";
    } else if (code == "permission-denied") {
      errorMessage = "You don’t have permission to perform this action!";
    } else {
      errorMessage = null;
    }
    return errorMessage;
  }
}
