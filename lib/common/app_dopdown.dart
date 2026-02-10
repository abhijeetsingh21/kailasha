import 'package:flutter/material.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';

class AppDropdown<T> extends StatefulWidget {
  final List<String>? list;
  final String? hintText;
  final void Function(String? value) callback;
  final String? selectedValue;
  final TextStyle? textStyle;

  const AppDropdown({
    super.key,
    required this.list,
    required this.callback,
    this.hintText,
    this.selectedValue,
    this.textStyle,
  });

  @override
  State<AppDropdown<T>> createState() => _AppDropdownState<T>();
}

class _AppDropdownState<T> extends State<AppDropdown<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.selectedValue;
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_overlayEntry == null) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height - 10.heightMultiplier),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8.radiusMultiplier),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white100,
                  borderRadius: BorderRadius.circular(8.radiusMultiplier),
                  border: Border.all(color: AppColors.borderColor),
                ),
                constraints: BoxConstraints(maxHeight: 220.heightMultiplier),
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: widget.list!
                      .map(
                        (item) => InkWell(
                          onTap: () {
                            setState(() => dropdownValue = item);
                            widget.callback(item);
                            _removeOverlay();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.widthMultiplier,
                              vertical: 12.heightMultiplier,
                            ),
                            child: Text(
                              item,
                              style:
                                  widget.textStyle ??
                                  CustomTextStyle.size14W500(
                                    color: AppColors.text1,
                                  ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10.widthMultiplier,
            vertical: 12.heightMultiplier,
          ),
          decoration: BoxDecoration(
            color: AppColors.white100,
            borderRadius: BorderRadius.circular(8.radiusMultiplier),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  dropdownValue ?? widget.hintText ?? '',
                  style:
                      widget.textStyle ??
                      CustomTextStyle.size14W500(color: AppColors.text1),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.greyShade,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
