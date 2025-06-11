

abstract class RegisterStates{}

class Initial extends RegisterStates{}

class ChangeSecure extends RegisterStates{
  bool isSecure;
  ChangeSecure(this.isSecure);

}
class RegisterLoading extends RegisterStates{}

class RegisterSuccess extends RegisterStates{
  String userId;
  RegisterSuccess(this.userId);
}

class RegisterFailure extends RegisterStates{
  String error;
  RegisterFailure(this.error);
}
