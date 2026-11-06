import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/services/location_service.dart';
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
  late TextEditingController _addressTextController;

  bool _deliveryAvailable = true;
  bool _isFetchingLocation = false;

  double? _currentLat;
  double? _currentLng;

  // متغيرات لاختيار أوقات العمل عبر TimePicker
  TimeOfDay? _selectedOpenTime;
  TimeOfDay? _selectedCloseTime;

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
  String? _commercialRegisterNumber;

  final TextEditingController _daysController = TextEditingController();
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
    _addressTextController = TextEditingController();

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
    _addressTextController.dispose();
    _daysController.dispose();
    _cityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _initControllers(dynamic pharmacyData) {
    if (_isDataInitialized) return;

    _nameController.text = pharmacyData.pharmacyName ?? '';
    _aboutController.text = pharmacyData.about ?? '';
    _licenseExpiryController.text = pharmacyData.licenseExpiry ?? '';
    _commercialRegisterNumber = pharmacyData.commercialRegisterNumber;

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
        : '30 m';

    _deliveryAvailable = pharmacyData.deliveryAvailable ?? true;

    _paymentMethods = List<String>.from(pharmacyData.paymentMethods ?? []);
    _workingHours = List<dynamic>.from(pharmacyData.workingHours ?? []);
    _deliveryPricing = List<dynamic>.from(pharmacyData.deliveryPricing ?? []);
    _addresses = List<dynamic>.from(pharmacyData.addresses ?? []);

    if (_addresses.isNotEmpty) {
      final firstAddress = _addresses.first;
      if (firstAddress is Map) {
        _addressTextController.text = firstAddress['addressText'] ?? '';
        final coords = firstAddress['location']?['coordinates'];
        if (coords is List && coords.length >= 2) {
          _currentLng = coords[0];
          _currentLat = coords[1];
        }
      } else {
        _addressTextController.text = firstAddress.addressText ?? '';
        final coords = firstAddress.location?.coordinates;
        if (coords != null && coords.length >= 2) {
          _currentLng = coords[0];
          _currentLat = coords[1];
        }
      }
    }

    _isDataInitialized = true;
  }

  // تنسيق الوقت المختار من TimePicker
  String _formatTimeOfDay(TimeOfDay time) {
    final hours = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    final minutes = time.minute.toString().padLeft(2, '0');
    return minutes == '00' ? '$hours $period' : '$hours:$minutes $period';
  }

  Future<void> _fetchAndFillLocation() async {
    setState(() => _isFetchingLocation = true);

    final locationData = await LocationService.getLocationWithAddress();

    if (locationData != null) {
      _currentLat = locationData.lat;
      _currentLng = locationData.lng;
      _addressTextController.text = locationData.addressText ?? "";
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to get current location")),
        );
      }
    }

    setState(() => _isFetchingLocation = false);
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.local_pharmacy,
                            size: 50,
                            color: ColorManager.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _nameController.text,
                          style: getBoldStyle(color: Colors.black, fontSize: 20),
                        ),
                      ],
                    ),
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
        Text(
          'Pharmacy details',
          style: getBoldStyle(color: Colors.black, fontSize: 18),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              _buildDetailRow(
                'Working hours',
                _workingHours.isEmpty
                    ? 'Sat–Thu: 8AM–8PM'
                    : _workingHours
                          .map((wh) => wh is Map ? "${wh['days']}: ${wh['time']}" : "${wh.days}: ${wh.time}")
                          .join('\n'),
                isMultiLine: true,
              ),
              const Divider(height: 24),

              _buildDetailRow(
                'Delivery',
                _deliveryAvailable ? 'Available · ${_deliveryTimeController.text}' : 'Not Available',
                isBadge: _deliveryAvailable,
              ),
              const Divider(height: 24),

              _buildDetailRow(
                'Delivery area',
                _deliveryPricing.isEmpty
                    ? (_addressTextController.text.isNotEmpty ? _addressTextController.text : 'No area specified')
                    : _deliveryPricing
                          .map((dp) => dp is Map ? dp['city'] : dp.city)
                          .join(', '),
              ),
              const Divider(height: 24),

              _buildDetailRow(
                'Payment',
                _paymentMethods.isEmpty ? 'Cash' : _paymentMethods.join(' · '),
                isMultiLine: true,
              ),
              const Divider(height: 24),

              _buildDetailRow(
                'License',
                '#${_commercialRegisterNumber ?? 'LOP-598423'} · Valid ${_licenseExpiryController.text}',
                isBoldValue: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        Text(
          'Pharmacy Address',
          style: getBoldStyle(color: Colors.black, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            _addressTextController.text.isNotEmpty
                ? _addressTextController.text
                : 'No address added yet',
            style: getRegularStyle(color: Colors.black87, fontSize: 14),
          ),
        ),
        const SizedBox(height: 16),

        if (_aboutController.text.isNotEmpty) ...[
          Text(
            'About',
            style: getBoldStyle(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              _aboutController.text,
              style: getRegularStyle(color: Colors.black87, fontSize: 14),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isBoldValue = false,
    bool isMultiLine = false,
    bool isBadge = false,
    Color? textColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: isMultiLine ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: getRegularStyle(color: Colors.grey.shade600, fontSize: 14),
        ),
        const SizedBox(width: 16),
        Flexible(
          child: isBadge
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    value,
                    style: getMediumStyle(color: Colors.green.shade700, fontSize: 13),
                  ),
                )
              : Text(
                  value,
                  textAlign: TextAlign.end,
                  style: isBoldValue
                      ? getBoldStyle(color: textColor ?? Colors.black, fontSize: 14)
                      : getMediumStyle(color: textColor ?? Colors.black87, fontSize: 14),
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

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildFieldLabel('Pharmacy Address'),
            TextButton.icon(
              onPressed: _isFetchingLocation ? null : _fetchAndFillLocation,
              icon: _isFetchingLocation
                  ? const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(
                      Icons.my_location,
                      size: 16,
                      color: ColorManager.primary,
                    ),
              label: Text(
                'Auto-detect Location',
                style: getBoldStyle(color: ColorManager.primary, fontSize: 12),
              ),
            ),
          ],
        ),
        CustomTextField(
          controller: _addressTextController,
          text: 'Address (e.g. 123 Main Street, City)',
          validator: (v) => v!.isEmpty ? 'Enter address' : null,
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

        // قسم Working Hours المدعوم بـ TimePicker لاختيار الوقت
        _buildSectionTitle('Working Hours'),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              CustomTextField(
                controller: _daysController,
                text: 'Days (e.g. Sat-Thu)',
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (picked != null) {
                          setState(() => _selectedOpenTime = picked);
                        }
                      },
                      icon: const Icon(Icons.access_time, size: 16, color: ColorManager.primary),
                      label: Text(
                        _selectedOpenTime != null
                            ? _formatTimeOfDay(_selectedOpenTime!)
                            : 'Open Time',
                        style: getMediumStyle(
                          color: _selectedOpenTime != null ? Colors.black : Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('to', style: TextStyle(color: Colors.grey)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (picked != null) {
                          setState(() => _selectedCloseTime = picked);
                        }
                      },
                      icon: const Icon(Icons.access_time, size: 16, color: ColorManager.primary),
                      label: Text(
                        _selectedCloseTime != null
                            ? _formatTimeOfDay(_selectedCloseTime!)
                            : 'Close Time',
                        style: getMediumStyle(
                          color: _selectedCloseTime != null ? Colors.black : Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_daysController.text.isNotEmpty &&
                        _selectedOpenTime != null &&
                        _selectedCloseTime != null) {
                      final timeString = "${_formatTimeOfDay(_selectedOpenTime!)} - ${_formatTimeOfDay(_selectedCloseTime!)}";
                      setState(() {
                        _workingHours.add({
                          "days": _daysController.text.trim(),
                          "time": timeString,
                        });
                        _daysController.clear();
                        _selectedOpenTime = null;
                        _selectedCloseTime = null;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select days, open time, and close time')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: Text(
                    'Add Working Hours',
                    style: getBoldStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (_workingHours.isNotEmpty) ...[
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _workingHours.length,
            itemBuilder: (context, index) {
              final wh = _workingHours[index];
              final days = wh is Map ? wh['days'] : wh.days;
              final time = wh is Map ? wh['time'] : wh.time;
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time_filled, color: ColorManager.primary, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            days ?? '',
                            style: getBoldStyle(color: Colors.black87, fontSize: 14),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            time ?? '',
                            style: getRegularStyle(color: Colors.grey.shade600, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => setState(() => _workingHours.removeAt(index)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
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

        // حقل الـ About بحجم كبير ومتعدد الأسطر
        _buildFieldLabel('About'),
        TextField(
          controller: _aboutController,
          maxLines: 4,
          minLines: 3,
          decoration: InputDecoration(
            hintText: 'Write something about your pharmacy...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: ColorManager.primary),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        const SizedBox(height: 20),

        CustemButton(
          text: 'Save Changes',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<PharmacyProfileCubit>().updatePharmacySettings(
                body: {"deliveryAvailable": _deliveryAvailable},
              );

              final updatedAddresses = [
                {
                  "addressText": _addressTextController.text.trim(),
                  "location": {
                    "type": "Point",
                    "coordinates": [
                      _currentLng ?? -122.074,
                      _currentLat ?? 37.4219973,
                    ],
                  },
                },
              ];

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
                  "addresses": updatedAddresses,
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
}