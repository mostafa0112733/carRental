import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
    String phone,
  ) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = credential.user;
      await user!.updateProfile(displayName: name);

      await _firestore.collection('users').doc(user.uid).set({
        'name': name,
        'phone': phone,
      });

      return user;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // If the sign-in is successful, you can access the user information using:
      User? user = userCredential.user;

      return user;
    } catch (e) {
      print('Error: $e');
      return null; // Return null or handle the error as needed.
    }
  }
}
