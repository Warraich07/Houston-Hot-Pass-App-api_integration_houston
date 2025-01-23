import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/bold_text.dart';
import 'package:houstan_hot_pass/app_widgets/custom_shadow_button.dart';
import 'package:houstan_hot_pass/controllers/offers_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../app_widgets/alertbox.dart';
import '../../../app_widgets/app_button.dart';
import '../../../app_widgets/custom_field .dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_icons.dart';
import '../../../controllers/home_controller.dart';
import '../../utils/custom_dialog.dart';
import 'blogs_filters.dart';

class BlogsFiltersBottomSheet extends StatefulWidget {
  const BlogsFiltersBottomSheet({super.key});

  @override
  State<BlogsFiltersBottomSheet> createState() => _BlogsFiltersBottomSheetState();
}

class _BlogsFiltersBottomSheetState extends State<BlogsFiltersBottomSheet> {
  // Controllers
  HomeController homeController = Get.find();
  // Lists
  List<String> items = [
    'American',
    'BBQ',
    'Bakery',
    'Coffee Shop',
    'Pizza',
    'Bar',
  ];
  // Variables
  String? selectedValue;
  String? selected;
  String option = "Cuisine";
  String selectedIndex = "0";

  final GlobalKey<FormState> _formKey = GlobalKey();
  OffersController _offersController=Get.find();
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Container(
        width: 100.w,

        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(5.0),
            ),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 15.w,
                        height: 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const BoldText(
                      Text: "Filter your Choice",
                      fontSize: 17,color: Colors.black,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 55,
                      width: 90.w,
                      decoration: customShadowedDecoration(buttonColor: Colors.white),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          dropdownStyleData: DropdownStyleData(
                            decoration: customShadowedDecoration(buttonColor: Colors.white),
                          ),
                          isExpanded: true,
                          hint: Row(
                            children: [
                              const SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  option,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: "montserrat-semibold",
                                      fontSize: 18,
                                      color: AppColors.primaryColor

                                  ),
                                ),
                              ),
                            ],
                          ),
                          items: items.map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item.toString(),
                              style:  TextStyle(
                                  color:AppColors.primaryColor,
                                  fontSize: 18,
                                  fontFamily: "montserrat-semibold"),
                            ),
                          ))
                              .toList(),
                          onChanged: (String? value) {
                            setState(() {
                              option = value!;
                            });
                            selectedIndex = (items.indexOf(value!)+1).toString();
                            print("Selected index: $selectedIndex");
                          },
                          buttonStyleData:  ButtonStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 40,
                            width: 140,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 130),
                    GestureDetector(
                        onTap: () {
                          if(selectedIndex=='0'){
                            CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: "Please select cuisine.");

                          }else{
                            Get.back();
                            applyFilters();
                          }

                        },
                        child:  CustomButton(
                          Text: "Apply Filters", textColor: Colors.white,buttonColor: AppColors.primaryColor,)),
                    const SizedBox(height: 50)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  applyFilters() {
    homeController.filterList.clear();

    // if (option == "Cuisine") {
    //   showDialog(
    //       context: context,
    //       builder: (context) {
    //         return CustomAlertDialog(
    //           buttonName: "Got It",
    //           img: AppIcons.questionMarkIcon,
    //           heading: "Please select a filter",
    //           subHeading: "Apply filter to continue ",
    //           height: 40.h,
    //           onTapped: () {
    //             Get.back();
    //           },
    //         );
    //       });
    //   return;
    // }
    // if (option != "Cuisine") {
    homeController.filterList.add(option);
    Get.to(() => BlogsFilterResults(filteredKeyWord: selectedIndex,));
    _offersController.filteredCuisineBlogsList.clear();
    _offersController.filteredCuisineBlogsCurrentPage.value=0;
    _offersController.filteredCuisineBlogsLastPage.value=0;
    _offersController.filterBlogsTypes(false,selectedIndex);
    // }
  }


}

spaceWidget({double height = 15}) {
  return SizedBox(
    height: height,
  );
}
