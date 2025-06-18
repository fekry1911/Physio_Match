
abstract class StudentState {}

class StudentInitial extends StudentState {}

class NextStep extends StudentState {}

class PreviousStep extends StudentState {}

class SetCurrent extends StudentState {}

class StudentGenderChanged extends StudentState{}

class PickDateDone extends StudentState{}

class StudentSubmitted extends StudentState{}


class StudentSubmitLoading extends StudentState{}

class StudentSubmitFailed extends StudentState{
  String error;
  StudentSubmitFailed({required this.error});
}


