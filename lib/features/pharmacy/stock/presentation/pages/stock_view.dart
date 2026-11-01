import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/core/widgets/custom_text_feild.dart';
import 'package:chefaa/features/pharmacy/stock/data/model/get_stock_model/medicine.dart';
import 'package:chefaa/features/pharmacy/stock/presentation/cubit/stock_cubit.dart';
import 'package:chefaa/features/pharmacy/stock/presentation/cubit/stock_state.dart';
import 'package:chefaa/features/pharmacy/stock/presentation/widget/filter_chip_item.dart';
import 'package:chefaa/features/pharmacy/stock/presentation/widget/medicine_card_item.dart';
import 'package:chefaa/features/pharmacy/stock/presentation/widget/stat_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';

class StockView extends StatefulWidget {
  const StockView({super.key});

  @override
  State<StockView> createState() => _StockViewState();
}

class _StockViewState extends State<StockView> {
  String selectedFilter = 'all';
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    context.read<StockCubit>().getStock();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightGray,
      appBar: AppBar(
        title: Text(
          'Pharmacy Stock',
          style: getBoldStyle(color: ColorManager.white, fontSize: 20),
        ),
        backgroundColor: ColorManager.primary,
        elevation: 0,
      ),
      body: BlocConsumer<StockCubit, StockState>(
        listener: (context, state) {
          if (state is AddMedicineSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Medicine added successfully'),
                backgroundColor: ColorManager.green600,
              ),
            );
          } else if (state is AddMedicineFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorModel.message),
                backgroundColor: ColorManager.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final stockModel = (state is GetStockSuccess)
              ? state.getStockModel
              : null;

