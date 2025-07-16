import 'package:add_ques/core/helpers/cache_helper.dart';
import 'package:add_ques/features/centers/data/models/rate_model.dart';
import 'package:add_ques/features/centers/data/rebo/rate_rebo/rate_rebo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RateReboImpl extends RateRebo{
  FirebaseFirestore firestore;
  RateReboImpl(this.firestore);
  @override
  Future<void> addRate(RateModel rateModel, String uid) async {
    try{
      await firestore.collection('admins').doc(uid).collection('rates').add(rateModel.toMap());
    }
        catch(e){
      print(e.toString());
        }

  }

  @override
  Future<List<RateModel>> getAllRates(String uid) async {
    List<RateModel> rates=[];
    try{
      var data= await firestore.collection('admins').doc(uid).collection('rates').get();
      data.docs.forEach((element) {
        rates.add(RateModel.fromMap(element.data()));
      });
      return Future.value(rates);
    }
        catch(e){
      throw(e.toString());
        }
  }
}