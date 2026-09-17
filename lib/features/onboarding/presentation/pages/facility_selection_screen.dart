import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FacilitySelectionScreen extends StatefulWidget {
  const FacilitySelectionScreen({super.key});

  @override
  State<FacilitySelectionScreen> createState() =>
      _FacilitySelectionScreenState();
}

class _FacilitySelectionScreenState extends State<FacilitySelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: SafeArea(
        child: Column(
          children: [const CustomHeader(), const SizedBox(height: 32)],
        ),
      ),
    );
  }
}
