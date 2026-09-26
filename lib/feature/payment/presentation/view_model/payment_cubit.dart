import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/feature/payment/domain/use_case/get_payment_url_use_case.dart';
import 'package:e_commerce_app/feature/payment/presentation/view_model/payment_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentCubit extends Cubit<PaymentState> {
  final GetPaymentUrlUseCase _getPaymentUrlUseCase;

  PaymentCubit(this._getPaymentUrlUseCase) : super(PaymentInitial());

  Future<void> initiatePayment({
    required double amount,
    required String currency,
  }) async {
    emit(PaymentLoading());
    try {
      final String amountCents = (amount * 100).toInt().toString();

      final Map<String, dynamic> dummyBillingData = {
        "apartment": "3",
        "email": "test@example.com",
        "floor": "2",
        "first_name": "John",
        "street": "Tahrir Street",
        "building": "15",
        "phone_number": "+201011122233",
        "shipping_method": "PKG",
        "postal_code": "11511", 
        "city": "Cairo",
        "country": "EG",
        "last_name": "Doe",
        "state": "Cairo"
      };

      final paymentUrl = await _getPaymentUrlUseCase(
        amountCents: amountCents,
        currency: currency,
        billingData: dummyBillingData,
      );

      emit(PaymentSuccess(paymentUrl));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }
}
