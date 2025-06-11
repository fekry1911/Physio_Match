import 'package:add_ques/features/home_page/data/rebo/get_all_ques.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  GetAllQues getAllQues;
  HomeCubit(this.getAllQues) : super(HomeInitial());

  List<Map<String,dynamic>> questions=[];

  Future<void> getRandomQues()async {
    emit(GetLoading());
    await getAllQues.getAllQues().then((onValue){
      questions=onValue;
      emit(GetSucc());
    }).catchError((onError){
      emit(GetFail(onError));
    });

  }
  void resetState() {
    questions=[];
    emit(HomeInitial());
  }

}
