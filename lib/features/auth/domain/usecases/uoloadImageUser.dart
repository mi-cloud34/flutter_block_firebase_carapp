import 'package:flutter_block_firebase_carapp/core/error/failures.dart';
import 'package:flutter_block_firebase_carapp/core/usecase/usecase.dart';
import 'package:flutter_block_firebase_carapp/features/auth/domain/entities/user.dart';
import 'package:flutter_block_firebase_carapp/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileUpload implements UseCase<User, UserProfileImageParams> {
  final AuthRepository authRepository;
  const UserProfileUpload(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserProfileImageParams params) async {
    return await authRepository.loadProfileUser(
      user: params.user,
      file: params.file,
    );
  }
}

class UserProfileImageParams {
  final User user;
  final XFile file;

  UserProfileImageParams({
    required this.user,
    required this.file,
  });
}
