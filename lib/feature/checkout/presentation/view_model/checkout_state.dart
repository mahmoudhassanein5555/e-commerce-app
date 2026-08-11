import 'package:e_commerce_app/feature/cart/domain/entites/product_cart_entity.dart';

enum CheckoutStatus { initial, loading, success, error, requiresSelection }

class CheckoutState {
  final List<ProductCartEntity> items;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final String selectedPaymentMethod;
  final CheckoutStatus status;
  final String? errorMessage;

  const CheckoutState({
    this.items = const [],
    this.subtotal = 0.0,
    this.deliveryFee = 0.0,
    this.total = 0.0,
    this.selectedPaymentMethod = '',
    this.status = CheckoutStatus.initial,
    this.errorMessage,
  });

  CheckoutState copyWith({
    List<ProductCartEntity>? items,
    double? subtotal,
    double? deliveryFee,
    double? total,
    String? selectedPaymentMethod,
    CheckoutStatus? status,
    String? errorMessage,
  }) {
    return CheckoutState(
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      total: total ?? this.total,
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
