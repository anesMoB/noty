
abstract class AppStates {}

class InitAppState extends AppStates{}

class NoteAddedSuccessfullyState extends AppStates{}
class NoteAddedFailedState extends AppStates{}

class NoteDeletedSuccessfullyState extends AppStates{}
class NoteDeletedFailedState extends AppStates{}

class SettingNewTitleNoteState extends AppStates{}
class SettingNewContentNoteState extends AppStates{}

class NoteUpdatedSuccessfullyState extends AppStates{}
class NoteUpdatedFailedState extends AppStates{}

class orientationPortraitState extends AppStates{}
class orientationLandscapeState extends AppStates{}

class IsOnUpdateModeToggleState extends AppStates{}

class NoteTitlePronouceState extends AppStates{}
class NoteContentPronouceState extends AppStates{}


// DATABASE SQFLITE

class DataBaseInitState extends AppStates{}
class getDataFromNotesDB extends AppStates{}

class insertNoteIntoDB extends AppStates{}
class updateNoteInDB extends AppStates{}
class deleteNoteFromDB extends AppStates{}

//

class ChangeIsOnLandAndClickedIndexState extends AppStates{}
