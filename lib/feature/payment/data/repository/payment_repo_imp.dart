import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/feature/payment/data/data_source/payment_data_source.dart';
import 'package:e_commerce_app/feature/payment/domain/repository/payment_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PaymentRepo)
class PaymentRepoImp implements PaymentRepo {
  final PaymentDataSource _dataSource;

  final int integrationId = 5939082;
  final String iframeId = AppStrings.defaultIframeId;

  PaymentRepoImp(this._dataSource);

  @override
  Future<String> getPaymentUrl({
    required String amountCents,
    required String currency,
    required Map<String, dynamic> billingData,
  }) async {
    final authToken = await _dataSource.getAuthToken();

    final orderId = await _dataSource.createOrder(
      authToken: authToken,
      amountCents: amountCents,
      currency: currency,
    );

    final paymentKey = await _dataSource.getPaymentKey(
      authToken: authToken,
      orderId: orderId.toString(),
      amountCents: amountCents,
      currency: currency,
      integrationId: integrationId,
      billingData: billingData,
    );

    return "${AppStrings.paymobIframeUrl}$iframeId?payment_token=$paymentKey";
  }
}
