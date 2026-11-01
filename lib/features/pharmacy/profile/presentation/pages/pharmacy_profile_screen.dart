import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/core/widgets/custom_text_feild.dart';
import 'package:chefaa/features/pharmacy/profile/presentation/cubit/pharmacy_profile_cubit.dart';
import 'package:chefaa/features/pharmacy/profile/presentation/cubit/pharmacy_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PharmacyProfileScreen extends StatefulWidget {
  const PharmacyProfileScreen({super.key});

  @override
  State<PharmacyProfileScreen> createState() => _PharmacyProfileScreenState();
}

class _PharmacyProfileScreenState extends State<PharmacyProfileScreen> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _aboutController;
  late TextEditingController _deliveryFeeController;
  late TextEditingController _minimumOrderController;
  late TextEditingController _deliveryTimeController;
  late TextEditingController _licenseExpiryController;

  bool _deliveryAvailable = true;

  final List<String> _availablePaymentOptions = [
    'Cash',
    'Visa',
    'Mastercard',
    'Vodafone Cash',
    'Instapay',
  ];
  List<String> _paymentMethods = [];
  List<dynamic> _workingHours = [];
  List<dynamic> _deliveryPricing = [];
  List<dynamic> _addresses = [];

  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  bool _isDataInitialized = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _aboutController = TextEditingController();
    _deliveryFeeController = TextEditingController();
    _minimumOrderController = TextEditingController();
    _deliveryTimeController = TextEditingController();
    _licenseExpiryController = TextEditingController();

    context.read<PharmacyProfileCubit>().getPharmacyProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _aboutController.dispose();
    _deliveryFeeController.dispose();
    _minimumOrderController.dispose();
    _deliveryTimeController.dispose();
    _licenseExpiryController.dispose();
    _daysController.dispose();
    _timeController.dispose();
    _cityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _initControllers(dynamic pharmacyData) {
    if (_isDataInitialized) return;

    _nameController.text = pharmacyData.pharmacyName ?? '';
    _aboutController.text = pharmacyData.about ?? '';
    _licenseExpiryController.text = pharmacyData.licenseExpiry ?? '';

    _deliveryFeeController.text =
        (pharmacyData.deliveryFee != null && pharmacyData.deliveryFee != 0)
        ? pharmacyData.deliveryFee.toString()
        : '';

    _minimumOrderController.text =
        (pharmacyData.minimumOrder != null && pharmacyData.minimumOrder != 0)
        ? pharmacyData.minimumOrder.toString()
        : '';

    _deliveryTimeController.text =
        (pharmacyData.deliveryTime != null && pharmacyData.deliveryTime != "0")
        ? pharmacyData.deliveryTime
        : '';

    // بنجيبها من السيرفر أول ما الصفحة تفتح بس
    _deliveryAvailable = pharmacyData.deliveryAvailable ?? true;

    _paymentMethods = List<String>.from(pharmacyData.paymentMethods ?? []);
    _workingHours = List<dynamic>.from(pharmacyData.workingHours ?? []);
    _deliveryPricing = List<dynamic>.from(pharmacyData.deliveryPricing ?? []);
    _addresses = List<dynamic>.from(pharmacyData.addresses ?? []);

    _isDataInitialized = true;
  }

  Future<void> _selectExpiryDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _licenseExpiryController.text =
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  void _showPaymentMethodsDropdown() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Select Payment Methods'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _availablePaymentOptions.map((method) {
                    bool isSelected = _paymentMethods.contains(method);
                    return CheckboxListTile(
                      title: Text(method),
                      value: isSelected,
                      activeColor: ColorManager.primary,
                      onChanged: (bool? value) {
                        setDialogState(() {
                          if (value == true) {
                            _paymentMethods.add(method);
                          } else {
                            _paymentMethods.remove(method);
                          }
                        });
                        setState(() {});
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Done'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Pharmacy Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.close : Icons.edit),
            onPressed: () => setState(() => _isEditing = !_isEditing),
          ),
        ],
      ),
      body: BlocConsumer<PharmacyProfileCubit, PharmacyProfileState>(
        listener: (context, state) {
          if (state is UpdatePharmacySettingsSuccess ||
              state is UpdatePharmacyProfileSuccess) {
            setState(() {
              _isEditing = false;
              _isDataInitialized = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile updated successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is UpdatePharmacyProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error.message),
                backgroundColor: ColorManager.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PharmacyProfileLoading ||
              state is UpdatePharmacyProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.primary),
            );
          }

          dynamic pharmacyData;
          if (state is UpdatePharmacyProfileSuccess) {
            pharmacyData = state.profile.data;
          } else if (state is PharmacyProfileSuccess) {
            pharmacyData = state.profile.data;
          }

          if (pharmacyData == null && state is PharmacyProfileError) {
            return Center(
              child: Text(
                state.error.message,
                style: getMediumStyle(color: ColorManager.error, fontSize: 14),
              ),
            );
          }

          if (pharmacyData == null) {
            return const Center(child: Text('No Profile Data Available'));
          }

          _initControllers(pharmacyData);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.local_pharmacy,
                      size: 60,
                      color: ColorManager.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _nameController.text,
                    style: getBoldStyle(color: Colors.black, fontSize: 20),
                  ),
                  const SizedBox(height: 20),

                  if (_isEditing)
                    _buildEditForm()
                  else
                    _buildProfileDetailsView(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileDetailsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('About'),
        _buildCardContainer(
          child: Text(
            _aboutController.text,
            style: getRegularStyle(color: Colors.black87, fontSize: 14),
          ),
        ),
        const SizedBox(height: 16),

        _buildSectionTitle('Working Hours'),
        _buildCardContainer(
          child: Column(
            children: _workingHours
                .map(
                  (wh) => ListTile(
                    title: Text(wh is Map ? wh['days'] ?? '' : wh.days ?? ''),
                    subtitle: Text(
                      wh is Map ? wh['time'] ?? '' : wh.time ?? '',
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 16),

        if (_deliveryAvailable) ...[
          _buildSectionTitle('Delivery Pricing by City'),
          _buildCardContainer(
            child: _deliveryPricing.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'No delivery pricing added yet',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  )
                : Column(
                    children: _deliveryPricing
                        .map(
                          (dp) => ListTile(
                            title: Text(
                              dp is Map ? dp['city'] ?? '' : dp.city ?? '',
                            ),
                            trailing: Text(
                              '${dp is Map ? dp['price'] : dp.price} EGP',
                              style: getBoldStyle(
                                color: ColorManager.primary,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
          const SizedBox(height: 16),
        ],
        _buildSectionTitle('Payment Methods'),
        _buildCardContainer(
          child: Wrap(
            spacing: 8,
            children: _paymentMethods
                .map((method) => Chip(label: Text(method)))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildEditForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Pharmacy Name'),
        CustomTextField(
          controller: _nameController,
          text: 'Pharmacy Name',
          validator: (v) => v!.isEmpty ? 'Enter name' : null,
        ),
        const SizedBox(height: 12),

        _buildFieldLabel('License Expiry Date'),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _selectExpiryDate(context),
          child: AbsorbPointer(
            child: CustomTextField(
              controller: _licenseExpiryController,
              text: 'License Expiry Date',
              validator: (v) => v!.isEmpty ? 'Select expiry date' : null,
            ),
          ),
        ),
        const SizedBox(height: 12),

        SwitchListTile(
          title: const Text(
            'Delivery Available',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          value: _deliveryAvailable,
          activeColor: ColorManager.primary,
          onChanged: (value) {
            setState(() {
              _deliveryAvailable = value;
            });
          },
        ),
        const SizedBox(height: 12),

        if (_deliveryAvailable) ...[
          _buildFieldLabel('Delivery Fee'),
          CustomTextField(
            controller: _deliveryFeeController,
            text: 'Delivery Fee',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),

          _buildFieldLabel('Minimum Order'),
          CustomTextField(
            controller: _minimumOrderController,
            text: 'Minimum Order',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),

          _buildFieldLabel('Delivery Time'),
          CustomTextField(
            controller: _deliveryTimeController,
            text: 'Delivery Time',
          ),
          const SizedBox(height: 12),

          _buildSectionTitle('Delivery Pricing by City'),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _cityController,
                  text: 'City Name',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomTextField(
                  controller: _priceController,
                  text: 'Price',
                  keyboardType: TextInputType.number,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle, color: ColorManager.primary),
                onPressed: () {
                  if (_cityController.text.isNotEmpty &&
                      _priceController.text.isNotEmpty) {
                    setState(() {
                      _deliveryPricing.add({
                        "city": _cityController.text,
                        "price": int.parse(_priceController.text),
                      });
                      _cityController.clear();
                      _priceController.clear();
                    });
                  }
                },
              ),
            ],
          ),
          ..._deliveryPricing.map(
            (dp) => ListTile(
              title: Text(dp is Map ? dp['city'] : dp.city),
              subtitle: Text('${dp is Map ? dp['price'] : dp.price} EGP'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => setState(() => _deliveryPricing.remove(dp)),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],

        _buildSectionTitle('Working Hours'),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: _daysController,
                text: 'Days (e.g. Sat-Thu)',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                controller: _timeController,
                text: 'Time (e.g. 8AM-12AM)',
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, color: ColorManager.primary),
              onPressed: () {
                if (_daysController.text.isNotEmpty &&
                    _timeController.text.isNotEmpty) {
                  setState(() {
                    _workingHours.add({
                      "days": _daysController.text,
                      "time": _timeController.text,
                    });
                    _daysController.clear();
                    _timeController.clear();
                  });
                }
              },
            ),
          ],
        ),
        ..._workingHours.map(
          (wh) => ListTile(
            title: Text(wh is Map ? wh['days'] : wh.days),
            subtitle: Text(wh is Map ? wh['time'] : wh.time),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => setState(() => _workingHours.remove(wh)),
            ),
          ),
        ),
        const SizedBox(height: 12),

        _buildFieldLabel('Payment Methods'),
        const SizedBox(height: 4),
        InkWell(
          onTap: _showPaymentMethodsDropdown,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _paymentMethods.isEmpty
                        ? 'Select Payment Methods'
                        : _paymentMethods.join(', '),
                    style: getRegularStyle(
                      color: _paymentMethods.isEmpty
                          ? Colors.grey
                          : Colors.black,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.grey),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        _buildFieldLabel('About'),
        CustomTextField(controller: _aboutController, text: 'About'),
        const SizedBox(height: 20),

        CustemButton(
          text: 'Save Changes',
          onPressed: () {
            if (_daysController.text.isNotEmpty &&
                _timeController.text.isNotEmpty) {
              _workingHours.add({
                "days": _daysController.text,
                "time": _timeController.text,
              });
              _daysController.clear();
              _timeController.clear();
            }

            if (_formKey.currentState!.validate()) {
              // 1. تحديث إعدادات التوصيل عبر الراوت المخصص للـ Settings
              context.read<PharmacyProfileCubit>().updatePharmacySettings(
                body: {"deliveryAvailable": _deliveryAvailable},
              );

              // 2. تحديث باقي بيانات البروفايل (الاسم، اللينك، أوقات العمل، إلخ...)
              context.read<PharmacyProfileCubit>().updatePharmacyProfile(
                body: {
                  "name": _nameController.text,
                  "about": _aboutController.text,
                  "deliveryFee":
                      _deliveryAvailable &&
                          _deliveryFeeController.text.isNotEmpty
                      ? int.parse(_deliveryFeeController.text)
                      : 0,
                  "minimumOrder":
                      _deliveryAvailable &&
                          _minimumOrderController.text.isNotEmpty
                      ? int.parse(_minimumOrderController.text)
                      : 0,
                  "deliveryTime": _deliveryAvailable
                      ? _deliveryTimeController.text
                      : "",
                  "licenseExpiry": _licenseExpiryController.text,
                  "paymentMethods": _paymentMethods,
                  "workingHours": _workingHours
                      .map(
                        (e) => e is Map
                            ? {"days": e['days'], "time": e['time']}
                            : {"days": e.days, "time": e.time},
                      )
                      .toList(),
                  "deliveryPricing": _deliveryAvailable
                      ? _deliveryPricing
                            .map(
                              (e) => e is Map
                                  ? {"city": e['city'], "price": e['price']}
                                  : {"city": e.city, "price": e.price},
                            )
                            .toList()
                      : [],
                  "cityDeliveryPrices": _deliveryAvailable
                      ? _deliveryPricing
                            .map(
                              (e) => e is Map
                                  ? {"city": e['city'], "price": e['price']}
                                  : {"city": e.city, "price": e.price},
                            )
                            .toList()
                      : [],
                  "addresses": _deliveryAvailable
                      ? _addresses
                            .map(
                              (e) => e is Map
                                  ? e
                                  : {
                                      "addressText": e.addressText,
                                      "location": e.location?.toMap(),
                                    },
                            )
                            .toList()
                      : [],
                },
              );
            }
          },
          isLoading: false,
        ),
      ],
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0, left: 12.0),
      child: Text(
        label,
        style: getBoldStyle(color: Colors.black87, fontSize: 13),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: getBoldStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }

  Widget _buildCardContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
