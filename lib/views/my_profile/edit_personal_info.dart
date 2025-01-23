import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/app_bottom_nav_bar/bottom_nav_bar.dart';
import 'package:houstan_hot_pass/app_widgets/app_button.dart';
import 'package:houstan_hot_pass/app_widgets/bold_text.dart';
import 'package:houstan_hot_pass/app_widgets/custom_appbar_background.dart';
import 'package:houstan_hot_pass/app_widgets/custom_field%20.dart';
import 'package:houstan_hot_pass/app_widgets/profile_picker.dart';
import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:houstan_hot_pass/controllers/auth_controller.dart';

import '../../app_widgets/app_subtitle_text.dart';
import '../../app_widgets/custom_dropdown.dart';
import '../../constants/app_icons.dart';
import '../../constants/custom_validators.dart';

class EditPersonalInfo extends StatefulWidget {
  const EditPersonalInfo({super.key});

  @override
  State<EditPersonalInfo> createState() => _EditPersonalInfoState();
}

class _EditPersonalInfoState extends State<EditPersonalInfo> {
  AuthController _authController=Get.find();
  List<String> selectedCuisines=[];
  List<String> selectedInterests=[];
  List<String> selectedCuisinesIds=[];
  List<String> selectedInterestsIds=[];
  List<String> memberShipOfHoustonData = [
    'Exploring new places',
    'Saving money',
    'VIP experiences',
    ' Other',
  ];
  List<String> spendPerVisitData = [
    'Under \$25',
    '\$25 - \$50',
    '\$51 - \$75',
    '\$76 - \$100',
    '\$101 - \$150',
    ' Over \$150',
  ];
  List<String> ageRangeData = [
    '18-24',
    '25-34',
    '35-44',
    '45-54',
    '55-64',
    ' 65 and older',
  ];
  List<String> genderData = [
    'Male',
    'Female',
    'Non-binary',
    'Prefer not to say',
    'Prefer to self-describe',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(_authController.userLoginData.value!.age.from);
    _authController.editProfileInfoFirstNameController.text=_authController.userLoginData.value!.name.toString();
    _authController.editProfileInfoEmailController.text=_authController.userLoginData.value!.email.toString();
    _authController.editProfileInfoLocationController.text=_authController.userLoginData.value!.residentialLocation.title.toString();
    _authController.editProfileInfoWorkAreaController.text=_authController.userLoginData.value!.commercialLocation.title.toString();
    _authController.editProfileInfoDineOutTimeController.text=_authController.userLoginData.value!.oftenDineOut.toString();
    _authController.updateDineOutInPersonalInfo(_authController.userLoginData.value!.oftenDineOut.toString());
    // from here
    selectedCuisines=_authController.userLoginData.value!.cuisines.map((cuisines) => cuisines.title.toString()).toList();
    selectedCuisinesIds=_authController.userLoginData.value!.cuisines.map((cuisines) => cuisines.id.toString()).toList();
    selectedInterests=_authController.userLoginData.value!.interests.map((interests) => interests.title.toString()).toList();
    selectedInterestsIds=_authController.userLoginData.value!.interests.map((interests) => interests.id.toString()).toList();
    _authController.updateFirstAndLastAgeFOrPersonalInfo(int.parse(_authController.userLoginData.value!.age.from),int.parse(_authController.userLoginData.value!.age.to));
    _authController.genderControllerForPersonalInfo.text=_authController.userLoginData.value!.gender.toString();
    _authController.updateSelectedGenderForPersonalInfo(_authController.userLoginData.value!.gender.toString());
    _authController.updatePerCapitasForPersonalInfo(int.parse(_authController.userLoginData.value!.avgSpending.from),int.parse(_authController.userLoginData.value!.avgSpending.to));
    _authController.updateFavoriteCuisinesForPersonalInfo(_authController.userLoginData.value!.cuisines[0].title,_authController.userLoginData.value!.cuisines.map((cuisine) => cuisine.id.toString()).toList());
    _authController.updatePreferredDiningTimesForPersonalInfo(_authController.userLoginData.value!.diningTimes[0].title,_authController.userLoginData.value!.diningTimes[0].id);
    _authController.updateHobbiesForPersonalInfo(_authController.userLoginData.value!.interests[0].title,_authController.userLoginData.value!.interests.map((interests) => interests.id.toString()).toList());
    _authController.updateHotPassMemberShipAimForPersonalInfo(_authController.userLoginData.value!.userAim);
    setState(() {

    });
    print(_authController.editProfileInfoDineOutTimeController.text);
    // _authController.updateDineOutInPersonalInfo(_authController.userLoginData.value!.oftenDineOut);
    // _authController.dineOutForPersonalInfo.value=_authController.userLoginData.value!.oftenDineOut;
  }
  List<String> dineOutData = [
    'Rarely (0-1 times per month)',
    'Occasionally (2-3 times per month)',
    'Regularly (4-6 times per month)',
    'Frequently (7-10 times per month)',
    'Very Frequently (11+ times per month)',
  ];
  @override
  Widget build(BuildContext context) {
    print(_authController.imagePath.value);
    return Scaffold(
      body: Obx(
        ()=> Column(
          children: [
             CustomAppBarBackGround(
              showIcon: false,
              showTextField: false,
              showFiltersIcon: false,
              showBackButton: true,
              showScreenTitle: true,
              screenTitle: "Edit Personal Info",
              screenSubtitle: "Edit Personal Details",
              showScreenSubtitle: true,
              height: 125,
            ),
            Expanded(
              child: CustomHorizontalPadding(
                child: SingleChildScrollView(
                  child: Form(
                    key: _authController.formKeyEditProfile,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 25),
                        ProfilePicker(forMyProfile: true,imagePath: _authController.userLoginData.value!.image.toString(),),
                        const SizedBox(height: 20),
                        BoldText(Text: "First Name",color: AppColors.blackColor),
                        const SizedBox(height: 7),
                        CustomTextField(
                          hintText: "First Name",hintTextColor: Colors.black.withOpacity(0.7),
                            fillColor: Colors.white,
                            fieldBorderColor: AppColors.primaryColor,
                            fieldName: "First Name",inputTextColor: Colors.black,
                          validator: (value) => CustomValidator.firstName(value),
                          controller: _authController.editProfileInfoFirstNameController,
                            isEditProfileInfoScreen:true
                        ),
                        spacingBetweenFields(),
                        BoldText(Text: "Email Address:",color: AppColors.blackColor),
                        const SizedBox(height: 7),

                        AbsorbPointer(
                          absorbing: true,
                          child: CustomTextField(
                            hintText: "Email Address",hintTextColor: Colors.black.withOpacity(0.7),
                              fillColor: Colors.white,
                              fieldBorderColor: AppColors.primaryColor,
                              fieldName: "Email Address:",inputTextColor: Colors.black,keyboardType: TextInputType.emailAddress,
                            validator: (value) => CustomValidator.email(value),
                            controller: _authController.editProfileInfoEmailController,
                              isEditProfileInfoScreen:true

                          ),
                        ),
                        spacingBetweenFields(),
                        BoldText(Text: "Where do you live?",color: AppColors.blackColor),
                        const SizedBox(height: 7),
                        CustomTextField(
                          hintText: "Where do you live?",hintTextColor: Colors.black.withOpacity(0.7),

                            fillColor: Colors.white,
                            fieldBorderColor: AppColors.primaryColor,
                            fieldName: "Where do you live?",inputTextColor: Colors.black,
                          validator: (value) => CustomValidator.isEmptyLocation(value),
                          controller: _authController.editProfileInfoLocationController,
                            isEditProfileInfoScreen:true

                        ),
                        spacingBetweenFields(),
                        BoldText(Text: "Which area you work in?",color: AppColors.blackColor),
                        const SizedBox(height: 7),
                        CustomTextField(
                          hintText: "Which area you work in?",hintTextColor: Colors.black.withOpacity(0.7),

                            fillColor: Colors.white,
                            fieldBorderColor: AppColors.primaryColor,
                            fieldName: "Which Area you work in?",inputTextColor: Colors.black,
                          validator: (value) => CustomValidator.isEmptyWorkArea(value),
                            controller: _authController.editProfileInfoWorkAreaController,
                            isEditProfileInfoScreen:true

                        ),
                        spacingBetweenFields(),
                        BoldText(Text: "How many times you typically eat out?",color: AppColors.blackColor),
                        const SizedBox(height: 7),
                        CustomDropDown(
                          dropDownButtonColor:AppColors.blackColor,
                          showDropDownIcon: false,
                          dropDownColor: AppColors.whiteColor,
                          dropDownBorderColor: AppColors.primaryColor,
                          dropDownHintTextColor: AppColors.blackColor,
                          dropDownTextColor: AppColors.blackColor,
                          isHowOftenDineOut:true,
                          selectedValue: _authController.dineOutForPersonalInfo.value,
                          hintText: _authController.userLoginData.value!.oftenDineOut.toString(),
                          dropDownData: dineOutData,
                          icon: AppIcons.diningIcon,
                          dropDownIconColor: AppColors.primaryColor,
                          onChanged: (String? value) {
                            _authController.updateDineOutInPersonalInfo(value!);
                            _authController.updateDineOutInPersonalInfoController(value);
                            setState(() {

                            });
                          },
                        ),
                        SizedBox(height: 15),
                        // additional fields to be added start
                        BoldText(Text: "What is your age range?",color: AppColors.blackColor),

                        betweenHeadingAndfieldSpacing(),
                        CustomDropDown(
                          dropDownButtonColor:AppColors.blackColor,
                          showDropDownIcon: false,
                          dropDownColor: AppColors.whiteColor,
                          dropDownBorderColor: AppColors.primaryColor,
                          dropDownHintTextColor: AppColors.blackColor,
                          dropDownTextColor: AppColors.blackColor,
                          isHowOftenDineOut:true,
                          selectedValue: _authController.selectedAgeForPersonalInfo.value.contains('older')?_authController.selectedAgeForPersonalInfo.value:"${_authController.firstAgeForPersonalInfo.value}-${_authController.lastAgeForPersonalInfo.value}",
                          hintText: _authController.userLoginData.value!.age.from.toString()+'-'+_authController.userLoginData.value!.age.to.toString(),
                          dropDownData: ageRangeData,
                          icon: AppIcons.chooseAgeIcon, onChanged: (String? value) {
                          _authController.updateSelectedAgeForPersonalInfo(value!);

                          // Split the selectedAge string into two parts
                          List<String> ageRange = value.split('-');

                          // Handle the case where the range is in the format "65 and older"
                          if (value.contains('and older')) {
                            // Set first part to 65 and second part to 100
                            int firstPart = 65;
                            int secondPart = 100;
                            _authController.updateFirstAndLastAgeFOrPersonalInfo(firstPart, secondPart);
                          } else {
                            // Otherwise, handle it as a normal range
                            int? firstPart = ageRange.isNotEmpty ? int.tryParse(ageRange[0]) : null;
                            int? secondPart = ageRange.length > 1 ? int.tryParse(ageRange[1]) : null;

                            // Only update if both parts are valid integers
                            if (firstPart != null && secondPart != null) {
                              _authController.updateFirstAndLastAgeFOrPersonalInfo(firstPart, secondPart);
                            } else {
                              // Handle error or fallback scenario if necessary
                              print('Invalid age range format.');

                            }
                          }
                          // print(_authController.firstAge.value);
                          // print(_authController.lastAge.value);
                        },),
                        Obx(()=>_authController.showValidationMessage.value==true &&_authController.selectedAgeForPersonalInfo.value.isEmpty? const Padding(
                          padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
                          child: Text("Please select age range",style: TextStyle(fontSize: 10,color: Colors.white),),
                        ): spacing(),),

                        BoldText(Text: "What is your gender?",color: AppColors.blackColor),

                        betweenHeadingAndfieldSpacing(),

                        CustomDropDown(
                          dropDownButtonColor:AppColors.blackColor,
                          showDropDownIcon: false,
                          dropDownColor: AppColors.whiteColor,
                          dropDownBorderColor: AppColors.primaryColor,
                          dropDownHintTextColor: AppColors.blackColor,
                          dropDownTextColor: AppColors.blackColor,
                          isHowOftenDineOut:true,
                          selectedValue: _authController.selectedGenderForPersonalInfo.value,
                          // selectedValueOfDropDown:selectedGender ,
                          hintText: _authController.userLoginData.value!.gender.toString(),
                          dropDownData: genderData,
                          icon: AppIcons.chooseGenderIcon,
                          onChanged: (value) {
                            _authController.updateSelectedGenderForPersonalInfo(value!);
                            print(value);
                          },
                        ),

                        if (_authController.selectedGenderForPersonalInfo.value == 'Prefer to self-describe')
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: CustomTextField(

                              fieldBorderColor: AppColors.primaryColor,
                              hintText: "write in your gender identity",
                              fillColor: AppColors.whiteColor,
                              hintTextColor: Colors.black.withOpacity(0.5),inputTextColor: Colors.black,
                              validator: (value) => CustomValidator.selectGenderRange(value),
                              controller: _authController.genderControllerForPersonalInfo,
                            ),

                          ),
                        Obx(()=>_authController.showValidationMessage.value==true &&_authController.selectedGenderForPersonalInfo.value.isEmpty? const Padding(
                          padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
                          child: Text("Please select gender",style: TextStyle(fontSize: 12,color: Colors.white),),
                        ): spacing(),),

                        BoldText(Text: "How much do you typically spend per visit at a restaurant or on entertainment?",color: AppColors.blackColor),

                        betweenHeadingAndfieldSpacing(),
                        CustomDropDown(
                          dropDownButtonColor:AppColors.blackColor,
                          showDropDownIcon: false,
                          dropDownColor: AppColors.whiteColor,
                          dropDownBorderColor: AppColors.primaryColor,
                          dropDownHintTextColor: AppColors.blackColor,
                          dropDownTextColor: AppColors.blackColor,
                          isHowOftenDineOut:true,
                          selectedValue: _authController.averageSpendingForPersonalInfo.value,
                          hintText:_authController.userLoginData.value!.avgSpending.from+(_authController.userLoginData.value!.avgSpending.from=='over' ||_authController.userLoginData.value!.avgSpending.from=='under'?' ${_authController.userLoginData.value!.avgSpending.to}':'-${_authController.userLoginData.value!.avgSpending.to}'),
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
                                _authController.updatePerCapitasForPersonalInfo(firstValue, secondValue);
                                print(_authController.firstCapitaValue.value);
                                print(_authController.lastCapitaValue.value);

                              } else if (value.contains("Over")) {
                                // Set firstValue and secondValue for 'Over $150'
                                firstValue = 150;
                                secondValue = 500;
                                _authController.updatePerCapitasForPersonalInfo(firstValue, secondValue);
                                print(_authController.firstCapitaValue.value);
                                print(_authController.lastCapitaValue.value);
                              } else if (value.contains('-')) {
                                // Extract range values for other options

                                final range = value.replaceAll('\$', '').split(' - ');
                                firstValue = int.parse(range[0]);
                                secondValue = int.parse(range[1]);
                                _authController.updatePerCapitasForPersonalInfo(firstValue, secondValue);
                                print(_authController.firstCapitaValue.value);
                                print(_authController.lastCapitaValue.value);

                              }
                            }

                            _authController.updateAverageSpendingForPersonalInfo(value!);

                          },
                        ),
                        Obx(()=>_authController.showValidationMessage.value==true &&_authController.averageSpending.value.isEmpty? const Padding(
                          padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
                          child: Text("Please select average spending",style: TextStyle(fontSize: 10,color: Colors.white),),
                        ): spacing(),),
                        // to here
                        BoldText(Text: "What are your favorite cuisines?",color: AppColors.blackColor),
                        betweenHeadingAndfieldSpacing(),
                        CustomDropDown(
                          dropDownButtonColor:AppColors.blackColor,
                          showDropDownIcon: false,
                          dropDownColor: AppColors.whiteColor,
                          dropDownBorderColor: AppColors.primaryColor,
                          dropDownHintTextColor: AppColors.blackColor,
                          dropDownTextColor: AppColors.blackColor,
                          isHowOftenDineOut:true,
                          selectedValue: _authController.favouriteCuisinesForPersonalInfo.value,
                          hintText: _authController.userLoginData.value!.cuisines[0].title.toString(),
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
                              _authController.updateFavoriteCuisinesForPersonalInfo(value!,selectedCuisinesIds);
                              setState(() {
                              });
                            }
                          },
                        ),
                        selectedCuisines.isEmpty ?const Text("Please select favourite cuisine",style: TextStyle(fontSize: 12,color: Colors.black),): SizedBox(
                          height: 50,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              // shrinkWrap: true,
                              itemCount: selectedCuisines.length,
                              itemBuilder: (context,index){
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Chip(
                                    backgroundColor: AppColors.primaryColor,
                                    side:  BorderSide(color: AppColors.primaryColor),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadiusDirectional.circular(100),
                                    ),
                                    label:  GestureDetector(
                                        onTap: (){
                                          print(selectedCuisines.length);
                                          selectedCuisines.removeAt(index);
                                          selectedCuisinesIds.removeAt(index);
                                          if(selectedCuisines.isEmpty){
                                            setState(() {

                                            });
                                          }
                                          _authController.updateFavoriteCuisinesForPersonalInfo(selectedCuisines[0],selectedCuisinesIds);

                                          setState(() {});
                                        },
                                        child: Text(selectedCuisines[index],style: TextStyle(color: AppColors.whiteColor),)),
                                    avatar:  Icon(Icons.cancel,color: AppColors.whiteColor,),
                                  ),
                                );
                              }),
                        ),

                        // Obx(()=>_authController.showValidationMessage.value==true &&_authController.favouriteCuisinesForPersonalInfo.value.isEmpty? const Padding(
                        //   padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
                        //   child: Text("Please select favorite cuisine",style: TextStyle(fontSize: 10,color: Colors.white),),
                        // ): spacing(),),
                        BoldText(Text: "What are your preferred dining times?",color: AppColors.blackColor),

                        betweenHeadingAndfieldSpacing(),
                        CustomDropDown(
                          dropDownButtonColor:AppColors.blackColor,
                          showDropDownIcon: false,
                          dropDownColor: AppColors.whiteColor,
                          dropDownBorderColor: AppColors.primaryColor,
                          dropDownHintTextColor: AppColors.blackColor,
                          dropDownTextColor: AppColors.blackColor,
                          isHowOftenDineOut:true,
                          selectedValue: _authController.preferredDiningTimesForPersonalInfo.value,
                          hintText: _authController.userLoginData.value!.diningTimes[0].title.toString(),
                          dropDownData: _authController.diningTimesList.map((e)=>e.title).toList(),
                          icon: AppIcons.diningIcon,
                          onChanged: (String? value) {
                            final preferredDiningTimes = _authController.diningTimesList.firstWhere(
                                  (preferredDiningTimes) => preferredDiningTimes.title == value,);
                            _authController.updatePreferredDiningTimesForPersonalInfo(value!,preferredDiningTimes.id);

                          },
                        ),

                        Obx(()=>_authController.showValidationMessage.value==true &&_authController.preferredDiningTimesForPersonalInfo.value.isEmpty? const Padding(
                          padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
                          child: Text("Please select dine out time",style: TextStyle(fontSize: 12,color: Colors.white),),
                        ): spacing(),),

                        BoldText(Text: "What other hobbies and interests do you have?",color: AppColors.blackColor,maxLines: 2,),

                        betweenHeadingAndfieldSpacing(),

                        CustomDropDown(
                          dropDownButtonColor:AppColors.blackColor,
                          showDropDownIcon: false,
                          dropDownColor: AppColors.whiteColor,
                          dropDownBorderColor: AppColors.primaryColor,
                          dropDownHintTextColor: AppColors.blackColor,
                          dropDownTextColor: AppColors.blackColor,
                          isHowOftenDineOut:true,
                          selectedValue: _authController.hobbiesForPersonalInfo.value,
                          hintText: _authController.userLoginData.value!.cuisines[0].title.toString(),
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
                              _authController.updateHobbiesForPersonalInfo(value!,selectedInterestsIds);
                              setState(() {
                              });
                            }
                          },
                        ),
                        selectedInterests.isEmpty?const Text("Please select hobbies",style: TextStyle(fontSize: 12,color: Colors.black),): SizedBox(
                          height: 50,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              // shrinkWrap: true,
                              itemCount: selectedInterests.length,
                              itemBuilder: (context,index){
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Chip(
                                    backgroundColor: AppColors.primaryColor,
                                    side: const BorderSide(color: Colors.white),

                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadiusDirectional.circular(100)
                                    ),
                                    label:  GestureDetector(
                                        onTap: (){
                                          selectedInterests.removeAt(index);
                                          selectedInterestsIds.removeAt(index);
                                          if(selectedInterests.isEmpty){
                                            setState(() {

                                            });
                                          }
                                          _authController.updateHobbiesForPersonalInfo(selectedInterests[0],selectedInterestsIds);

                                          setState(() {});
                                        },
                                        child: Text(selectedInterests[index],style: TextStyle(color: AppColors.whiteColor),)),
                                    avatar: Icon(Icons.cancel,color: AppColors.whiteColor,),
                                  ),
                                );
                              }),
                        ),
                        // Obx(()=>_authController.showValidationMessage.value==true &&_authController.hobbiesForPersonalInfo.value.isEmpty? const Padding(
                        //   padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
                        //   child: Text("Please select hobbies",style: TextStyle(fontSize: 12,color: Colors.white),),
                        // ): spacing(),),
                        BoldText(Text: "What do you hope to gain from your Houston Hotpass membership?",color: AppColors.blackColor),

                        betweenHeadingAndfieldSpacing(),
                        // diamond
                        CustomDropDown(
                          dropDownButtonColor:AppColors.blackColor,
                          showDropDownIcon: false,
                          dropDownColor: AppColors.whiteColor,
                          dropDownBorderColor: AppColors.primaryColor,
                          dropDownHintTextColor: AppColors.blackColor,
                          dropDownTextColor: AppColors.blackColor,
                          isHowOftenDineOut:true,
                          hintText: _authController.userLoginData.value!.userAim.toString(),
                          dropDownData: memberShipOfHoustonData,
                          icon: AppIcons.diamondIcon, onChanged: (String? value) {
                          _authController.updateHotPassMemberShipAimForPersonalInfo(value!);
                        }, selectedValue: _authController.hotPassMemberShipAimForPersonalInfo.value,),
                        Obx(()=>_authController.showValidationMessage.value==true &&_authController.hotPassMemberShipAimForPersonalInfo.value.isEmpty? const Padding(
                          padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
                          child: Text("Please select hotpass membership aim",style: TextStyle(fontSize: 10,color: Colors.white),),
                        ): spacing(),),
                        const SizedBox(height: 50),
                        // additional fields to be added end
                        // Obx(()=>_authController.showValidationMessage.value==true &&_authController.dineOut.value.isEmpty? const Padding(
                        //   padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
                        //   child: Text("Please select dine out time",style: TextStyle(fontSize: 12,color: Colors.white),),
                        // ): const SizedBox(height: 15),),
                        // CustomTextField(
                        //   hintText: "How many times you typically eat out?",hintTextColor: Colors.black.withOpacity(0.7),
                        //   fillColor: Colors.white,
                        //     fieldBorderColor: AppColors.primaryColor,
                        //     fieldName: "How many times you typically eat out?",inputTextColor: Colors.black,
                        //   controller: _authController.editProfileInfoDineOutTimeController,
                        //     validator: (value) => CustomValidator.dineOutTime(value),
                        //
                        //     isEditProfileInfoScreen:true
                        //
                        // ),
                        // const SizedBox(height: 30),
                        CustomButton(
                          Text: "Save Changes",buttonColor: AppColors.primaryColor,textColor: Colors.white,
                          onTap: () {
                              if(_authController.imagePath.value.contains("https")){
                                _authController.imagePath.value='';
                              }
                            if(_authController.formKeyEditProfile.currentState!.validate() && selectedCuisines.isNotEmpty&& selectedInterests.isNotEmpty){
                              _authController.editProfile();
                              // Get.to(()=>const CustomBottomBarr());
                            }

                        },),
                        const SizedBox(height: 30),

                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget spacingBetweenFields() {
    return const SizedBox(height: 17);
  }
  Widget spacing() {
    return const SizedBox(height: 15);
  }
  Widget betweenHeadingAndfieldSpacing() {
    return const SizedBox(height: 8);
  }
}