import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:flutter/material.dart';

class TipsCard extends StatelessWidget {
  final List<String> tips;
  const TipsCard({super.key, required this.tips});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: ColorManager.gold, width: 1),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(60),
            blurRadius: 10,
            offset: Offset(2, 10),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset("assets/images/star 1.png", width: 70, height: 70),
              const SizedBox(width: 10),
              Text(
                'What can you do?',
                style: getBoldStyle(color: ColorManager.black, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            children: tips.map((tip) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '• ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        tip,
                        style: getRegularStyle(
                          color: ColorManager.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
