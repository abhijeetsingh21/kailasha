import 'package:flutter/material.dart';
import 'package:kailasha/common/clickable_button.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';

class CustomGradientButtonProps {
  final void Function() onTap;
  final String? title;
  final TextStyle? titleStyle;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool? isInfiniteWidth;
  final double? width;
  final double? height;
  final Widget? child;

  const CustomGradientButtonProps({
    required this.onTap,
    this.title,
    this.titleStyle,
    this.borderRadius,
    this.padding,
    this.isInfiniteWidth = false,
    this.width,
    this.height,
    this.child,
  });
}

class CustomGradientButton extends StatefulWidget {
  const CustomGradientButton({required this.props, super.key});
  final CustomGradientButtonProps props;

  @override
  State<CustomGradientButton> createState() => _CustomGradientButtonState();
}

class _CustomGradientButtonState extends State<CustomGradientButton> {
  bool _internalLoading = false;

  bool get _isLoading => _internalLoading;

  Future<void> _handleTap() async {
    if (_isLoading) return;

    final Function() action = widget.props.onTap;

    // async function support
    if (action is Future Function()) {
      setState(() => _internalLoading = true);
      try {
        await action();
      } finally {
        if (mounted) {
          setState(() => _internalLoading = false);
        }
      }
    } else {
      action();
    }
  }

  @override
  Widget build(BuildContext context) {
    final props = widget.props;

    return ClickableButton(
      onTap: _handleTap,
      child: Container(
        height: props.height,
        width: (props.isInfiniteWidth == true)
            ? double.infinity
            : (props.width),
        padding:
            props.padding ??
            EdgeInsets.symmetric(
              horizontal: 24.widthMultiplier,
              vertical: 10.heightMultiplier,
            ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            props.borderRadius ?? 28.radiusMultiplier,
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.textgradient,
          ),
        ),
        child: Center(
          child: _isLoading
              ? SizedBox(
                  height: 12.heightMultiplier,
                  width: 12.widthMultiplier,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.white100,
                  ),
                )
              : props.child ??
                    Text(
                      props.title ?? '',
                      style:
                          props.titleStyle ??
                          CustomTextStyle.customW500(
                            fontSize: 12,
                            color: AppColors.white100,
                          ),
                    ),
        ),
      ),
    );
  }
}
