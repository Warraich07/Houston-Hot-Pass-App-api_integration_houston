import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:houstan_hot_pass/app_widgets/bold_text.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:sizer/sizer.dart';


/// Text Field
class CustomTextField extends StatefulWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final String? prefixIcon;
  final bool? isObscure;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final onChanged;
  final String? suffixText;
  final String? prefixText;
  final String? fieldName;
  final inputFormatters;
  final bool? enabled;
  final String? heading;
  final int? maxLines;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final Color? hintTextColor;
  final Color? fieldBorderColor;
  final Color? fillColor;
  final Color? inputTextColor;
  final double? scale;
  final  Function()? onTap;
  final bool isEditProfileInfoScreen;
  final FocusNode? focusNode;
  void Function(String)? onFieldSubmitted;
   CustomTextField(
      {super.key,
      this.hintText,
      this.suffixIcon,
      this.isObscure,
      this.prefixIcon,
      this.validator,
      this.keyboardType,
      this.suffixText,
      this.prefixText,
      this.onChanged,
      this.controller,
      this.inputFormatters,
      this.heading,
        this.focusNode,this.onFieldSubmitted,
      this.enabled, this.maxLines, this.prefixIconColor, this.scale, this.onTap, this.fieldName, this.hintTextColor, this.fillColor, this.inputTextColor, this.fieldBorderColor, this.suffixIconColor,this.isEditProfileInfoScreen=false
        });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return
        Column(crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // Padding(
            //   padding: const EdgeInsets.only(left: 13.0),
            //   child: BoldText(Text: widget.fieldName.toString()?? '',color: Colors.black),
            // ),
            // SizedBox(height: 5),
            TextSelectionTheme(
              data: TextSelectionThemeData(
                cursorColor: Colors.black, // Sets the cursor color
                selectionColor: Colors.grey, // Color for selected text
                selectionHandleColor: AppColors.blackColor, // Color for the selection handles
              ),
              child: TextFormField(
             onFieldSubmitted: widget.onFieldSubmitted,
                focusNode: widget.focusNode,
                // enabled: widget.enabled??true,
                readOnly: widget.enabled ?? false,
                keyboardType: widget.keyboardType,
                validator: widget.validator,
                maxLines:widget.maxLines??1 ,
              onTap: widget.onTap,
                obscureText: widget.isObscure ?? false,
                controller: widget.controller,
                cursorColor: Colors.black,
                cursorErrorColor: Colors.black,
                onChanged: widget.onChanged,
                inputFormatters: widget.inputFormatters ?? [],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style:  TextStyle(fontSize: 16,fontFamily: "medium",color: widget.inputTextColor??AppColors.whiteColor),
                decoration: InputDecoration(
                  constraints: BoxConstraints(minHeight: 50,minWidth: 90.w),
                  fillColor:  widget.fillColor??AppColors.primaryColor,
                    filled: true,
                    suffixText: widget.suffixText ?? '',
                    prefixText: widget.prefixText ?? '',
                    prefixStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    border: OutlineInputBorder(
                        borderSide:  BorderSide(
                             width: 1.3,color: widget.fieldBorderColor??Colors.white )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:  BorderSide(
                             width: 1.3,color: widget.fieldBorderColor?? Colors.white)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide:  BorderSide(
                             width: 1.3,color:  widget.fieldBorderColor??Colors.white)
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderSide:  BorderSide(
                             width: 1.3,color: widget.fieldBorderColor??Colors.white)
                    ),
                    errorBorder:  OutlineInputBorder(
                        borderSide: BorderSide(
                            color:widget.isEditProfileInfoScreen? AppColors.primaryColor: Colors.white, width: 1.3,
                        )
                    ),
                    focusedErrorBorder:  OutlineInputBorder(
                        borderSide:  BorderSide(
                             width: 1.3,color:widget.isEditProfileInfoScreen? AppColors.primaryColor:Colors.white)
                    ),
                    hintText: widget.hintText,
                    errorStyle:  TextStyle(fontSize: 10,color:widget.isEditProfileInfoScreen? AppColors.primaryColor: Colors.white),
                    errorMaxLines: 3,
                    hintStyle:
                       TextStyle(
                           fontSize: 16,fontFamily: "medium",color: widget.hintTextColor??Colors.white.withOpacity(0.7)),
                    suffixIcon: widget.suffixIcon,
                    suffixIconColor: widget.suffixIconColor??Colors.white,
                    prefixIcon: widget.prefixIcon == null
                        ? const Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: SizedBox(),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 10),
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: Image.asset(
                                widget.prefixIcon!,color: widget.prefixIconColor??Colors.white,scale: widget.scale,

                              ),
                            ),
                          ),
                    prefixIconConstraints: const BoxConstraints(
                      maxHeight: 30,
                      minHeight: 30,

                    )),
              ),
            ),
          ],
        );


  }
}
