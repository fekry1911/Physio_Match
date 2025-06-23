part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {}


final class PaymentSucc extends PaymentState {
  String url;
  PaymentSucc(this.url);
}


final class PaymentFail extends PaymentState {
  final String error;
  PaymentFail(this.error);
}



