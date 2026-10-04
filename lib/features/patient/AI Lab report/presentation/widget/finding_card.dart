import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/data/model/finding.dart';
import 'package:flutter/material.dart';

class FindingCard extends StatelessWidget {
  final List<Finding> findings;
  const FindingCard({super.key, required this.findings});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: ColorManager.gray, width: 1),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(60),
            blurRadius: 10,
            offset: Offset(2, 10),
          ),
        ],
      ),
      child: Column(
        children: findings.map((finding) {
          final isLast = findings.last == finding;
          final statusColor = _getStatusColor(finding.status);
          final statusBgColor = _getStatusBgColor(finding.status);
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          finding.testName ?? '',
                          style: getBoldStyle(
                            color: ColorManager.black,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${finding.result ?? ''} ${finding.unit ?? ''}'
                              .trim(),
                          style: getMediumStyle(
                            color: statusColor,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusBgColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      finding.status ?? 'Normal',
                      style: getBoldStyle(color: statusColor, fontSize: 12),
                    ),
                  ),
                ],
              ),
              if (!isLast) const Divider(height: 24, thickness: 1),
            ],
          );
        }).toList(),
      ),
    );
  }
}

Color _getStatusColor(String? status) {
  switch (status?.toLowerCase()) {
    case 'high':
      return ColorManager.error;
    case 'pre-risk':
    case 'warning':
      return ColorManager.amber600;
    case 'normal':
    default:
      return ColorManager.lightGreen;
  }
}

Color _getStatusBgColor(String? status) {
  switch (status?.toLowerCase()) {
    case 'high':
      return const Color(0xFFFFEBEE);
    case 'pre-risk':
    case 'warning':
      return const Color(0xFFFFF8E1);
    case 'normal':
    default:
      return const Color(0xFFE8F5E9);
  }
}
