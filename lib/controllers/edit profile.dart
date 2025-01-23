// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:houstan_hot_pass/app_bottom_nav_bar/bottom_nav_bar.dart';
// import 'package:houstan_hot_pass/app_widgets/app_button.dart';
// import 'package:houstan_hot_pass/app_widgets/bold_text.dart';
// import 'package:houstan_hot_pass/app_widgets/custom_appbar_background.dart';
// import 'package:houstan_hot_pass/app_widgets/custom_field%20.dart';
// import 'package:houstan_hot_pass/app_widgets/profile_picker.dart';
// import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
// import 'package:houstan_hot_pass/constants/app_colors.dart';
// import 'package:houstan_hot_pass/controllers/auth_controller.dart';
//
// import '../../app_widgets/app_subtitle_text.dart';
// import '../../app_widgets/custom_dropdown.dart';
// import '../../constants/app_icons.dart';
// import '../../constants/custom_validators.dart';
//
// class EditPersonalInfo extends StatefulWidget {
//   const EditPersonalInfo({super.key});
//
//   @override
//   State<EditPersonalInfo> createState() => _EditPersonalInfoState();
// }
//
// class _EditPersonalInfoState extends State<EditPersonalInfo> {
//   AuthController _authController=Get.find();
//   List<String> selectedCuisines=[];
//   List<String> selectedInterests=[];
//   List<String> selectedCuisinesIds=[];
//   List<String> selectedInterestsIds=[];
//   List<String> memberShipOfHoustonData = [
//     'Exploring new places',
//     'Saving money',
//     'VIP experiences',
//     ' Other',
//   ];
//   List<String> spendPerVisitData = [
//     'Under \$25',
//     '\$25 - \$50',
//     '\$51 - \$75',
//     '\$76 - \$100',
//     '\$101 - \$150',
//     ' Over \$150',
//   ];
//   List<String> ageRangeData = [
//     '18-24',
//     '25-34',
//     '35-44',
//     '45-54',
//     '55-64',
//     ' 65 and older',
//   ];
//   List<String> genderData = [
//     'Male',
//     'Female',
//     'Non-binary',
//     'Prefer not to say',
//     'Prefer to self-describe',
//   ];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _authController.editProfileInfoFirstNameController.text=_authController.userLoginData.value!.name.toString();
//     _authController.editProfileInfoEmailController.text=_authController.userLoginData.value!.email.toString();
//     _authController.editProfileInfoLocationController.text=_authController.userLoginData.value!.residentialLocation.title.toString();
//     _authController.editProfileInfoWorkAreaController.text=_authController.userLoginData.value!.commercialLocation.title.toString();
//     _authController.editProfileInfoDineOutTimeController.text=_authController.userLoginData.value!.oftenDineOut.toString();
//     _authController.updateDineOutInPersonalInfo(_authController.userLoginData.value!.oftenDineOut.toString());
//     // from here
//     selectedCuisines=_authController.userLoginData.value!.cuisines.map((cuisines) => cuisines.title.toString()).toList();
//     selectedCuisinesIds=_authController.userLoginData.value!.cuisines.map((cuisines) => cuisines.id.toString()).toList();
//     selectedInterests=_authController.userLoginData.value!.interests.map((interests) => interests.title.toString()).toList();
//     selectedInterestsIds=_authController.userLoginData.value!.interests.map((interests) => interests.id.toString()).toList();
//     _authController.updateFirstAndLastAgeFOrPersonalInfo(int.parse(_authController.userLoginData.value!.age.from),int.parse(_authController.userLoginData.value!.age.to));
//     _authController.genderControllerForPersonalInfo.text=_authController.userLoginData.value!.gender.toString();
//     _authController.updateSelectedGenderForPersonalInfo(_authController.userLoginData.value!.gender.toString());
//     _authController.updatePerCapitasForPersonalInfo(int.parse(_authController.userLoginData.value!.avgSpending.from),int.parse(_authController.userLoginData.value!.avgSpending.to));
//     _authController.updateFavoriteCuisinesForPersonalInfo(_authController.userLoginData.value!.cuisines[0].title,_authController.userLoginData.value!.cuisines.map((cuisine) => cuisine.id.toString()).toList());
//     _authController.updatePreferredDiningTimesForPersonalInfo(_authController.userLoginData.value!.diningTimes[0].title,_authController.userLoginData.value!.diningTimes[0].id);
//     _authController.updateHobbiesForPersonalInfo(_authController.userLoginData.value!.interests[0].title,_authController.userLoginData.value!.interests.map((interests) => interests.id.toString()).toList());
//     _authController.updateHotPassMemberShipAimForPersonalInfo(_authController.userLoginData.value!.userAim);
//     setState(() {
//
//     });
//     print(_authController.editProfileInfoDineOutTimeController.text);
//     // _authController.updateDineOutInPersonalInfo(_authController.userLoginData.value!.oftenDineOut);
//     // _authController.dineOutForPersonalInfo.value=_authController.userLoginData.value!.oftenDineOut;
//   }
//   List<String> dineOutData = [
//     'Rarely (0-1 times per month)',
//     'Occasionally (2-3 times per month)',
//     'Regularly (4-6 times per month)',
//     'Frequently (7-10 times per month)',
//     'Very Frequently (11+ times per month)',
//   ];
//   @override
//   Widget build(BuildContext context) {
//     print(_authController.imagePath.value);
//     return Scaffold(
//       body: Obx(
//             ()=> Column(
//           children: [
//             CustomAppBarBackGround(
//               showIcon: false,
//               showTextField: false,
//               showFiltersIcon: false,
//               showBackButton: true,
//               showScreenTitle: true,
//               screenTitle: "Edit Personal Info",
//               screenSubtitle: "Edit Personal Details",
//               showScreenSubtitle: true,
//               height: 125,
//             ),
//             Expanded(
//               child: CustomHorizontalPadding(
//                 child: SingleChildScrollView(
//                   child: Form(
//                     key: _authController.formKeyEditProfile,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 25),
//                         ProfilePicker(forMyProfile: true,imagePath: _authController.userLoginData.value!.image.toString(),),
//                         const SizedBox(height: 20),
//                         BoldText(Text: "First Name",color: AppColors.blackColor),
//                         const SizedBox(height: 7),
//                         CustomTextField(
//                             hintText: "First Name",hintTextColor: Colors.black.withOpacity(0.7),
//                             fillColor: Colors.white,
//                             fieldBorderColor: AppColors.primaryColor,
//                             fieldName: "First Name",inputTextColor: Colors.black,
//                             validator: (value) => CustomValidator.firstName(value),
//                             controller: _authController.editProfileInfoFirstNameController,
//                             isEditProfileInfoScreen:true
//                         ),
//                         spacingBetweenFields(),
//                         BoldText(Text: "Email Address:",color: AppColors.blackColor),
//                         const SizedBox(height: 7),
//
//                         AbsorbPointer(
//                           absorbing: true,
//                           child: CustomTextField(
//                               hintText: "Email Address",hintTextColor: Colors.black.withOpacity(0.7),
//                               fillColor: Colors.white,
//                               fieldBorderColor: AppColors.primaryColor,
//                               fieldName: "Email Address:",inputTextColor: Colors.black,keyboardType: TextInputType.emailAddress,
//                               validator: (value) => CustomValidator.email(value),
//                               controller: _authController.editProfileInfoEmailController,
//                               isEditProfileInfoScreen:true
//
//                           ),
//                         ),
//                         spacingBetweenFields(),
//                         BoldText(Text: "Where do you live?",color: AppColors.blackColor),
//                         const SizedBox(height: 7),
//                         CustomTextField(
//                             hintText: "Where do you live?",hintTextColor: Colors.black.withOpacity(0.7),
//
//                             fillColor: Colors.white,
//                             fieldBorderColor: AppColors.primaryColor,
//                             fieldName: "Where do you live?",inputTextColor: Colors.black,
//                             validator: (value) => CustomValidator.isEmptyLocation(value),
//                             controller: _authController.editProfileInfoLocationController,
//                             isEditProfileInfoScreen:true
//
//                         ),
//                         spacingBetweenFields(),
//                         BoldText(Text: "Which area you work in?",color: AppColors.blackColor),
//                         const SizedBox(height: 7),
//                         CustomTextField(
//                             hintText: "Which area you work in?",hintTextColor: Colors.black.withOpacity(0.7),
//
//                             fillColor: Colors.white,
//                             fieldBorderColor: AppColors.primaryColor,
//                             fieldName: "Which Area you work in?",inputTextColor: Colors.black,
//                             validator: (value) => CustomValidator.isEmptyWorkArea(value),
//                             controller: _authController.editProfileInfoWorkAreaController,
//                             isEditProfileInfoScreen:true
//
//                         ),
//                         spacingBetweenFields(),
//                         BoldText(Text: "How many times you typically eat out?",color: AppColors.blackColor),
//                         const SizedBox(height: 7),
//                         CustomDropDown(
//                           dropDownButtonColor:AppColors.blackColor,
//                           showDropDownIcon: false,
//                           dropDownColor: AppColors.whiteColor,
//                           dropDownBorderColor: AppColors.primaryColor,
//                           dropDownHintTextColor: AppColors.blackColor,
//                           dropDownTextColor: AppColors.blackColor,
//                           isHowOftenDineOut:true,
//                           selectedValue: _authController.dineOutForPersonalInfo.value,
//                           hintText: _authController.userLoginData.value!.oftenDineOut.toString(),
//                           dropDownData: dineOutData,
//                           icon: AppIcons.diningIcon,
//                           dropDownIconColor: AppColors.primaryColor,
//                           onChanged: (String? value) {
//                             _authController.updateDineOutInPersonalInfo(value!);
//                             _authController.updateDineOutInPersonalInfoController(value);
//                             setState(() {
//
//                             });
//                           },
//                         ),
//                         SizedBox(height: 15),
//                         // additional fields to be added start
//                         BoldText(Text: "What is your age range?",color: AppColors.blackColor),
//
//                         betweenHeadingAndfieldSpacing(),
//                         CustomDropDown(
//                           dropDownButtonColor:AppColors.blackColor,
//                           showDropDownIcon: false,
//                           dropDownColor: AppColors.whiteColor,
//                           dropDownBorderColor: AppColors.primaryColor,
//                           dropDownHintTextColor: AppColors.blackColor,
//                           dropDownTextColor: AppColors.blackColor,
//                           isHowOftenDineOut:true,
//                           selectedValue: _authController.selectedAgeForPersonalInfo.value,
//                           hintText: _authController.userLoginData.value!.age.from.toString()+'-'+_authController.userLoginData.value!.age.to.toString(),
//                           dropDownData: ageRangeData,
//                           icon: AppIcons.chooseAgeIcon, onChanged: (String? value) {
//                           _authController.updateSelectedAgeForPersonalInfo(value!);
//
//                           // Split the selectedAge string into two parts
//                           List<String> ageRange = value.split('-');
//
//                           // Handle the case where the range is in the format "65 and older"
//                           if (value.contains('and older')) {
//                             // Set first part to 65 and second part to 100
//                             int firstPart = 65;
//                             int secondPart = 100;
//                             _authController.updateFirstAndLastAgeFOrPersonalInfo(firstPart, secondPart);
//                           } else {
//                             // Otherwise, handle it as a normal range
//                             int? firstPart = ageRange.isNotEmpty ? int.tryParse(ageRange[0]) : null;
//                             int? secondPart = ageRange.length > 1 ? int.tryParse(ageRange[1]) : null;
//
//                             // Only update if both parts are valid integers
//                             if (firstPart != null && secondPart != null) {
//                               _authController.updateFirstAndLastAgeFOrPersonalInfo(firstPart, secondPart);
//                             } else {
//                               // Handle error or fallback scenario if necessary
//                               print('Invalid age range format.');
//
//                             }
//                           }
//                           // print(_authController.firstAge.value);
//                           // print(_authController.lastAge.value);
//                         },),
//                         Obx(()=>_authController.showValidationMessage.value==true &&_authController.selectedAgeForPersonalInfo.value.isEmpty? const Padding(
//                           padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
//                           child: Text("Please select age range",style: TextStyle(fontSize: 10,color: Colors.white),),
//                         ): spacing(),),
//
//                         BoldText(Text: "What is your gender?",color: AppColors.blackColor),
//
//                         betweenHeadingAndfieldSpacing(),
//
//                         CustomDropDown(
//                           dropDownButtonColor:AppColors.blackColor,
//                           showDropDownIcon: false,
//                           dropDownColor: AppColors.whiteColor,
//                           dropDownBorderColor: AppColors.primaryColor,
//                           dropDownHintTextColor: AppColors.blackColor,
//                           dropDownTextColor: AppColors.blackColor,
//                           isHowOftenDineOut:true,
//                           selectedValue: _authController.selectedGenderForPersonalInfo.value,
//                           // selectedValueOfDropDown:selectedGender ,
//                           hintText: _authController.userLoginData.value!.gender.toString(),
//                           dropDownData: genderData,
//                           icon: AppIcons.chooseGenderIcon,
//                           onChanged: (value) {
//                             _authController.updateSelectedGenderForPersonalInfo(value!);
//                             print(value);
//                           },
//                         ),
//
//                         if (_authController.selectedGenderForPersonalInfo.value == 'Prefer to self-describe')
//                           Padding(
//                             padding: const EdgeInsets.only(top: 16.0),
//                             child: CustomTextField(
//
//                               fieldBorderColor: AppColors.primaryColor,
//                               hintText: "write in your gender identity",
//                               fillColor: AppColors.whiteColor,
//                               hintTextColor: Colors.black.withOpacity(0.5),inputTextColor: Colors.black,
//                               validator: (value) => CustomValidator.selectGenderRange(value),
//                               controller: _authController.genderControllerForPersonalInfo,
//                             ),
//
//                           ),
//                         Obx(()=>_authController.showValidationMessage.value==true &&_authController.selectedGenderForPersonalInfo.value.isEmpty? const Padding(
//                           padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
//                           child: Text("Please select gender",style: TextStyle(fontSize: 12,color: Colors.white),),
//                         ): spacing(),),
//
//                         BoldText(Text: "How much do you typically spend per visit at a restaurant or on entertainment?",color: AppColors.blackColor),
//
//                         betweenHeadingAndfieldSpacing(),
//                         CustomDropDown(
//                           dropDownButtonColor:AppColors.blackColor,
//                           showDropDownIcon: false,
//                           dropDownColor: AppColors.whiteColor,
//                           dropDownBorderColor: AppColors.primaryColor,
//                           dropDownHintTextColor: AppColors.blackColor,
//                           dropDownTextColor: AppColors.blackColor,
//                           isHowOftenDineOut:true,
//                           selectedValue: _authController.averageSpendingForPersonalInfo.value,
//                           hintText:_authController.userLoginData.value!.avgSpending.from+(_authController.userLoginData.value!.avgSpending.from=='over' ||_authController.userLoginData.value!.avgSpending.from=='under'?' ${_authController.userLoginData.value!.avgSpending.to}':'-${_authController.userLoginData.value!.avgSpending.to}'),
//                           dropDownData: spendPerVisitData,
//                           icon: AppIcons.diningIcon,
//                           onChanged: (String? value) {
//
//                             int firstValue;
//                             int secondValue;
//                             if (value != null) {
//                               if (value == 'Under \$25') {
//                                 // Set firstValue and secondValue for 'Under $25'
//
//                                 firstValue = 0;
//                                 secondValue = 25;
//                                 _authController.updatePerCapitasForPersonalInfo(firstValue, secondValue);
//                                 print(_authController.firstCapitaValue.value);
//                                 print(_authController.lastCapitaValue.value);
//
//                               } else if (value.contains("Over")) {
//                                 // Set firstValue and secondValue for 'Over $150'
//                                 firstValue = 150;
//                                 secondValue = 500;
//                                 _authController.updatePerCapitasForPersonalInfo(firstValue, secondValue);
//                                 print(_authController.firstCapitaValue.value);
//                                 print(_authController.lastCapitaValue.value);
//                               } else if (value.contains('-')) {
//                                 // Extract range values for other options
//
//                                 final range = value.replaceAll('\$', '').split(' - ');
//                                 firstValue = int.parse(range[0]);
//                                 secondValue = int.parse(range[1]);
//                                 _authController.updatePerCapitasForPersonalInfo(firstValue, secondValue);
//                                 print(_authController.firstCapitaValue.value);
//                                 print(_authController.lastCapitaValue.value);
//
//                               }
//                             }
//
//                             _authController.updateAverageSpendingForPersonalInfo(value!);
//
//                           },
//                         ),
//                         Obx(()=>_authController.showValidationMessage.value==true &&_authController.averageSpending.value.isEmpty? const Padding(
//                           padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
//                           child: Text("Please select average spending",style: TextStyle(fontSize: 10,color: Colors.white),),
//                         ): spacing(),),
//                         // to here
//                         selectedCuisines.isEmpty ||selectedCuisines.length<2?Container(): SizedBox(
//                           height: 50,
//                           child: ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               // shrinkWrap: true,
//                               itemCount: selectedCuisines.length,
//                               itemBuilder: (context,index){
//                                 return Padding(
//                                   padding: const EdgeInsets.only(right: 5),
//                                   child: Chip(
//                                     side: const BorderSide(color: Colors.white),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadiusDirectional.circular(100),
//                                     ),
//                                     label:  GestureDetector(
//                                         onTap: (){
//                                           print(selectedCuisines.length);
//                                           selectedCuisines.removeAt(index);
//                                           selectedCuisinesIds.removeAt(index);
//                                           _authController.updateFavoriteCuisinesForPersonalInfo(_authController.userLoginData.value!.cuisines[0].title,selectedCuisinesIds);
//                                           setState(() {});
//                                         },
//                                         child: Text(selectedCuisines[index])),
//                                     avatar:  Icon(Icons.cancel,color: AppColors.primaryColor,),
//                                   ),
//                                 );
//                               }),
//                         ),
//                         BoldText(Text: "What are your favorite cuisines?",color: AppColors.blackColor),
//                         betweenHeadingAndfieldSpacing(),
//                         CustomDropDown(
//                           dropDownButtonColor:AppColors.blackColor,
//                           showDropDownIcon: false,
//                           dropDownColor: AppColors.whiteColor,
//                           dropDownBorderColor: AppColors.primaryColor,
//                           dropDownHintTextColor: AppColors.blackColor,
//                           dropDownTextColor: AppColors.blackColor,
//                           isHowOftenDineOut:true,
//                           selectedValue: _authController.favouriteCuisinesForPersonalInfo.value,
//                           hintText: _authController.userLoginData.value!.cuisines[0].title.toString(),
//                           dropDownData: _authController.cuisinesList.map((e)=>e.title).toList(),
//                           icon: AppIcons.diningIcon,
//                           onChanged: (String? value) {
//                             final selectedCuisine = _authController.cuisinesList.firstWhere(
//                                   (cuisine) => cuisine.title == value,);
//                             if(selectedCuisines.contains(selectedCuisine.title)){
//                               print("empty");
//                             }else{
//                               selectedCuisines.add(selectedCuisine.title);
//                               selectedCuisinesIds.add(selectedCuisine.id.toString());
//                               _authController.updateFavoriteCuisinesForPersonalInfo(value!,selectedCuisinesIds);
//                               setState(() {
//                               });
//                             }
//                           },
//                         ),
//                         Obx(()=>_authController.showValidationMessage.value==true &&_authController.favouriteCuisinesForPersonalInfo.value.isEmpty? const Padding(
//                           padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
//                           child: Text("Please select favorite cuisine",style: TextStyle(fontSize: 10,color: Colors.white),),
//                         ): spacing(),),
//                         BoldText(Text: "What are your preferred dining times?",color: AppColors.blackColor),
//
//                         betweenHeadingAndfieldSpacing(),
//                         CustomDropDown(
//                           dropDownButtonColor:AppColors.blackColor,
//                           showDropDownIcon: false,
//                           dropDownColor: AppColors.whiteColor,
//                           dropDownBorderColor: AppColors.primaryColor,
//                           dropDownHintTextColor: AppColors.blackColor,
//                           dropDownTextColor: AppColors.blackColor,
//                           isHowOftenDineOut:true,
//                           selectedValue: _authController.preferredDiningTimesForPersonalInfo.value,
//                           hintText: _authController.userLoginData.value!.diningTimes[0].title.toString(),
//                           dropDownData: _authController.diningTimesList.map((e)=>e.title).toList(),
//                           icon: AppIcons.diningIcon,
//                           onChanged: (String? value) {
//                             final preferredDiningTimes = _authController.diningTimesList.firstWhere(
//                                   (preferredDiningTimes) => preferredDiningTimes.title == value,);
//                             _authController.updatePreferredDiningTimesForPersonalInfo(value!,preferredDiningTimes.id);
//
//                           },
//                         ),
//
//                         Obx(()=>_authController.showValidationMessage.value==true &&_authController.preferredDiningTimesForPersonalInfo.value.isEmpty? const Padding(
//                           padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
//                           child: Text("Please select dine out time",style: TextStyle(fontSize: 12,color: Colors.white),),
//                         ): spacing(),),
//                         selectedInterests.isEmpty||selectedInterests.length<2?Container(): SizedBox(
//                           height: 50,
//                           child: ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               // shrinkWrap: true,
//                               itemCount: selectedInterests.length,
//                               itemBuilder: (context,index){
//                                 return Padding(
//                                   padding: const EdgeInsets.only(right: 5),
//                                   child: Chip(
//                                     side: const BorderSide(color: Colors.white),
//
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadiusDirectional.circular(100)
//                                     ),
//                                     label:  GestureDetector(
//                                         onTap: (){
//                                           selectedInterests.removeAt(index);
//                                           selectedInterestsIds.removeAt(index);
//                                           _authController.updateHobbiesForPersonalInfo(_authController.userLoginData.value!.interests[0].title,selectedInterestsIds);
//
//                                           setState(() {});
//                                         },
//                                         child: Text(selectedInterests[index])),
//                                     avatar: Icon(Icons.cancel,color: AppColors.primaryColor,),
//                                   ),
//                                 );
//                               }),
//                         ),
//                         BoldText(Text: "What other hobbies and interests do you have?",color: AppColors.blackColor),
//
//                         betweenHeadingAndfieldSpacing(),
//                         CustomDropDown(
//                           dropDownButtonColor:AppColors.blackColor,
//                           showDropDownIcon: false,
//                           dropDownColor: AppColors.whiteColor,
//                           dropDownBorderColor: AppColors.primaryColor,
//                           dropDownHintTextColor: AppColors.blackColor,
//                           dropDownTextColor: AppColors.blackColor,
//                           isHowOftenDineOut:true,
//                           selectedValue: _authController.hobbiesForPersonalInfo.value,
//                           hintText: _authController.userLoginData.value!.cuisines[0].title.toString(),
//                           dropDownData: _authController.interestsList.map((e)=>e.title).toList(),
//                           icon: AppIcons.interestsAndHobbiesIcon,
//                           onChanged: (String? value) {
//                             final interests = _authController.interestsList.firstWhere(
//                                   (interests) => interests.title == value,);
//
//                             if(selectedInterests.contains(interests.title)){
//                               print("already selected");
//                             }else{
//                               selectedInterests.add(interests.title);
//                               selectedInterestsIds.add(interests.id.toString());
//                               _authController.updateHobbiesForPersonalInfo(value!,selectedInterestsIds);
//                               setState(() {
//                               });
//                             }
//                           },
//                         ),
//                         Obx(()=>_authController.showValidationMessage.value==true &&_authController.hobbiesForPersonalInfo.value.isEmpty? const Padding(
//                           padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
//                           child: Text("Please select hobbies",style: TextStyle(fontSize: 12,color: Colors.white),),
//                         ): spacing(),),
//                         BoldText(Text: "What do you hope to gain from your Houston Hotpass membership?",color: AppColors.blackColor),
//
//                         betweenHeadingAndfieldSpacing(),
//                         // diamond
//                         CustomDropDown(
//                           dropDownButtonColor:AppColors.blackColor,
//                           showDropDownIcon: false,
//                           dropDownColor: AppColors.whiteColor,
//                           dropDownBorderColor: AppColors.primaryColor,
//                           dropDownHintTextColor: AppColors.blackColor,
//                           dropDownTextColor: AppColors.blackColor,
//                           isHowOftenDineOut:true,
//                           hintText: _authController.userLoginData.value!.userAim.toString(),
//                           dropDownData: memberShipOfHoustonData,
//                           icon: AppIcons.diamondIcon, onChanged: (String? value) {
//                           _authController.updateHotPassMemberShipAimForPersonalInfo(value!);
//                         }, selectedValue: _authController.hotPassMemberShipAimForPersonalInfo.value,),
//                         Obx(()=>_authController.showValidationMessage.value==true &&_authController.hotPassMemberShipAimForPersonalInfo.value.isEmpty? const Padding(
//                           padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
//                           child: Text("Please select hotpass membership aim",style: TextStyle(fontSize: 10,color: Colors.white),),
//                         ): spacing(),),
//                         const SizedBox(height: 50),
//                         // additional fields to be added end
//                         // Obx(()=>_authController.showValidationMessage.value==true &&_authController.dineOut.value.isEmpty? const Padding(
//                         //   padding: EdgeInsets.only(top: 3,left: 20,bottom: 10),
//                         //   child: Text("Please select dine out time",style: TextStyle(fontSize: 12,color: Colors.white),),
//                         // ): const SizedBox(height: 15),),
//                         // CustomTextField(
//                         //   hintText: "How many times you typically eat out?",hintTextColor: Colors.black.withOpacity(0.7),
//                         //   fillColor: Colors.white,
//                         //     fieldBorderColor: AppColors.primaryColor,
//                         //     fieldName: "How many times you typically eat out?",inputTextColor: Colors.black,
//                         //   controller: _authController.editProfileInfoDineOutTimeController,
//                         //     validator: (value) => CustomValidator.dineOutTime(value),
//                         //
//                         //     isEditProfileInfoScreen:true
//                         //
//                         // ),
//                         // const SizedBox(height: 30),
//                         CustomButton(
//                           Text: "Save Changes",buttonColor: AppColors.primaryColor,textColor: Colors.white,
//                           onTap: () {
//                             if(_authController.imagePath.value.contains("https")){
//                               _authController.imagePath.value='';
//                             }
//                             if(_authController.formKeyEditProfile.currentState!.validate()){
//                               _authController.editProfile();
//                               // Get.to(()=>const CustomBottomBarr());
//                             }
//
//                           },),
//                         const SizedBox(height: 30),
//
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget spacingBetweenFields() {
//     return const SizedBox(height: 17);
//   }
//   Widget spacing() {
//     return const SizedBox(height: 15);
//   }
//   Widget betweenHeadingAndfieldSpacing() {
//     return const SizedBox(height: 8);
//   }
// }
//
//
//
//
//
// // fst
// void updateSelectedAge(String value){
//   selectedAge.value=value;
// }
// void updateSelectedAgeForPersonalInfo(String value){
//   selectedAgeForPersonalInfo.value=value;
// }
// void updateAverageSpending(String value){
//   averageSpending.value=value;
// }
// void updateAverageSpendingForPersonalInfo(String value){
//   averageSpendingForPersonalInfo.value=value;
// }
// void updateFirstAndLastAge(int fAge,int lAge){
//   firstAge.value=fAge;
//   lastAge.value=lAge;
// }
// void updateFirstAndLastAgeFOrPersonalInfo(int fAge,int lAge){
//   firstAgeForPersonalInfo.value=fAge;
//   lastAgeForPersonalInfo.value=lAge;
// }
// void updatePerCapitas(int fValue,int sValue){
//   firstCapitaValue.value=fValue;
//   lastCapitaValue.value=sValue;
// }
// void updatePerCapitasForPersonalInfo(int fValue,int sValue){
//   firstCapitaValueForPersonalInfo.value=fValue;
//   lastCapitaValueForPersonalInfo.value=sValue;
// }
// void updateSelectedGender(String value){
//   selectedGender.value=value;
// }
// void updateSelectedGenderForPersonalInfo(String value){
//   selectedGenderForPersonalInfo.value=value[0].toUpperCase() + value.substring(1);
// }
// void updateHotPassMemberShipAim(String value){
//   hotPassMemberShipAim.value=value;
// }
// void updateHotPassMemberShipAimForPersonalInfo(String value){
//   hotPassMemberShipAimForPersonalInfo.value=value;
// }
// void updateFavoriteCuisines(String value,int id,List<String> cuisinesId){
//   favouriteCuisines.value=value;
//   cuisineId.value=id;
//   cuisineIds.value=cuisinesId;
// }
// void updateFavoriteCuisinesForPersonalInfo(String value,List<String> cuisinesId){
//   favouriteCuisinesForPersonalInfo.value=value;
//
//
//   cuisineIdsForPersonalInfo.value=cuisinesId;
// }
// void updatePreferredDiningTimes(String value,int id){
//   preferredDiningTimes.value=value;
//   preferredDiningTimesId.value=id;
// }
// void updatePreferredDiningTimesForPersonalInfo(String value,int id){
//   preferredDiningTimesForPersonalInfo.value=value;
//   preferredDiningTimesIdForPersonalInfo.value=id;
// }
// void updateDineOut(String value){
//   dineOut.value=value;
// }
// void updateDineOutInPersonalInfo(String value){
//   dineOutForPersonalInfo.value=value;
// }
// void updateDineOutInPersonalInfoController(String value){
//   editProfileInfoDineOutTimeController.text=value;
// }
// void updateEmail(String value){
//   email.value=value;
// }
// void updateHobbies(String value,int id,List<String> interestsId){
//   hobbies.value=value;
//   hobbiesId.value=id;
//   interestsIds.value=interestsId;
// }
// void updateHobbiesForPersonalInfo(String value,List<String> interestsId){
//   hobbiesForPersonalInfo.value=value;
//   interestsIdsForPersonalInfo.value=interestsId;
// }
//
//
// RxString selectedAgeForPersonalInfo=''.obs;
// RxInt firstAgeForPersonalInfo=0.obs;
// RxInt lastAgeForPersonalInfo=0.obs;
// RxString selectedGenderForPersonalInfo=''.obs;
// RxString averageSpendingForPersonalInfo=''.obs;
// RxInt firstCapitaValueForPersonalInfo=034.obs;
// RxInt lastCapitaValueForPersonalInfo=0.obs;
// RxString favouriteCuisinesForPersonalInfo=''.obs;
// RxInt cuisineIdForPersonalInfo=0.obs;
// RxList<String> cuisineIdsForPersonalInfo=<String>[].obs;
// RxString preferredDiningTimesForPersonalInfo=''.obs;
// RxInt preferredDiningTimesIdForPersonalInfo=0.obs;
// RxString hobbiesForPersonalInfo=''.obs;
// RxInt hobbiesIdForPersonalInfo=0.obs;
// RxList<String> interestsIdsForPersonalInfo=<String>[].obs;
// RxString hotPassMemberShipAimForPersonalInfo=''.obs;
//
//
// import 'dart:async';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:houstan_hot_pass/app_widgets/alertbox.dart';
// import 'package:houstan_hot_pass/app_widgets/app_button.dart';
// import 'package:houstan_hot_pass/app_widgets/app_subtitle_text.dart';
// import 'package:houstan_hot_pass/app_widgets/scaffold_symmetric_padding.dart';
// import 'package:houstan_hot_pass/app_widgets/shimmer_single_widget.dart';
// import 'package:houstan_hot_pass/constants/app_colors.dart';
// import 'package:houstan_hot_pass/app_widgets/custom_appbar_background.dart';
// import 'package:houstan_hot_pass/controllers/auth_controller.dart';
// import 'package:houstan_hot_pass/controllers/general_controller.dart';
// import 'package:houstan_hot_pass/controllers/offers_controller.dart';
// import 'package:houstan_hot_pass/controllers/timer_controller.dart';
// import 'package:houstan_hot_pass/views/auth_screens/sign_in/sign_in_screen.dart';
// import 'package:pretty_qr_code/pretty_qr_code.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../app_bottom_nav_bar/bottom_nav_bar.dart';
// import '../../app_widgets/QR_scanner.dart';
// import '../../constants/app_icons.dart';
// import '../../constants/app_images.dart';
// import '../auth_screens/sign_up/sign_up_screeen.dart';
//
// class RedeemOffersScreen extends StatefulWidget {
//   RedeemOffersScreen({super.key,this.offerId,this.imagePath,this.title,this.description,this.validTill});
//   String? offerId;
//   String? imagePath;
//   String? title;
//   String? description;
//   String? validTill;
//
//
//   @override
//   State<RedeemOffersScreen> createState() => _RedeemOffersScreenState();
// }
//
// class _RedeemOffersScreenState extends State<RedeemOffersScreen> {
//
//   // void initState() {
//   //   super.initState();
//   //
//   //   // Show popup after 10 seconds
//   //   Future.delayed(const Duration(seconds: 10), () {
//   //     // Show dialog
//   //     showDialog(
//   //       context: context,
//   //       builder: (BuildContext context) {
//   //         return CustomAlertDialog(
//   //           heading: "Driver Has Arrived",
//   //           subHeading: "Enjoy your meal! See you in next order :)",
//   //           buttonName: "Complete Order",img: AppIcons.successIcon,onTapped: () {
//   //           Get.to(());
//   //         },);
//   //       },
//   //     );
//   //   });
//   // }
//
//   // bool showQrCode = false;
//   bool showMessage = false;
//   // late Timer _timer;
//   // int _countdown = 60;
//   // bool _resendVisible = false;
//   // bool _regenerateVisible = false;
//   // bool _showTimerValues = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _offersController.showQrCode.value=false;
//
//     _timerControlle.regenerateVisible.value=false;
//     _offersController.getData(widget.offerId!);
//     // Future.delayed(Duration(seconds: 5));
//
//     // Future.delayed(const Duration(seconds: 10), () {
//     //   // Show dialog
//     //   showDialog(
//     //     context: context,
//     //     builder: (BuildContext context) {
//     //       return CustomAlertDialog(
//     //         heading: "Offer Redeemed successfully",
//     //         subHeading: "Congratulations! Discount Offer has been redemmed successfully.enjoy your meal ☺️!",
//     //         buttonName: "Great",img: AppIcons.successIcon,onTapped: () {
//     //         Get.back();
//     //       },);
//     //     },
//     //   );
//     // });
//
//     showMessage = false;
//     // startTimer();
//   }
//
//   @override
//   void dispose() {
//     _timerControlle.timer.cancel();
//     super.dispose();
//   }
//
//   // void startTimer() {
//   //   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//   //     setState(() {
//   //       if (_countdown > 0) {
//   //         _countdown--;
//   //       } else {
//   //         _timer.cancel();
//   //         _resendVisible = true;
//   //         _regenerateVisible = true; // Show regenerate text
//   //       }
//   //     });
//   //   });
//   // }
//
//   // void resendOtp() {
//   //   // Logic to resend OTP, e.g., make API call
//   //   setState(() {
//   //     _countdown = 60; // Reset countdown
//   //     _resendVisible = false; // Hide resend button
//   //     _regenerateVisible = false; // Hide regenerate text
//   //   });
//   //   startTimer(); // Start
//   //   // the timer again
//   // }
//   GeneralController _generalController=Get.find();
//   OffersController _offersController=Get.find();
//   AuthController _authController=Get.find();
//   TimerController _timerControlle=Get.find();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(
//             ()=> Column(
//           children: [
//             const CustomAppBarBackGround(
//               showTextField: false,
//               showFiltersIcon: false,
//               showBackButton: true,
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: CustomHorizontalPadding(
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 15),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const AppSubtitleText(
//                               Text: 'Offer', color: Colors.black, fontSize: 20),
//                           AppSubtitleText(
//                             Text:widget.validTill?? "Valid Until: 7/26/2024",
//                             color: AppColors.primaryColor,
//                             fontSize: 13,
//                           )
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       SizedBox(
//                         height: 190,
//                         width: 90.w,
//                         child: Stack(
//                           fit: StackFit.expand,
//                           children: [
//                             CachedNetworkImage(
//                               // memCacheWidth: 150,
//                               // memCacheHeight: 150,
//                               // maxHeightDiskCache: 150,
//                               // maxWidthDiskCache: 150,
//                               imageUrl:widget.imagePath??AppImages.foodTileImg,
//                               placeholder: (context, url) =>
//                                   Center(
//                                       child: ShimmerSingleWidget(shimmerWidth: 90.w)),
//                               errorWidget: (context, url,
//                                   error) =>
//                                   Image.asset(
//                                     AppImages.foodTileImg,scale: 5.3,
//                                     // color:   widget.forMyProfile==false?AppColors.whiteColor:AppColors.primaryColor,
//
//                                   ),
//                               fit: BoxFit.cover,
//                               scale:20 ,
//                               // width: double.infinity,
//                               // height: 250,
//                             ),
//                             // Image.asset(AppImages.foodTileImg, fit: BoxFit.cover),
//                             Positioned(
//                               bottom: 10,
//                               left: 10,
//                               child: Container(
//                                 width: 85.w,
//                                 decoration: BoxDecoration(
//                                   color: AppColors.whiteColor,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: AppColors.primaryColor, // Shadow color
//                                       spreadRadius: 1, // The radius of the shadow
//                                       blurRadius: 0, // The blur effect
//                                       offset: const Offset(0, -5), // Offset of the shadow
//                                     ),
//                                   ],
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 10, vertical: 17),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       AppSubtitleText(
//                                         Text: widget.title??'curry pizza guys',
//                                         color: Colors.black,
//                                         height: 1,
//                                         maxLines: 3,
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Text(
//                                         widget.description??'30% Off On All-You-Can-Eat',
//                                         overflow: TextOverflow.ellipsis,
//                                         maxLines: 2,
//                                         style: const TextStyle(
//                                           fontFamily: "regular",
//                                           fontSize: 10,
//                                           color: Colors.black,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       if (_offersController.showQrCode.value) ...[
//                         _offersController.codeType.value=='code'?
//                         Column(
//                           children: [
//                             Text(
//                               "Ask staff to use this code to redeem offer.",
//                               textAlign: TextAlign.start,
//                               style: TextStyle(
//
//                                   fontFamily: "fontspring-semibold",
//                                   fontSize: 20,
//                                   color: AppColors.blackColor),
//                             ),
//                             SizedBox(height: 10.h),
//                             const SizedBox(height: 10),
//                             Container(
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   border: Border.all(
//                                       width: 3,
//                                       color: AppColors.primaryColor
//                                   )),
//                               height: 60,
//                               width: 200,
//                               child: Center(
//                                 child: Text(
//                                   _offersController.qrCodeDataForRedeemingOffer.value,
//                                   style: TextStyle(
//                                     // fontFamily: "fontspring-semibold",
//                                       fontSize: 24,
//                                       color: AppColors.primaryColor),
//                                 ),
//                               ),
//                             ),
//                             _offersController.codeType.value=='code'?SizedBox(height: 10.h):Container(),
//
//                           ],
//                         ) : Column(
//                           children: [
//                             Text(
//                               "Offer QR code",
//                               style: TextStyle(
//                                   fontFamily: "fontspring-semibold",
//                                   fontSize: 20,
//                                   color: AppColors.primaryColor),
//                             ),
//                             const SizedBox(height: 10),
//                             // customQrScanner(),
//                             SizedBox(
//                               height: 280,
//                               width: 280,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
//                                 child: QrImageView(
//                                   data: _offersController.qrCodeDataForRedeemingOffer.value,
//                                   version: QrVersions.auto,
//                                   size: 200.0,
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//
//                       ] else
//                         const SizedBox(height: 80),
//
//                       if (!_offersController.showQrCode.value)
//                         CustomButton(
//                           Text: "REDEEM",
//                           buttonColor: AppColors.primaryColor,
//                           textColor: Colors.white,
//                           onTap: () {
//                             if(_authController.userStatusForShowingPopups.value=='false'){
//                               showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return CustomAlertDialog(
//                                     height: 370,
//                                     heading: "Want to Redeem Offers?",
//                                     subHeading: "You need to sign in to redeem this offer.",
//                                     buttonName: "Continue",img: AppIcons.questionMarkIcon,onTapped: () {
//                                     Get.back();
//                                     _generalController.onBottomBarTapped(0);
//                                     Get.off(() => const CustomBottomBarr());
//                                     Get.to(()=>const SignInScreen());
//                                   },);
//                                 },
//                               );
//                             }else if(_authController.userStatusForShowingPopups.value==''){
//                               showDialog(
//
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return CustomAlertDialog(
//                                     height: 370,
//                                     heading: "Want to Redeem Offers?",
//                                     subHeading: "You need to sign up in to redeem this offer.",
//                                     buttonName: "Continue",img: AppIcons.questionMarkIcon,onTapped: () {
//                                     Get.back();
//                                     _generalController.onBottomBarTapped(0);
//                                     Get.off(() => const CustomBottomBarr());
//                                     Get.to(()=>const SignUpScreeen());
//                                   },);
//                                 },
//                               );
//                             }else{
//                               // _timerControlle.startTimer();
//                               _offersController.redeemOffer(widget.offerId??'',context);
//                               // setState(() {
//                               //   _offersController.showQrCode.value = !_offersController.showQrCode.value;
//                               // });
//                             }
//
//                           },
//                         ),
//                       // const SizedBox(height: 10),
//                       if (_timerControlle.regenerateVisible.value)
//                         GestureDetector(
//                           onTap: () {
//                             // _offersController.showQrCode.value=!_offersController.showQrCode.value;
//                             if(_authController.userStatusForShowingPopups.value=='false'){
//                               showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return CustomAlertDialog(
//                                     height: 370,
//                                     heading: "Want to Redeem Offers?",
//                                     subHeading: "You need to sign in to redeem this offer.",
//                                     buttonName: "Continue",img: AppIcons.questionMarkIcon,onTapped: () {
//                                     Get.back();
//                                     _generalController.onBottomBarTapped(0);
//                                     Get.off(() => const CustomBottomBarr());
//                                     Get.to(()=>const SignInScreen());
//                                   },);
//                                 },
//                               );
//                             }else if(_authController.userStatusForShowingPopups.value==''){
//                               showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return CustomAlertDialog(
//                                     height: 370,
//                                     heading: "Want to Redeem Offers?",
//                                     subHeading: "You need to sign up in to redeem this offer.",
//                                     buttonName: "Continue",img: AppIcons.questionMarkIcon,onTapped: () {
//                                     Get.back();
//                                     _generalController.onBottomBarTapped(0);
//                                     Get.off(() => const CustomBottomBarr());
//                                     Get.to(()=>const SignUpScreeen());
//                                   },);
//                                 },
//                               );
//                             }else{
//                               // resendOtp();
//                               // _offersController.showQrCode.value=true;
//                               _offersController.redeemOffer(widget.offerId??'',context);
//
//                               // setState(() {
//                               //   _showTimerValues=true;
//                               // });
//
//                               // setState(() {
//                               //   _offersController.showQrCode.value = !_offersController.showQrCode.value;
//                               // });
//                             }
//
//                           },
//                           child: Text(
//                             "Regenerate",
//                             style: TextStyle(
//                                 color: AppColors.primaryColor,
//                                 fontSize: 20,
//                                 fontFamily: "bold"),
//                           ),
//                         ),
//                       // const SizedBox(height: 13,),
//                       Text(
//                         _timerControlle.resendVisible.value ? '' :_offersController.showQrCode.value==true? ' 00:${_timerControlle.countdown.toString().padLeft(2, '0')}':'', // Use padLeft to format
//                         // _resendVisible ? '' : ' 00:$_countdown',
//                         style: TextStyle(
//                             color: AppColors.primaryColor,
//                             fontSize: 20,
//                             fontFamily: "bold"),
//                       ),
//                       _timerControlle.regenerateVisible.value?Container():_offersController.showQrCode.value==true?  AppSubtitleText(
//                         Text: "Seconds left",
//                         fontSize: 15,
//                       ):Container(),
//                       SizedBox(height: 20,)
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// RxString codeType = ''.obs;
//
// Future redeemOffer(String offerId,BuildContext context) async {
//   _baseController.showLoading();
//   Map<String, String> body = {
//     'offer_id': offerId
//   };
//   var response = await DataApiService.instance
//       .post('user/redeem-offer', body)
//       .catchError((error) {
//     if (error is BadRequestException) {
//       var apiError = json.decode(error.message!);
//       CustomDialog.showErrorDialog(description: apiError["reason"]);
//     } else {
//       _baseController.handleError(error);
//     }
//   });
//   update();
//   _baseController.hideLoading();
//   if (response == null) return;
//   print(response+ "responded");
//   var result = json.decode(response);
//   if (result['success']) {
//
//     print(result['type'].toString()+"this is code");
//     if(result['type']=='qr_code'){
//       codeType.value='qr_code';
//       showQrCode.value = true;
//       qrCodeDataForRedeemingOffer.value=result['code'];
//
//       print(qrCodeDataForRedeemingOffer.value);
//       _timerController.resendOtp();
//     }else{
//       showQrCode.value = true;
//       codeType.value='code';
//       qrCodeDataForRedeemingOffer.value=result['code'];
//       _timerController.resendOtp();
//     }
//
//     // Get.offAll(() => Login());
//
//     // showDialog(
//     //   context: context,
//     //   builder: (BuildContext context) {
//     //     return CustomAlertDialog(
//     //       heading: "Offer Redeemed successfully",
//     //       subHeading: "Congratulations! Discount Offer has been redemmed successfully.enjoy your meal ☺️!",
//     //       buttonName: "Great",img: AppIcons.successIcon,onTapped: () {
//     //       Get.back();
//     //       Get.back();
//     //     },);
//     //   },
//     // );
//
//
//   } else {
//     List<dynamic> errorMessage=result['message'];
//     String message=errorMessage.join();
//     CustomDialog.showErrorDialog(description: message);
//   }
// }