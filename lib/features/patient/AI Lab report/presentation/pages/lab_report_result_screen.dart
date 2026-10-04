import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/data/model/data.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/presentation/widget/finding_card.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/presentation/widget/health_indicator.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/presentation/widget/risk_level_banner.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/presentation/widget/summery_card.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/presentation/widget/tips_card.dart';
import 'package:flutter/material.dart';

class LabReportResultScreen extends StatelessWidget {
  final Data data;
  const LabReportResultScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        title: Text(
          'AI Lab Report Analysis',
          style: getBoldStyle(color: ColorManager.black, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: ColorManager.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Report Findings",
              style: getBoldStyle(color: ColorManager.black, fontSize: 16),
            ),
            const SizedBox(height: 12),
            FindingCard(findings: data.findings ?? []),
            const SizedBox(height: 24),
            Text(
              "Your Health Indicator",
              style: getBoldStyle(color: ColorManager.black, fontSize: 16),
            ),
            const SizedBox(height: 12),
            HealthIndicator(dangerScore: data.dangerScore ?? 0),
            const SizedBox(height: 24),
            RiskLevelBanner(
              text:
                  data.findings
                      ?.where(
                        (f) =>
                            f.status?.toLowerCase() != 'normal' &&
                            f.interpretation != null,
                      )
                      .map((f) => f.interpretation!)
                      .join('\n\n') ??
                  'All Results Are Normal',
            ),
            const SizedBox(height: 24),
            if (data.summary != null && data.summary!.isNotEmpty) ...[
              SummeryCard(summary: data.summary ?? ""),
              const SizedBox(height: 24),
            ],
            if (data.tips != null && data.tips!.isNotEmpty) ...[
              TipsCard(tips: data.tips ?? []),
              const SizedBox(height: 24),
            ],
          ],
        ),
      ),
    );
  }
}
