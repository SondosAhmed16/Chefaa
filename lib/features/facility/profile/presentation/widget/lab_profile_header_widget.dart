import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/font.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/facility/profile/data/model/profile_data.dart';
import 'package:flutter/material.dart';

class LabProfileHeaderWidget extends StatelessWidget {
  final ProfileData profile;
  final VoidCallback? onEditPressed;
  final VoidCallback? onBackPressed;

  const LabProfileHeaderWidget({
    Key? key,
    required this.profile,
    this.onEditPressed,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final facilityType = profile.facilityType?.toLowerCase() ?? '';
    final isHomeServiceAvailable =
        profile.settings?.homeSampleCollection ?? false;
    final servicesCount = profile.servicesCount ?? 0;
    return Container(
      width: double.infinity,
      color: ColorManager.primary,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: ColorManager.white.withOpacity(0.2),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: ColorManager.white,
                        size: 18,
                      ),
                      onPressed:
                          onBackPressed ?? () => Navigator.maybePop(context),
                    ),
                  ),
                  InkWell(
                    onTap: onEditPressed,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Edit',
                        style: getBoldStyle(
                          color: ColorManager.white,
                          fontSize: FontSize.s14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Text(
                profile.name ?? '',
                textAlign: TextAlign.center,
                style: getBoldStyle(
                  color: ColorManager.white,
                  fontSize: FontSize.s20,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                profile.addresses?.isNotEmpty == true
                    ? profile.addresses!.first.addressText ?? ''
                    : '',
                textAlign: TextAlign.center,
                style: getMediumStyle(
                  color: ColorManager.white.withOpacity(0.8),
                  fontSize: FontSize.s13,
                ),
              ),

              const SizedBox(height: 16),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  if (facilityType == 'lab' || facilityType == 'both')
                    _buildBadge('Lab'),
                  if (facilityType == 'radiology center' ||
                      facilityType == 'both')
                    _buildBadge('Radiology'),
                  if (isHomeServiceAvailable) _buildBadge('Home service'),
                  if (servicesCount != 0)
                    _buildBadge("${servicesCount} Services"),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: ColorManager.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: getMediumStyle(color: ColorManager.white, fontSize: 12),
      ),
    );
  }
}
