
import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mobile_tp/themes_and_componants/noty_text_Style.dart';
import 'package:mobile_tp/themes_and_componants/nue_container.dart';
import 'package:mobile_tp/themes_and_componants/responsive.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../models/note.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {

  AppCubit() : super(InitAppState());
  static AppCubit get(context) => BlocProvider.of(context);


  bool isOnLandAndClicked=false;

  void changeIsOnLandAndClickedIndex(){
    isOnLandAndClicked=!isOnLandAndClicked;
    emit(ChangeIsOnLandAndClickedIndexState());
  }
  List<Note> itemsList=[];
  late Note currentNote;
  TextEditingController titleController=TextEditingController();
  TextEditingController contentController=TextEditingController();

  void insertNote({
    required BuildContext context,}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[200],
          title: Center(child: const Text('New Note')),
          content: Container(
            width: getNewWidth(350.0),
            height: getNewHeight(260.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      label: Text("Note Title"),
                     ),
                  ),
                   SizedBox(height: getNewHeight(20),),
                  TextFormField(
                    controller: contentController,
                    maxLines: 7,
                    decoration: const InputDecoration(
                       label: Text("Note Content"),
                     ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: NeuContainer(width: getNewWidth(60), height: getNewHeight(45), child:
               Center(child: Text('Cancel',style: TextStyle(color: nColor,fontSize: 15,fontWeight: FontWeight.bold),))),
              onPressed: () {
                titleController.text="";
                contentController.text="";
                Navigator.of(context).pop();
                emit(NoteAddedFailedState());

              },
            ),
            TextButton(
              child: NeuContainer(width: getNewWidth(60), height: getNewHeight(45), child:
             Center(child: Text('Add',style: TextStyle(color: Colors.green,fontSize: 15,fontWeight: FontWeight.bold),))),
              onPressed: () async{
                if(titleController.text.isNotEmpty){
                  await insertIntoDataBase(noteId: Uuid().v4(),
                      noteTitle: titleController.text,
                      noteContent: contentController.text,
                      noteCreatedAt: DateTime.now().toString());
                      titleController.text="";
                      contentController.text="";
                  Navigator.of(context).pop();
                  emit(NoteAddedSuccessfullyState());
                }else{

                  Navigator.of(context).pop();
                  emit(NoteAddedFailedState());
                }

              },
            ),
          ],
        );
      },
    );
  }

  void deleteAlert({
    required BuildContext context,
    required Note items,}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[200],
          title:  Text('Note Delete',style: TextStyle(fontSize: 25),),
          content:  Text('You Will Delete This Note!!',style: TextStyle(fontSize: 20),),
          actions: <Widget>[
            TextButton(
              child: NeuContainer(width: getNewWidth(60), height: getNewHeight(45), child:
              const Center(child:
              Text('Cancel',style: TextStyle(color: nColor),))),
              onPressed: () {
                emit(NoteDeletedFailedState());
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: NeuContainer(width: getNewWidth(60), height: getNewHeight(45), child:
              const Center(child: Text('Delete',style: TextStyle(color: Colors.redAccent),))),
              onPressed: () {
                deleteNoteFromDataBase(noteId: currentNote.noteId);
                    emit(NoteDeletedSuccessfullyState());
                   Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );
  }



  void updateNoteTitleDialog({ required BuildContext context,}){
      titleController.text=currentNote.noteTitle;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[200],
            title: Center(child: const Text('UPDATE Note Title',)),
            content: TextFormField(
              onTap: (){
                isNotInUpdateMode=false;
                emit(IsOnUpdateModeToggleState());
              },
              style: TextStyle(fontSize: 18),
              minLines: 1,
              maxLines: 4,
              controller: titleController,
            ),
            actions: <Widget>[
              TextButton(
                child: NeuContainer(width: getNewWidth(60), height: getNewHeight(45), child:
                 Center(child: Text('Cancel',style: TextStyle(color: nColor,fontSize: 15,fontWeight: FontWeight.bold),))),
                onPressed: () {
                  titleController.text="";
                  isNotInUpdateModeReset();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: NeuContainer(width:getNewWidth(60), height: getNewHeight(45), child:
                 Center(child: Text('Update',style: TextStyle(color: Colors.green,fontSize: 15,fontWeight: FontWeight.bold),))),
                onPressed: () {
                  if(titleController.text.isNotEmpty){
                    updateNoteInDataBase(
                        noteId: currentNote.noteId,
                        noteTitle: titleController.text,
                        noteContent: currentNote.Content);
                    titleController.text="";
                    isNotInUpdateModeReset();
                    Navigator.of(context).pop();
                    emit(NoteUpdatedSuccessfullyState());
                  }else{
                    titleController.text="";
                    isNotInUpdateModeReset();
                    Navigator.of(context).pop();
                    emit(NoteUpdatedFailedState());
                  }

                },
              ),
            ],
          );
        },
      );
  }
  void updateNoteContentDialog({ required BuildContext context,}){

      contentController.text = currentNote.Content;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[200],
            title: Center(child: const Text('UPDATE Note Content')),
            content:TextFormField(
              controller: contentController,
              maxLines: 6,
              minLines: 1,
              style: TextStyle(fontSize: 18),
              onTap: (){
                isNotInUpdateMode=false;
                emit(IsOnUpdateModeToggleState());
              },
            ),
            actions: <Widget>[
              TextButton(
                child: NeuContainer(width: getNewWidth(60), height: getNewHeight(45), child:
                Center(child: Text('Cancel',style: TextStyle(color: nColor,fontSize: 15,fontWeight: FontWeight.bold),))),
                onPressed: () {
                  contentController.text="";
                  isNotInUpdateModeReset();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: NeuContainer(width: getNewWidth(60), height: getNewHeight(45), child:
                Center(child: Text('Update',style: TextStyle(color: Colors.green,fontSize:  15,fontWeight: FontWeight.bold),))),
                onPressed: () {
                    updateNoteInDataBase(
                        noteId: currentNote.noteId,
                        noteTitle: currentNote.noteTitle,
                        noteContent: contentController.text);
                    contentController.text="";
                    isNotInUpdateModeReset();
                    Navigator.of(context).pop();
                    emit(NoteUpdatedSuccessfullyState());
                },
              ),
            ],
          );
        },
      );
  }


  bool isNotOnLandScapeMode=true;
  Orientation orientation=Orientation.landscape;
  void  orientationToggle(Orientation or){
    if(orientation!=or){
      isNotOnLandScapeMode=true;
      isOnLandAndClicked=false;

      emit(orientationPortraitState());
    }else{
      isNotOnLandScapeMode=false;
      emit(orientationLandscapeState());

    }
  }

  bool isNotInUpdateMode=true;
  void isNotInUpdateModeReset() {
    isNotInUpdateMode=true;
    emit(IsOnUpdateModeToggleState());

  }

  FlutterTts flutterTts = FlutterTts();
  Future<void> pronouceTitle()async{
    await flutterTts.speak(currentNote.noteTitle);
    emit(NoteTitlePronouceState());
  }
  Future<void> pronouceContent()async{
    await flutterTts.speak(currentNote.Content);
    emit(NoteContentPronouceState());
  }

  late Database db;

  Future<void> createdDatabase()async {
    openDatabase(
      "notesDB.db",
      version: 1,
      onCreate: (database,version)async{
        String query="CREATE TABLE notes (idn TEXT PRIMARY KEY,noteTitle TEXT,noteContent TEXT, createdAt TEXT)";
        await database.execute(query);
        if (kDebugMode) {
          print("DATABASE CREATED ***************");

        }},
      onOpen: (dataBase){
        getDataFromDataBase(dataBase);
      }
    ).then((value) {
      db=value;
      emit(DataBaseInitState());
    });
  }

  Future<void> getDataFromDataBase(Database dataBase) async {
    String query="SELECT * FROM notes";
    dataBase.rawQuery(query).then((notes){
      itemsList=[];
      for (var note in notes) {
          Note newNote=Note(
              noteId:note['idn'].toString(),
              noteTitle: note['noteTitle'].toString(),
              Content: note['noteContent'].toString(),
              createdAt: note['createdAt'].toString()
          );
          itemsList.add(newNote);
      }
      if (kDebugMode) {
        print("GET DATA From notesDB***************");

      }
      if (kDebugMode) {
        print("after *************** ${itemsList.length}");
      }
      emit(getDataFromNotesDB());
    });
  }

  Future<void> insertIntoDataBase(
      { required String noteId,
      required String noteTitle,
       required String noteContent,
        required String noteCreatedAt}) async {
    if (kDebugMode) {
      print("before insert*************** ${itemsList.length}");
    }
    await db.transaction((txn)  async {

      await txn.rawInsert(
          "INSERT INTO notes(idn,noteTitle,noteContent,createdAt) VALUES('$noteId','$noteTitle','$noteContent','$noteCreatedAt')");
      if (kDebugMode) {
        print("Note Inserted ***************");
      }
      emit(insertNoteIntoDB());
      await getDataFromDataBase(db);
    });
  }
  Future<void> updateNoteInDataBase({
    required String noteId,
    required String noteTitle,
    required String noteContent,
  }) async{
    if (kDebugMode) {
      print("before update*************** ${itemsList.length}");
    }
    await db.update(
      'notes',
      {
        'noteTitle': noteTitle,
        'noteContent': noteContent,
      },
      where: 'idn = ?',
      whereArgs: [noteId],
    ).then((value)async {
      currentNote.noteTitle=noteTitle;
      currentNote.Content=noteContent;

      emit(updateNoteInDB());
      await getDataFromDataBase(db);
    });
  }

  void deleteNoteFromDataBase({
    required String noteId,
  }) async{
    if (kDebugMode) {
      print("before delete*************** ${itemsList.length}");
    }
    db.rawDelete(
      'DELETE FROM notes WHERE idn = ?',
      [noteId],
    ).then((value) {
      emit(deleteNoteFromDB());
      getDataFromDataBase(db);
    });
  }
}