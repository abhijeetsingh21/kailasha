import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kailasha/common/clickable_button.dart';
import 'package:kailasha/common/common_back_button.dart';
import 'package:kailasha/common/common_background.dart';
import 'package:kailasha/common/common_container.dart';
import 'package:kailasha/common/custom_textfield.dart';
import 'package:kailasha/common/image_loader.dart';
import 'package:kailasha/core/constants/app_images.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';
import 'package:kailasha/core/utils/common_enums.dart';
import 'package:kailasha/pages/chat/cubit/chat_cubit.dart';


@RoutePage()
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatCubit chatCubit;
  @override
  void initState() {
    chatCubit = context.read<ChatCubit>();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<String> chipMessages = [
      "I'm here",
      "Be right there",
      "I'm looking for you",
    ];
    return CommonBackground(
      // showSafeArea: false,
      child: CommonContainer(
        child: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            return Column(
              children: [
                // -- Header --
                _header(),
                // profile with name
                _profileSection(),

                20.verticalSpace,

                Divider(color: AppColors.borderColor),

                // -- Messages Area --
                _messages(),
                12.verticalSpace,

                // - Quick Reply Suggested Chips -
                _prePrompts(chipMessages),

                16.verticalSpace,

                // -- Text Field Row --
                _bottomRow(),
              ],
            );
          },
        ),
      ),
    );
  }

  Row _bottomRow() {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            controller: messageController,
            hintText: "Message.....",
            backgroundColor: AppColors.white5,
            borderRadius: 4.radiusMultiplier,
            borderColor: Colors.transparent,
            useLabelText: false,
            maxlines: 1,
          ),
        ),

        8.horizontalSpace,

        // send icon button
        ClickableButton(
          onTap: () {
            if (messageController.text.isNotEmpty) {
              chatCubit.sendMessage(message: messageController.text);
              messageController.clear();
            }
          },
          child: CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.borderColor,
            child: ImageLoader.asset(
              AppIcons.sendIcon,
              height: 28.heightMultiplier,
            ),
          ),
        ),
      ],
    );
  }

  SizedBox _prePrompts(List<String> chipMessages) {
    return SizedBox(
      height: 45.heightMultiplier,
      child: ListView.separated(
        itemCount: chipMessages.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => 10.horizontalSpace,
        itemBuilder: (_, index) {
          return _chip(chipMessages[index]);
        },
      ),
    );
  }

  Expanded _messages() {
    return Expanded(
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return ListView.separated(
            itemCount: state.messages.length,
            separatorBuilder: (context, index) => 12.verticalSpace,
            itemBuilder: (context, index) {
              final message = state.messages[index];
              return Row(
                mainAxisAlignment: message.chatSender == ChatSender.driver
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Flexible(flex: 1, child: SizedBox()),
                  Flexible(
                    flex: 3,
                    child: CommonContainer(
                      color: AppColors.borderColor,
                      child: Text(
                        message.message,
                        style: CustomTextStyle.customW500(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Column _profileSection() {
    return Column(
      children: [
        GradientCommonContainer(
          height: 90.heightMultiplier,
          width: 90.widthMultiplier,
          padding: EdgeInsets.zero,
          borderGradientColors: AppColors.textgradient,
          borderWidth: 3.5,
          boxShape: BoxShape.circle,
          child: CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage(AppImages.johnImage), // replace asset
          ),
        ),
        6.verticalSpace,
        Text("John", style: CustomTextStyle.customW600(fontSize: 20)),
        Text(
          "Wed, Dec 15, 6:00 PM",
          style: CustomTextStyle.customW600(
            fontSize: 12,
            color: AppColors.text2,
          ),
        ),
        6.verticalSpace,
        Text(
          "Keep your account safe - never share\npersonal or account information in this chat",
          textAlign: TextAlign.center,
          style: CustomTextStyle.customW600(
            fontSize: 14,
            color: AppColors.text2,
          ),
        ),
      ],
    );
  }

  Row _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // back button
        CommonBackButton(
          backgroundColor: AppColors.primary,
          color: AppColors.white100,
        ),

        // call button
        CircleAvatar(
          backgroundColor: AppColors.primary,
          child: ImageLoader.asset(
            AppIcons.phoneIcon,
            color: AppColors.white100,
            height: 20.heightMultiplier,
          ),
        ),
      ],
    );
  }

  Widget _chip(String text) {
    return ClickableButton(
      onTap: () {
        chatCubit.sendMessage(message: text);
      },
      child: CommonContainer(
        borderRadius: 32.radiusMultiplier,
        color: AppColors.borderColor,
        padding: EdgeInsets.symmetric(
          horizontal: 25.widthMultiplier,
          vertical: 10.heightMultiplier,
        ),
        child: Text(text, style: CustomTextStyle.size14W500()),
      ),
    );
  }
}
