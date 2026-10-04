import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:flutter/material.dart';

class RiskLevelBanner extends StatelessWidget {
  final String text;
  const RiskLevelBanner({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(25),
        border: Border(
          left: BorderSide(color: ColorManager.gold, width: 10),
          
        
        ),

        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(60),
            blurRadius: 10,
            offset: Offset(2, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/images/risk_level.png", width: 70, height: 70),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Risk Level",
                  style: getBoldStyle(color: ColorManager.black, fontSize: 14),
                ),

                const SizedBox(height: 5),
                Text(
                  text,
                  style: getRegularStyle(
                    color: ColorManager.gray600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
