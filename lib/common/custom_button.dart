import 'package:flutter/material.dart';
import 'package:kailasha/common/clickable_button.dart';
import 'package:kailasha/models/custom_button_props_model/custom_button_props_model.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';
class CustomButton extends StatefulWidget {
  final CustomButtonPropsModel props;

  const CustomButton({super.key, required this.props});

  @override
  State<CustomButton> createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButton> {
  bool _internalLoading = false;

  bool get _isLoading => widget.props.isLoading || _internalLoading;

  Future<void> _handleTap() async {
    if (widget.props.isDisabled || _isLoading) return;

    final Function() action = widget.props.onPressed;

    // async function
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

    Widget content = _isLoading
        ? SizedBox(
            height: 10.heightMultiplier,
            width: 10.widthMultiplier,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: props.progressColor ?? AppColors.white100,
              ),
            ),
          )
        : props.child ??
              Center(
                child: props.textGradientColors != null
                    ? ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: props.textGradientColors!,
                        ).createShader(bounds),
                        child: Text(
                          props.text ?? '',
                          style:
                              (props.textStyle ?? CustomTextStyle.size18W600())
                                  .copyWith(color: Colors.white),
                        ),
                      )
                    : Text(
                        props.text ?? '',
                        style:
                            props.textStyle ??
                            CustomTextStyle.size14W600(
                              color: props.textColor ?? AppColors.white100,
                            ),
                      ),
              );

    Widget button = Container(
      padding: props.padding,
      width: props.width ?? double.infinity,
      height: props.height ?? 55.heightMultiplier,
      clipBehavior: Clip.hardEdge,
      decoration:
          props.boxDecoration ??
          BoxDecoration(
            borderRadius: BorderRadius.circular(
              props.radius ?? 8.radiusMultiplier,
            ),
            border: Border.all(
              color: props.borderGradientColors == null
                  ? (props.borderColor ?? AppColors.trasnparent)
                  : Colors.transparent,
              width: props.borderWidth ?? 1.widthMultiplier,
            ),
            color: props.backgroundColor ?? AppColors.primary,
          ),
      child: content,
    );

    if (props.borderGradientColors != null) {
      button = Container(
        padding: EdgeInsets.all(props.borderWidth ?? 1.widthMultiplier),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: props.borderGradientColors!),
          borderRadius: BorderRadius.circular(
            props.radius ?? 8.radiusMultiplier,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            props.radius ?? 8.radiusMultiplier,
          ),
          child: button,
        ),
      );
    }

    return ClickableButton(
      onTap: _handleTap,
      child: Opacity(opacity: props.isDisabled ? 0.6 : 1, child: button),
    );
  }
}
