import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/routes/app_router.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/core/widgets/custom_dialog.dart';
import 'package:chefaa/features/patient/book/presentation/cubit/book_cubit.dart';
import 'package:chefaa/features/patient/book/presentation/cubit/book_state.dart';
import 'package:chefaa/features/patient/book/presentation/widget/appo_card.dart';
import 'package:chefaa/features/patient/book/presentation/widget/payment_form.dart';
import 'package:chefaa/features/patient/book/presentation/widget/payment_method_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmPage extends StatelessWidget {
  const ConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookCubit, BookState>(
      buildWhen: (previous, current) =>
          current is BookingInitialState ||
          current is BookingLoadingState ||
          current is BookingSuccessState ||
          current is BookingErrorState,
      listenWhen: (previous, current) =>
          current is BookingSuccessState || current is BookingErrorState,
      listener: (context, state) {
        if (state is BookingSuccessState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => CustomDialog(
              title: 'Booking Successful',
              message:
                  state.message ??
                  'Your appointment has been booked successfully!',
              type: DialogType.success,
              buttonText: 'Done',
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.homePatient,
                  ((route) => false),
                );
              },
            ),
          );
        } else if (state is BookingErrorState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => CustomDialog(
              title: 'Booking Failed',
              message: state.error,
              type: DialogType.fail,
              buttonText: 'Done',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<BookCubit>();

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                24,
                24,
                24,
                24 + MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Review & Confirm",
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Check your appointment details",
                    style: getMediumStyle(
                      color: ColorManager.gray,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppoCard(cubit: cubit),

                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment Methods",
                        style: getBoldStyle(
                          color: ColorManager.black,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Choose the best way to pay",
                        style: getMediumStyle(
                          color: ColorManager.gray,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),

                  PaymentMethodCard(
                    type: "Credit Card",
                    imgPath: "assets/images/card_image.png",
                    isSelected:
                        cubit.selectedPaymentMethod == PaymentMethod.creditCard,
                    isGroupHeader: cubit.needsCard,
                    onTap: () =>
                        cubit.selectPaymentMethod(PaymentMethod.creditCard),
                  ),

                  AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: cubit.needsCard
                        ? PaymentForm(
                            formKey: cubit.cardFormKey,
                            cardNumberController: cubit.cardNumberController,
                            cardHolderNameController:
                                cubit.cardHolderNameController,
                            expiryDateController: cubit.expiryDateController,
                            cvvController: cubit.cvvController,
                            borderColor: ColorManager.primary,
                            borderWidth: 2,
                            removeTopBorder: true,
                            showShadow: false,
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 16),
                  PaymentMethodCard(
                    type: "Cash",
                    imgPath: "assets/images/cash.png",
                    isSelected:
                        cubit.selectedPaymentMethod == PaymentMethod.cash,
                    onTap: () => cubit.selectPaymentMethod(PaymentMethod.cash),
                  ),

                  const SizedBox(height: 24),

                  if (cubit.selectedPaymentMethod != null)
                    Column(
                      children: [
                        CustemButton(
                          text: state is BookingLoadingState
                              ? "Booking"
                              : "Continue",
                          onPressed: state is BookingLoadingState
                              ? () {}
                              : () async {
                                  final bool proced = cubit
                                      .onConfirmBookPressed();
                                  if (!proced) return;

                                  final bool cridetCard =
                                      cubit.selectedPaymentMethod ==
                                      PaymentMethod.creditCard;
                                  await cubit.bookAppointment(
                                    clinicId: cubit.selectedClinic!.id!,
                                    isFollowUp: false,
                                    paymentOption: cridetCard
                                        ? "prePay"
                                        : "atClinic",
                                    cardNumber: cridetCard
                                        ? cubit.cardNumberController.text
                                        : null,
                                    expiryMonth: cridetCard
                                        ? cubit.expiryDateController.text.split(
                                            "/",
                                          )[0]
                                        : null,
                                    expiryYear: cridetCard
                                        ? cubit.expiryDateController.text.split(
                                            "/",
                                          )[1]
                                        : null,
                                    cvv: cridetCard
                                        ? cubit.cvvController.text
                                        : null,
                                    cardholderName: cridetCard
                                        ? cubit.cardHolderNameController.text
                                        : null,
                                  );
                                },
                          isLoading: state is BookingLoadingState,
                        ),

                        const SizedBox(height: 10),
                        Text(
                          "By confirming, you agree to our terms and cancellation policy",
                          style: getSemiBoldStyle(
                            color: ColorManager.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
