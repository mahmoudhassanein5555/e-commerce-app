import 'package:e_commerce_app/feature/payment/domain/repository/payment_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetPaymentUrlUseCase {
  final PaymentRepo _repository;

  GetPaymentUrlUseCase(this._repository);

  Future<String> call({
    required String amountCents,
    required String currency,
    required Map<String, dynamic> billingData,
  }) async {
    return await _repository.getPaymentUrl(
      amountCents: amountCents,
      currency: currency,
      billingData: billingData,
    );
  }
}
