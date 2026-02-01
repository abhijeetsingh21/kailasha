import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/services.dart';
import 'package:kailasha/common/custom_textfield.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';
import 'package:kailasha/core/utils/validators.dart';

class CustomPhoneTextField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String fullNumber)? onChanged;
  final String hintText;
  final bool? showLabel;

  const CustomPhoneTextField({
    super.key,
    required this.controller,
    this.onChanged,
    this.hintText = 'Mobile Number',
    this.showLabel = true,
  });

  @override
  State<CustomPhoneTextField> createState() => _CustomPhoneTextFieldState();
}

class _CustomPhoneTextFieldState extends State<CustomPhoneTextField> {
  Country _selectedCountry = CountryParser.parseCountryCode('IN');

  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      useSafeArea: true,
      onSelect: (country) {
        setState(() {
          _selectedCountry = country;
        });
        _emitFullNumber(widget.controller.text);
      },
    );
  }

  void _emitFullNumber(String number) {
    if (widget.onChanged != null) {
      widget.onChanged!('+${_selectedCountry.phoneCode}$number');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Expanded(
        //   flex: 1,
        //   child: CommonContainer(
        //     borderRadius: 8.radiusMultiplier,
        //     padding: EdgeInsets.symmetric(
        //       horizontal: 12.widthMultiplier,
        //       vertical: 6.heightMultiplier,
        //     ),
        //     borderColor: AppColors.borderColor,
        //     child: ClickableButton(
        //       onTap: _openCountryPicker,
        //       child: Row(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           Text(
        //             _selectedCountry.flagEmoji,
        //             style: CustomTextStyle.customW600(fontSize: 25),
        //           ),
        //           2.horizontalSpace,
        //           Icon(
        //             Icons.arrow_drop_down,
        //             size: 25.heightMultiplier,
        //             color: AppColors.black100,
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        // 10.horizontalSpace,
        Expanded(
          flex: 3,
          child: CustomTextField(
            controller: widget.controller,
            hintText: widget.hintText,
            useLabelText: widget.showLabel,
            textStyle: CustomTextStyle.size13W600(color: AppColors.black100),
            keyboardType: TextInputType.phone,
            validator: validatePhoneNumber,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
            onChanged: _emitFullNumber,
            prefixIconConstraints: BoxConstraints(
              maxHeight: 40.heightMultiplier,
              maxWidth: 50.widthMultiplier,
            ),
            prefixIcon: Row(
              children: [
                6.horizontalSpace,
                Text(
                  '+${_selectedCountry.phoneCode}',
                  style: CustomTextStyle.size13W600(color: AppColors.black100),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
