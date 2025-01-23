// import 'package:flutter/material.dart';
// import 'package:houstan_hot_pass/app_widgets/app_button.dart';
// import 'package:houstan_hot_pass/app_widgets/custom_shadow_button.dart';
// import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
// import 'package:houstan_hot_pass/constants/app_colors.dart';
// import 'package:houstan_hot_pass/constants/app_icons.dart';
// import 'package:houstan_hot_pass/views/auth_screens/sign_up/widgets/payment_button.dart';
//
// import '../../app_widgets/custom_appbar_background.dart';
//
// class PaymentMethodScreen extends StatefulWidget {
//   const PaymentMethodScreen({super.key});
//
//   @override
//   State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
// }
//
// class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           CustomAppBarBackGround(
//             showTextField: false,
//             showFiltersIcon: false,
//             showIcon: false,
//             screenTitle: "Payment Methods",
//             showScreenTitle: true,
//             showBackButton: true,
//             height: 125,
//             screenSubtitle: "Edit your payment method",
//             showScreenSubtitle: true,
//           ),
//           Expanded(
//             child: Column(
//               children: [
//                 SizedBox(height: 30),
//                 PaymentButton(
//                     buttonIcon: AppIcons.masterCardIcon,
//                     buttonTitle: "Hassan Tanveer",
//                     decoration:
//                         customShadowedDecoration(buttonColor: Colors.white),
//                     showAccountNumber: true,
//                     accountNumber: "•••• 1234",showRemoveText: true),
//                 spacing(),
//                 PaymentButton(
//                     buttonIcon: AppIcons.googleIcon,
//                     buttonTitle: "Hassan Tanveer",
//                     decoration:
//                     customShadowedDecoration(buttonColor: Colors.white),
//                     showAccountNumber: true,
//                     accountNumber: "•••• 1234",showRemoveText: true),
//                 spacing(),
//                 PaymentButton(
//                     buttonIcon: AppIcons.appleIcon,
//                     buttonTitle: "Apple Pay",
//                     decoration:
//                         customShadowedDecoration(buttonColor: Colors.white)),
//                 spacing(),
//                 PaymentButton(
//                     buttonIcon: AppIcons.paypalIcon,
//                     buttonTitle: "PayPal",
//                     decoration:
//                         customShadowedDecoration(buttonColor: Colors.white)),
//                 Spacer(),
//                 CustomHorizontalPadding(child: CustomButton(Text: "Add New Card",textColor: Colors.white,buttonColor: AppColors.primaryColor,))
// ,               SizedBox(height: 30,)
//
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//   Widget spacing(){
//     return SizedBox(height: 20);
//
//   }
//
// }
