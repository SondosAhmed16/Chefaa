import 'package:chefaa/core/di/injection_container.dart';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/order%20track/presentation/pages/order_track_screen.dart';
import 'package:chefaa/features/patient/order/presentation/cubit/get_orders_cubit.dart';
import 'package:chefaa/features/patient/order/presentation/cubit/get_orders_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersHistoryScreen extends StatelessWidget {
  const OrdersHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GetOrdersCubit>()..getOrders(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
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
                  "My Orders History",
                  style: getBoldStyle(color: ColorManager.white, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<GetOrdersCubit, GetOrdersState>(
          builder: (context, state) {
            if (state is GetOrdersLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetOrdersError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    state.error.message ,
                    style: getBoldStyle(color: ColorManager.error, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            } else if (state is GetOrdersSuccess) {
              final ordersList = state.orders.data ?? [];

              if (ordersList.isEmpty) {
                return Center(
                  child: Text(
                    "No orders found yet.",
                    style: getMediumStyle(color: Colors.grey.shade600, fontSize: 16),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: ordersList.length,
                itemBuilder: (context, index) {
                  final order = ordersList[index];
                  final isConfirmed = order.isPatientConfirmed ?? false;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
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
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                order.orderNumber ?? "",
                                style: getBoldStyle(color: ColorManager.black, fontSize: 16),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isConfirmed 
                                      ? Colors.green.withOpacity(0.1) 
                                      : Colors.orange.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  isConfirmed ? "Completed" : "Active / In Progress",
                                  style: getBoldStyle(
                                    color: isConfirmed ? Colors.green : Colors.orange,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.local_pharmacy_outlined, size: 18, color: ColorManager.primary),
                                  const SizedBox(width: 8),
                                  Text(
                                    order.pharmacyName ?? "",
                                    style: getMediumStyle(color: Colors.grey.shade800, fontSize: 14),
                                  ),
                                ],
                              ),
                              Text(
                                order.orderType ?? "",
                                style: getMediumStyle(color: Colors.grey.shade600, fontSize: 13),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "EGP ${order.totalPrice ?? 0}",
                                style: getBoldStyle(color: ColorManager.primary, fontSize: 15),
                              ),
                              Text(
                                order.createdAt != null 
                                    ? "${order.createdAt!.toLocal().toString().split(' ')[0]}" 
                                    : "",
                                style: getRegularStyle(color: Colors.grey.shade500, fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: ColorManager.primary),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                if (order.orderId != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OrderTrackScreen(orderId: order.orderId!),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                "Track Order / Details",
                                style: getBoldStyle(color: ColorManager.primary, fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}