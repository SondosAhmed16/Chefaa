import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:flutter/material.dart';

class PatientAdvice extends StatelessWidget {
  final String text;
  const PatientAdvice({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ColorManager.input,
        borderRadius: BorderRadius.circular(30),
        shape: BoxShape.rectangle,
        border: Border.all(color: ColorManager.gold, width: 2),
        boxShadow: const [
          BoxShadow(
            color: ColorManager.gray,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset("assets/images/star 1.png", width: 30),
          const SizedBox(width: 32),
          Expanded(
            child: Text(text, style: getMediumStyle(color: ColorManager.black)),
          ),
        ],
      ),
    );
  }
}
