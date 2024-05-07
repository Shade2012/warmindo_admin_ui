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
const Color blueTextColor = Color(0xFF4282FF);

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

TextStyle boldTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(15)));

TextStyle helloLoginTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(24)));

TextStyle welcomeLoginTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.normal,
        fontSize: figmaFontsize(17)));

TextStyle whiteboldTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: secondaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(17)));

TextStyle homeWelcomeTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: secondaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(22)));

TextStyle hintSearchBarTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: greyTextColor,
        fontWeight: FontWeight.normal,
        fontSize: figmaFontsize(15)));

TextStyle headerAnalyticBoxTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(12)));

TextStyle valueAnalyticBoxTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(20)));

TextStyle subHeadOrderTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(16)));

TextStyle viewAllTextStyle2 = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: blueTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(14)));

TextStyle idOrderBoxTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(16)));

TextStyle labelOrderBoxTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: secondaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(11)));

TextStyle titleMenuOrderTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w700,
        fontSize: figmaFontsize(14)));

TextStyle priceMenuOrderTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w700,
        fontSize: figmaFontsize(14)));

TextStyle categoryTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(16)));

TextStyle filterTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: secondaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(14)));

TextStyle categorylistTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(14)));

TextStyle titleproductTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w600,
        fontSize: figmaFontsize(14)));

TextStyle subtitleproductTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w600,
        fontSize: figmaFontsize(14)));

TextStyle contentDialogButtonTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(12)));  

TextStyle titleDialogButtonTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(14)));  

TextStyle dialogButtonTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: secondaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(12)));  

TextStyle dialogendButtonTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(12)));  

TextStyle headerverificationTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w600,
        fontSize: figmaFontsize(14)));

TextStyle contentverificationTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w600,
        fontSize: figmaFontsize(14)));

TextStyle verificationTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: greenTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(16)));

TextStyle unverificationTextStyle = GoogleFonts.oxygen(
    textStyle: TextStyle(
        color: greyTextColor,
        fontWeight: FontWeight.bold,
        fontSize: figmaFontsize(16)));



