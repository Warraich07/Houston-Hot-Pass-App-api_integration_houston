import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_widgets/app_button.dart';
import 'package:houstan_hot_pass/app_widgets/custom_field%20.dart';
import 'package:houstan_hot_pass/app_widgets/custom_screen_title.dart';
import 'package:houstan_hot_pass/app_widgets/custom_shadow_button.dart';
import 'package:houstan_hot_pass/app_widgets/profile_picker.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:houstan_hot_pass/constants/app_icons.dart';
import 'package:houstan_hot_pass/views/auth_screens/sign_up/become_a_member_subscription_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../app_widgets/app_subtitle_text.dart';
import '../../../app_widgets/custom_dropdown.dart';
import '../../../app_widgets/scaffold_symmetric_padding.dart';
import '../../../constants/custom_validators.dart';
import '../../../controllers/auth_controller.dart';
import '../../../utils/custom_dialog.dart';
import '../auth_widgets/auth_screen_background_decoration.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  String? selectedGender;
  List<String> favoriteCuisinesData = [
    'Italian',
    'Mexican',
    'Japanese',
    'Vietnamese',
  ];
  List<String> diningTimesData = [
    'Breakfast (6 AM - 9 AM)',
    'Brunch (9 AM - 11 AM)',
    'Lunch (11 AM - 2 PM)',
    'Afternoon (2 PM - 5 PM)',
    'Dinner (5 PM - 8 PM)',
    'Late Dinner (8 PM - 11 PM)',
    'Late Night (After 11 PM)',
  ];
  List<String> dineOutData = [
    'Rarely (0-1 times per month)',
    'Occasionally (2-3 times per month)',
    'Regularly (4-6 times per month)',
    'Frequently (7-10 times per month)',
    'Very Frequently (11+ times per month)',
  ];
  List<String> hobbiesAndInterestsData = [
    'Sports',
    'Arts',
    'Music',
    'Theater',
    'Shopping',
  ];
  List<String> genderData = [
    'Male',
    'Female',
    'Non-binary',
    'Prefer not to say',
    'Prefer to self-describe',
  ];
  List<String> ageRangeData = [
    '18-24',
    '25-34',
    '35-44',
    '45-54',
    '55-64',
    ' 65 and older',
  ];
  List<String> spendPerVisitData = [
    'Under \$25',
    '\$25 - \$50',
    '\$51 - \$75',
    '\$76 - \$100',
    '\$101 - \$150',
    ' Over \$150',
  ];
  List<String> memberShipOfHoustonData = [
    'Exploring new places',
    'Saving money',
    'VIP experiences',
    ' Other',
  ];
  List<String> selectedCuisines=[];
  List<String> selectedCuisinesIds=[];
  List<String> selectedInterests=[];
  List<String> selectedInterestsIds=[];
TextEditingController locationAreaController=TextEditingController();
TextEditingController workAreaController=TextEditingController();
  final AuthController _authController=Get.find();

