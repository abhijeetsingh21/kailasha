import 'package:flutter/material.dart';
import 'package:kailasha/common/common_container.dart';
import 'package:kailasha/common/clickable_button.dart';
import 'package:kailasha/common/custom_textfield.dart';
import 'package:kailasha/common/gradient_text.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';
import 'package:kailasha/models/science_experiment/science_experiment_model.dart';

class Section extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const Section({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.heightMultiplier),
      child: GradientCommonContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(
              text: title,
              style: CustomTextStyle.customW600(fontSize: 16),
            ),
            12.verticalSpace,
            ...children,
          ],
        ),
      ),
    );
  }
}

class Field extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;

  const Field(this.label, this.controller, {super.key, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.heightMultiplier),
      child: CustomTextField(
        controller: controller,
        hintText: label,
        maxlines: maxLines,
        validator: (v) => v == null || v.isEmpty ? 'Required' : null,
      ),
    );
  }
}

class DynamicObservationSection extends StatelessWidget {
  final List<ObservationControllers> observations;
  final VoidCallback onAdd;

  const DynamicObservationSection({super.key, 
    required this.observations,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Section(
      title: 'Observations',
      children: [
        ...observations.map((o) => o.build()),
        ClickableButton(
          onTap: onAdd,
          child: Text(
            '+ Add Observation',
            style: CustomTextStyle.size13W600(
              color: AppColors.textgradient.first,
            ),
          ),
        ),
      ],
    );
  }
}

class ObservationControllers {
  final distanceController = TextEditingController();
  final intensityController = TextEditingController();
  final bubblesController = TextEditingController();

  Widget build() {
    return Column(
      children: [
        CustomTextField(
          controller: distanceController,
          hintText: 'Distance (cm)',
          keyboardType: TextInputType.number,
        ),
        8.verticalSpace,
        CustomTextField(
          controller: intensityController,
          hintText: 'Light Intensity',
        ),
        8.verticalSpace,
        CustomTextField(
          controller: bubblesController,
          hintText: 'Oxygen Bubbles / Minute',
          keyboardType: TextInputType.number,
        ),
        12.verticalSpace,
      ],
    );
  }

  Observation toObservation() {
    return Observation(
      distanceCm: int.tryParse(distanceController.text) ?? 0,
      lightIntensity: intensityController.text,
      oxygenBubblesPerMinute: int.tryParse(bubblesController.text) ?? 0,
    );
  }

  void dispose() {
    distanceController.dispose();
    intensityController.dispose();
    bubblesController.dispose();
  }
}

class DynamicTextListSection extends StatelessWidget {
  final String title;
  final List<TextEditingController> controllers;
  final String hint;
  final VoidCallback onAdd;

  const DynamicTextListSection({super.key, 
    required this.title,
    required this.controllers,
    required this.hint,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Section(
      title: title,
      children: [
        ...controllers.map(
          (c) => Padding(
            padding: EdgeInsets.only(bottom: 8.heightMultiplier),
            child: CustomTextField(controller: c, hintText: hint),
          ),
        ),
        ClickableButton(
          onTap: onAdd,
          child: Text(
            '+ Add $title',
            style: CustomTextStyle.size13W600(
              color: AppColors.textgradient.first,
            ),
          ),
        ),
      ],
    );
  }
}
