import 'package:e_commerce_app/feature/cart/domain/entites/product_cart_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'checkout_state.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  static const String _paymentMethodKey = 'selected_payment_method';

  CheckoutCubit() : super(const CheckoutState());

  Future<void> initCheckout(List<ProductCartEntity> items) async {
    final prefs = await SharedPreferences.getInstance();
    final savedMethod = prefs.getString(_paymentMethodKey) ?? '';

    final subtotal = items.fold(
      0.0, 
      (sum, item) => sum + (double.tryParse(item.price) ?? 0) * item.quantity
    );
    final deliveryFee = subtotal >= 850 ? 0.0 : 50.0;
    final total = subtotal + deliveryFee;

    emit(state.copyWith(
      items: items,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      total: total,
      selectedPaymentMethod: savedMethod,
      status: CheckoutStatus.initial,
    ));
  }

  Future<void> changePaymentMethod(String method) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_paymentMethodKey, method);
    emit(state.copyWith(selectedPaymentMethod: method, status: CheckoutStatus.initial));
  }

  Future<void> payNow() async {
    if (state.selectedPaymentMethod.isEmpty) {
      emit(state.copyWith(status: CheckoutStatus.requiresSelection));
      return;
    }

    emit(state.copyWith(status: CheckoutStatus.loading));
    
    // Simulate payment processing delay
    await Future.delayed(const Duration(seconds: 2));
    
    emit(state.copyWith(status: CheckoutStatus.success));
  }
}
