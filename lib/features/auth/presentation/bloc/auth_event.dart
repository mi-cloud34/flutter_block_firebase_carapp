part of 'auth_bloc.dart';


sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final String name;

  AuthSignUp({
    required this.email,
    required this.password,
    required this.name,
  });
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({
    required this.email,
    required this.password,
  });
}
final class CurrentUserEvent extends AuthEvent {}
class AuthUploadProfileImage extends AuthEvent {
  final User user;
  final XFile pickedFile;

   AuthUploadProfileImage({
    required this.user,
    required this.pickedFile,
  });

  /* @override
  List<Object> get props => [user, pickedFile]; */
}
final class AuthIsUserLoggedIn extends AuthEvent {}
