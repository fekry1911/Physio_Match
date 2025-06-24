
abstract class TypeRegisterState {}

class StudentInitial extends TypeRegisterState {}

class NextStep extends TypeRegisterState {}

class PreviousStep extends TypeRegisterState {}

class SetCurrent extends TypeRegisterState {}

class StudentGenderChanged extends TypeRegisterState{}

class PickDateDone extends TypeRegisterState{}

class StudentSubmitted extends TypeRegisterState{}

class UploadImageSucc extends TypeRegisterState{}

class UploadImageFail extends TypeRegisterState{}

class UploadCVSucc extends TypeRegisterState{}

class UploadCVFail extends TypeRegisterState{}

class StudentSubmitLoading extends TypeRegisterState{}

class StudentSubmitFailed extends TypeRegisterState{
  String error;
  StudentSubmitFailed({required this.error});
}


