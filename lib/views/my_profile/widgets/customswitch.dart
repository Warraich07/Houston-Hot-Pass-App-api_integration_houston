import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 50.0,
        height: 28.0,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor, width: 1.3),
          borderRadius: BorderRadius.circular(20.0),
          gradient: value
              ? LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryColor,
              AppColors.primaryColor,
            ],
          )
              : LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.whiteColor, AppColors.whiteColor],
          ),
        ),
        child: Stack(
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: value ? 20.0 : 0.0,
              right: value ? 0.0 : 20.0,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: value ? Colors.white : AppColors.primaryColor, // Change color based on value
                    border: Border.all(
                      color: value ? Colors.white : AppColors.primaryColor, // Change border color based on value
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
