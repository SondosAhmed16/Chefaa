import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/features/pharmacy/orders/data/model/get_orders_model/order.dart';
import 'package:chefaa/features/pharmacy/orders/presentation/cubit/pharm_orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderItemCard extends StatefulWidget {
  final Order order;

  const OrderItemCard({super.key, required this.order});

  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    final items = order.items ?? [];
    final itemsCount = items.fold(0, (sum, item) => sum + (item.quantity ?? 0));

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent, 
        borderRadius: BorderRadius.circular(16),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: isExpanded,
            onExpansionChanged: (val) {
              setState(() {
                isExpanded = val;
              });
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.orderNumber ?? "N/A",
                  style: getBoldStyle(color: ColorManager.primary, fontSize: 15),
                ),
                _buildStatusBadge(order.status ?? ""),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Customer: ${order.userId?.name ?? "Unknown"}",
                    style: getMediumStyle(color: ColorManager.darkGray, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Type: ${order.orderType ?? "Pickup"} | Items: $itemsCount",
                        style: getRegularStyle(color: ColorManager.gray, fontSize: 12),
                      ),
                      Text(
                        "${order.totalPrice ?? 0} EGP",
                        style: getBoldStyle(color: ColorManager.black, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(color: ColorManager.input),
                    const SizedBox(height: 4),
                    Text("Medicines Details:", style: getBoldStyle(color: ColorManager.darkGray, fontSize: 13)),
                    const SizedBox(height: 8),
                    ...items.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "${item.medicineId?.medicineName ?? "Medicine"} (x${item.quantity ?? 1})",
                                style: getRegularStyle(color: ColorManager.black, fontSize: 13),
                              ),
                            ),
                            Text(
                              "${(item.price ?? 0) * (item.quantity ?? 1)} EGP",
                              style: getMediumStyle(color: ColorManager.darkGray, fontSize: 13),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Payment Method:", style: getRegularStyle(color: ColorManager.gray, fontSize: 12)),
                        Text(order.paymentMethod ?? "Cash", style: getMediumStyle(color: ColorManager.black, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 12),

                    if (order.status == "New")
                      SizedBox(
                        height: 40,
                        child: CustemButton(
                          text: "Accept Order",
                          isLoading: false,
                          onPressed: () {
                            context.read<PharmOrdersCubit>().acceptOrder(orderId: order.id ?? "");
                          },
                        ),
                      )
                    else if (order.status == "Preparing")
                      SizedBox(
                        height: 40,
                        child: CustemButton(
                          text: "Prepare & Ready Order",
                          isLoading: false,
                          onPressed: () {
                            context.read<PharmOrdersCubit>().readyOrder(orderId: order.id ?? "");
                          },
                        ),
                      )
                    else if (order.status == "Ready")
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          "Waiting for patient to receive and confirm completion.",
                          style: getMediumStyle(color: ColorManager.amber600, fontSize: 12),
                        ),
                      ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case "New":
        color = ColorManager.blue600;
        break;
      case "Preparing":
        color = ColorManager.amber600;
        break;
      case "Ready":
        color = ColorManager.green600;
        break;
      case "Completed":
        color = ColorManager.purple600;
        break;
      default:
        color = ColorManager.gray;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: getBoldStyle(color: color, fontSize: 11),
      ),
    );
  }
}