          if (state is GetStockLoading && stockModel == null) {
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.primary),
            );
          }

          if (state is GetStockFailure && stockModel == null) {
            return Center(
              child: Text(
                state.errorModel.message,
                style: getRegularStyle(color: ColorManager.error, fontSize: 16),
              ),
            );
          }

          final medicinesList = stockModel?.data?.medicines ?? [];
          final summary = stockModel?.data?.summary;
          final pagination = stockModel?.data?.pagination;

          final filteredMedicines = medicinesList.where((med) {
            final qty = med.quantity ?? 0;
            if (selectedFilter == 'instock') {
              return qty > 0;
            } else if (selectedFilter == 'outofstock') {
              return qty == 0;
            }
            return true;
          }).toList();

          return RefreshIndicator(
            onRefresh: () async {
              await context.read<StockCubit>().getStock();
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
                        child: StatCardItem(
                          title: 'Total',
                          count: '${summary?.total ?? 0}',
                          color: ColorManager.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: StatCardItem(
                          title: 'Low Stock',
                          count: '${summary?.lowStockCount ?? 0}',
                          color: ColorManager.amber600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: StatCardItem(
                          title: 'Out of Stock',
                          count: '${summary?.outOfStockCount ?? 0}',
                          color: ColorManager.error,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilterChipItem(
                        label: 'All',
                        value: 'all',
                        isSelected: selectedFilter == 'all',
                        onSelected: (_) =>
                            setState(() => selectedFilter = 'all'),
                      ),
                      const SizedBox(width: 10),
                      FilterChipItem(
                        label: 'In Stock',
                        value: 'instock',
                        isSelected: selectedFilter == 'instock',
                        onSelected: (_) =>
                            setState(() => selectedFilter = 'instock'),
                      ),
                      const SizedBox(width: 10),
                      FilterChipItem(
                        label: 'Out of Stock',
                        value: 'outofstock',
                        isSelected: selectedFilter == 'outofstock',
                        onSelected: (_) =>
                            setState(() => selectedFilter = 'outofstock'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (state is AddMedicineLoading)
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: ColorManager.primary,
                        ),
                      ),
                    ),

                  if (state is! AddMedicineLoading && filteredMedicines.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: Center(
                        child: Text(
                          'No medicines available in this section',
                          style: getMediumStyle(
                            color: ColorManager.gray,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  else if (filteredMedicines.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredMedicines.length,
                      itemBuilder: (context, index) {
                        final medicine = filteredMedicines[index];
                        return MedicineCardItem(
                          medicine: medicine,
                          onTap: () =>
                              _showRestockBottomSheet(context, medicine),
                        );
                      },
                    ),
                  const SizedBox(height: 16),
                  if (pagination != null && pagination.totalPages! > 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: pagination.page! > 1
                              ? () => setState(() => currentPage--)
                              : null,
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                        Text(
                          'Page ${pagination.page ?? 1} of ${pagination.totalPages ?? 1}',
                          style: getBoldStyle(
                            color: ColorManager.black,
                            fontSize: 14,
                          ),
                        ),
                        IconButton(
                          onPressed: pagination.page! < pagination.totalPages!
                              ? () => setState(() => currentPage++)
                              : null,
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.primary,
        onPressed: () => _showAddMedicineBottomSheet(context),
        child: const Icon(Icons.add, color: ColorManager.white),
      ),
    );
  }

  void _showAddMedicineBottomSheet(BuildContext context) {
    final stockCubit = context.read<StockCubit>();

    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final genericController = TextEditingController();
    final concentrationController = TextEditingController(text: 'N/A');
    final manufacturerController = TextEditingController();
    final barcodeController = TextEditingController();
    final priceController = TextEditingController();
    final quantityController = TextEditingController();
    final minThresholdController = TextEditingController(text: '10');
    final indicationsController = TextEditingController();
    final sideEffectsController = TextEditingController();
    final dosageInstructionsController = TextEditingController();

    String? selectedCategory;
    String? selectedDosageForm;
    DateTime? selectedExpiryDate;

    final categories = [
      "analgesic",
      "antibiotic",
      "antiviral",
      "antidiabetic",
      "cardiac",
      "diabetes",
      "allergy",
      "vitamins",
      "antihistamine",
      "antifungal",
      "antiseptic",
      "respiratory",
      "gastrointestinal",
      "dermatology",
      "supplements",
      "other",
    ];

    final dosageForms = [
      "Tablet",
      "Capsule",
      "Syrup",
      "Injection",
      "Cream",
      "Drops",
      "Other",
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorManager.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return BlocProvider.value(
          value: stockCubit,
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 16,
                  right: 16,
                  top: 20,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'Add New Medicine',
                          style: getBoldStyle(
                            color: ColorManager.black,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Medicine Name",
                          style: getMediumStyle(
                            color: ColorManager.darkGray,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextField(
                          controller: nameController,
                          text: 'Medicine Name',
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Generic Name",
                          style: getMediumStyle(
                            color: ColorManager.darkGray,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextField(
                          controller: genericController,
                          text: 'Generic Name',
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Concentration",
                          style: getMediumStyle(
                            color: ColorManager.darkGray,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextField(
                          controller: concentrationController,
                          text: 'Concentration',
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Category",
                          style: getMediumStyle(
                            color: ColorManager.darkGray,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        DropdownButtonFormField<String>(
                          value: selectedCategory,
                          decoration: InputDecoration(
                            labelText: 'Category',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          items: categories.map((cat) {
                            return DropdownMenuItem(
                              value: cat,
                              child: Text(cat),
                            );
                          }).toList(),
                          onChanged: (val) =>
                              setModalState(() => selectedCategory = val),
                          validator: (val) =>
                              val == null ? 'Please select category' : null,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Dosage Form",
                          style: getMediumStyle(
                            color: ColorManager.darkGray,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        DropdownButtonFormField<String>(
                          value: selectedDosageForm,
                          decoration: InputDecoration(
                            labelText: 'Dosage Form',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          items: dosageForms.map((form) {
                            return DropdownMenuItem(
                              value: form,
                              child: Text(form),
                            );
                          }).toList(),
                          onChanged: (val) =>
                              setModalState(() => selectedDosageForm = val),
                          validator: (val) =>
                              val == null ? 'Please select dosage form' : null,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Manufacturer",
                          style: getMediumStyle(
                            color: ColorManager.darkGray,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextField(
                          controller: manufacturerController,
                          text: 'Manufacturer',
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Barcode",
                          style: getMediumStyle(
                            color: ColorManager.darkGray,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextField(
                          controller: barcodeController,
                          text: 'Barcode',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Price",
                          style: getMediumStyle(
                            color: ColorManager.darkGray,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextField(
                          controller: priceController,
                          text: 'Price',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Quantity",
                          style: getMediumStyle(
                            color: ColorManager.darkGray,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextField(
                          controller: quantityController,
                          text: 'Quantity',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Min Threshold",
                          style: getMediumStyle(
                            color: ColorManager.darkGray,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextField(
                          controller: minThresholdController,
                          text: 'Min Threshold',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Expire Date",
                          style: getMediumStyle(
                            color: ColorManager.darkGray,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        InkWell(
                          onTap: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2035),
                            );
                            if (pickedDate != null) {
                              setModalState(
                                () => selectedExpiryDate = pickedDate,
                              );
                            }
                          },
                          child: InputDecorator(
                            decoration: InputDecoration(
                              labelText: 'Expiry Date',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              selectedExpiryDate == null
                                  ? 'Select Expiry Date'
                                  : selectedExpiryDate!.toIso8601String().split(
                                      'T',
                                    )[0],
                              style: getRegularStyle(
                                color: selectedExpiryDate == null
                                    ? ColorManager.gray
                                    : ColorManager.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Indications",
                          style: getMediumStyle(
                            color: ColorManager.darkGray,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextField(
                          controller: indicationsController,
                          text: 'Indications',
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Side Effects",
                          style: getMediumStyle(
                            color: ColorManager.darkGray,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextField(
                          controller: sideEffectsController,
                          text: 'Side Effects',
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Dosage Instructions",
                          style: getMediumStyle(
                            color: ColorManager.darkGray,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextField(
                          controller: dosageInstructionsController,
                          text: 'Dosage Instructions',
                        ),
                        const SizedBox(height: 20),
                        CustemButton(
                          text: 'Save Medicine',
                          isLoading: false,
                          onPressed: () {
                            if (formKey.currentState!.validate() &&
                                selectedExpiryDate != null) {
                              final body = {
                                "medicineName": nameController.text.trim(),
                                "genericName": genericController.text.trim(),
                                "concentration": concentrationController.text
                                    .trim(),
                                "category": selectedCategory,
                                "dosageForm": selectedDosageForm,
                                "manufacturer": manufacturerController.text
                                    .trim(),
                                "barcode": barcodeController.text.trim(),
                                "price": int.parse(priceController.text.trim()),
                                "quantity": int.parse(
                                  quantityController.text.trim(),
                                ),
                                "minThreshold": int.parse(
                                  minThresholdController.text.trim(),
                                ),
                                "expiryDate": selectedExpiryDate!
                                    .toIso8601String(),
                                "indications": indicationsController.text
                                    .trim(),
                                "sideEffects": sideEffectsController.text
                                    .trim(),
                                "dosageInstructions":
                                    dosageInstructionsController.text.trim(),
                              };

                              stockCubit.addMedicine(body: body);
                              Navigator.pop(context);
                            } else if (selectedExpiryDate == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please select expiry date'),
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showRestockBottomSheet(BuildContext context, Medicine medicine) {
    final stockCubit = context.read<StockCubit>();
    final formKey = GlobalKey<FormState>();
    final priceController = TextEditingController(
      text: medicine.price.toString(),
    );
    final quantityController = TextEditingController(
      text: medicine.quantity.toString(),
    );
    final minThresholdController = TextEditingController(
      text: medicine.minThreshold.toString(),
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorManager.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return BlocProvider.value(
          value: stockCubit,
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 16,
                  right: 16,
                  top: 20,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Update Medicine',
                          style: getBoldStyle(
                            color: ColorManager.black,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Price",
                          style: getMediumStyle(
                            color: ColorManager.darkGray,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextField(
                          controller: priceController,
                          text: 'Price',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Quantity",
                          style: getMediumStyle(
                            color: ColorManager.darkGray,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextField(
                          controller: quantityController,
                          text: 'Quantity',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Min Threshold",
                          style: getMediumStyle(
                            color: ColorManager.darkGray,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextField(
                          controller: minThresholdController,
                          text: 'Min Threshold',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 15),
                        CustemButton(
                          text: 'Save Medicine',
                          isLoading: false,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              final body = {
                                "price": int.parse(priceController.text.trim()),
                                "quantity": int.parse(
                                  quantityController.text.trim(),
                                ),
                                "minThreshold": int.parse(
                                  minThresholdController.text.trim(),
                                ),
                              };

                              stockCubit.restock(
                                medId: medicine.id ?? '',
                                body: body,
                              );
                              Navigator.pop(context);
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
