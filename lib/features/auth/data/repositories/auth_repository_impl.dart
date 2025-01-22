import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_block_firebase_carapp/core/error/exceptions.dart';
import 'package:flutter_block_firebase_carapp/core/error/failures.dart';
import 'package:flutter_block_firebase_carapp/features/auth/data/models/user_model.dart';
import 'package:flutter_block_firebase_carapp/features/auth/domain/entities/user.dart';
import 'package:flutter_block_firebase_carapp/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

class AuthRepositoryImpl implements AuthRepository {
  final firebase_auth.FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final CloudinaryPublic cloudinary;

  AuthRepositoryImpl(this.firebaseAuth, this.firestore)
      : cloudinary = CloudinaryPublic('mst1993-hb', 'flutter-car', cache: false);

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
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
        role: 'user',
      );
      await firestore.collection('users').doc(user.uid).set(userModel.toMap());
      return right(userModel);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return left(Failure(e.message ?? 'An error occurred'));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
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
      return right(UserModel.fromMap(userData.data()!));
    } on firebase_auth.FirebaseAuthException catch (e) {
      return left(Failure(e.message ?? 'An error occurred'));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        return left(Failure('User not logged in!'));
      }
      final userData = await firestore.collection('users').doc(user.uid).get();
      return right(UserModel.fromMap(userData.data()!));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loadProfileUser({required User user, required XFile file}) async {
    try {
      final response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(file.path, folder: 'profileimag'),
      );
      final downloadUrl = response.secureUrl;
      await firestore.collection('users').doc(user.uid).update({'imageUrl': downloadUrl});
      final updatedUser = await firestore.collection('users').doc(user.uid).get();
      return right(UserModel.fromMap(updatedUser.data()!));
    } catch (e) {
      return left(Failure('Error uploading profile image: $e'));
    }
  }
}