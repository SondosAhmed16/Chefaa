import 'package:chefaa/core/di/injection_container.dart';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/routes/app_router.dart';
import 'package:chefaa/core/utils/validator.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/core/widgets/custom_text_feild.dart';
import 'package:chefaa/features/patient/cart/presentation/cubit/cart_cubit.dart';

import 'package:chefaa/features/patient/order/presentation/cubit/checkout_cubit.dart';
import 'package:chefaa/features/patient/order/presentation/cubit/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _streetAddressController =
      TextEditingController();

  String _orderType = "Delivery";
  String _paymentMethod = "Cash";

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _streetAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.watch<CartCubit>();
    final cityPrices = cartCubit.pharmacy?.cityDeliveryPrices ?? [];

    final int deliveryFee = _orderType == "Delivery"
        ? cartCubit.deliveryFee
        : 0;
    final double totalPrice = cartCubit.subtotal + deliveryFee;

    return BlocProvider(
      create: (context) => getIt<CheckoutCubit>(),
      child: Scaffold(
        backgroundColor: ColorManager.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            decoration: const BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 20,
                    color: ColorManager.white,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "Checkout",
                  style: getBoldStyle(color: ColorManager.white, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        body: BlocConsumer<CheckoutCubit, CheckoutState>(
          listener: (context, state) {
            if (state is CheckoutSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.orderModel.message ?? "Order placed successfully!",
                  ),
                  backgroundColor: Colors.green,
                ),
              );

              final orderId = state.orderModel.data?.orderId ?? "";
              final double subtotal = cartCubit.subtotal;
              final int fee = deliveryFee;

              cartCubit.clearCart();

              if (_paymentMethod == "Visa") {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.paymentProceed,
                  arguments: {
                    'orderId': orderId,
                    'subtotal': subtotal,
                    'deliveryFee': fee,
                  },
                );
              } else {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.orderTrack,
                  arguments: orderId,
                );
              }
            } else if (state is CheckoutFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message.message),
                  backgroundColor: ColorManager.error,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is CheckoutLoading;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Order Type",
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSelectCard(
                            title: "Delivery",
                            icon: Icons.local_shipping_outlined,
                            isSelected: _orderType == "Delivery",
                            onTap: () {
                              setState(() {
                                _orderType = "Delivery";
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildSelectCard(
                            title: "Pickup",
                            icon: Icons.storefront_outlined,
                            isSelected: _orderType == "Pickup",
                            onTap: () {
                              setState(() {
                                _orderType = "Pickup";
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    if (_orderType == "Delivery") ...[
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.black.withOpacity(0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delivery Address & City",
                              style: getBoldStyle(
                                color: ColorManager.black,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 12),

                            Text(
                              "Select Delivery City",
                              style: getMediumStyle(
                                color: Colors.grey.shade700,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 6),
                            cityPrices.isNotEmpty
                                ? DropdownButtonFormField<String>(
                                    value:
                                        cityPrices.any(
                                          (e) =>
                                              e.city == cartCubit.selectedCity,
                                        )
                                        ? cartCubit.selectedCity
                                        : null,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 12,
                                          ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                    ),
                                    hint: const Text("Select your city"),
                                    items: cityPrices.map((cityPrice) {
                                      return DropdownMenuItem<String>(
                                        value: cityPrice.city,
                                        child: Text(
                                          "${cityPrice.city} (EGP ${cityPrice.price})",
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newCity) {
                                      if (newCity != null) {
                                        cartCubit.selectCity(newCity);
                                      }
                                    },
                                  )
                                : const Text(
                                    "No delivery cities configured for this pharmacy",
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 12,
                                    ),
                                  ),
                            const SizedBox(height: 12),

                            CustomTextField(
                              controller: _fullNameController,
                              text: "Full Name",
                              validator: Validators.nameValidator,
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              controller: _phoneController,
                              text: "Phone Number",
                              keyboardType: TextInputType.phone,
                              validator: Validators.validatePhone,
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              controller: _streetAddressController,
                              text: "Street Address",
                              validator: (v) =>
                                  v!.isEmpty ? "Enter street address" : null,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],

                    Text(
                      "Select Payment Method",
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSelectCard(
                            title: "Cash",
                            icon: Icons.payments_outlined,
                            isSelected: _paymentMethod == "Cash",
                            onTap: () {
                              setState(() {
                                _paymentMethod = "Cash";
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildSelectCard(
                            title: "Online Card",
                            icon: Icons.credit_card_outlined,
                            isSelected: _paymentMethod == "Visa",
                            onTap: () {
                              setState(() {
                                _paymentMethod = "Visa";
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order Summary",
                            style: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Subtotal",
                                style: getMediumStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "EGP ${cartCubit.subtotal.toStringAsFixed(2)}",
                                style: getBoldStyle(
                                  color: ColorManager.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Delivery Fee",
                                style: getMediumStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "EGP $deliveryFee",
                                style: getBoldStyle(
                                  color: ColorManager.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: getBoldStyle(
                                  color: ColorManager.black,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "EGP ${totalPrice.toStringAsFixed(2)}",
                                style: getBoldStyle(
                                  color: ColorManager.primary,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    CustemButton(
                      text: _paymentMethod == "Cash"
                          ? "Order Tracking"
                          : "Continue",
                      isLoading: isLoading,
                      onPressed: () {
                        if (_orderType == "Delivery") {
                          if (cartCubit.selectedCity == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please select a delivery city."),
                              ),
                            );
                            return;
                          }
                          if (!_formKey.currentState!.validate()) return;
                        }

                        context.read<CheckoutCubit>().checkoutFromCart(
                          cartCubit: cartCubit,
                          fullName: _fullNameController.text.trim().isNotEmpty
                              ? _fullNameController.text.trim()
                              : "Patient User",
                          phoneNumber: _phoneController.text.trim().isNotEmpty
                              ? _phoneController.text.trim()
                              : "0100000000",
                          streetAddress:
                              _streetAddressController.text.trim().isNotEmpty
                              ? _streetAddressController.text.trim()
                              : "Address Details",
                          paymentMethod: _paymentMethod,
                          orderType: _orderType,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSelectCard({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorManager.primary.withOpacity(0.08)
              : ColorManager.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? ColorManager.primary : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? ColorManager.primary : Colors.grey.shade600,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: getBoldStyle(
                color: isSelected ? ColorManager.primary : Colors.black87,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
