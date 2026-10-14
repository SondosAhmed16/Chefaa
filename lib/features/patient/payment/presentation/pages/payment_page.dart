import 'package:chefaa/core/di/injection_container.dart';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/routes/app_router.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/features/patient/book/presentation/widget/payment_form.dart';
import 'package:chefaa/features/patient/payment/presentation/cubit/payment_cubit.dart';
import 'package:chefaa/features/patient/payment/presentation/cubit/payment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentPage extends StatefulWidget {
  final String orderId;
  final double subtotal;
  final int deliveryFee;

  const PaymentPage({
    super.key,
    required this.orderId,
    required this.subtotal,
    required this.deliveryFee,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderNameController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PaymentCubit>(),
      child: Builder(
        builder: (context) {
          final double totalPrice = widget.subtotal + widget.deliveryFee;

          return Scaffold(
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
                      "Online Payment Proceed",
                      style: getBoldStyle(
                        color: ColorManager.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: BlocConsumer<PaymentCubit, PaymentState>(
              listener: (context, state) {
                if (state is PaymentSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.paymentModel.message ?? "Payment successful!",
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pushReplacementNamed(
                    context,
                    Routes.orderTrack,
                    arguments: widget.orderId,
                  );
                } else if (state is PaymentError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error.message),
                      backgroundColor: ColorManager.error,
                    ),
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state is PaymentLoading;

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      PaymentForm(
                        formKey: _formKey,
                        cardNumberController: _cardNumberController,
                        cardHolderNameController: _cardHolderNameController,
                        expiryDateController: _expiryDateController,
                        cvvController: _cvvController,
                        borderColor: Colors.grey.shade300,
                        borderWidth: 1,
                        removeTopBorder: false,
                        showShadow: true,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.black.withOpacity(0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
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
                                  "EGP ${widget.subtotal.toStringAsFixed(2)}",
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
                                  "EGP ${widget.deliveryFee.toDouble().toStringAsFixed(2)}",
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
                        text: "Pay Now",
                        isLoading: isLoading,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<PaymentCubit>().paymentOnline(
                              orderId: widget.orderId,
                              cardholderName: _cardHolderNameController.text
                                  .trim(),
                              cardNumber: _cardNumberController.text.trim(),
                              expiryDate: _expiryDateController.text.trim(),
                              cvv: _cvvController.text.trim(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
