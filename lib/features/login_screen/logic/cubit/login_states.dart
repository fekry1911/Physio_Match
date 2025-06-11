

abstract class LoginStates{}

class Initial extends LoginStates{}

class ToggleSecure extends LoginStates{
  bool isSecure;
  ToggleSecure({required this.isSecure});
}

class AuthLoading extends LoginStates{}

class AuthSuccess extends LoginStates{}

class AuthFailure extends LoginStates{
  String error;
  AuthFailure({required this.error});
}
class AuthInitial extends LoginStates{}
