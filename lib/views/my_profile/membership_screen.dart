import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:houstan_hot_pass/app_widgets/app_button.dart';
import 'package:houstan_hot_pass/app_widgets/app_subtitle_text.dart';
import 'package:houstan_hot_pass/app_widgets/custom_appbar_background.dart';
import 'package:houstan_hot_pass/app_widgets/custom_shadow_button.dart';
import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:houstan_hot_pass/utils/custom_dialog.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/auth_controller.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({super.key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  bool isPaused = false; //
  List<String> plansList=['Monthly','Annually'];
  List<String> plansPriceList=['\$9/month','\$100/year'];
  void _toggleMembership() {
    setState(() {
      isPaused = !isPaused;
    });
  }
  int? selectedIndex;
  bool isMonthly = false;
  // bool isYearly = false;
  AuthController authController = Get.find();
  // PurchaseController purchaseController = Get.find();
  String subPlan = "";

  getData() async {
    // subPlan = authController.userLoginData.value!.subscriptionPlan;
    print("plan Paln");
    print(subPlan);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    if(authController.userLoginData.value!.subscriptionStatus.toString()=='true'){
      isMonthly=true;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBarBackGround(
            showTextField: false,
            showFiltersIcon: false,
            showIcon: false,
            screenTitle: "Membership",
            showScreenTitle: true,
            showBackButton: true,
            height: 125,
            screenSubtitle:authController.userLoginData.value!.subscriptionStatus.toString()=='true'?'Premium member': "Become our member",
            showScreenSubtitle: true,
          ),
          SizedBox(height: 30),
          ListView.builder(
            // reverse: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 0),
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    //  if(selectedIndex==index){
                    //    selectedIndex=null;
                    //    isMonthly=false;
                    //    print(isMonthly);
                    //  }else{
                    //    selectedIndex=index;
                    //    isMonthly=true;
                    //    print(isMonthly);
                    //
                    //  }
                    // setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10,left: 20,right: 20),
                    width: 90.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor, width:isMonthly==true?3: 1),
                      color: AppColors.peachColor, // Use the provided color or fall back to default
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: AppColors.primaryColor, // Shadow color
                      //     offset: Offset(1, 1), // Offset of the shadow
                      //   ),
                      // ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Membership Plan",
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily: "black",
                                fontSize: 20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppSubtitleText(
                                Text: plansList[index],
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              AppSubtitleText(
                                Text: plansPriceList[index],
                                color: Colors.black.withOpacity(0.7),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),

          SizedBox(height: 30),

          Spacer(),
          if (isPaused)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: AppSubtitleText(Text:
              "Your membership paused. Resubscribe to become a member again.",color: Colors.black54,TextALign: TextAlign.center,

              ),
            ),
          SizedBox(height: 20),
          CustomHorizontalPadding(
            child: CustomButton(
              Text:authController.userLoginData.value!.subscriptionStatus.toString()=='true'?'Subscribed': "Subscribe",
              buttonColor: AppColors.primaryColor,
              textColor: Colors.white,
              onTap: ()async{
                // purchaseController.restore(context);
                // if(authController.userLoginData.value!.subscriptionStatus.toString()=='true'){
                //   print("already subscribed");
                //   await purchaseController.logIn(authController.userLoginData.value!.id.toString(), context);
                //
                //   await purchaseController.logOutPurchase(context);
                //
                //   // CustomDialog.showErrorDialog(description: 'You are already premium user.',title: '',showTitle: true);
                // }else{
                //   handleSubscription();
                // }

                // _toggleMembership
              },
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

}
