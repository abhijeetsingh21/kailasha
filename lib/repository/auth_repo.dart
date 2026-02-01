import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:kailasha/core/utils/custom_toast.dart';

@LazySingleton()
class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ---------------------------------------------------------------------------
  // SCHOOL SIGNUP (EMAIL + FIRESTORE)
  // ---------------------------------------------------------------------------

  Future<User?> createSchoolAccount({
    required String email,
    required String password,

    required String schoolName,
    required String board,
    required String city,
    required String state,
    required String contactPerson,
    required List<String> classes,
  }) async {
    try {
      /// 1️⃣ Create auth user
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw 'Failed to create user';
      }

      /// 2️⃣ Create school document
      await _firestore.collection('schools').doc(user.uid).set({
        'name': schoolName,
        'board': board,
        'city': city,
        'state': state,
        'contactPerson': contactPerson,
        'email': email,
        'classes': classes,
        'role': 'school',
        'createdBy': user.uid,
        'createdAt': FieldValue.serverTimestamp(),
        'isActive': true,
      });

      log('✅ School account created successfully');
      return user;
    } on FirebaseAuthException catch (e) {
      log('🔥 AUTH ERROR');
      log('CODE: ${e.code}');
      log('MESSAGE: ${e.message}');
      throw _mapAuthError(e);
    } catch (e) {
      log('❌ School signup failed: $e');
      rethrow;
    }
  }

  // ---------------------------------------------------------------------------
  // EMAIL SIGN IN
  // ---------------------------------------------------------------------------

  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      AppUtils.customToast(message: e.message);
      throw _mapAuthError(e);
    }
  }

  // ---------------------------------------------------------------------------
  // SIGN OUT
  // ---------------------------------------------------------------------------

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;

  // ---------------------------------------------------------------------------
  // ERROR MAPPER
  // ---------------------------------------------------------------------------

  String _mapAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already registered';
      case 'invalid-email':
        return 'Invalid email address';
      case 'weak-password':
        return 'Password must be at least 6 characters';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'wrong-password':
        return 'Incorrect password';
      default:
        return 'Authentication failed. Please try again';
    }
  }
}
