import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class CustomDropDown extends StatefulWidget {
   CustomDropDown({super.key, required this.hintText, required this.dropDownData, required this.icon,required this.onChanged,required this.selectedValue,this.isHowOftenDineOut,this.dropDownColor,this.dropDownBorderColor,this.dropDownHintTextColor,this.dropDownIconColor,this.dropDownTextColor,this.showDropDownIcon=true,this.dropDownButtonColor});
  final String hintText;
  final List<String> dropDownData;
  final String icon;
  void Function(String?)? onChanged;
  final String? selectedValue;
  final bool? isHowOftenDineOut;
  final Color? dropDownColor;
  final Color? dropDownBorderColor;
  final Color? dropDownHintTextColor;
  final Color? dropDownIconColor;
  final Color? dropDownTextColor;
  final bool showDropDownIcon;
   final Color? dropDownButtonColor;
  // Added icon parameter

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {


  @override
  Widget build(BuildContext context) {
    return Container(
      height:widget.isHowOftenDineOut==true?60: 55,
      width: 90.w,
      decoration: BoxDecoration(
        border: Border.all(color:widget.dropDownBorderColor?? AppColors.whiteColor),
        color:widget.dropDownColor?? AppColors.primaryColor,
      ),
      child: DropdownButtonHideUnderline(


        child: DropdownButton2<String>(


          iconStyleData: IconStyleData(icon: Image.asset("assets/app_icons/dropdown_icon.png",scale: 4,color: widget.dropDownButtonColor??AppColors.whiteColor,)),
          dropdownStyleData: DropdownStyleData(

            decoration: BoxDecoration(
              color: AppColors.primaryColor,
            ),
          ),
          isExpanded: true,
          hint: Row(
            children: [
           widget.showDropDownIcon==false?Container():  Image.asset(widget.icon,scale: 3,color: widget.dropDownIconColor??AppColors.whiteColor,),  // Display the icon
              SizedBox(width: 10), // Add spacing between icon and text
              Text(
                widget.hintText,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "medium",
                  color:widget.dropDownHintTextColor?? AppColors.whiteColor.withOpacity(0.7)
                ),
              ),
            ],
          ),
          items: widget.dropDownData
              .map((String item) => DropdownMenuItem<String>(

            value: item,
            child: Text(
              item,
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 16,
                fontFamily: "medium"
              ),
            ),
          ))
              .toList(),
          value: widget.selectedValue!.isEmpty?null:widget.selectedValue,
          selectedItemBuilder: (context) {
            return widget.dropDownData.map((String item) {

              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item,
                  style: TextStyle(
                    fontFamily: "medium",
                    color:widget.dropDownTextColor?? AppColors.whiteColor, // Color of the selected value
                    fontSize: 16,
                  ),
                ),
              );
            }).toList();
          },
          onChanged: widget.onChanged,

          buttonStyleData: const ButtonStyleData(
                // decoration: BoxDecoration(color: Colors.green),
            padding: EdgeInsets.only(right: 20),
            height: 55,
            // width: 140,
          ),
          menuItemStyleData: const MenuItemStyleData(



            height: 55,
          ),
        ),
      ),
    );
  }
}
