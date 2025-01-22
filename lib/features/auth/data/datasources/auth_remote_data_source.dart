
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_block_firebase_carapp/core/error/exceptions.dart';
import 'package:flutter_block_firebase_carapp/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  User? get currentUser;
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImp(this.firebaseAuth, this.firestore);

  @override
  User? get currentUser => firebaseAuth.currentUser;

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user == null) {
        throw const ServerException('User is null!');
      }
      final userData = await firestore.collection('users').doc(user.uid).get();
      return UserModel.fromMap(userData.data()!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'An error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user == null) {
        throw const ServerException('User is null!');
      }
      final userModel = UserModel(
        uid: user.uid,
        name: name,
        email: email,
      );
      await firestore.collection('users').doc(user.uid).set(userModel.toMap());
      return userModel;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'An error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      final user = currentUser;
      if (user != null) {
        final userData = await firestore.collection('users').doc(user.uid).get();
        return UserModel.fromMap(userData.data()!);
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}