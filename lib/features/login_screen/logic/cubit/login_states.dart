

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


class GetDataDone extends LoginStates{}

class GetDataFail extends LoginStates{}


class GetScoreDone extends LoginStates{}

class GetScoreFail extends LoginStates{}



class SignOutLoad extends LoginStates{}

class SignOutDone extends LoginStates{}

class SignOutFail extends LoginStates{
  String error;
  SignOutFail(this.error);
}


