import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      await _createUserInFirestore(userCredential.user!);
      return userCredential.user;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  Future<User?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
      );

      final AuthCredential credential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      await _createUserInFirestore(userCredential.user!);
      return userCredential.user;
    } catch (e) {
      print('Error signing in with Apple: $e');
      return null;
    }
  }

  Future<void> _createUserInFirestore(User user) async {
    final userDoc = _firestore.collection('users').doc(user.uid);

    final data = {
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName ?? '',
      'createdAt': FieldValue.serverTimestamp(),
    };

    await userDoc.set(data, SetOptions(merge: true));
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }

  Future<void> saveNote({
    required String title,
    required String content,
    required BuildContext context,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Map<String, dynamic> noteData = {
          'title': title,
          'content': content,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        };

        DocumentReference noteRef = await _firestore.collection('users').doc(user.uid).collection('notes').add(noteData);

        String noteId = noteRef.id;
        await noteRef.update({'noteId': noteId});

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Note added successfully!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add note: $e')),
      );
    }
  }

  Future<void> updateNote({
    required String title,
    required String content,
    required String noteId,
    required BuildContext context,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Map<String, dynamic> updatedNoteData = {
          'title': title,
          'content': content,
          'updatedAt': FieldValue.serverTimestamp(),
        };

        await _firestore.collection('users').doc(user.uid).collection('notes').doc(noteId).update(updatedNoteData);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Note updated successfully!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update note: $e')),
      );
    }
  }
}
