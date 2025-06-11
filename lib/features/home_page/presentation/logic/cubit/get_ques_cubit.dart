import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_ques_state.dart';

class GetQuesCubit extends Cubit<GetQuesState> {
  GetQuesCubit() : super(GetQuesInitial());
}
