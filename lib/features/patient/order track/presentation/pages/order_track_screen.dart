import 'package:chefaa/core/di/injection_container.dart';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/routes/app_router.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/features/patient/order%20track/presentation/cubit/order_track_cubit.dart';
import 'package:chefaa/features/patient/order%20track/presentation/cubit/order_track_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderTrackScreen extends StatelessWidget {
  final String orderId;

  const OrderTrackScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<OrderTrackCubit>()..orderTack(orderId: orderId),
      child: BlocConsumer<OrderTrackCubit, OrderTrackState>(
        listener: (context, state) {},
        builder: (context, state) {
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
                      "Order Tracking",
                      style: getBoldStyle(
                        color: ColorManager.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: _buildBody(context, state),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorManager.white,
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: CustemButton(
                text: "Confirm Order Receipt",
                isLoading: false,
                onPressed: () {
                  context.read<OrderTrackCubit>().orderConfirm(
                    orderId: orderId,
                  );

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.homePatient,
                    (route) => false,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Order receipt confirmation triggered!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, OrderTrackState state) {
    if (state is OrderTrackLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is OrderTrackError) {
      return Center(
        child: Text(
          state.error.message,
          style: getBoldStyle(color: ColorManager.error, fontSize: 16),
        ),
      );
    } else if (state is OrderTrackSuccess) {
      final data = state.model.data;
      if (data == null) {
        return const Center(child: Text("No data available"));
      }

      final bool isPickup =
          (data.orderContents?.summary?.deliveryFee ?? 0) == 0;

      return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order Number",
                        style: getMediumStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data.orderNumber ?? "",
                        style: getBoldStyle(
                          color: ColorManager.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      isPickup ? "Pickup Order" : (data.orderStatus ?? ""),
                      style: getBoldStyle(
                        color: ColorManager.primary,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Timeline Section
            Text(
              "Order Status Timeline",
              style: getBoldStyle(color: ColorManager.black, fontSize: 16),
            ),
            const SizedBox(height: 12),
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
                children: [
                  _buildTimelineTile(
                    title: data.statusTimeline?.orderConfirmed?.title ?? "",
                    description:
                        data.statusTimeline?.orderConfirmed?.description ?? "",
                    time: data.statusTimeline?.orderConfirmed?.time?.toString(),
                    isCompleted:
                        data.statusTimeline?.orderConfirmed?.isCompleted ??
                        false,
                    isFirst: true,
                    isLast: isPickup,
                  ),
                  _buildTimelineTile(
                    title: data.statusTimeline?.pharmacyPreparing?.title ?? "",
                    description: isPickup
                        ? "Pharmacy is preparing your order for pickup"
                        : (data
                                  .statusTimeline
                                  ?.pharmacyPreparing
                                  ?.description ??
                              ""),
                    time: data.statusTimeline?.pharmacyPreparing?.time
                        ?.toString(),
                    isCompleted:
                        data.statusTimeline?.pharmacyPreparing?.isCompleted ??
                        false,
                    isFirst: false,
                    isLast: isPickup,
                  ),
                  if (!isPickup) ...[
                    _buildTimelineTile(
                      title: data.statusTimeline?.riderPickedUp?.title ?? "",
                      description:
                          data.statusTimeline?.riderPickedUp?.description ?? "",
                      time: data.statusTimeline?.riderPickedUp?.time
                          ?.toString(),
                      isCompleted:
                          data.statusTimeline?.riderPickedUp?.isCompleted ??
                          false,
                      isFirst: false,
                      isLast: false,
                    ),
                    _buildTimelineTile(
                      title: data.statusTimeline?.onTheWay?.title ?? "",
                      description:
                          data.statusTimeline?.onTheWay?.description ?? "",
                      time: data.statusTimeline?.onTheWay?.time?.toString(),
                      isCompleted:
                          data.statusTimeline?.onTheWay?.isCompleted ?? false,
                      isFirst: false,
                      isLast: true,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Order Contents & Summary
            Text(
              "Order Contents",
              style: getBoldStyle(color: ColorManager.black, fontSize: 16),
            ),
            const SizedBox(height: 12),
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
                children: [
                  ...?data.orderContents?.items?.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.medicineName ?? "",
                                style: getBoldStyle(
                                  color: ColorManager.black,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "Qty: ${item.quantity}",
                                style: getMediumStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "EGP ${item.itemTotal}",
                            style: getBoldStyle(
                              color: ColorManager.primary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 20),
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
                        "EGP ${data.orderContents?.summary?.subtotal}",
                        style: getBoldStyle(
                          color: ColorManager.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (!isPickup) ...[
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
                          "EGP ${data.orderContents?.summary?.deliveryFee}",
                          style: getBoldStyle(
                            color: ColorManager.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Price",
                        style: getBoldStyle(
                          color: ColorManager.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "EGP ${data.orderContents?.summary?.totalPrice}",
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
          ],
        ),
      );
    }
    return const SizedBox();
  }

  Widget _buildTimelineTile({
    required String title,
    required String description,
    required String? time,
    required bool isCompleted,
    required bool isFirst,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? ColorManager.primary
                    : Colors.grey.shade300,
              ),
              child: Icon(
                isCompleted ? Icons.check : Icons.circle,
                size: 14,
                color: ColorManager.white,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 45,
                color: isCompleted
                    ? ColorManager.primary
                    : Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: getBoldStyle(
                          color: isCompleted ? ColorManager.black : Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: getMediumStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                if (time != null && time.isNotEmpty)
                  Text(
                    time,
                    style: getRegularStyle(
                      color: Colors.grey.shade500,
                      fontSize: 11,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
