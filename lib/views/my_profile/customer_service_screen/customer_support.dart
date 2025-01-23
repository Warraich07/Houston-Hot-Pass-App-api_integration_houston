import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/custom_appbar_background.dart';
// import 'package:houstan_hot_pass/app_widgets/shimmer.dart';
import 'package:houstan_hot_pass/app_widgets/shimmer_single_widget.dart';
import 'package:houstan_hot_pass/views/my_profile/customer_service_screen/widgets/customer_service_button.dart';
import 'package:houstan_hot_pass/views/my_profile/customer_service_screen/widgets/expandable_tile.dart';
import 'package:sizer/sizer.dart';
import '../../../app_widgets/bold_text.dart';
import '../../../constants/app_icons.dart';
import '../../../controllers/offers_controller.dart';

class CustomerSupport extends StatefulWidget {
  const CustomerSupport({super.key});

  @override
  State<CustomerSupport> createState() => _CustomerSupportState();
}

class _CustomerSupportState extends State<CustomerSupport> {
  final OffersController _offersController=Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _offersController.getFAQs();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
          ()=> Column(
          children: [
            const CustomAppBarBackGround(
              height: 130,
                showTextField: false,
                showFiltersIcon: false,
                showIcon: false,
                showScreenTitle: true,
                screenTitle: "Customer Support",
                showBackButton: true),
            _offersController.isLoading.value==true?Column(
              children: [
                SizedBox(height: 20,),
                Container(
                    height: 95,
                    child: ShimmerSingleWidget(shimmerWidth: 90.w)),
                SizedBox(height: 20,),
                Container(
                    height: 95,
                    child: ShimmerSingleWidget(shimmerWidth: 90.w)),
                SizedBox(height: 20,),
                Container(
                    height: 95,
                    child: ShimmerSingleWidget(shimmerWidth: 90.w)),
              ],
            ): Expanded(
              child: SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(height: 30),
                  CustomerServiceButton(
                    title: _offersController.adminEmail.value,
                    onTap: () {},
                    image: AppIcons.emailIconForCustomerSupport,
                    subTitle: 'Write us at',
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: BoldText(Text: "Frequently Asked Questions", fontSize: 18,color: Colors.black,),
                  ),
                  ListView.builder(
                    physics: const ScrollPhysics(),
                      padding: const EdgeInsets.only(top: 10),
                      shrinkWrap: true,
                      itemCount: _offersController.faqsList.length,
                      itemBuilder: (context,index){
                    return CustomExpandableTile(
                      questionTitle: _offersController.faqsList[index].question,
                      answer:_offersController.faqsList[index].answer,
                    );
                  }),
                  // const CustomExpandableTile(
                  //     questionTitle: 'Can I redeem an offer multiple times?',
                  //     answer: 'answer',
                  // ),
                  // buttonsSpacing(),
                  // const CustomExpandableTile(
                  //     questionTitle: 'Are the offers in the app applicable at all times?'),
                  // buttonsSpacing(),
                  // const CustomExpandableTile(questionTitle: 'How is my eating out frequency used?'),
                  // buttonsSpacing(),
                  // const CustomExpandableTile(
                  //     questionTitle:
                  //         'Why do you need to know my neighborhood and work area?'),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonsSpacing() {
    return const SizedBox(height: 10);
  }
}
