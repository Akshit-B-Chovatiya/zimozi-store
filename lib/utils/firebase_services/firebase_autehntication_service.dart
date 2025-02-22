import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:zimozi_store/config/app_constant.dart';
import 'package:zimozi_store/models/authentication/authentication_model.dart';
import 'package:zimozi_store/models/authentication/user_model.dart';
import 'package:zimozi_store/utils/common/log_services.dart';
import 'package:zimozi_store/utils/common/toast_message_services.dart';
import 'package:zimozi_store/utils/firebase_services/firebase_service.dart';
import 'package:zimozi_store/utils/storage_services/shared_preferences.dart';

class FirebaseAuthService {
  static Future<AuthenticationModel> register({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String emailAddress,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseService.firebaseAuth
          .createUserWithEmailAndPassword(email: emailAddress, password: password);

      User? user = userCredential.user;
      if (user != null) {
        await FirebaseService.firebaseFireStore.collection(FirebaseKeys.users).doc(user.uid).set({
          "id" : user.uid,
          "profile_image": "",
          "first_name": firstName,
          "last_name": lastName,
          "email_address": emailAddress,
          "phone_number": phoneNumber,
          "created_at": DateTime.now().toIso8601String(),
          "updated_at": "",
          "cart": [],
          "wishlist": []
        });
        return AuthenticationModel(isSuccess: true, message: "User registered successfully!", user: user);
      }
    } on FirebaseAuthException catch (e) {
      return AuthenticationModel(
          isSuccess: false,
          message:
              FirebaseService.getErrorSpecificMessage(code: e.code) ?? e.message ?? "Registration failed!",
          user: null);
    } catch (e) {
      return AuthenticationModel(isSuccess: false, message: "Something went wrong!", user: null);
    }
    return AuthenticationModel(isSuccess: false, message: "Something went wrong!", user: null);
  }

  static Future<AuthenticationModel> login({required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseService.firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthenticationModel(isSuccess: true, message: "Login successfully!", user: userCredential.user);
    } on FirebaseAuthException catch (e) {
      return AuthenticationModel(
          isSuccess: false,
          message: FirebaseService.getErrorSpecificMessage(code: e.code) ?? e.message ?? "Login failed!",
          user: null);
    } catch (e) {
      return AuthenticationModel(isSuccess: false, message: "Something went wrong!", user: null);
    }
  }

  static Future<AuthenticationModel> sendPasswordResetLinkToEmail({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return AuthenticationModel(isSuccess: true, message: "Password reset link sent to $email.");
    } on FirebaseAuthException catch (e) {
      return AuthenticationModel(
          isSuccess: false,
          message: FirebaseService.getErrorSpecificMessage(code: e.code) ?? e.message ?? "Login failed!",
          user: null);
    } catch (e) {
      return AuthenticationModel(isSuccess: false, message: "Something went wrong!", user: null);
    }
  }

  static Future<UserModel> getUserData({required String userId}) async {
    try {
      DocumentSnapshot doc =
          await FirebaseService.firebaseFireStore.collection(FirebaseKeys.users).doc(userId).get();
      if (doc.exists) {
        showLogs(message: "DATA : ${doc.data() as Map<String, dynamic>}");
        return UserModel(
            isSuccess: true,
            message: "User details fetched successfully!",
            user: ZimoziUser.fromJson(doc.data() as Map<String, dynamic>));
      }
      return UserModel(isSuccess: false, message: "User details not found!", user: null);
    } on FirebaseAuthException catch (e) {
      return UserModel(
          isSuccess: false,
          message: FirebaseService.getErrorSpecificMessage(code: e.code) ??
              e.message ??
              "User details fetch error!",
          user: null);
    } catch (e) {
      return UserModel(isSuccess: false, message: "Something went wrong!", user: null);
    }
  }

  static Future<void> logout() async {
    await FirebaseService.firebaseAuth.signOut();
  }

  static Future<String?> uploadImageToFirebaseStorage(
      {required BuildContext context, required String userId, required File imageFile}) async {
    try {
      String fileExtension = imageFile.path.split(".").last;
      Reference storageRef = FirebaseStorage.instance.ref().child("users/$userId/profile.$fileExtension");
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      showToastMessage(
          context: AppConstants.navigatorKey.currentContext ?? context,
          message: "File upload error : ${e.toString()}");
      return null;
    }
  }

  static Future<AuthenticationModel> updateUserDetails(
      {required BuildContext context, required ZimoziUser zimoziUser, File? profileImage}) async {
    String? userId = await LocalStorage.getString(key: AppConstants.userId);
    if (userId == null) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        userId = user.uid;
      }
    }
    if (userId != null) {
      try {
        Map<String, dynamic> updatedData = zimoziUser.toJson();
        if (profileImage != null) {
          String? downloadLink = await uploadImageToFirebaseStorage(
              context: AppConstants.navigatorKey.currentContext ?? context,
              userId: userId,
              imageFile: profileImage);
          if (downloadLink != null && downloadLink.isNotEmpty) {
            updatedData["profile_image"] = downloadLink;
          }
        }
        updatedData["updated_at"] = DateTime.now().toIso8601String();
        updatedData.remove("cart");
        updatedData.remove("wishlist");
        updatedData.remove("created_at");
        updatedData.remove("id");
        showLogs(message: "LATEST DATA : $updatedData");
        await FirebaseFirestore.instance.collection(FirebaseKeys.users).doc(userId).update(updatedData);
        return AuthenticationModel(
            isSuccess: true, message: "User profile updated successfully!", user: null);
      } on FirebaseAuthException catch (e) {
        return AuthenticationModel(
            isSuccess: false,
            message: FirebaseService.getErrorSpecificMessage(code: e.code) ??
                e.message ??
                "User details update error!",
            user: null);
      } catch (e) {
        return AuthenticationModel(isSuccess: false, message: "User profile update failed!", user: null);
      }
    } else {
      return AuthenticationModel(isSuccess: false, message: "Something went wrong!", user: null);
    }
  }
}
