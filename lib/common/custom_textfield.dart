import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kailasha/common/clickable_button.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';
class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final AutovalidateMode? autovalidateMode;
  final Widget? prefixIcon;
  final bool obscureText;
  final bool isPasswordField;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? hintTextStyle;
  final double? borderRadius;
  final Color? borderColor;
  final bool? readOnly;
  final double? height;
  final Color? backgroundColor;
  final void Function()? onTap;
  final TextStyle? textStyle;
  final bool? useLabelText;
  final int? maxlines;
  final int? maxLength;
  final Color? cursorColor;
  final double? cursorHeight;
  final double? cursorWidth;
  final bool? textCapitalization;
  final String? errorText;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? prefixIconPadding;
  final EdgeInsetsGeometry? suffixIconPadding;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final Color? errorBackgroundColor;
  final void Function(String)? onFieldSubmitted;
  final Widget? suffix;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.autovalidateMode,
    this.obscureText = false,
    this.isPasswordField = false, // default false
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.inputFormatters,
    this.hintTextStyle,
    this.borderRadius,
    this.borderColor,
    this.readOnly,
    this.height,
    this.backgroundColor,
    this.onTap,
    this.textStyle,
    this.useLabelText = true,
    this.maxlines,
    this.maxLength,
    this.cursorColor,
    this.cursorHeight,
    this.cursorWidth,
    this.textCapitalization,
    this.errorText,
    this.suffixIcon,
    this.prefixIconConstraints,
    this.prefixIconPadding,
    this.suffixIconPadding,
    this.suffixIconConstraints,
    this.errorBackgroundColor,
    this.onFieldSubmitted,
    this.suffix,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final ValueNotifier<bool> _obscureNotifier;

  @override
  void initState() {
    super.initState();
    _obscureNotifier = ValueNotifier<bool>(widget.obscureText);
  }

  @override
  void dispose() {
    _obscureNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureNotifier,
      builder: (context, obscureValue, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: widget.height,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? 8.radiusMultiplier,
                ),
              ),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.top,
                onFieldSubmitted: widget.onFieldSubmitted,
                maxLength: widget.maxLength,
                cursorColor: widget.cursorColor ?? AppColors.primary3,
                textCapitalization: widget.textCapitalization == true
                    ? TextCapitalization.sentences
                    : TextCapitalization.none,
                cursorHeight: widget.cursorHeight,
                cursorWidth: widget.cursorWidth ?? 2.0,
                maxLines: widget.maxlines,
                readOnly: widget.readOnly ?? false,
                autovalidateMode:
                    widget.autovalidateMode ??
                    AutovalidateMode.onUserInteraction,
                inputFormatters: widget.inputFormatters,
                controller: widget.controller,
                obscureText: widget.isPasswordField
                    ? obscureValue
                    : widget.obscureText,
                keyboardType: widget.keyboardType,
                validator: widget.validator,
                onChanged: widget.onChanged,
                onTap: widget.onTap,
                style:
                    widget.textStyle ??
                    CustomTextStyle.size13W600(color: AppColors.black100),
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  errorMaxLines: 3,
                  suffix: widget.suffix,
                  prefixIconConstraints:
                      widget.prefixIconConstraints ??
                      BoxConstraints(
                        maxHeight: 40.heightMultiplier,
                        maxWidth: 40.widthMultiplier,
                      ),
                  prefixIcon: widget.prefixIcon != null
                      ? Padding(
                          padding:
                              widget.prefixIconPadding ??
                              EdgeInsets.only(left: 8.widthMultiplier),
                          child: widget.prefixIcon,
                        )
                      : null,
                  suffixIconConstraints:
                      widget.suffixIconConstraints ??
                      BoxConstraints(
                        maxHeight: 40.heightMultiplier,
                        maxWidth: 40.widthMultiplier,
                      ),
                  // Password toggle logic
                  suffixIcon: widget.isPasswordField
                      ? Padding(
                          padding:
                              widget.suffixIconPadding ??
                              EdgeInsets.only(right: 12.widthMultiplier),
                          child: ClickableButton(
                            onTap: () => _obscureNotifier.value =
                                !_obscureNotifier.value,
                            child: Icon(
                              obscureValue
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.text2,
                            ),
                          ),
                        )
                      : (widget.suffixIcon != null
                            ? Padding(
                                padding:
                                    widget.suffixIconPadding ??
                                    EdgeInsets.only(right: 12.widthMultiplier),
                                child: widget.suffixIcon!,
                              )
                            : null),
                  filled: true,
                  fillColor: widget.backgroundColor ?? Colors.transparent,
                  labelText: widget.useLabelText == true
                      ? widget.hintText
                      : null,
                  hintText: widget.useLabelText == true
                      ? null
                      : widget.hintText,
                  labelStyle:
                      widget.hintTextStyle ??
                      CustomTextStyle.size12W600(color: AppColors.white50),
                  hintStyle:
                      widget.hintTextStyle ??
                      CustomTextStyle.size12W600(color: AppColors.text2),

                  border: border(),
                  focusedBorder: border(),
                  enabledBorder: border(),
                  disabledBorder: border(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.heightMultiplier,
                    horizontal: 12.widthMultiplier,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  OutlineInputBorder border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        widget.borderRadius ?? 8.radiusMultiplier,
      ),
      borderSide: BorderSide(
        color: widget.borderColor ?? AppColors.borderColor,
      ),
    );
  }
}
