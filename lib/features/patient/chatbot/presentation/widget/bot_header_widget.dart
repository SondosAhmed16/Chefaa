import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BotHeaderWidget extends StatelessWidget {
  const BotHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: ColorManager.lightBlue, width: 1.5),
            color: ColorManager.white,
          ),
          child: CircleAvatar(
            backgroundColor: ColorManager.transparent,
            child: Image.asset('assets/images/bot.png', fit: BoxFit.contain),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('👋 ', style: TextStyle(fontSize: 20)),
            Text(
              "Welcome, I'm Chefaa\nAssistant",
              textAlign: TextAlign.center,
              style: getBoldStyle(
                color: ColorManager.black,
                fontSize: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            "I'm here to help you get your medications\nand medical consultations easily.",
            textAlign: TextAlign.center,
            style: getRegularStyle(
              color: ColorManager.gray,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                icon: Icons.medical_services_outlined,
                title: 'Ask about\nmedication',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                icon: Icons.add_box_outlined,
                title: 'Talk to a\npharmacist',
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildActionCard({required IconData icon, required String title}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: ColorManager.sky50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManager.lightBlue100),
      ),
      child: Column(
        children: [
          Icon(icon, color: ColorManager.primary, size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: getBoldStyle(
              color: ColorManager.primary,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}