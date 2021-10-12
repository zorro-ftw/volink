import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:string_validator/string_validator.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:volink/constants.dart';
import 'package:volink/firebase_services/data_service.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  currentUser() async {
    return _auth.currentUser;
  }

  String get currentUserId {
    return _auth.currentUser.uid;
  }

  currentUserEmail() async {
    return _auth.currentUser.email.toString();
  }

  currentUserName() async {
    return _auth.currentUser.displayName;
  }

  Future signInWithEmailAndPassword(email, password) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<bool> signIN(email, password) async {
    try {
      final user = await signInWithEmailAndPassword(email, password);
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

  Future registerUser({String email, String password, String userName}) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      print(newUser);
      if (newUser != null) {
        print(newUser);
        await _auth.currentUser.updateDisplayName(userName);
        await DataService().addData(collectionPath: 'users', data: {
          'userID': currentUserId,
          'registeredAt': Timestamp.now(),
          'userName': userName,
          'profilePhotoURL': kDefaultProfilePhotoURL
        });
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}

class EmailValidator {
  static String validate(String email) {
    if (email == null || email.isEmpty) {
      return "Email can't be empty!";
    } else if (!isEmail(email)) {
      return "Not a valid e-mail!";
    }
    return null;
  }
}

class NameValidator {
  static String validate(String name) {
    String pattern = r'^[a-zA-Z0-9\s]+$';
    if (name == null || name.isEmpty) {
      return "Name can't be empty!";
    } else if (name.length < 3) {
      return "Name can't be shorter than 3 characters!";
    } else if (name.length > 20) {
      return "Name can't be longer than 20 characters!";
    } else if (!isAlpha(name[0])) {
      return "First character of a name must be a letter!";
    }
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(name)) {
      return "Name must be alphanumerical characters only!";
    }
    return null;
  }
}

class PasswordValidator {
  static String validate(String value, value2) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty!";
    }
    if (value2 != value) {
      return "Passwords do not match!";
    }
    String pattern = r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~,.]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return "Password must contain at least 8 characters, a letter, number and special character!";
    }
    return null;
  }
}
