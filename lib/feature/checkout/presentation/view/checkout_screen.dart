import 'package:e_commerce_app/feature/app_section/main_tab_cubit.dart';
import 'package:e_commerce_app/feature/cart/presentation/view_model/home_cubit/product_cart_cubit.dart';
import 'package:e_commerce_app/feature/checkout/presentation/view/fake_wallet_screen.dart';
import 'package:e_commerce_app/feature/checkout/presentation/view/payment_success_screen.dart';
import 'package:e_commerce_app/feature/checkout/presentation/view/visa_card_screen.dart';
import 'package:e_commerce_app/feature/checkout/presentation/view_model/checkout_cubit.dart';
import 'package:e_commerce_app/feature/checkout/presentation/view_model/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CheckoutScreen extends StatefulWidget {
  static const String routeName = 'CheckoutScreen';
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    super.initState();
    final cartItems = context.read<CartCubit>().state.items;
    context.read<CheckoutCubit>().initCheckout(cartItems);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        if (state.status == CheckoutStatus.requiresSelection) {
          _showPaymentMethodBottomSheet(context);
        } else if (state.status == CheckoutStatus.success) {
          if (state.selectedPaymentMethod == 'Visa' || state.selectedPaymentMethod == 'MasterCard') {
            Navigator.pushNamed(context, VisaCardScreen.routeName);
          } else if (state.selectedPaymentMethod == 'Wallet') {
            Navigator.pushNamed(context, FakeWalletScreen.routeName);
          } else if (state.selectedPaymentMethod == 'Cash') {
            Navigator.pushNamed(context, PaymentSuccessScreen.routeName);
          }
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: const Color(0xFFF9F9F9),
              appBar: AppBar(
                title: const Text(
                  "Checkout",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Delivery Information Section
                    _buildSectionHeader("Delivery Information"),
                    _buildAddressCard(),

                    // Cart Items Summary
                    _buildSectionHeader("Order Summary"),
                    _buildItemsList(state),

                    // Payment Method Section
                    _buildSectionHeaderWithAction(
                      "Payment Method", 
                      onAction: () => _showPaymentMethodBottomSheet(context),
                    ),
                    _buildSelectedPaymentMethodCard(state),

                    const SizedBox(height: 24),

                    // Price Summary
                    _buildPriceSummary(state.subtotal, state.deliveryFee, state.total),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
              bottomNavigationBar: _buildBottomNavigationBar(context),
            ),
            if (state.status == CheckoutStatus.loading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
  Widget _buildSectionHeaderWithAction(String title, {required VoidCallback onAction}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 10, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextButton(
            onPressed: onAction,
            child: const Text(
              "Change",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildAddressCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.location_on_outlined, color: Colors.black),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Home Address",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 4),
                Text(
                  "123 Street Name, Cairo, Egypt",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList(CheckoutState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.items.length,
        separatorBuilder: (context, index) => const Divider(height: 1, indent: 16, endIndent: 16),
        itemBuilder: (context, index) {
          final item = state.items[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
              ),
            ),
            title: Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              "Qty: ${item.quantity}",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            trailing: Text(
              "EGP ${item.price}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectedPaymentMethodCard(CheckoutState state) {
    IconData icon;
    String title;
    bool hasSelection = state.selectedPaymentMethod.isNotEmpty;

    if (hasSelection) {
      switch (state.selectedPaymentMethod) {
        case 'Visa':
          icon = Icons.credit_card;
          title = "Visa Card";
          break;
        case 'MasterCard':
          icon = Icons.credit_card;
          title = "MasterCard";
          break;
        case 'Wallet':
          icon = Icons.account_balance_wallet;
          title = "Mobile Wallet";
          break;
        case 'Cash':
          icon = Icons.money;
          title = "Cash on Delivery";
          break;
        default:
          icon = Icons.payment;
          title = state.selectedPaymentMethod;
      }
    } else {
      icon = Icons.payment_outlined;
      title = "Select Payment Method";
    }

    return GestureDetector(
      onTap: () => _showPaymentMethodBottomSheet(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black54, size: 28),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            if (hasSelection)
              const Icon(Icons.check_circle, color: Colors.green, size: 20)
            else 
              const Icon(Icons.arrow_forward_ios, color: Colors.black26, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceSummary(double subtotal, double delivery, double total) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _priceRow("Subtotal", "EGP ${subtotal.toStringAsFixed(2)}"),
          const SizedBox(height: 12),
          _priceRow("Delivery Fee", delivery == 0 ? "Free" : "EGP ${delivery.toStringAsFixed(2)}", 
            isFree: delivery == 0),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(height: 1),
          ),
          _priceRow("Total", "EGP ${total.toStringAsFixed(2)}", isTotal: true),
        ],
      ),
    );
  }

  Widget _priceRow(String label, String value, {bool isTotal = false, bool isFree = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 15,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w400,
            color: isTotal ? Colors.black : Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 15,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isFree ? Colors.green : (isTotal ? Colors.black : Colors.black87),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BlocBuilder<MainTabCubit, int>(
      builder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Pay Now Button Area
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<CheckoutCubit>().payNow();
                    
                    // The PayNow method in Cubit now handles validation and status
                    // We should only navigate on success in a real app listener, 
                    // but for fake flow we can do it after a delay or based on state.
                    // To follow "Handle everything inside CheckoutCubit", 
                    // we'll move navigation to the listener or based on state.
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Pay Now",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            // Mirrored Bottom Navigation Bar
            BottomNavigationBar(
              unselectedFontSize: 13,
              selectedFontSize: 14,
              selectedItemColor: const Color(0xff5C5C5C),
              unselectedItemColor: const Color(0xff5C5C5C),
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              currentIndex: 1, // Cart index
              onTap: (selectedIndex) {
                context.read<MainTabCubit>().selectTab(selectedIndex);
                Navigator.pop(context);
              },
              items: [
                _buildNavItem(0, 'Home', 'assets/icons/icon-home.svg'),
                _buildNavItem(1, 'Cart', 'assets/icons/icon-cart.svg'),
                _buildNavItem(2, 'Favorite', 'assets/icons/icon-favourite.svg'),
                _buildNavItem(3, 'Profile', 'assets/icons/icon-profile.svg'),
              ],
            ),
          ],
        );
      },
    );
  }

  BottomNavigationBarItem _buildNavItem(int index, String label, String iconPath) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        iconPath,
        height: 23,
        width: 23,
        fit: BoxFit.cover,
        color: const Color(0xff5C5C5C),
      ),
      label: label,
    );
  }

  void _showPaymentMethodBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select Payment Method",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  _buildBottomSheetOption(context, "Visa", Icons.credit_card, "Visa Card", state.selectedPaymentMethod == "Visa"),
                  _buildBottomSheetOption(context, "MasterCard", Icons.payment, "MasterCard", state.selectedPaymentMethod == "MasterCard"),
                  _buildBottomSheetOption(context, "Wallet", Icons.account_balance_wallet, "Mobile Wallet", state.selectedPaymentMethod == "Wallet"),
                  _buildBottomSheetOption(context, "Cash", Icons.money, "Cash on Delivery", state.selectedPaymentMethod == "Cash"),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBottomSheetOption(BuildContext context, String value, IconData icon, String title, bool isSelected) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.black) : null,
      onTap: () {
        context.read<CheckoutCubit>().changePaymentMethod(value);
        Navigator.pop(context);
      },
    );
  }
}
