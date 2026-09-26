abstract class PaymentRepo {
  Future<String> getPaymentUrl({
    required String amountCents,
    required String currency,
    required Map<String, dynamic> billingData,
  });
}
