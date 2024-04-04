import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//figma font size
figmaFontsize(double fontSize) {
  return fontSize * 0.95;
}

//Colors
const Color primaryTextColor = Color(0xFF000000);
const Color secondaryTextColor = Color(0xFFffffff);
const Color greyTextColor = Color(0xFF696969);
const Color greenTextColor = Color(0xFF007F6D);
const Color yellowTextColor = Color(0xFFFFA41D);
const Color redTextColor = Color(0xFFC62828);


TextStyle appBarTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(16)));

TextStyle searchBarTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: greyTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(11)));

TextStyle filterButtonTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(14)));

TextStyle menuTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(14)));

TextStyle detailOrderHeaderTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(16)));

TextStyle detailOrderSubHeaderTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: greyTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(12)));

TextStyle nameRestoTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(16)));

TextStyle inproggresTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: yellowTextColor,
        fontWeight: FontWeight.normal,
        fontSize: figmaFontsize(12)));