// TextEditingController favouriteCuisineController=TextEditingController();
// TextEditingController areaController=TextEditingController();
// TextEditingController areaController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }

      },
      child: Scaffold(
        body: AuthCustomBackGround(
            child: CustomHorizontalPadding(
          child: SingleChildScrollView(
            child: Form(
              key: _authController.formKeyForCompleteProfile,
              child: Obx(

                ()=> Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     CustomScreenTitle(
                        showLeading: false,
                        screenTitle: 'Complete Profile'),
                    AppSubtitleText(
                        Text:
                            "Add Profile pic and answer the following questions to get best offers",color: AppColors.whiteColor.withOpacity(0.7)),
                    const SizedBox(height: 25),
                    const ProfilePicker(forMyProfile: false,),
                    const SizedBox(height: 25),
                    AppSubtitleText(
                        Text: "What is your age range?",
                        color: AppColors.whiteColor),
                    betweenHeadingAndfieldSpacing(),
                    CustomDropDown(
                      selectedValue: _authController.selectedAge.value,
                        hintText: "Choose Age",
                        dropDownData: ageRangeData,
                        icon: AppIcons.chooseAgeIcon, onChanged: (String? value) {
                        _authController.updateSelectedAge(value!);

                        // Split the selectedAge string into two parts
                        List<String> ageRange = value.split('-');

      // Handle the case where the range is in the format "65 and older"
                      if (value.contains('and older')) {
                        // Set first part to 65 and second part to 100
                        int firstPart = 65;
                        int secondPart = 100;
                        _authController.updateFirstAndLastAge(firstPart, secondPart);
                      } else {
                        // Otherwise, handle it as a normal range
                        int? firstPart = ageRange.isNotEmpty ? int.tryParse(ageRange[0]) : null;
                        int? secondPart = ageRange.length > 1 ? int.tryParse(ageRange[1]) : null;

                        // Only update if both parts are valid integers
                        if (firstPart != null && secondPart != null) {
                          _authController.updateFirstAndLastAge(firstPart, secondPart);
                        } else {
                          // Handle error or fallback scenario if necessary
                          print('Invalid age range format.');

                        }
                      }
                      print(_authController.firstAge.value);
                      print(_authController.lastAge.value);
                    },),
                    Obx(()=>_authController.showValidationMessage.value==true &&_authController.selectedAge.value.isEmpty? const Padding(
                      padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
                      child: Text("Please select age range",style: TextStyle(fontSize: 10,color: Colors.white),),
                    ): spacing(),),
                    AppSubtitleText(
                      Text: "What is your gender?",
                      color: AppColors.whiteColor,
                    ),
                    betweenHeadingAndfieldSpacing(),

                    CustomDropDown(
                      selectedValue: _authController.selectedGender.value,
                      // selectedValueOfDropDown:selectedGender ,
                      hintText: "Choose Gender",
                      dropDownData: genderData,
                      icon: AppIcons.chooseGenderIcon,
                      onChanged: (value) {
                        _authController.updateSelectedGender(value!);
                      },
                    ),

                    if (_authController.selectedGender.value == 'Prefer to self-describe')
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: CustomTextField(
                          hintText: "write in your gender identity",
                          fillColor: AppColors.whiteColor,
                          hintTextColor: Colors.black.withOpacity(0.5),inputTextColor: Colors.black,
                          validator: (value) => CustomValidator.selectGenderRange(value),
                          controller: _authController.genderController,
                        ),

                      ),
                    Obx(()=>_authController.showValidationMessage.value==true &&_authController.selectedGender.value.isEmpty? const Padding(
                      padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
                      child: Text("Please select gender",style: TextStyle(fontSize: 12,color: Colors.white),),
                    ): spacing(),),

                    // if (_authController.selectedGender.value != 'Prefer to self-describe')
                    //   Container(),

                    // spacing(),
                    AppSubtitleText(
                        Text: "What area/neighborhood do you live in?",
                        color: AppColors.whiteColor),
                    betweenHeadingAndfieldSpacing(),
                    CustomTextField(
                      hintText: "Type Answer",
                      prefixIcon: AppIcons.locationIcon,
                      hintTextColor: AppColors.whiteColor.withOpacity(0.7),
                      controller: _authController.locationAreaController,
                      validator: (value) => CustomValidator.isEmptyLocation(value),
                    ),
                    spacing(),
                    // Obx(()=>_authController.showValidationMessage.value==true && _authController.locationAreaController.text.isEmpty? Text("Please select location",style: TextStyle(fontSize: 12,color: Colors.white),): spacing(),),
                    AppSubtitleText(
                        Text: "Which area do you work in?",
                        color: AppColors.whiteColor),
                    betweenHeadingAndfieldSpacing(),
                    CustomTextField(
                        hintText: "Type Answer",
                        prefixIcon: AppIcons.bagIcon,
                        hintTextColor: AppColors.whiteColor.withOpacity(0.7),
                        controller: _authController.workAreaController,
                      validator: (value) => CustomValidator.isEmptyWorkArea(value),

                    ),
                    spacing(),
                    // from here
                    AppSubtitleText(
                        Text: "How much do you typically spend per visit at a restaurant or on entertainment?",
                        color: AppColors.whiteColor),
                    betweenHeadingAndfieldSpacing(),
                    CustomDropDown(
                      selectedValue: _authController.averageSpending.value,
                      hintText: "Choose Options",
                      dropDownData: spendPerVisitData,
                      icon: AppIcons.diningIcon,
                      onChanged: (String? value) {

                        int firstValue;
                        int secondValue;
                        if (value != null) {
                          if (value == 'Under \$25') {
                            // Set firstValue and secondValue for 'Under $25'

                            firstValue = 0;
                            secondValue = 25;
                            _authController.updatePerCapitas(firstValue, secondValue);
                            print(_authController.firstCapitaValue.value);
                            print(_authController.lastCapitaValue.value);

                          } else if (value.contains("Over")) {
                            // Set firstValue and secondValue for 'Over $150'
                            firstValue = 150;
                            secondValue = 500;
                            _authController.updatePerCapitas(firstValue, secondValue);
                            print(_authController.firstCapitaValue.value);
                            print(_authController.lastCapitaValue.value);
                          } else if (value.contains('-')) {
                            // Extract range values for other options

                            final range = value.replaceAll('\$', '').split(' - ');
                            firstValue = int.parse(range[0]);
                            secondValue = int.parse(range[1]);
                            _authController.updatePerCapitas(firstValue, secondValue);
                            print(_authController.firstCapitaValue.value);
                            print(_authController.lastCapitaValue.value);

                          }
                        }

                        _authController.updateAverageSpending(value!);

                      },
                    ),
                    Obx(()=>_authController.showValidationMessage.value==true &&_authController.averageSpending.value.isEmpty? const Padding(
                      padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
                      child: Text("Please select average spending",style: TextStyle(fontSize: 10,color: Colors.white),),
                    ): spacing(),),
                    // to here

                    AppSubtitleText(
                        Text: "What are your favorite cuisines?",
                        color: AppColors.whiteColor),
                    betweenHeadingAndfieldSpacing(),
                    CustomDropDown(
                      selectedValue: _authController.favouriteCuisines.value,
                        hintText: "Choose Options",
                        dropDownData: _authController.cuisinesList.map((e)=>e.title).toList(),
                        icon: AppIcons.diningIcon,
                    onChanged: (String? value) {
                      final selectedCuisine = _authController.cuisinesList.firstWhere(
                            (cuisine) => cuisine.title == value,);
                        if(selectedCuisines.contains(selectedCuisine.title)){
                          print("empty");
                        }else{
                          selectedCuisines.add(selectedCuisine.title);
                          selectedCuisinesIds.add(selectedCuisine.id.toString());
                          _authController.updateFavoriteCuisines(value!,selectedCuisine.id,selectedCuisinesIds);
                          setState(() {
                          });
                        }
                    },
                    ),
                    selectedCuisines.isEmpty ?Obx(()=>_authController.showValidationMessage.value==true &&_authController.favouriteCuisines.value.isEmpty? const Padding(
                      padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
                      child: Text("Please select favorite cuisine",style: TextStyle(fontSize: 10,color: Colors.white),),
                    ): spacing(),): SizedBox(
                      height: 50,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          // shrinkWrap: true,
                          itemCount: selectedCuisines.length,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Chip(
                                side: const BorderSide(color: Colors.white),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusDirectional.circular(100),
                                ),
                                label:  GestureDetector(
                                    onTap: (){
                                      selectedCuisines.removeAt(index);
                                      selectedCuisinesIds.removeAt(index);
                                      if(selectedCuisines.isEmpty){
                                        _authController.showValidationMessage.value=true ;
                                        _authController.favouriteCuisines.value='';
                                      }
                                      setState(() {});
                                    },
                                    child: Text(selectedCuisines[index])),
                                avatar:  Icon(Icons.cancel,color: AppColors.primaryColor,),
                              ),
                            );
                          }),
                    ),


                    AppSubtitleText(
                        Text: "What are your preferred dining times?",
                        color: AppColors.whiteColor),
                    betweenHeadingAndfieldSpacing(),
                    CustomDropDown(
                      selectedValue: _authController.preferredDiningTimes.value,
                      hintText: "Choose Option",
                        dropDownData: _authController.diningTimesList.map((e)=>e.title).toList(),
                        icon: AppIcons.diningIcon,
                      onChanged: (String? value) {
                        final preferredDiningTimes = _authController.diningTimesList.firstWhere(
                              (preferredDiningTimes) => preferredDiningTimes.title == value,);
                        _authController.updatePreferredDiningTimes(value!,preferredDiningTimes.id);

                    },
                    ),
                    Obx(()=>_authController.showValidationMessage.value==true &&_authController.preferredDiningTimes.value.isEmpty? const Padding(
                      padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
                      child: Text("Please select preferred dining times ",style: TextStyle(fontSize: 12,color: Colors.white),),
                    ): spacing(),),
                    AppSubtitleText(
                        Text: "How often do you dine out?",
                        color: AppColors.whiteColor),
                    betweenHeadingAndfieldSpacing(),
                    CustomDropDown(
                      isHowOftenDineOut:true,
                      selectedValue: _authController.dineOut.value,

                      hintText: "Choose Option",
                        dropDownData: dineOutData,
                        icon: AppIcons.diningIcon,
                      onChanged: (String? value) {
                        _authController.updateDineOut(value!);
                        setState(() {

                        });
                      },
                    ),
                    Obx(()=>_authController.showValidationMessage.value==true &&_authController.dineOut.value.isEmpty? const Padding(
                      padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
                      child: Text("Please select dine out time",style: TextStyle(fontSize: 12,color: Colors.white),),
                    ): spacing(),),

                    AppSubtitleText(
                        Text: "What other hobbies and interests do you have?",
                        color: AppColors.whiteColor),
                    betweenHeadingAndfieldSpacing(),
                    CustomDropDown(
                      selectedValue: _authController.hobbies.value,
                      hintText: "Choose Options",
                        dropDownData: _authController.interestsList.map((e)=>e.title).toList(),
                        icon: AppIcons.interestsAndHobbiesIcon,
                      onChanged: (String? value) {
                        final interests = _authController.interestsList.firstWhere(
                              (interests) => interests.title == value,);

                        if(selectedInterests.contains(interests.title)){
                          print("already selected");
                        }else{
                          selectedInterests.add(interests.title);
                          selectedInterestsIds.add(interests.id.toString());
                          _authController.updateHobbies(value!,interests.id,selectedInterestsIds);
                          setState(() {
                          });
                        }
                      },
                    ),
                    selectedInterests.isEmpty?  Obx(()=>_authController.showValidationMessage.value==true &&_authController.hobbies.value.isEmpty? const Padding(
                      padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
                      child: Text("Please select hobbies",style: TextStyle(fontSize: 12,color: Colors.white),),
                    ): spacing(),): SizedBox(
                      height: 50,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          // shrinkWrap: true,
                          itemCount: selectedInterests.length,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Chip(
                                side: const BorderSide(color: Colors.white),

                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusDirectional.circular(100)
                                ),
                                label:  GestureDetector(
                                    onTap: (){
                                      selectedInterests.removeAt(index);
                                      selectedInterestsIds.removeAt(index);
                                      if(selectedInterests.isEmpty){
                                        _authController.showValidationMessage.value=true;
                                        _authController.hobbies.value='';
                                      }
                                      setState(() {});
                                    },
                                    child: Text(selectedInterests[index])),
                                avatar: Icon(Icons.cancel,color: AppColors.primaryColor,),
                              ),
                            );
                          }),
                    ),
                    // Obx(()=>_authController.showValidationMessage.value==true &&_authController.hobbies.value.isEmpty? const Padding(
                    //   padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
                    //   child: Text("Please select hobbies",style: TextStyle(fontSize: 12,color: Colors.white),),
                    // ): Container(),),

                    AppSubtitleText(
                        Text: "What do you hope to gain from your Houston Hotpass membership?",
                        color: AppColors.whiteColor),
                    betweenHeadingAndfieldSpacing(),
                    // diamond
                    CustomDropDown(
                        hintText: "Choose Options",
                        dropDownData: memberShipOfHoustonData,
                        icon: AppIcons.diamondIcon, onChanged: (String? value) {
                          _authController.updateHotPassMemberShipAim(value!);
                    }, selectedValue: _authController.hotPassMemberShipAim.value,),
                    Obx(()=>_authController.showValidationMessage.value==true &&_authController.hotPassMemberShipAim.value.isEmpty? const Padding(
                      padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
                      child: Text("Please select hotpass membership aim",style: TextStyle(fontSize: 10,color: Colors.white),),
                    ): spacing(),),
                    const SizedBox(height: 50),
                    CustomButton(Text: "Continue",onTap: () {
                      print(_authController.favouriteCuisines.value);
                      print(_authController.firstCapitaValue.value);
                      print(_authController.lastCapitaValue.value);
                      print(_authController.selectedGender.value);
                      print(_authController.lastAge.value);
                      print(_authController.firstAge.value);
                      print(_authController.hotPassMemberShipAim.value);
                      print(_authController.hobbies.value);
                      print(_authController.dineOut.value);
                      print(_authController.preferredDiningTimes.value);
                      _authController.updateShowValidationMessage(true);
                       if(_authController.formKeyForCompleteProfile.currentState!.validate()&&
                           _authController.favouriteCuisines.isNotEmpty&&
                           _authController.preferredDiningTimes.isNotEmpty&&
                           _authController.dineOut.isNotEmpty&&_authController.hobbies.isNotEmpty&&
                           _authController.hotPassMemberShipAim.isNotEmpty&&
                           _authController.firstAge.value!=0&&_authController.lastAge.value!=0&&
                           _authController.selectedGender.isNotEmpty&&
                           _authController.firstCapitaValue.value!=034&&
                           _authController.lastCapitaValue.value!=0){
                         if(_authController.completeProfileImagePath.value.isEmpty){
                           CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: "Please select image");
                         }else{
                           _authController.completeProfile();
                           print("hit api");
                         }
                        }
                      // if(_authController.formKeyForCompleteProfile.currentState!.validate()){
                      //   if(workAreaController.text.isEmpty||locationAreaController.text.isEmpty||_authController.favouriteCuisines.isEmpty||_authController.preferredDiningTimes.isEmpty||_authController.dineOut.isEmpty||_authController.hobbies.isEmpty){
                      //     CustomDialog.showErrorDialog(description: "Please select all fields");
                      //   }else if(_authController.imagePath.value.isEmpty){
                      //     CustomDialog.showErrorDialog(description: "Please select image");
                      //   }
                      //   Get.to(()=>BecomeAMemberSubscriptionScreen());
                      // }

                    },),
                    const SizedBox(height: 30),


                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }

  Widget spacing() {
    return const SizedBox(height: 15);
  }
  Widget betweenHeadingAndfieldSpacing() {
    return const SizedBox(height: 8);
  }

}
