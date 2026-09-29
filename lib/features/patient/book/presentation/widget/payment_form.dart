import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/utils/validator.dart';
import 'package:chefaa/core/widgets/custom_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController cardNumberController;
  final TextEditingController cardHolderNameController;
  final TextEditingController expiryDateController;
  final TextEditingController cvvController;

  final Color borderColor;
  final double borderWidth;
  final bool removeTopBorder;
  final bool showShadow;
  const PaymentForm({
    super.key,
    required this.formKey,
    required this.cardNumberController,
    required this.cardHolderNameController,
    required this.expiryDateController,
    required this.cvvController,
    required this.borderColor,
    required this.borderWidth,
    required this.removeTopBorder,
    required this.showShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
        border: removeTopBorder
            ? Border(
                left: BorderSide(color: borderColor, width: borderWidth),
                right: BorderSide(color: borderColor, width: borderWidth),
                bottom: BorderSide(color: borderColor, width: borderWidth),
                top: BorderSide.none,
              )
            : Border.all(color: borderColor, width: borderWidth),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: ColorManager.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),

      child: Form(
        key: formKey,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: ColorManager.lightGreen,
                borderRadius: BorderRadius.circular(12),
              ),

              child: Row(
                children: [
                  Image.asset(
                    "assets/images/Vector.png",
                    width: 20,
                    height: 20,
                  ),

                  const SizedBox(width: 3),

                  Text(
                    "Secure payment - Your data is encrypted",
                    style: getRegularStyle(
                      color: ColorManager.green600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            const Text("Card Number"),
            const SizedBox(height: 6),
            CustomTextField(
              controller: cardNumberController,
              text: "e.g., •••• •••• •••• 4242",
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(19),
              ],
              validator: Validators.validateCardNumber,
            ),

            const SizedBox(height: 12),

            const Text("Cardholder Name"),
            const SizedBox(height: 6),
            CustomTextField(
              controller: cardHolderNameController,
              text: "e.g., Khaled Mohamed",
              textInputAction: TextInputAction.next,
              validator: Validators.required,
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Expiry Date"),
                      const SizedBox(height: 6),
                      CustomTextField(
                        controller: expiryDateController,
                        text: "MM/YY",
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(5)],
                        validator: Validators.validateExpiry,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("CVV"),
                      const SizedBox(height: 6),
                      CustomTextField(
                        controller: cvvController,
                        text: "e.g., 123",
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
                        validator: Validators.validateCvv,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
