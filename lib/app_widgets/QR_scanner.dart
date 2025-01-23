import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:houstan_hot_pass/constants/app_colors.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

customQrScanner(){
  return Center(
    child: SizedBox(
      height: 290,
      width: 290,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: PrettyQrView.data(
          data:
          '',
          decoration: const PrettyQrDecoration(
            background: Colors.white,
          ),
        ),
      ),
    ),
  );
}