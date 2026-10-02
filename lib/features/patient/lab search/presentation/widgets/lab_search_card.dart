import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/lab%20search/presentation/widgets/get_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:chefaa/features/patient/lab%20search/data/model/center.dart';

class LabSearchCard extends StatelessWidget {
  final CenterModel center;
  final VoidCallback onTap;
  const LabSearchCard({super.key, required this.center, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final String tag = center.badge ?? "";

    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManager.input, width: 1),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(10),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      clipBehavior: Clip.antiAlias,
      child: Material(
        color: ColorManager.transparent,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              PositionedDirectional(
                start: 0,
                top: 0,
                bottom: 0,
                child: Container(width: 5, color: tag.toTagTextColor),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 17,
                  top: 12,
                  right: 12,
                  bottom: 12,
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(25),
                      child: Image.asset(
                        center.imagePath,
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            center.name ?? "",
                            style: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            center.distance ?? "",
                            style: getRegularStyle(
                              color: ColorManager.gray,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(
                                Icons.star_rate_rounded,
                                color: ColorManager.gold,
                                size: 15,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                (center.rating ?? 0).toString(),
                                style: getSemiBoldStyle(
                                  color: ColorManager.gray,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (tag.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: tag.toTagBackgroundColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              tag,
                              style: getBoldStyle(
                                color: tag.toTagTextColor,
                                fontSize: 10,
                              ),
                            ),
                          ),

                        const SizedBox(height: 20),
                        Text(
                          "EGP${center.minPrice ?? 0}",
                          style: getBoldStyle(
                            color: ColorManager.primary,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension TagColorExtension on String {
  Color get toTagBackgroundColor {
    switch (toUpperCase()) {
      case 'NEAREST':
        return ColorManager.lightBlue100;
      case 'CHEAPEST':
        return ColorManager.green100;
      case 'TOP RATED':
        return ColorManager.amber100;
      case 'FASTEST':
        return ColorManager.mint100;
      default:
        return ColorManager.lightGray;
    }
  }

  Color get toTagTextColor {
    switch (toUpperCase()) {
      case 'NEAREST':
        return ColorManager.blue600;
      case 'CHEAPEST':
        return ColorManager.green600;
      case 'TOP RATED':
        return ColorManager.amber600;
      case 'FASTEST':
        return ColorManager.mint600;
      default:
        return ColorManager.darkGray;
    }
  }
}
