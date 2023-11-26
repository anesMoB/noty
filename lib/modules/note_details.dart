import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_tp/themes_and_componants/responsive.dart';
import 'package:toast/toast.dart';
import '../shared/cubit/app_cubit.dart';
import '../shared/cubit/app_states.dart';
import '../themes_and_componants/noty_text_Style.dart';
import '../themes_and_componants/nue_container.dart';
import '../themes_and_componants/toast.dart';

class NoteDetails extends StatefulWidget {
  NoteDetails({Key? key}) : super(key: key);

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> with WidgetsBindingObserver{
  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    AppCubit.get(context).flutterTts.stop();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    initToast(context);
    return OrientationBuilder(
      builder: (context,orientation) {
        return BlocConsumer<AppCubit, AppStates>(
            builder: (context, state) {
              var appCubit = AppCubit.get(context);
              bool shw=screenHeight>screenWidth;
              return SafeArea(
                child: Scaffold(
                    backgroundColor: Colors.white.withOpacity(0.89),
                    body: Container(
                      width: double.infinity,
                      height: double.infinity,
                      // padding:
                      // EdgeInsets.symmetric(
                      //     horizontal: getNewPaddingLeftRight(25),
                      //     vertical: getNewPaddingTOPBOTTOM(10)),
                      child: SingleChildScrollView(
                        child: Container(
                          width: shw? screenWidth: screenHeight,
                          height: shw? screenHeight: screenWidth,
                          padding:
                          EdgeInsetsDirectional.fromSTEB(
                               getNewPaddingLeftRight(25),
                               getNewPaddingTOPBOTTOM(10),
                                getNewPaddingLeftRight(25),
                               getNewPaddingTOPBOTTOM(20),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if(appCubit.isNotInUpdateMode) Center(

                                      child: Image(
                                        image: AssetImage("assets/imgs/noteB.png"),
                                        color: nColor,
                                        width: getNewWidth(250),
                                        height: getNewHeight(250),

                                    )),
                                SizedBox(
                                  height: getNewHeight(25),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width:(!appCubit.isNotOnLandScapeMode && appCubit.isOnLandAndClicked) ? screenHeight-getNewWidth(670): getNewWidth(280),
                                        height:getNewHeight(110),
                                        child: SingleChildScrollView(
                                          child: Text(
                                            appCubit.currentNote.noteTitle,
                                            style: TextStyle(color: nColor,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                            maxLines: 20,
                                          ),
                                        )
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        if(orientation==Orientation.landscape){
                                          showToast("We can not update the title in landscape orientation ",gravity: Toast.bottom);

                                        }else{
                                          appCubit.updateNoteTitleDialog(context: context);

                                        }
                                      },
                                      child: NeuContainer(
                                        width: getNewWidth(40),
                                        height: getNewHeight(40),
                                        child: Icon(
                                          Icons.mode_edit_outline_outlined,
                                          color: nColor,
                                          size: 25,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width:(!appCubit.isNotOnLandScapeMode && appCubit.isOnLandAndClicked) ? screenHeight-getNewWidth(670): getNewWidth(280),
                                      height: getNewHeight(280),
                                      child: SingleChildScrollView(
                                          child: Text(
                                            appCubit.currentNote.Content,
                                            style: TextStyle(
                                                color: nColor, fontSize: 25),
                                            maxLines: 80,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        if(orientation==Orientation.landscape){
                                          showToast("We can not update the content in landscape orientation ",gravity: Toast.bottom);

                                        }else{
                                          appCubit.contentController.text =
                                              appCubit.currentNote.Content;
                                          appCubit.updateNoteContentDialog(
                                              context: context);
                                        }

                                      },
                                      child: NeuContainer(
                                        width: (!appCubit.isNotOnLandScapeMode && appCubit.isOnLandAndClicked) ? getNewWidth(32):getNewWidth(40),
                                        height: (!appCubit.isNotOnLandScapeMode && appCubit.isOnLandAndClicked) ? getNewHeight(32): getNewHeight(40),
                                        child: Icon(
                                          Icons.mode_edit_outline_outlined,
                                          color: nColor,
                                          size: 25,
                                        ),
                                      ),
                                    )
                                  ],
                                ),

                                const Spacer(),
                                Center(
                                  child: Text("created At : ${appCubit.currentNote
                                      .createdAt}",
                                      style: TextStyle(
                                          fontSize: 14, color: nColor)),
                                ),
                                SizedBox(height: getNewHeight(10),),
                                GestureDetector(
                                  onDoubleTap: () async {
                                    await appCubit.pronouceContent();
                                  },
                                  onTap: () async {
                                    await appCubit.pronouceTitle();
                                  },
                                  child: NeuContainer(
                                      width: double.infinity,
                                      height: getNewHeight(70),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              Text("Click on me to hear the sound",
                                                  style: TextStyle(
                                                      color: nColor,
                                                      fontSize: (!appCubit.isNotOnLandScapeMode && appCubit.isOnLandAndClicked) ? 15:20,
                                                      fontWeight: FontWeight.bold)),
                                              Text(
                                                  "one click to hear the title / tow taps to hear the content ",
                                                  style: TextStyle(
                                                      color: nColor,
                                                      fontSize: (!appCubit.isNotOnLandScapeMode && appCubit.isOnLandAndClicked) ?7:10,
                                                      fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                          SizedBox(
                                            width: getNewHeight(10),
                                          ),
                                          Icon(
                                            Icons.record_voice_over_sharp,
                                            color: nColor,
                                            size: 40,
                                          )
                                        ],
                                      )),
                                )
                              ]),
                        ),
                      ),
                    )
                ),
              );
            },
            listener: (context, state) {});
      });
      }
  }

