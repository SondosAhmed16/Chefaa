import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:flutter/material.dart';

enum DialogType { success, fail, validation, verification }

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.title,
    required this.message,
    required this.type,
    this.buttonText,
    this.onPressed,
  });

  final String title;
  final String message;
  final DialogType type;
  final String? buttonText;
  final VoidCallback? onPressed;

  _DialogConfig _getConfig() {
    switch (type) {
      case DialogType.success:
        return _DialogConfig(
          icon: Icons.check_circle_outline_rounded,
          color: Colors.green,
        );
      case DialogType.fail:
        return _DialogConfig(
          icon: Icons.error_outline_rounded,
          color: ColorManager.error,
        );
      case DialogType.validation:
        return _DialogConfig(
          icon: Icons.warning_amber_rounded,
          color: Colors.orange,
        );
      case DialogType.verification:
        return _DialogConfig(
          icon: Icons.access_time_rounded,
          color: Colors.grey,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = _getConfig();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 45, bottom: 20, left: 20, right: 20),
            margin: const EdgeInsets.only(top: 35),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: getBoldStyle(color: ColorManager.black, fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: getRegularStyle(
                    color: ColorManager.gray,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: config.color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (onPressed != null) onPressed!();
                    },
                    child: Text(
                      buttonText ?? 'Ok',
                      style: getMediumStyle(
                        color: ColorManager.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 35,
            backgroundColor: config.color,
            child: Icon(config.icon, size: 40, color: ColorManager.white),
          ),
        ],
      ),
    );
  }
}

class _DialogConfig {
  final IconData icon;
  final Color color;

  _DialogConfig({required this.icon, required this.color});
}