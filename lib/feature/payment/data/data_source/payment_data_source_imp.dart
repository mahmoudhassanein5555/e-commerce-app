import 'package:dio/dio.dart';
import 'package:e_commerce_app/feature/payment/data/data_source/payment_data_source.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PaymentDataSource)
class PaymentDataSourceImp implements PaymentDataSource {
  final Dio _apiManager = Dio();
  final payMobBaseUrl = "https://accept.paymob.com/api/";
  @override
  Future<String> getAuthToken() async {
    final response =
        await _apiManager.post("${payMobBaseUrl}auth/tokens", data: {
      "api_key":
          "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRJek16RTRPQ3dpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5lMG9CVlpTTG1mX3hmUG9UX1RtSldjcHg4MER1OHl6V25rVWNJTFRuOGRON0NGbGY4bUx2RWJfRzBCWnpidl9xOUJzR1NUQ1F5RDhTN1ZSNVFGTEhOdw=="
    });
    return response.data["token"];
  }

  //* Save the order Id (After get it from CreateOrder) Function in FirebaseFirestore
  @override
  Future<int> createOrder(
      {required String authToken,
      required String amountCents,
      required String currency}) async {
    final response =
        await _apiManager.post("${payMobBaseUrl}ecommerce/orders", data: {
      'auth_token': authToken,
      'delivery_needed': 'false',
      'amount_cents': amountCents,
      'currency': currency,
      'items': [],
    });
    return response.data["id"];
  }

  @override
  Future<String> getPaymentKey({
    required String authToken,
    required String orderId,
    required String amountCents,
    required String currency,
    required int integrationId,
    required Map<String, dynamic> billingData,
  }) async {
    final response = await _apiManager
        .post('${payMobBaseUrl}acceptance/payment_keys', data: {
      'auth_token': authToken,
      'amount_cents': amountCents,
      'expiration': 3600,
      'order_id': orderId,
      'billing_data': billingData,
      'currency': currency,
      'integration_id': integrationId, // هنا هتحط 5943104
      'lock_order_when_paid': 'false',
    });
    return response.data['token'];
  }
}
