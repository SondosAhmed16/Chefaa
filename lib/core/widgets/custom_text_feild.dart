import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

enum _TextFieldVisualState { empty, valid, error }

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.controller,
    required this.text,
    this.validator,
    this.onChanged,
    this.isPass = false,
    this.isReadOnly = false,
    this.rec = false,
    this.keyboardType,
    this.prefixIcon,
    this.inputFormatters,
    this.textInputAction,
    this.onPressMic,
    this.isSearch=false ,
      this.onPressSearch,
  }) : isObscureNotifier = ValueNotifier<bool>(isPass);

  final TextEditingController controller;
  final String text;
  final String? Function(String? value)? validator;
  final Function(String)? onChanged;
  final bool isPass;
  final bool isSearch;
  final bool isReadOnly;
  final bool rec;
  final TextInputType? keyboardType;
  final String? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final VoidCallback? onPressMic;
  final void Function()? onPressSearch;

  final ValueNotifier<bool> isObscureNotifier;

  _TextFieldVisualState _resolveState(String value) {
    if (value.trim().isEmpty) {
      return _TextFieldVisualState.empty;
    }
    final errorMessage = validator?.call(value);
    return errorMessage == null
        ? _TextFieldVisualState.valid
        : _TextFieldVisualState.error;
  }

  Color _resolveColor(_TextFieldVisualState state) {
    if (isReadOnly) {
      return ColorManager.gray;
    }
    switch (state) {
      case _TextFieldVisualState.empty:
        return ColorManager.gray;
      case _TextFieldVisualState.valid:
        return ColorManager.primary;
      case _TextFieldVisualState.error:
        return ColorManager.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(50);

    return ValueListenableBuilder<bool>(
      valueListenable: isObscureNotifier,
      builder: (context, isObscure, _) {
        return ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, _) {
            final visualState = _resolveState(value.text);
            final currentColor = _resolveColor(visualState);

            return TextFormField(
              controller: controller,
              readOnly: isReadOnly,
              textInputAction: textInputAction,
              keyboardType: keyboardType,
              obscureText: isObscure,
              onChanged: onChanged,
              inputFormatters: inputFormatters,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validator,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              style: getRegularStyle(color: ColorManager.black, fontSize: 16),
              decoration: InputDecoration(
                fillColor: ColorManager.white,
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                hintText: text,
                hintStyle: getRegularStyle(
                  color: ColorManager.gray,
                  fontSize: 16,
                ),
                prefixIcon: prefixIcon != null
                    ? Padding(
                        padding: EdgeInsets.only(left: 20, right: 12),
                        child: SvgPicture.asset(
                          prefixIcon!,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            currentColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      )
                    : null,
                prefixIconConstraints: BoxConstraints(minWidth: 50),
                enabledBorder: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(color: currentColor, width: 1.2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(color: currentColor, width: 1.5),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(color: ColorManager.error, width: 1.2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(color: ColorManager.error, width: 1.5),
                ),
                errorStyle: getMediumStyle(
                  color: ColorManager.error,
                  fontSize: 12,
                ),
                suffixIcon: _buildSuffixIcon(isObscure),
              ),
            );
          },
        );
      },
    );
  }

  Widget? _buildSuffixIcon(bool isObscure) {
    if (isPass) {
      return IconButton(
        icon: Icon(
          isObscure ? Icons.visibility_off : Icons.visibility,
          color: ColorManager.gray,
        ),
        onPressed: () {
          isObscureNotifier.value = !isObscureNotifier.value;
        },
      );
    }
    if (rec) {
      return IconButton(
        icon: const Icon(Icons.mic_none_outlined, color: ColorManager.primary),
        onPressed: onPressMic,
      );
    }
    return null;
  }
}
