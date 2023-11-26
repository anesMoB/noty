import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_tp/shared/cubit/app_cubit.dart';
import 'package:mobile_tp/shared/cubit/app_states.dart';
import 'package:toast/toast.dart';
import '../themes_and_componants/noty_text_Style.dart';
import '../themes_and_componants/nue_container.dart';
import '../themes_and_componants/responsive.dart';
import '../themes_and_componants/toast.dart';
import 'note_details.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



    @override
  Widget build(BuildContext context) {

    initToast(context);
    return OrientationBuilder(
        builder: (context,orientation){
          return BlocConsumer<AppCubit,AppStates>(builder: (context,state){
            var appCubit=AppCubit.get(context);
            appCubit.orientationToggle(orientation);
            return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white.withOpacity(0.89),
                body: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: getNewHeight(60),
                        margin: EdgeInsets.symmetric(
                            horizontal:getNewMarginLeftRight(10),vertical:getNewMarginTOPBOTTOM(15)),
                        padding: EdgeInsets.symmetric(horizontal: getNewPaddingLeftRight(10),),
                        child: Row(
                          children: [
                            Expanded(flex: 3,child:  Text("NOTY",style:
                            notyTextStyle,),),
                            GestureDetector(
                              onTap: (){
                                if(orientation == Orientation.landscape){
                                  showToast("We can not insert a note in landscape orientation ",duration:2,gravity: Toast.bottom);
                                }else{
                                  appCubit.insertNote(context: context);
                                }
                              },
                              child: NeuContainer(width:getNewWidth(65), height:getNewHeight(65),
                                  child:Icon(Icons.note_add,color: nColor,size: 35,)),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context,index){
                                    return Padding(
                                      padding:EdgeInsets.symmetric(horizontal: getNewPaddingLeftRight(18),vertical:getNewPaddingTOPBOTTOM(5)),
                                      child: GestureDetector(
                                          onTap: (){
                                            appCubit.currentNote=appCubit.itemsList[index];
                                            if(appCubit.isNotOnLandScapeMode){
                                              Navigator.push(context, MaterialPageRoute(builder: (builder)=>NoteDetails()));
                                            }else{
                                              appCubit.changeIsOnLandAndClickedIndex();
                                            }
                                          },
                                          onLongPress: (){
                                            appCubit.currentNote=appCubit.itemsList[index];
                                            appCubit.deleteAlert(context: context, items: appCubit.itemsList[index]);
                                          },
                                          child: NeuContainer(
                                            width:(!appCubit.isNotOnLandScapeMode && appCubit.isOnLandAndClicked) ?
                                               getNewWidth(150) : getNewWidth(300), height:getNewHeight(90),isLight: true,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: getNewPaddingLeftRight(15),vertical:getNewPaddingTOPBOTTOM(5)),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Image(
                                                    width: getNewWidth(55),
                                                    height: getNewHeight(55),
                                                    image: AssetImage("assets/imgs/noteB.png"),color:nColor ,),
                                                  SizedBox(width: getNewWidth(15),),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        width:(!appCubit.isNotOnLandScapeMode && appCubit.isOnLandAndClicked) ? getNewWidth(250) : getNewWidth(100),
                                                        child: Text("${appCubit.itemsList[index].noteTitle}",
                                                          maxLines: 1,
                                                          softWrap: false,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(fontSize: 22,
                                                            color: nColor,
                                                            letterSpacing: 2,wordSpacing: 2,
                                                          ),),
                                                      ),
                                                      Container(
                                                        width: (!appCubit.isNotOnLandScapeMode && appCubit.isOnLandAndClicked) ? getNewWidth(220) : screenHeight-getNewWidth(650),
                                                        child: Text(
                                                          appCubit.itemsList[index].Content,
                                                          maxLines: 1,
                                                          softWrap: false,
                                                          overflow: TextOverflow.ellipsis,
                                                          style:  TextStyle(fontSize: 20,
                                                            color: nColor,
                                                          ),),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),)
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context,index)=>const SizedBox(),
                                  itemCount: appCubit.itemsList.length),
                            ),
                            if(!appCubit.isNotOnLandScapeMode && appCubit.isOnLandAndClicked)
                              SizedBox(
                                width:getNewWidth(300),
                                height: double.infinity,
                                child: NoteDetails(),
                              )
                          ],
                        ),),
                    ],
                  ),
                ),
              ),
            );
          }, listener: (context,state){});
    });
  }
}