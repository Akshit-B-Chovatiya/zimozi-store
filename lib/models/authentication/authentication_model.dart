import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationModel {
  bool isSuccess;
  String message;
  User? user;

  AuthenticationModel({required this.isSuccess, required this.message, this.user});
}
