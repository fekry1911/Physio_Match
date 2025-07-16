import 'package:add_ques/features/payment/logic/paymob_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this._paymobService) : super(PaymentInitial());
  final PaymobService _paymobService;
  String? url;
  final formKey = GlobalKey<FormState>();
  TextEditingController? firstName=TextEditingController();
  TextEditingController? lastName=TextEditingController();
  TextEditingController? email=TextEditingController();
  TextEditingController? phone=TextEditingController();
  TextEditingController? city=TextEditingController();
  TextEditingController? street=TextEditingController();

  Future<void> initiatePayment() async {
    emit(PaymentLoading());
    try {
      final authToken = await _paymobService.getAuthToken();
      print(authToken);
      final orderId = await _paymobService.createOrder(authToken, 10000);
      print(orderId);
      print(firstName!.text);
      print(lastName!.text);
      print(email!.text);
      print(phone!.text);
      print(city!.text);
      print(street!.text);
      final paymentKey = await _paymobService.getPaymentKey(
        authToken,
        orderId,
        10000,
        firstName: firstName!.text,
        lastName: lastName!.text,
        email: email!.text,
        phoneNumber: phone!.text,
        city: city!.text,
        street: street!.text,
      );
      print(paymentKey);
      url = _paymobService.getPaymentUrl(paymentKey);
      print(url);
      emit(PaymentSucc(url!));
      lastName!.clear();
      firstName!.clear();
      email!.clear();
      phone!.clear();
      city!.clear();
      street!.clear();
    } catch (e) {
      emit(PaymentFail(e.toString()));
    }
  }
}
