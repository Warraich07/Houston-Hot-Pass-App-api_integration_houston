import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:houstan_hot_pass/constants/app_icons.dart';
import 'package:houstan_hot_pass/controllers/offers_controller.dart';
import 'package:houstan_hot_pass/utils/custom_dialog.dart';
import 'package:houstan_hot_pass/views/history_screen/history_screen.dart';
import 'package:houstan_hot_pass/views/my_profile/profile_screen.dart';

import '../app_widgets/alertbox.dart';
import '../constants/app_images.dart';
import '../controllers/general_controller.dart';
import '../views/blogs/blogs_screen.dart';
import '../views/home/home_screen.dart';
import '../views/nearby_on_map_screen/nearby_on_map_screen.dart';


class CustomBottomBarr extends StatefulWidget {
  const CustomBottomBarr({super.key});


  @override
  State<CustomBottomBarr> createState() => _CustomBottomBarrState();

}



class _CustomBottomBarrState extends State<CustomBottomBarr> {
  final GeneralController _generalController = Get.put(GeneralController());
  final OffersController _offersController = Get.find();
  int selectedIndex = -1;
  List pages =[
    const HomeScreen(),
    const NearbyOnMapScreen(),
    const BlogScreen(),
    const HistoryScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        setState(() {
          if(_generalController.currentIndex==0){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomAlertDialogForExiting(
                  height: 370,
                  heading: "Exit",
                  subHeading: "Are you sure you want to exit?",
                  buttonName: "Yes",img: AppIcons.questionMarkIcon,onTapped: () {
                  SystemNavigator.pop();
                },);
              },
            );
          }else{
            _generalController.onBottomBarTapped(0);

          }
        });
      },

      child: Scaffold(
          body: Column(
            children: [
              Expanded(child: pages[_generalController.currentIndex]),
            ],
          ),
          bottomNavigationBar: Container(
            height: 80,
            decoration:  BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: AppColors.primaryColor, width: 2.5))
            ),
            child: BottomNavigationBar(

              backgroundColor: Colors.white,

              unselectedLabelStyle: const TextStyle(fontSize: 12,color:Colors.grey ,fontFamily: "medium"),
              selectedLabelStyle:TextStyle(fontSize: 12,color: AppColors.primaryColor,fontFamily: 'heavy'),
              elevation: 0,


              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: Colors.black.withOpacity(0.6),
              type: BottomNavigationBarType.fixed,

              enableFeedback: false,
              showUnselectedLabels: true,
              currentIndex: _generalController.currentIndex,
              onTap: (index) {
                setState(() {
                  _generalController.onBottomBarTapped(index);
                 selectedIndex = index;
                 if(selectedIndex!=1){
                     _offersController.updateLatLongForNavigatingCamera(null,null);

                 }
                });
              },
              items: [
                BottomNavigationBarItem(

                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Image.asset(
                      _generalController.currentIndex == 0 ?  "assets/app_icons/bottom_bar_icons/selected_home_icon.png": AppIcons.homeIcon,
                      height: 22,
                      width: 22,
                      color: _generalController.currentIndex == 0 ?  AppColors.primaryColor : const Color(0xff000000),
                    ),
                  ),
                  label:"Home",
                ),
                BottomNavigationBarItem(icon: Padding(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: Image.asset(
                    _generalController.currentIndex == 1 ?  "assets/app_icons/bottom_bar_icons/selected_nearby_icon.png": AppIcons.nearbyIcon,

                    height: 22,
                    width: 22,
                    color: _generalController.currentIndex == 1 ? AppColors.primaryColor: const Color(0xff000000),),
                ),
                    label:"Nearby"
                ),
                BottomNavigationBarItem(

                    icon: Padding(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: Image.asset(
                      _generalController.currentIndex == 2 ?  "assets/app_icons/bottom_bar_icons/blog_selected_icon.png": AppIcons.blogIcon,


                    height: 22,
                    width: 22,
                    color: _generalController.currentIndex == 2? AppColors.primaryColor: const Color(0xff000000)),
                ),
                    label:"Blogs"
                ),
                BottomNavigationBarItem(
                    icon: Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Image.asset(
                    _generalController.currentIndex == 3 ?  "assets/app_icons/bottom_bar_icons/history_selected_icon.png": AppIcons.historyIcon,


                    width: 22,
                    color: _generalController.currentIndex == 3 ?AppColors.primaryColor: const Color(0xff000000),),
                ),
                    label: "History"
                ),
                 BottomNavigationBarItem(icon: Padding(
                 padding: const EdgeInsets.only(bottom: 3),
                  child: Image.asset(_generalController.currentIndex == 4 ?  "assets/app_icons/bottom_bar_icons/profile_selected_icon.png":AppIcons.profileIcon,

                    height: 22,
                  width: 22,
                    color: _generalController.currentIndex == 4 ?AppColors.primaryColor: const Color(0xff000000),),
                 ),
                  label: "Profile"
                ),
                 ],
            ),
          ),
        ),
    ),
    );
  }
}
