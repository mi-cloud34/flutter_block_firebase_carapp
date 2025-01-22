part of 'auth_bloc.dart';


sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final User user;
  const AuthSuccess(this.user);
}

final class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);
}
class CurrentUserState extends AuthState {}
class AuthProfileImageUploadSuccess extends AuthState {
  final String profileImageUrl;

  const AuthProfileImageUploadSuccess(this.profileImageUrl);

/*   @override
  List<Object> get props => [profileImageUrl]; */
}