abstract class PaymentDataSource {
  Future<String> getAuthToken();
  Future<int> createOrder(
      {required String authToken,
      required String amountCents,
      required String currency});
  Future<String> getPaymentKey({
    required String authToken,
    required String orderId,
    required String amountCents,
    required String currency,
    required int integrationId,
    required Map<String, dynamic> billingData,
  });
}
