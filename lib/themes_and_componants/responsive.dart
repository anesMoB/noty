
import 'package:flutter/cupertino.dart';

var screenWidth;
var screenHeight;

double  getNewWidth(double w){
  return ((screenWidth * w)/392.72727272727275) ;

}
double  getNewHeight(double h){
  return  ((screenHeight * h)/875.6363636363636 );
}

double  getNewPaddingTOPBOTTOM(double ptb){
  return ((screenHeight * ptb)/392.72727272727275) ;
}
double  getNewPaddingLeftRight(double plr){
  return ((screenWidth * plr)/392.72727272727275) ;
}

double  getNewMarginTOPBOTTOM(double mtb){
  return  ((screenHeight * mtb)/875.6363636363636 );
}
double  getNewMarginLeftRight(double mlr){
  return  ((screenWidth * mlr)/875.6363636363636 );
}
double  getNewSize(double s){
  return  (s);
}


Future<void> initWidthHeight(context)async {
  if(MediaQuery.of(context).size.width<MediaQuery.of(context).size.height){
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }else{
    screenWidth = MediaQuery.of(context).size.height;
    screenHeight = MediaQuery.of(context).size.width;
  }
}