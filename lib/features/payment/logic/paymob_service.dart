import '../../../core/keys.dart';
import '../const/consts.dart';
import '../service/dio_helper_payment/dio_helper_payment.dart';

class PaymobService {

  Future<String> getAuthToken() async {
    final response = await DioHelperPayMent.postData(
      path: auth,
      data: {'api_key': payMobKey},
    );
    return response.data['token'];
  }

  Future<int> createOrder(String token, int amountCents) async {
    final response = await DioHelperPayMent.postData(
      path: order,
      data: {
        'auth_token': token,
        'delivery_needed': false,
        'amount_cents': amountCents,
        'currency': 'EGP',
        'items': [],
      },
    );
    return response.data['id'];
  }

  Future<String> getPaymentKey(
      String token,
      int orderId,
      int amountCents,
  {
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? city,
    String? street,
  }

      ) async {
    final response = await DioHelperPayMent.postData(
      path: paymentKey,
      data: {
        'auth_token': token,
        'amount_cents': amountCents,
        'expiration': 3600,
        'order_id': orderId,
        'billing_data': {
          'apartment': '803',
          'email': email,
          'first_name': firstName,
          'last_name': lastName,
          'phone_number': phoneNumber,
          'city':city ,
          'country': 'EG',
          'street': street,
          'floor': '5',
          'building': '22A',
          'shipping_method': 'PKG',
          'postal_code': '12345',
          'state': 'Cairo',
        },
        'currency': 'EGP',
        'integration_id': int.parse(payMobID),
      },
    );
    return response.data['token'];
  }

  String getPaymentUrl(String paymentToken) {
    return 'https://accept.paymob.com/api/acceptance/iframes/$iframeId?payment_token=$paymentToken';
  }
}
