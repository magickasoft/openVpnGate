import 'package:flutter/material.dart';
///Main App Colors
const primaryColor=Color(0xFF211F2F);
const cardColor=Color(0xFF2F2C43);
const white=Color(0xFFFFFFFF);
const blue=Color(0xFF3E64C5);
const gradientBlue=Color(0xFF65B8DB);
const lightGradientBlue=Color(0xFF92D3EF);
const lightBlue=Color(0xFF6F8DD9);
const iconBlueColor=Color(0xFF48A7D3);
const gray=Color(0xFF707070);
const yellow=Color(0xFFFFE601);
const gradientYellow=Color(0xFFF6FA59);
const green =Color(0xFF57DF04);
const gradientGreen=Color(0xFFA5FA71);
const black=Color(0xFF141414);
const lightGray=Color(0xFFADADAD);
const darkGray=Color(0xFF636363);
const mediumGray=Color(0xFF989898);
const midGray=Color(0xFF7D7D7D);
const halfWhite= Color(0xFFACACAC);
const grayText=Color(0xFF707070);
const dividerColor=Color(0xFF454545);

///Styling
const boldStyle=TextStyle(fontFamily: 'UBold',fontSize: 20,color:white);
const mediumStyle=TextStyle(fontFamily: 'UMedium',fontSize: 14,color:white);
const grayTextStyle=TextStyle(fontFamily: 'UBold',fontSize: 12,color:grayText );
const logoText=TextStyle(fontFamily: 'JMedium',fontSize: 20,color: white);
const btnText=TextStyle(fontFamily: 'USBold',fontSize: 16,color:white);

const blueGradient=LinearGradient(
    begin: FractionalOffset.topRight,
    end: FractionalOffset.bottomLeft,
    colors: [

      blue,
      gradientBlue,

    ]
);