import 'package:chefaa/features/pharmacy/orders/presentation/widget/order_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/pharmacy/orders/presentation/cubit/pharm_orders_cubit.dart';
import 'package:chefaa/features/pharmacy/orders/presentation/cubit/pharm_orders_state.dart';

class PharmacyOrdersView extends StatefulWidget {
  const PharmacyOrdersView({super.key});

  @override
  State<PharmacyOrdersView> createState() => _PharmacyOrdersViewState();
}

class _PharmacyOrdersViewState extends State<PharmacyOrdersView> {
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    context.read<PharmOrdersCubit>().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: ColorManager.lightGray,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130 + topPadding),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: topPadding + 8,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
                  Expanded(
                    child: Text(
                      "Pharmacy Orders",
                      style: getBoldStyle(
                        color: ColorManager.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 4.0),
                child: Text(
                  "Manage, accept and track your customer orders",
                  style: getMediumStyle(
                    color: ColorManager.white,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocConsumer<PharmOrdersCubit, PharmOrdersState>(
        listener: (context, state) {
          if (state is AcceptOrderSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.orderStatModel.message ?? "Order Accepted successfully",
                ),
              ),
            );
            context.read<PharmOrdersCubit>().getOrders(status: selectedStatus);
          } else if (state is ReadyOrderSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.orderStatModel.message ?? "Order is now Ready",
                ),
              ),
            );
            context.read<PharmOrdersCubit>().getOrders(status: selectedStatus);
          }
        },
        builder: (context, state) {
          final cubit = context.read<PharmOrdersCubit>();
          final statusCounts = cubit.getOrdersModel?.data?.statusCounts;
          final orders = cubit.getOrdersModel?.data?.orders ?? [];

          return RefreshIndicator(
            onRefresh: () async {
              await cubit.getOrders(status: selectedStatus);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildCountCard(
                          "New",
                          statusCounts?.newOrders ?? 0,
                          ColorManager.blue600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildCountCard(
                          "Preparing",
                          statusCounts?.preparing ?? 0,
                          ColorManager.amber600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _buildCountCard(
                          "Ready",
                          statusCounts?.ready ?? 0,
                          ColorManager.green600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildCountCard(
                          "Completed",
                          statusCounts?.completed ?? 5,
                          ColorManager.purple600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "Filter by Status",
                    style: getBoldStyle(
                      color: ColorManager.darkGray,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip("All", null),
                        _buildFilterChip("New", "New"),
                        _buildFilterChip("Preparing", "Preparing"),
                        _buildFilterChip("Ready", "Ready"),
                        _buildFilterChip("Completed", "Completed"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  if (state is GetOrdersLoadingState)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.0),
                        child: CircularProgressIndicator(
                          color: ColorManager.primary,
                        ),
                      ),
                    )
                  else if (orders.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: Text(
                          "No orders found",
                          style: getRegularStyle(
                            color: ColorManager.gray,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        return OrderItemCard(order: orders[index]);
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCountCard(String title, int count, Color color) {
    bool isSelected = selectedStatus == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedStatus = title;
        });
        context.read<PharmOrdersCubit>().getOrders(status: selectedStatus);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.15) : ColorManager.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : ColorManager.input,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: getMediumStyle(color: color, fontSize: 13)),
            const SizedBox(height: 6),
            Text(
              count.toString(),
              style: getBoldStyle(color: ColorManager.black, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String? statusValue) {
    bool isSelected = selectedStatus == statusValue;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: ColorManager.primary,
        labelStyle: getMediumStyle(
          color: isSelected ? ColorManager.white : ColorManager.darkGray,
          fontSize: 13,
        ),
        backgroundColor: ColorManager.white,
        onSelected: (bool selected) {
          setState(() {
            selectedStatus = statusValue;
          });
          context.read<PharmOrdersCubit>().getOrders(status: selectedStatus);
        },
      ),
    );
  }
}
