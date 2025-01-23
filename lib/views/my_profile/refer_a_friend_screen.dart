import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:houstan_hot_pass/app_bottom_nav_bar/bottom_nav_bar.dart';
import 'package:houstan_hot_pass/app_widgets/custom_appbar_background.dart';
import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import '../../app_widgets/app_button.dart';
import '../../app_widgets/custom_field .dart';
import '../../constants/app_icons.dart';

class ReferAFriendScreen extends StatefulWidget {
  const ReferAFriendScreen({super.key});

  @override
  State<ReferAFriendScreen> createState() => _ReferAFriendScreenState();
}

class _ReferAFriendScreenState extends State<ReferAFriendScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _subjectController = TextEditingController(text: 'Check out this amazing app!');
  TextEditingController _bodyController = TextEditingController(
    text: 'Hey! I found this great app with amazing offers and discounts.',
  );
  List<String> attachments = [];
  bool isHTML = false;
  final FocusNode _emailFocusNode = FocusNode();
  Future<void> sendEmail() async {
    _emailFocusNode.unfocus();
      final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: [_emailController.text],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );

    String platformResponse;
    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'Invitation Sent!';
    } catch (error) {
      platformResponse = 'Failed to send invitation.';
      // print(error);
    }

    if (!mounted) return;
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(platformResponse),
    //   ),
    // );
  }

  void _openImagePicker() async {
    final picker = ImagePicker();
    final pick = await picker.pickImage(source: ImageSource.gallery);
    if (pick != null) {
      setState(() {
        attachments.add(pick.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBarBackGround(
            showTextField: false,
            showFiltersIcon: false,
            showIcon: false,
            screenTitle: "Refer a Friend",
            showScreenTitle: true,
            showBackButton: true,
            height: 125,
            screenSubtitle: "Let your friends know about amazing offers",
            showScreenSubtitle: true,
          ),
          CustomHorizontalPadding(
            child: Column(
              children: [
                const SizedBox(height: 30),
                CustomTextField(
                  focusNode: _emailFocusNode,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  fillColor: Colors.white,
                  fieldBorderColor: AppColors.primaryColor,
                  fieldName: "Email Address",
                  inputTextColor: Colors.black,
                  prefixIcon: AppIcons.emailIcon,
                  prefixIconColor: Colors.black.withOpacity(0.5),
                  hintTextColor: Colors.black.withOpacity(0.5),
                  hintText: "Email Address",
                ),
                const SizedBox(height: 200),
                CustomButton(
                  Text: "Send Invitation",
                  buttonColor: AppColors.primaryColor,
                  textColor: Colors.white,
                  onTap: sendEmail,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}








// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:houstan_hot_pass/app_bottom_nav_bar/bottom_nav_bar.dart';
// import 'package:houstan_hot_pass/app_widgets/custom_appbar_background.dart';
// import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
// import 'package:houstan_hot_pass/constants/app_colors.dart';
//
// import '../../app_widgets/app_button.dart';
// import '../../app_widgets/custom_field .dart';
// import '../../constants/app_icons.dart';
//
// class ReferAFriendScreen extends StatefulWidget {
//   const ReferAFriendScreen({super.key});
//
//   @override
//   State<ReferAFriendScreen> createState() => _ReferAFriendScreenState();
// }
//
// class _ReferAFriendScreenState extends State<ReferAFriendScreen> {
//   TextEditingController _emailController=TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//         const CustomAppBarBackGround(
//           showTextField: false,
//           showFiltersIcon: false,
//           showIcon: false,
//           screenTitle: "Refer a Friend",
//           showScreenTitle: true,
//           showBackButton: true,
//           height: 125,
//           screenSubtitle: "Let your friends know about amazing offers",
//           showScreenSubtitle: true,
//         ),
//           CustomHorizontalPadding(
//             child: Column(
//               children: [
//                 const SizedBox(height: 30),
//                 CustomTextField(
//                   controller: _emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   fillColor: Colors.white,
//                   fieldBorderColor: AppColors.primaryColor,
//                   fieldName: "Email Address:",
//                   inputTextColor: Colors.black,
//                   prefixIcon: AppIcons.emailIcon,
//                   prefixIconColor: Colors.black.withOpacity(0.5),
//                   hintTextColor: Colors.black.withOpacity(0.5),
//                   hintText: "Email Address",),
//                 const SizedBox(height: 200),
//                 CustomButton(
//                   Text: "Send Invitation",
//                   buttonColor: AppColors.primaryColor,
//                   textColor: Colors.white,onTap: () {
//                   // Get.to(()=>CustomBottomBarr());
//                 },),
//               ],
//             ),
//           )
//       ],
//       ),
//     );
//   }
// }
