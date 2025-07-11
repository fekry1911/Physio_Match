import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/center_model.dart';
import '../data/rebo/get_center_data.dart';

part 'get_center_data_state.dart';

class GetCenterDataCubit extends Cubit<GetCenterDataState> {
  GetCenterData centerData;
  GetCenterDataCubit(this.centerData) : super(GetCenterDataInitial());
  List<AdminModel> adminList = [];
  Future<void> getAdminData() async {
    emit(GetAllCenterDataLoading());
    try {
      adminList = await centerData.getAllCentersData();
      emit(GetAllCenterDataSuccess(adminList));
    } catch (e) {
      emit(GetAllCenterDataError(e.toString()));
    }
  }

  AdminModel? centerModel;
  Future<void> getCenterInfo(String uid) async {
    emit(GetCenterDataLoading());
    try {
      centerModel = await centerData.getCenterData(uid);
      emit(GetCenterDataSuccess(centerModel!));
    } catch (e) {
      emit(GetCenterDataError(e.toString()));
    }
  }

}
