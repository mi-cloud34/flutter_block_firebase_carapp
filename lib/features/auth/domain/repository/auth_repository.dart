import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:flutter_block_firebase_carapp/core/error/failures.dart';
import 'package:flutter_block_firebase_carapp/features/auth/domain/entities/user.dart';
import 'package:image_picker/image_picker.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> currentUser();
  Future<Either<Failure, User>> loadProfileUser({
    required User user,
    required XFile file
  });
}