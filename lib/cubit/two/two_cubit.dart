import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project1/cubit/two/two_states.dart';
import 'package:sqflite/sqflite.dart';

import '../../shared/constants.dart';


class TwoCubit extends Cubit<TwoStates> {
  TwoCubit() : super(TwoInitialState());

  static TwoCubit get(context) {
    return BlocProvider.of(context);
  }

  void fillHack() {
    hack = [];
    gameNameHack = [];
    for (int j = 33 ; j <=64 ; j++)
    {
      hack.add(String.fromCharCode(j));
    }
    for (int a = 91 ; a <=96 ; a++)
    {
      hack.add(String.fromCharCode(a));
    }
    for (int u = 123 ; u <=126 ; u++)
    {
      hack.add(String.fromCharCode(u));
    }
    for (int j = 33 ; j <=39 ; j++)
    {
      gameNameHack.add(String.fromCharCode(j));
    }
    for (int j = 59 ; j <=64 ; j++)
    {
      gameNameHack.add(String.fromCharCode(j));
    }
    for (int a = 126 ; a <=127 ; a++)
    {
      gameNameHack.add(String.fromCharCode(a));
    }
    gameNameHack.add(String.fromCharCode(42));
    gameNameHack.add(String.fromCharCode(94));
    gameNameHack.add(String.fromCharCode(96));
  }

  /*
  * This method has been created to fill 2 Char lists.
  * Those Char lists if it is written inside text field, It's meant to be hacking Chars.
  * This method depends on ASCII code.
  * it's called on creating the cubit ( At the beginning of the game ),
  */

  bool checkText(String text,hackList) {
    check = false;
    // wrong = [];
    for ( int i = 0 ; i < text.length ; i++)
      {
        for (int j = 0 ; j < hackList.length ; j++)
          {
            if( text[i] == hackList[j] )
              {
                check = true ;
                // wrong.add(hack[j]);
              }
          }
      }
    return check;
  }

  /*
  * This method is to check any text ( passed to it ) if it has any hacking Chars or not.
  * it returns true if the text has one hacking Char or more.
  */

  void addRound() {
    keys1.add(GlobalKey());
    roundsNum++;
    player1.add(hisPoints);
    player2.add(myPoints);
    myPoints = 0 ;
    hisPoints = 0 ;
    myPointsWhileClosing = 0 ;
    HisPointsWhileClosing = 0 ;
    emit(TwoAddRoundState());
  }

  /*
  * This method is called when playing a new round.
  * it simply creates new line ( round ) in the board.
  */

  void delete(index, context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Burgundy,
      content: Row(
        children: [
          Icon(Icons.delete,color: WHI,),
          SizedBox(width: 6,),
          Text(
            'Successfully deleted',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: WHI),
          ),
        ],
      ),
    ));
    roundsNum--;
    keys1.remove(keys1[index]);
    player1.remove(player1[index]);
    player2.remove(player2[index]);
    emit(TwoDeleteRoundState());
  }

  /*
  * This method is called when sliding round to the right.
  * it simply delete line ( round ) in the board.
  */

  void remove() {
    myPointsWhileClosing = 0 ;
    HisPointsWhileClosing = 0 ;
    myPoints = 0 ;
    hisPoints = 0 ;
    gameUp = false ;
    holdState = false ;
    myHoldState = false ;
    hisHoldState = false ;
    holdCreate = false ;
    didNotClosed = true ;
    player1password = null;
    player2password = null;
    IAmPlayingNow = false ;
    heIsPlayingNow = false ;
    leftGround = [];
    rightGround = [];
    initially = [];
    aboveSupport = [];
    belowSupport = [];
    myCards = [];
    hisCards = [];
    mySelectedCards = [];
    hisSelectedCards = [];
    theAvailableLeft = null;
    theAvailableRight =  null;
    forSupport = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27];
    supportAndMyCards = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27];
    supportAndHisCards = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27];
    initial = false;
    theHighestPriority = null ;
    theHighestPriorityInMyCards = 0 ;
    theHighestPriorityInHisCards = 0 ;
    filling();
    falseSelections();
    selected = false;
    selectedCard = null ;
    playerOneController.text = '';
    playerTwoController.text = '';
    player1=[];
    player2=[];
    keys1=[];
    roundsNum=0;
    emit(TwoRemoveState());
  }

  /*
  * This method is called when finishing a game.
  * it simply reset.
  */

  void saveAppearance() {
    save_appearance = true ;
    if(saveController.text == '' || checkText(saveController.text,gameNameHack) == true || saveController.text.trim() == '' )
    {
      save_appearance = false ;
    }
    emit(TwoZhorElSaveStata());
  }

  /*
  * This method is called when naming a game.
  * it checks if the game name isn't empty and doesn't have hacking Chars.
  */

  void updateAppearance(String old) {
    update_appearance = true ;
    if(editGameNameController.text == '' || checkText(editGameNameController.text,gameNameHack) == true || editGameNameController.text.trim() == '' || editGameNameController.text == old)
    {
      update_appearance = false ;
    }
    emit(TwoZhorElupdateStata());
  }

  /*
  * This method is called when updating game name.
  * it checks if the game name isn't empty and doesn't have hacking Chars.
  */

  void makeEditTrue() {
    isEditState = true;
    emit(TwomakeEditTrueState());
  }

  /*
  * This method is called while updating game name to change the editing icon to update word.
  */

  void makeEditFalse() {
    isEditState = false;
    emit(TwomakeEditFalseState());
  }

  /*
  * This method is called while updating game name to change the update word to editing icon.
  */

  void creatingDatabase() {
    openDatabase(
        "j.db",
        version: 1,
        onCreate: (database, version) {
          print("database version: $version was created");
          database.execute(
              "CREATE TABLE Scores (ID INTEGER PRIMARY KEY , GameName TEXT , PlayerOne TEXT , PlayerTwo TEXT , FinalScoreOne INTEGER , FinalScoreTwo INTEGER , InnerScoresOne TEXT, InnerScoresTwo TEXT , NumberOfRounds INTEGER, Player1Image TEXT, Player2Image TEXT , DateTime TEXT ) ")
              .then((value) {
            print("tables of $database version: $version were created");
          }).catchError((onError) {
            print(
                "error on creating tables of $database version: $version \n $onError");
          });
        },
        onOpen: (database) {
          getData(database);
          print("database: $database was opened");
        }
    ).then((value) {
      dataBase = value;
      emit(TwoCreatingDatabaseState());
    });
  }

  /*
  * Creating database.
  */

  Future insertToDatabase() async
  {
    dataBase!.transaction((txn) =>
        txn.rawInsert("INSERT INTO Scores (GameName,PlayerOne,PlayerTwo,FinalScoreOne,FinalScoreTwo,InnerScoresOne,InnerScoresTwo,NumberOfRounds,Player1Image,Player2Image,DateTime) VALUES ('${saveController.text.trim()}','${playerOneController.text.trim()}','${playerTwoController.text.trim()}',${player1.isEmpty? "0" : player1.reduce((value, element) => value + element)},${player2.isEmpty? "0" : player2.reduce((value, element) => value + element)},'$temp1','$temp2',$roundsNum,'','','${DateTime.now().toString()}')")
            .then((value) {
          print("$value data were successfully inserted");
        }).catchError((onError) {
          print("error in inserting new record \n $onError");
        })
    ).then((value) {
      FocusManager.instance.primaryFocus?.unfocus();
      saveController.text = '';
      temp1List = [];
      temp2List = [];
      temp1 = '';
      temp2 = '';
      save_appearance = false ;
      emit(TwoInsertDataState());
      getData(dataBase!);
    });
  }

  /*
  * Inserting into database.
  */

  Future getData(Database database) async {
    emit(TwoLoadingDatabaseState());
    selectedList = [];
    whiteList = [];
    getGameNames = [];
    getPlayerOneFinalScores = [];
    getPlayerTwoFinalScores = [];
    getPlayerOneNames = [];
    getPlayerTwoNames = [];
    getDates = [];
    database.rawQuery('SELECT * FROM Scores').then((value) {
      users = value;
      for (var element in users) {
        getGameNames.add(element['GameName']);
        getPlayerOneNames.add(element['PlayerOne']);
        getPlayerTwoNames.add(element['PlayerTwo']);
        getPlayerOneFinalScores.add(element['FinalScoreOne']);
        getPlayerTwoFinalScores.add(element['FinalScoreTwo']);
        getDates.add(element['DateTime']);
        for(int y = 0 ; y < users.length ; y++)
        {
          selectedList.add(false);
          whiteList.add(WHI);
        }
      }
      emit(TwoGetDataState());
    });
  }

  /*
  * Get data from database.
  */

  Future updateGameName(newGameName, index) async {
    getGameName = newGameName;
    dataBase!.rawUpdate('UPDATE Scores SET GameName = ? WHERE ID = ?', ['$newGameName', '${users[index]['ID']}'])
        .then((value) {
      isEditState = false;
      update_appearance = false ;
      getData(dataBase!);
      emit(TwoUpdating1DatabaseState());
    });
  }

  /*
  * This method is called to update game name in the database.
  */

  void innerScore(index) {
    getData(dataBase!);
    getInnerDate = '';
    getNumberOfRounds = 0;
    tempString = '';
    temp1List = [];
    temp2List = [];
    getGameName = '';
    getInnerPlayerOneName = '';
    getInnerPlayerTwoName = '';
    getInnerPlayerOneFinalScore = 0;
    getInnerPlayerTwoFinalScore = 0;
    getPlayerOneImage = '';
    getPlayerTwoImage = '';
    getGameName = users[index]['GameName'];
    editGameNameController.text = getGameName;
    getInnerPlayerOneName = users[index]['PlayerOne'];
    getInnerPlayerTwoName = users[index]['PlayerTwo'];
    getInnerPlayerOneFinalScore = users[index]['FinalScoreOne'];
    getInnerPlayerTwoFinalScore = users[index]['FinalScoreTwo'];
    tempString = users[index]['InnerScoresOne'];
    tempString1List = tempString.split(',');
    tempString = users[index]['InnerScoresTwo'];
    tempString2List = tempString.split(',');
    getNumberOfRounds = users[index]['NumberOfRounds'];
    getPlayerOneImage = users[index]['Player1Image'];
    getPlayerTwoImage = users[index]['Player2Image'];
    getInnerDate = users[index]['DateTime'];
    emit(TwoGetInnerDataState());
  }

  /*
  * This method is called to get the values of each game on clicking on it in the challenging page.
  */

  ImagePicker picker = ImagePicker();
  ImageCropper cropper = ImageCropper();
  Future<void> getPlayer1ImageC() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      player1Image = File(pickedFile.path);
      final croppedPlayer1 = await cropper.cropImage(
        sourcePath: player1Image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              statusBarColor: WHI,
              backgroundColor: BLA,
              activeControlsWidgetColor: Colors.green,
              toolbarColor: BLA,
              toolbarWidgetColor: WHI,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if(croppedPlayer1 !=null)
      {
        enable = true;
        croppedPlayer1Image = File(croppedPlayer1.path);
        convertImage(croppedPlayer1Image!);
        emit(TwoPlayer1ImageSuccessState());
      }
      else
      {
        emit(TwoPlayer1ImageErrorState());
      }
    } else {
      emit(TwoPlayer1ImageErrorState());
    }
  }
  Future<void> getPlayer2ImageC() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      player2Image = File(pickedFile.path);
      final croppedPlayer2 = await cropper.cropImage(
        sourcePath: player2Image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              statusBarColor: WHI,
              backgroundColor: BLA,
              activeControlsWidgetColor: Colors.green,
              toolbarColor: BLA,
              toolbarWidgetColor: WHI,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if(croppedPlayer2 !=null)
      {
        enable = true;
        croppedPlayer2Image = File(croppedPlayer2.path);
        convertImage(croppedPlayer2Image!);
        emit(TwoPlayer1ImageSuccessState());
      }
      else
      {
        emit(TwoPlayer1ImageErrorState());
      }
    } else {
      emit(TwoPlayer1ImageErrorState());
    }
  }
  Future<void> getPlayer1ImageG() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      player1Image = File(pickedFile.path);
      final croppedPlayer1 = await cropper.cropImage(
        sourcePath: player1Image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              statusBarColor: WHI,
              backgroundColor: BLA,
              activeControlsWidgetColor: Colors.green,
              toolbarColor: BLA,
              toolbarWidgetColor: WHI,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if(croppedPlayer1 !=null)
      {
        enable = true;
        croppedPlayer1Image = File(croppedPlayer1.path);
        convertImage(croppedPlayer1Image!);
        emit(TwoPlayer1ImageSuccessState());
      }
      else
      {
        emit(TwoPlayer1ImageErrorState());
      }
    } else {
      emit(TwoPlayer1ImageErrorState());
    }
  }
  Future<void> getPlayer2ImageG() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      player2Image = File(pickedFile.path);
      final croppedPlayer2 = await cropper.cropImage(
        sourcePath: player2Image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              statusBarColor: WHI,
              backgroundColor: BLA,
              activeControlsWidgetColor: Colors.green,
              toolbarColor: BLA,
              toolbarWidgetColor: WHI,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if(croppedPlayer2 !=null)
      {
        enable = true;
        croppedPlayer2Image = File(croppedPlayer2.path);
        convertImage(croppedPlayer2Image!);
        emit(TwoPlayer1ImageSuccessState());
      }
      else
      {
        emit(TwoPlayer1ImageErrorState());
      }
    } else {
      emit(TwoPlayer1ImageErrorState());
    }
  }
  Future<void> getPlayer1ImageCameraAdd(index) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      player1Image = File(pickedFile.path);
      final croppedPlayer1 = await cropper.cropImage(
        sourcePath: player1Image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              statusBarColor: WHI,
              backgroundColor: BLA,
              activeControlsWidgetColor: Colors.green,
              toolbarColor: BLA,
              toolbarWidgetColor: WHI,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if(croppedPlayer1 !=null)
      {
        enable = true;
        croppedPlayer1Image = File(croppedPlayer1.path);
        convertImage(croppedPlayer1Image!).then((value){
          addPlayer1PhotoToDatabaseAdd(base64string , index);
        });
        emit(TwoPlayer1ImageSuccessState());
      }
      else
      {
        emit(TwoPlayer1ImageErrorState());
      }
    } else {
      emit(TwoPlayer1ImageErrorState());
    }
  }
  Future<void> getPlayer2ImageCameraAdd(index) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      player2Image = File(pickedFile.path);
      final croppedPlayer2 = await cropper.cropImage(
        sourcePath: player2Image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              statusBarColor: WHI,
              backgroundColor: BLA,
              activeControlsWidgetColor: Colors.green,
              toolbarColor: BLA,
              toolbarWidgetColor: WHI,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if(croppedPlayer2 !=null)
      {
        enable = true;
        croppedPlayer2Image = File(croppedPlayer2.path);
        convertImage(croppedPlayer2Image!).then((value){
          addPlayer2PhotoToDatabaseAdd(base64string , index );
        });
        emit(TwoPlayer1ImageSuccessState());
      }
      else
      {
        emit(TwoPlayer1ImageErrorState());
      }
    } else {
      emit(TwoPlayer1ImageErrorState());
    }
  }
  Future<void> getPlayer1ImageGalleryAdd(index) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      player1Image = File(pickedFile.path);
      final croppedPlayer1 = await cropper.cropImage(
        sourcePath: player1Image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              statusBarColor: WHI,
              backgroundColor: BLA,
              activeControlsWidgetColor: Colors.green,
              toolbarColor: BLA,
              toolbarWidgetColor: WHI,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if(croppedPlayer1 !=null)
      {
        enable = true;
        croppedPlayer1Image = File(croppedPlayer1.path);
        convertImage(croppedPlayer1Image!).then((value){
          addPlayer1PhotoToDatabaseAdd(base64string , index );
        });

        emit(TwoPlayer1ImageSuccessState());
      }
      else
      {
        emit(TwoPlayer1ImageErrorState());
      }
    } else {
      emit(TwoPlayer1ImageErrorState());
    }
  }
  Future<void> getPlayer2ImageGalleryAdd(index) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      player2Image = File(pickedFile.path);
      final croppedPlayer2 = await cropper.cropImage(
        sourcePath: player2Image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              statusBarColor: WHI,
              backgroundColor: BLA,
              activeControlsWidgetColor: Colors.green,
              toolbarColor: BLA,
              toolbarWidgetColor: WHI,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if(croppedPlayer2 !=null)
      {
        enable = true;
        croppedPlayer2Image = File(croppedPlayer2.path);
        convertImage(croppedPlayer2Image!).then((value){
          addPlayer2PhotoToDatabaseAdd(base64string , index );
        });
        emit(TwoPlayer1ImageSuccessState());
      }
      else
      {
        emit(TwoPlayer1ImageErrorState());
      }
    } else {
      emit(TwoPlayer1ImageErrorState());
    }
  }

  /*
  * These methods are created to take photos for the game
  */

  Future convertImage(File image)async {
    Uint8List imageBytes = await image.readAsBytes();
    base64string = base64.encode(imageBytes);
    // print(base64string);
  }

  Future addPlayer1PhotoToDatabase(stringImage, index,context) async {
    getPlayerOneImage = stringImage ;
    dataBase!.rawUpdate('UPDATE Scores SET Player1Image = ? WHERE ID = ?', ['$stringImage', '${users[index]['ID']}'])
        .then((value) {
      player1Image = null;
      croppedPlayer1Image = null;
      base64string = '';
      enable = false ;
      Navigator.pop(context);
      getData(dataBase!);
      emit(TwoUpdating1DatabaseState());
    });
  }

  Future addPlayer2PhotoToDatabase(stringImage, index,context) async {
    getPlayerTwoImage = stringImage ;
    dataBase!.rawUpdate('UPDATE Scores SET Player2Image = ? WHERE ID = ?', ['$stringImage', '${users[index]['ID']}'])
        .then((value) {
      player2Image = null;
      croppedPlayer2Image = null;
      base64string = '';
      enable = false ;
      Navigator.pop(context);
      getData(dataBase!);
      emit(TwoUpdating2DatabaseState());
    });
  }

  /*
  * These methods are created to update photos of the game to the database.
  */

  Future addPlayer1PhotoToDatabaseAdd(stringImage, index) async {
    getPlayerOneImage = stringImage ;
    dataBase!.rawUpdate('UPDATE Scores SET Player1Image = ? WHERE ID = ?', ['$stringImage', '${users[index]['ID']}'])
        .then((value) {
      player1Image = null;
      croppedPlayer1Image = null;
      base64string = '';
      enable = false ;
      getData(dataBase!);
      emit(TwoUpdating1AddDatabaseState());
    });
  }

  Future addPlayer2PhotoToDatabaseAdd(stringImage, index) async {
    getPlayerTwoImage = stringImage ;
    dataBase!.rawUpdate('UPDATE Scores SET Player2Image = ? WHERE ID = ?', ['$stringImage', '${users[index]['ID']}'])
        .then((value) {
      player2Image = null;
      croppedPlayer2Image = null;
      base64string = '';
      enable = false ;
      getData(dataBase!);
      emit(TwoUpdating2AddDatabaseState());
    });
  }

  /*
  * These methods are created to save photos of the game to the database.
  */

  void deleting(index) async {
    dataBase!.rawDelete(
        'DELETE FROM Scores WHERE ID = ? ', [users[index]['ID']]
    ).then((value){
      emit(TwoDeleteFromDataState());
    });
  }

  void selectState() {
    selectBool = true;
    emit(TwoSelectState());
  }

  void changeColor(index) {
    selectedList[index] = !selectedList[index];

    if(whiteList[index] == WHI)
      {
        whiteList[index] = Colors.grey[400]!;
        intSelectedList.add(index);
      }
    else
      {
        whiteList[index] = WHI;
        intSelectedList.remove(index);
      }
    emit(TwoChangeColorState());
  }

  void cancelSelection() {
    selectedList = [];
    whiteList = [];
    selectBool = false;
    intSelectedList = [];
    for(int y = 0 ; y < users.length ; y++)
    {
      selectedList.add(false);
      whiteList.add(WHI);
    }
    emit(TwoCancelSelectionState());
  }

  Future deleteSelected()async {
    for(int i = 0 ; i < intSelectedList.length ; i++)
      {
        deleting(intSelectedList[i]);
      }
    emit(TwoDeleteSelectedState());
  }

  /*
  * These methods is created to delete selected game(s) from database.
  */

  void filling() {
    tempRandomChoice = 0 ;
    var rand = Random();
    for (int i = 0; i < 7; i++)
    {
      tempRandomChoice = forSupport[rand.nextInt(forSupport.length)];
      myCards.add(tempRandomChoice!);
      forSupport.remove(tempRandomChoice);
      supportAndHisCards.remove(tempRandomChoice);
    }
    for (int i = 0; i < 7; i++)
    {
      tempRandomChoice = forSupport[rand.nextInt(forSupport.length)];
      hisCards.add(tempRandomChoice!);
      forSupport.remove(tempRandomChoice);
      supportAndMyCards.remove(tempRandomChoice);
    }
    for (int p = 0 ; p < 7 ; p++)
    {
      tempRandomChoice = forSupport[rand.nextInt(forSupport.length)];
      aboveSupport.add(tempRandomChoice!);
      forSupport.remove(tempRandomChoice);
    }
    for (int p = 7 ; p < 14 ; p++)
    {
      tempRandomChoice = forSupport[rand.nextInt(forSupport.length)];
      belowSupport.add(tempRandomChoice!);
      forSupport.remove(tempRandomChoice);
    }
  }

  /*
  * This method is responsible for distributing cards ( 7 for me , 7 for him , 14 for the ground ).
  */

  void falseSelections() {
    mySelectedCards = [];
    hisSelectedCards = [];
    for ( int i = 0 ; i < myCards.length ; i++ )
    {
      mySelectedCards.add(false) ;
    }
    for ( int j = 0 ; j < hisCards.length ; j++ )
    {
      hisSelectedCards.add(false) ;
    }

  }

  /*
  * This method is responsible for unselect in the beginning.
  */

  void selectingMyCard(index) {
    if (didNotClosed && !gameUp)
    {
      for (int i = 0; i < myCards.length; i++) {
        mySelectedCards[i] = false;
      }
      mySelectedCards[index] = true;
      selectedCard = myCards[index];
      selected = true;
      emit(SelectElnosState());
    }
  }


  void selectHisCard(index) {
    if (didNotClosed && !gameUp )
    {
      for (int i = 0; i < hisCards.length; i++) {
        hisSelectedCards[i] = false;
      }
      hisSelectedCards[index] = true;
      selectedCard = hisCards[index];
      selectedCard = hisCards[index];
      selected = true;
      emit(SelectElnosohState());
    }
  }


  void unselectMyCard(index) {
    if (didNotClosed && !gameUp)
    {
      mySelectedCards[index] = false;
      selectedCard = null;
      selected = false;
      emit(SelectElnosState());
    }
  }


  void unselectHisCard(index) {
    if (didNotClosed && !gameUp)
    {
      hisSelectedCards[index] = false;
      selectedCard = null;
      selected = false;
      emit(SelectElnosohState());
    }
  }


  /*
  * These methods are Responsible for selecting and unselecting cards the player's cards.
  */


  bool symmetricalityCheck(index)
  {
    if (cardDetails[cards[index]]![0] == cardDetails[cards[index]]![1] )
      {
        return true ;
      }
    else
      {
        return false;
      }
  }

  /*
  * This method is Responsible for checking if the card is symmetric or not.
  */

  void restart(context) {
    gameUp = false ;
    holdState = false ;
    myHoldState = false ;
    hisHoldState = false ;
    holdCreate = false ;
    didNotClosed = true ;
    IAmPlayingNow = false ;
    heIsPlayingNow = false ;
    leftGround = [];
    rightGround = [];
    initially = [];
    aboveSupport = [];
    belowSupport = [];
    myCards = [];
    hisCards = [];
    mySelectedCards = [];
    hisSelectedCards = [];
    theAvailableLeft = null;
    theAvailableRight =  null;
    forSupport = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27];
    supportAndMyCards = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27];
    supportAndHisCards = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27];
    initial = false;
    theHighestPriority = null ;
    theHighestPriorityInMyCards = 0 ;
    theHighestPriorityInHisCards = 0 ;
    filling();
    falseSelections();
    selected = false;
    selectedCard = null ;
    theHighestPriorityInMyCards = myCards.reduce((max));
    theHighestPriorityInHisCards = hisCards.reduce((max));
    if (theHighestPriorityInHisCards! > theHighestPriorityInMyCards!)
      {
        myTurn = false;
      }
    else
      {
        myTurn = true;
      }
    if (myTurn)
      {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (context, setState) =>
                  WillPopScope(
                    onWillPop: ()async
                    {
                      FocusManager.instance.primaryFocus?.unfocus();
                      checkMyPasswordController.text = '';
                      Navigator.pop(context);
                      acceptingPlayer1PasswordAppearance = false;
                      holdState = true ;
                      myHoldState = true;
                      hisHoldState = false ;
                      IAmPlayingNow = false ;
                      return false ;
                    },
                    child: AlertDialog(
                      shape: BeveledRectangleBorder(),
                      backgroundColor: WHI,
                      title: Text(
                        'Please, enter player 1 password ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: BLA),
                      ),
                      content: SizedBox(
                        height: 61,
                        child: Column(
                          children: [
                            Form(
                                key: checkMyPasswordKey,
                                child: TextFormField(
                                  enableInteractiveSelection: false,
                                  style: Theme.of(
                                      context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                      color:
                                      BLA),
                                  cursorColor: GREY,
                                  onChanged: (value) {
                                    checkingPlayer1PasswordToPlay();
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    if (value!
                                        .isEmpty) {
                                      return;
                                    }
                                    return null;
                                  },
                                  controller: checkMyPasswordController,
                                  decoration: InputDecoration(
                                    focusedBorder:
                                    OutlineInputBorder(),
                                    enabledBorder:
                                    OutlineInputBorder(),
                                    hintText:
                                    'password',
                                    hintStyle: Theme.of(
                                        context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                        color:
                                        GREY),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      contentPadding:
                      EdgeInsetsDirectional.only(
                          start: 20,
                          end: 20,
                          top: 19,
                          bottom: 11),
                      actions: [
                        MaterialButton(
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            checkMyPasswordController.text = '';
                            Navigator.pop(context);
                            IAmPlayingNow = false ;
                            holdState = true ;
                            myHoldState = true;
                            hisHoldState = false ;
                            acceptingPlayer1PasswordAppearance = false;
                          },
                          child: Text('cancel',style: TextStyle(color: Colors.green),),
                        ),
                        Padding(
                          padding:
                          const EdgeInsetsDirectional
                              .only(end: 10),
                          child: ConditionalBuilder(
                            condition: acceptingPlayer1PasswordAppearance,
                            builder:
                                (context) =>
                                MaterialButton(
                                    minWidth: 1,
                                    padding: EdgeInsets.zero,
                                    onPressed:
                                        () {
                                      acceptingPlayer1PasswordAppearance = false;
                                      IAmPlayingNow = true ;
                                      holdState = false ;
                                      myHoldState = false;
                                      hisHoldState = false ;
                                      checkMyPasswordController.text = '';
                                      Navigator.pop(context);
                                      emit(RestartState());
                                    },
                                    child: Text(
                                      'go',style: TextStyle(color: Colors.green),)),
                            fallback: (context) =>
                                MaterialButton(
                                  minWidth: 1,
                                  padding: EdgeInsets.zero,
                                  onPressed: null,
                                  child: Text(
                                    'go',
                                    style: TextStyle(
                                        color: GREY),
                                  ),
                                ),
                          ),
                        ),
                      ],
                      actionsPadding:
                      EdgeInsetsDirectional.only(
                          bottom: 8),
                    ),
                  ),
            ));
      }
    else
      {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (context, setState) =>
                  WillPopScope(
                    onWillPop: ()async
                    {
                      FocusManager.instance.primaryFocus?.unfocus();
                      checkHisPasswordController.text = '';
                      Navigator.pop(context);
                      acceptingPlayer2PasswordAppearance = false;
                      holdState = true ;
                      hisHoldState = true ;
                      myHoldState = false ;
                      heIsPlayingNow = false ;
                      return false ;
                    },
                    child: AlertDialog(
                      shape: BeveledRectangleBorder(),
                      backgroundColor: WHI,
                      title: Text(
                        'Please, enter player 2 password ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: BLA),
                      ),
                      content: SizedBox(
                        height: 61,
                        child: Column(
                          children: [
                            Form(
                                key: checkHisPasswordKey,
                                child: TextFormField(
                                  enableInteractiveSelection: false,
                                  style: Theme.of(
                                      context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                      color:
                                      BLA),
                                  cursorColor: GREY,
                                  onChanged: (value) {
                                    checkingPlayer2PasswordToPlay();
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    if (value!
                                        .isEmpty) {
                                      return;
                                    }
                                    return null;
                                  },
                                  controller: checkHisPasswordController,
                                  decoration: InputDecoration(
                                    focusedBorder:
                                    OutlineInputBorder(),
                                    enabledBorder:
                                    OutlineInputBorder(),
                                    hintText:
                                    'password',
                                    hintStyle: Theme.of(
                                        context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                        color:
                                        GREY),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      contentPadding:
                      EdgeInsetsDirectional.only(
                          start: 20,
                          end: 20,
                          top: 19,
                          bottom: 11),
                      actions: [
                        MaterialButton(
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            checkHisPasswordController.text = '';
                            Navigator.pop(context);
                            heIsPlayingNow = false ;
                            holdState = true ;
                            hisHoldState = true ;
                            myHoldState = false ;
                            acceptingPlayer2PasswordAppearance = false;
                          },
                          child: Text('cancel',style: TextStyle(color: Colors.green),),
                        ),
                        Padding(
                          padding:
                          const EdgeInsetsDirectional
                              .only(end: 10),
                          child: ConditionalBuilder(
                            condition: acceptingPlayer2PasswordAppearance,
                            builder:
                                (context) =>
                                MaterialButton(
                                    minWidth: 1,
                                    padding: EdgeInsets.zero,
                                    onPressed:
                                        () {
                                      acceptingPlayer2PasswordAppearance = false;
                                      holdState = false ;
                                      hisHoldState = false ;
                                      myHoldState = false ;
                                      heIsPlayingNow = true ;
                                      checkHisPasswordController.text = '';
                                      Navigator.pop(context);
                                      emit(RestartState());
                                    },
                                    child: const Text(
                                      'go',style: TextStyle(color: Colors.green),)),
                            fallback: (context) =>
                                MaterialButton(
                                  minWidth: 1,
                                  padding: EdgeInsets.zero,
                                  onPressed: null,
                                  child: Text(
                                    'go',
                                    style: TextStyle(
                                        color: GREY),
                                  ),
                                ),
                          ),
                        ),
                      ],
                      actionsPadding:
                      EdgeInsetsDirectional.only(
                          bottom: 8),
                    ),
                  ),
            ));
      }
    emit(RestartState());
  }

  /*
  * This method is created to restart the game by returning all variables to their initial values.
  * It also checks the biggest card value of my and his cards and depends on that, it decides who will start the game.
  */

  void restartWithOne(context) {
    gameUp = false ;
    holdState = false ;
    myHoldState = false ;
    hisHoldState = false ;
    holdCreate = false ;
    didNotClosed = true ;
    IAmPlayingNow = false ;
    heIsPlayingNow = false ;
    leftGround = [];
    rightGround = [];
    initially = [];
    aboveSupport = [];
    belowSupport = [];
    myCards = [];
    hisCards = [];
    mySelectedCards = [];
    hisSelectedCards = [];
    theAvailableLeft = null;
    theAvailableRight =  null;
    forSupport = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27];
    supportAndMyCards = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27];
    supportAndHisCards = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27];
    initial = false;
    theHighestPriority = null ;
    theHighestPriorityInMyCards = 0 ;
    theHighestPriorityInHisCards = 0 ;
    filling();
    falseSelections();
    selected = false;
    selectedCard = null ;
    myTurn = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => StatefulBuilder(
            builder: (context, setState) =>
                WillPopScope(
                  onWillPop: ()async
                  {
                    FocusManager.instance.primaryFocus?.unfocus();
                    checkMyPasswordController.text = '';
                    Navigator.pop(context);
                    acceptingPlayer1PasswordAppearance = false;
                    holdState = true ;
                    myHoldState = true;
                    hisHoldState = false ;
                    IAmPlayingNow = false ;
                    return false ;
                  },
                  child: AlertDialog(
                    shape: BeveledRectangleBorder(),
                    backgroundColor: WHI,
                    title: Text(
                      'Please, enter player 1 password ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: BLA),
                    ),
                    content: SizedBox(
                      height: 61,
                      child: Column(
                        children: [
                          Form(
                              key: checkMyPasswordKey,
                              child: TextFormField(
                                enableInteractiveSelection: false,
                                style: Theme.of(
                                    context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                    color:
                                    BLA),
                                cursorColor: GREY,
                                onChanged: (value) {
                                  checkingPlayer1PasswordToPlay();
                                  setState(() {});
                                },
                                validator: (value) {
                                  if (value!
                                      .isEmpty) {
                                    return;
                                  }
                                  return null;
                                },
                                controller: checkMyPasswordController,
                                decoration: InputDecoration(
                                  focusedBorder:
                                  OutlineInputBorder(),
                                  enabledBorder:
                                  OutlineInputBorder(),
                                  hintText:
                                  'password',
                                  hintStyle: Theme.of(
                                      context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                      color:
                                      GREY),
                                ),
                              )),
                        ],
                      ),
                    ),
                    contentPadding:
                    EdgeInsetsDirectional.only(
                        start: 20,
                        end: 20,
                        top: 19,
                        bottom: 11),
                    actions: [
                      MaterialButton(
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          checkMyPasswordController.text = '';
                          Navigator.pop(context);
                          IAmPlayingNow = false ;
                          holdState = true ;
                          myHoldState = true;
                          hisHoldState = false ;
                          acceptingPlayer1PasswordAppearance = false;
                        },
                        child: Text('cancel',style: TextStyle(color: Colors.green),),
                      ),
                      Padding(
                        padding:
                        const EdgeInsetsDirectional
                            .only(end: 10),
                        child: ConditionalBuilder(
                          condition: acceptingPlayer1PasswordAppearance,
                          builder:
                              (context) =>
                              MaterialButton(
                                  minWidth: 1,
                                  padding: EdgeInsets.zero,
                                  onPressed:
                                      () {
                                    acceptingPlayer1PasswordAppearance = false;
                                    IAmPlayingNow = true ;
                                    holdState = false ;
                                    myHoldState = false;
                                    hisHoldState = false ;
                                    checkMyPasswordController.text = '';
                                    Navigator.pop(context);
                                    emit(RestartState());
                                  },
                                  child: Text(
                                    'go',style: TextStyle(color: Colors.green),)),
                          fallback: (context) =>
                              MaterialButton(
                                minWidth: 1,
                                padding: EdgeInsets.zero,
                                onPressed: null,
                                child: Text(
                                  'go',
                                  style: TextStyle(
                                      color: GREY),
                                ),
                              ),
                        ),
                      ),
                    ],
                    actionsPadding:
                    EdgeInsetsDirectional.only(
                        bottom: 8),
                  ),
                ),
          ));
    emit(RestartState());
  }

  /*
  * This method is created to restart the game by returning all variables to their initial values.
  * It makes player one start the game.
  */

  void restartWithTwo(context) {
    gameUp = false ;
    holdState = false ;
    myHoldState = false ;
    hisHoldState = false ;
    holdCreate = false ;
    didNotClosed = true ;
    IAmPlayingNow = false ;
    heIsPlayingNow = false ;
    leftGround = [];
    rightGround = [];
    initially = [];
    aboveSupport = [];
    belowSupport = [];
    myCards = [];
    hisCards = [];
    mySelectedCards = [];
    hisSelectedCards = [];
    theAvailableLeft = null;
    theAvailableRight =  null;
    forSupport = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27];
    supportAndMyCards = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27];
    supportAndHisCards = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27];
    initial = false;
    theHighestPriority = null ;
    theHighestPriorityInMyCards = 0 ;
    theHighestPriorityInHisCards = 0 ;
    filling();
    falseSelections();
    selected = false;
    selectedCard = null ;
    myTurn = false;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => StatefulBuilder(
            builder: (context, setState) =>
                WillPopScope(
                  onWillPop: ()async
                  {
                    FocusManager.instance.primaryFocus?.unfocus();
                    checkHisPasswordController.text = '';
                    Navigator.pop(context);
                    acceptingPlayer2PasswordAppearance = false;
                    holdState = true ;
                    hisHoldState = true ;
                    myHoldState = false ;
                    heIsPlayingNow = false ;
                    return false ;
                  },
                  child: AlertDialog(
                    shape: BeveledRectangleBorder(),
                    backgroundColor: WHI,
                    title: Text(
                      'Please, enter player 2 password ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: BLA),
                    ),
                    content: SizedBox(
                      height: 61,
                      child: Column(
                        children: [
                          Form(
                              key: checkHisPasswordKey,
                              child: TextFormField(
                                enableInteractiveSelection: false,
                                style: Theme.of(
                                    context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                    color:
                                    BLA),
                                cursorColor: GREY,
                                onChanged: (value) {
                                  checkingPlayer2PasswordToPlay();
                                  setState(() {});
                                },
                                validator: (value) {
                                  if (value!
                                      .isEmpty) {
                                    return;
                                  }
                                  return null;
                                },
                                controller: checkHisPasswordController,
                                decoration: InputDecoration(
                                  focusedBorder:
                                  OutlineInputBorder(),
                                  enabledBorder:
                                  OutlineInputBorder(),
                                  hintText:
                                  'password',
                                  hintStyle: Theme.of(
                                      context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                      color:
                                      GREY),
                                ),
                              )),
                        ],
                      ),
                    ),
                    contentPadding:
                    EdgeInsetsDirectional.only(
                        start: 20,
                        end: 20,
                        top: 19,
                        bottom: 11),
                    actions: [
                      MaterialButton(
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          checkHisPasswordController.text = '';
                          Navigator.pop(context);
                          heIsPlayingNow = false ;
                          holdState = true ;
                          hisHoldState = true ;
                          myHoldState = false ;
                          acceptingPlayer2PasswordAppearance = false;
                        },
                        child: Text('cancel',style: TextStyle(color: Colors.green),),
                      ),
                      Padding(
                        padding:
                        const EdgeInsetsDirectional
                            .only(end: 10),
                        child: ConditionalBuilder(
                          condition: acceptingPlayer2PasswordAppearance,
                          builder:
                              (context) =>
                              MaterialButton(
                                  minWidth: 1,
                                  padding: EdgeInsets.zero,
                                  onPressed:
                                      () {
                                    acceptingPlayer2PasswordAppearance = false;
                                    holdState = false ;
                                    hisHoldState = false ;
                                    myHoldState = false ;
                                    heIsPlayingNow = true ;
                                    checkHisPasswordController.text = '';
                                    Navigator.pop(context);
                                    emit(RestartState());
                                  },
                                  child: Text(
                                    'go',style: TextStyle(color: Colors.green),)),
                          fallback: (context) =>
                              MaterialButton(
                                minWidth: 1,
                                padding: EdgeInsets.zero,
                                onPressed: null,
                                child: Text(
                                  'go',
                                  style: TextStyle(
                                      color: GREY),
                                ),
                              ),
                        ),
                      ),
                    ],
                    actionsPadding:
                    EdgeInsetsDirectional.only(
                        bottom: 8),
                  ),
                ),
          ));
    emit(RestartState());
  }

  /*
  * This method is created to restart the game by returning all variables to their initial values.
  * It makes player tow start the game.
  */

  void supportMeFromBelow(index) {
    if (IAmPlayingNow! && player2password != null && didNotClosed && !gameUp)
    {
      myCards.add(index);
      belowSupport.remove(index);
      supportAndHisCards.remove(index);
      mySelectedCards.add(false);
      emit(S7biT7tState());
    }
  }

  void supportMeFromAbove(index) {
    if (IAmPlayingNow! && player2password != null && didNotClosed && !gameUp)
    {
      myCards.add(index);
      aboveSupport.remove(index);
      supportAndHisCards.remove(index);
      mySelectedCards.add(false);
      emit(S7biFo2State());
    }
  }

  void supportHimFromBelow(index) {
    if (heIsPlayingNow! && player2password != null && didNotClosed && !gameUp )
    {
      hisCards.add(index);
      belowSupport.remove(index);
      hisSelectedCards.add(false);
      supportAndMyCards.remove(index);
      emit(S7bohT7tState());
    }
  }

  void supportHimFromAbove(index) {
    if (heIsPlayingNow! && player2password != null && didNotClosed && !gameUp)
      {
        hisCards.add(index);
        aboveSupport.remove(index);
        hisSelectedCards.add(false);
        supportAndMyCards.remove(index);
        emit(S7bohFo2State());
      }
  }

  /*
  * These methods are handling supporting.
  */

  bool symmetricalityCheck2(index)
  {
    for (int i = 27 ; i > 20 ; i--)
    {
      if ( index == i )
      {
        return true ;
      }
    }
    for (int j = 48 ; j > 55 ; j--)
    {
      if ( index == j )
      {
        return true ;
      }
    }
    return false ;
  }

  /*
  * This method is Responsible for checking if the card is symmetric or not.
  */

  void mePlayingRight(index,context) {
    if (cardDetails[cards[index]]![0] == theAvailableRight)
    {
        theAvailableRight = cardDetails[cards[index]]![1];
        rightGround.add(index);
      }
    else
    {
      theAvailableRight = cardDetails[cards[index]]![0];
      rightGround.add(index+28);
    }
    myCards.remove(index);
    mySelectedCards.removeLast();
    supportAndMyCards.remove(index);
    for( int j = 0 ; j < myCards.length ; j++)
      {
        mySelectedCards[j] = false;
      }
    selected = false;
    if (myCards.isNotEmpty)
    {
      for (int t = 0; t < supportAndHisCards.length; t++) {
        if ((theAvailableLeft == cardDetails[cards[supportAndHisCards[t]]]![0] ||
                theAvailableLeft == cardDetails[cards[supportAndHisCards[t]]]![1]) ||
            (theAvailableRight == cardDetails[cards[supportAndHisCards[t]]]![0] ||
                theAvailableRight == cardDetails[cards[supportAndHisCards[t]]]![1])) {
          myTurn = false;
          break;
        }
      }
      IAmPlayingNow = false;
      if (myTurn)
      {
        for (int t = 0; t < supportAndMyCards.length; t++) {
          if ((theAvailableLeft == cardDetails[cards[supportAndMyCards[t]]]![0] || theAvailableLeft == cardDetails[cards[supportAndMyCards[t]]]![1]) || (theAvailableRight == cardDetails[cards[supportAndMyCards[t]]]![0] || theAvailableRight == cardDetails[cards[supportAndMyCards[t]]]![1]))
          {
            hisCards = [];
            hisSelectedCards = [];
            for (int k = 0; k < supportAndHisCards.length; k++) {
              hisCards.add(supportAndHisCards[k]);
              hisSelectedCards.add(false);
            }
            aboveSupport = [];
            belowSupport = [];
            IAmPlayingNow = true;
            didNotClosed = true;
            break;
          } else {
            didNotClosed = false;
          }
        }
        if (!didNotClosed) {
          for (int q = 0 ; q < myCards.length ; q++)
          {
            myPoints += cardDetails[cards[myCards[q]]]![0] + cardDetails[cards[myCards[q]]]![1] ;
          }
          for (int q = 0 ; q < hisCards.length ; q++)
          {
            hisPoints += cardDetails[cards[hisCards[q]]]![0] + cardDetails[cards[hisCards[q]]]![1] ;
          }
          myPointsWhileClosing = myPoints ;
          HisPointsWhileClosing = hisPoints ;
          if (myPoints > hisPoints)
          {
            IWinWhileClosing = false ;
            myPoints = myPoints - hisPoints ;
            hisPoints = 0 ;
          }
          else if (hisPoints > myPoints)
          {
            IWinWhileClosing = true ;
            hisPoints = hisPoints - myPoints ;
            myPoints = 0 ;
          }
          else
          {
            IWinWhileClosing = null ;
          }
          IAmPlayingNow = true;
          heIsPlayingNow = true;
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => StatefulBuilder(
                    builder: (context, setState) => WillPopScope(
                      onWillPop: ()async{
                        Navigator.pop(context);
                        return false ;
                      },
                      child: AlertDialog(
                        shape: BeveledRectangleBorder(),
                        backgroundColor: WHI,
                        title: Text(
                          'WARNING',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: BLA),
                        ),
                        content: Wrap(
                          children: [
                            Text(
                              IWinWhileClosing != null ?
                              IWinWhileClosing! ?
                              "it's قفلة ... Player 1 points >> $myPointsWhileClosing ... Player 2 points >> $HisPointsWhileClosing ... Player 1 wins >> $hisPoints"
                                  :
                              "it's قفلة ... Player 1 points >> $myPointsWhileClosing ... Player 2 points >> $HisPointsWhileClosing ... Player 2 wins >> $myPoints"

                                  :

                              "it's باطل ... Player 1 points >> $myPointsWhileClosing ... Player 2 points >> $HisPointsWhileClosing",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: BLA),
                            ),
                          ],
                        ),
                        contentPadding: EdgeInsetsDirectional.only(
                            start: 20, end: 20, top: 19, bottom: 11),
                        actions: [
                          TextButton(
                            onPressed: () {
                              addRound();
                              Navigator.pop(context); // Close the dialog
                            },
                            child: Text(
                              'OK',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: GRE, fontSize: 15),
                            ),
                          ),
                        ],
                        actionsPadding:
                            EdgeInsetsDirectional.only(bottom: 8, end: 8),
                      ),
                    ),
                  ));
        }
      }
      else
      {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => StatefulBuilder(
                  builder: (context, setState) => WillPopScope(
                    onWillPop: ()async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      checkHisPasswordController.text = '';
                      Navigator.pop(context);
                      acceptingPlayer2PasswordAppearance = false;
                      heIsPlayingNow = false;
                      holdState = true;
                      hisHoldState = true;
                      myHoldState = false;
                      return false ;
                    },
                    child: AlertDialog(
                      shape: BeveledRectangleBorder(),
                      backgroundColor: WHI,
                      title: Text(
                        'Please, enter player 2 password ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: BLA),
                      ),
                      content: SizedBox(
                        height: 61,
                        child: Column(
                          children: [
                            Form(
                                key: checkHisPasswordKey,
                                child: TextFormField(
                                  enableInteractiveSelection: false,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: BLA),
                                  cursorColor: GREY,
                                  onChanged: (value) {
                                    checkingPlayer2PasswordToPlay();
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return;
                                    }
                                    return null;
                                  },
                                  controller: checkHisPasswordController,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(),
                                    hintText: 'password',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: GREY),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      contentPadding: EdgeInsetsDirectional.only(
                          start: 20, end: 20, top: 19, bottom: 11),
                      actions: [
                        MaterialButton(
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            checkHisPasswordController.text = '';
                            Navigator.pop(context);
                            heIsPlayingNow = false;
                            holdState = true;
                            hisHoldState = true;
                            myHoldState = false;
                            acceptingPlayer2PasswordAppearance = false;
                          },
                          child: Text(
                            'cancel',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: 10),
                          child: ConditionalBuilder(
                            condition: acceptingPlayer2PasswordAppearance,
                            builder: (context) => MaterialButton(
                                minWidth: 1,
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  acceptingPlayer2PasswordAppearance = false;
                                  heIsPlayingNow = true;
                                  holdState = false;
                                  hisHoldState = false;
                                  myHoldState = false;
                                  checkHisPasswordController.text = '';
                                  Navigator.pop(context);
                                  emit(l3biT7tState());
                                },
                                child: Text(
                                  'go',
                                  style: TextStyle(color: Colors.green),
                                )),
                            fallback: (context) => MaterialButton(
                              minWidth: 1,
                              padding: EdgeInsets.zero,
                              onPressed: null,
                              child: Text(
                                'go',
                                style: TextStyle(color: GREY),
                              ),
                            ),
                          ),
                        ),
                      ],
                      actionsPadding: EdgeInsetsDirectional.only(bottom: 8),
                    ),
                  ),
                ));
      }
    }
    else
    {
        for (int q = 0 ; q < hisCards.length ; q++)
        {
          hisPoints += cardDetails[cards[hisCards[q]]]![0] + cardDetails[cards[hisCards[q]]]![1] ;
        }
        gameUp = true ;
        heIsPlayingNow = true ;
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (context, setState) => WillPopScope(
                onWillPop: ()async {
                  Navigator.pop(context);
                  return false ;
                },
                child: AlertDialog(
                  shape: BeveledRectangleBorder(),
                  backgroundColor: WHI,
                  title: Text(
                    'WARNING',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: BLA),
                  ),
                  content: Wrap(
                    children: [
                      Text(
                        " Player 1 wins >> $hisPoints",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: BLA),
                      ),
                    ],
                  ),
                  contentPadding: EdgeInsetsDirectional.only(
                      start: 20, end: 20, top: 19, bottom: 11),
                  actions: [
                    TextButton(
                      onPressed: () {
                        addRound();
                        Navigator.pop(context); // Close the dialog
                      },
                      child: Text(
                        'OK',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: GRE, fontSize: 15),
                      ),
                    ),
                  ],
                  actionsPadding:
                  EdgeInsetsDirectional.only(bottom: 8, end: 8),
                ),
              ),
            ));
      }
    emit(l3biT7tState());
  }
  void mePlayingLeft(index ,context) {
    if (cardDetails[cards[index]]![1] == theAvailableLeft)
    {
      theAvailableLeft = cardDetails[cards[index]]![0];
      leftGround.add(index);
    }
    else
    {
      theAvailableLeft = cardDetails[cards[index]]![1];
      leftGround.add(index+28);
    }
    myCards.remove(index);
    mySelectedCards.removeLast();
    supportAndMyCards.remove(index);
    for( int j = 0 ; j < myCards.length ; j++)
    {
      mySelectedCards[j] = false;
    }
    selected = false;
    if (myCards.isNotEmpty)
    {
      for (int t = 0; t < supportAndHisCards.length; t++) {
        if ((theAvailableLeft == cardDetails[cards[supportAndHisCards[t]]]![0] ||
                theAvailableLeft == cardDetails[cards[supportAndHisCards[t]]]![1]) ||
            (theAvailableRight == cardDetails[cards[supportAndHisCards[t]]]![0] ||
                theAvailableRight == cardDetails[cards[supportAndHisCards[t]]]![1])) {
          myTurn = false;
          break;
        }
      }
      IAmPlayingNow = false;
      if (myTurn)
      {
        for (int t = 0; t < supportAndMyCards.length; t++) {
          if ((theAvailableLeft == cardDetails[cards[supportAndMyCards[t]]]![0] ||
                  theAvailableLeft == cardDetails[cards[supportAndMyCards[t]]]![1]) ||
              (theAvailableRight == cardDetails[cards[supportAndMyCards[t]]]![0] ||
                  theAvailableRight == cardDetails[cards[supportAndMyCards[t]]]![1])) {
            hisCards = [];
            hisSelectedCards = [];
            for (int k = 0; k < supportAndHisCards.length; k++) {
              hisCards.add(supportAndHisCards[k]);
              hisSelectedCards.add(false);
            }
            aboveSupport = [];
            belowSupport = [];
            IAmPlayingNow = true;
            didNotClosed = true;
            break;
          } else {
            didNotClosed = false;
          }
        }
        if (!didNotClosed) {
          for (int q = 0 ; q < myCards.length ; q++)
          {
            myPoints += cardDetails[cards[myCards[q]]]![0] + cardDetails[cards[myCards[q]]]![1] ;
          }
          for (int q = 0 ; q < hisCards.length ; q++)
          {
            hisPoints += cardDetails[cards[hisCards[q]]]![0] + cardDetails[cards[hisCards[q]]]![1] ;
          }
          myPointsWhileClosing = myPoints ;
          HisPointsWhileClosing = hisPoints ;
          if (myPoints > hisPoints)
          {
            IWinWhileClosing = false ;
            myPoints = myPoints - hisPoints ;
            hisPoints = 0 ;
          }
          else if (hisPoints > myPoints)
          {
            IWinWhileClosing = true ;
            hisPoints = hisPoints - myPoints ;
            myPoints = 0 ;
          }
          else
          {
            IWinWhileClosing = null ;
          }
          IAmPlayingNow = true;
          heIsPlayingNow = true;
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => StatefulBuilder(
                    builder: (context, setState) => WillPopScope(
                      onWillPop: ()async {
                        Navigator.pop(context);
                        return false ;
                      },
                      child: AlertDialog(
                        shape: BeveledRectangleBorder(),
                        backgroundColor: WHI,
                        title: Text(
                          'WARNING',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: BLA),
                        ),
                        content: Wrap(
                          children: [
                            Text(
                              IWinWhileClosing != null ?
                              IWinWhileClosing! ?
                              "it's قفلة ... Player 1 points >> $myPointsWhileClosing ... Player 2 points >> $HisPointsWhileClosing ... Player 1 wins >> $hisPoints"
                                  :
                              "it's قفلة ... Player 1 points >> $myPointsWhileClosing ... Player 2 points >> $HisPointsWhileClosing ... Player 2 wins >> $myPoints"

                                  :

                              "it's باطل ... Player 1 points >> $myPointsWhileClosing ... Player 2 points >> $HisPointsWhileClosing",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: BLA),
                            ),
                          ],
                        ),
                        contentPadding: EdgeInsetsDirectional.only(
                            start: 20, end: 20, top: 19, bottom: 11),
                        actions: [
                          TextButton(
                            onPressed: () {
                              addRound();
                              Navigator.pop(context); // Close the dialog
                            },
                            child: Text(
                              'OK',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: GRE, fontSize: 15),
                            ),
                          ),
                        ],
                        actionsPadding:
                            EdgeInsetsDirectional.only(bottom: 8, end: 8),
                      ),
                    ),
                  ));
        }
      }
      else
      {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => StatefulBuilder(
                  builder: (context, setState) => WillPopScope(
                    onWillPop: ()async{
                      FocusManager.instance.primaryFocus?.unfocus();
                      checkHisPasswordController.text = '';
                      Navigator.pop(context);
                      acceptingPlayer2PasswordAppearance = false;
                      heIsPlayingNow = false;
                      holdState = true;
                      hisHoldState = true;
                      myHoldState = false;
                      return false ;
                    },
                    child: AlertDialog(
                      shape: BeveledRectangleBorder(),
                      backgroundColor: WHI,
                      title: Text(
                        'Please, enter player 2 password ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: BLA),
                      ),
                      content: SizedBox(
                        height: 61,
                        child: Column(
                          children: [
                            Form(
                                key: checkHisPasswordKey,
                                child: TextFormField(
                                  enableInteractiveSelection: false,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: BLA),
                                  cursorColor: GREY,
                                  onChanged: (value) {
                                    checkingPlayer2PasswordToPlay();
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return;
                                    }
                                    return null;
                                  },
                                  controller: checkHisPasswordController,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(),
                                    hintText: 'password',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: GREY),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      contentPadding: EdgeInsetsDirectional.only(
                          start: 20, end: 20, top: 19, bottom: 11),
                      actions: [
                        MaterialButton(
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            checkHisPasswordController.text = '';
                            Navigator.pop(context);
                            heIsPlayingNow = false;
                            holdState = true;
                            hisHoldState = true;
                            myHoldState = false;
                            acceptingPlayer2PasswordAppearance = false;
                          },
                          child: Text(
                            'cancel',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: 10),
                          child: ConditionalBuilder(
                            condition: acceptingPlayer2PasswordAppearance,
                            builder: (context) => MaterialButton(
                                minWidth: 1,
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  acceptingPlayer2PasswordAppearance = false;
                                  heIsPlayingNow = true;
                                  checkHisPasswordController.text = '';
                                  holdState = false;
                                  hisHoldState = false;
                                  myHoldState = false;
                                  Navigator.pop(context);
                                  emit(l3biFo2State());
                                },
                                child: Text(
                                  'go',
                                  style: TextStyle(color: Colors.green),
                                )),
                            fallback: (context) => MaterialButton(
                              minWidth: 1,
                              padding: EdgeInsets.zero,
                              onPressed: null,
                              child: Text(
                                'go',
                                style: TextStyle(color: GREY),
                              ),
                            ),
                          ),
                        ),
                      ],
                      actionsPadding: EdgeInsetsDirectional.only(bottom: 8),
                    ),
                  ),
                ));
      }
    }
    else
    {
      for (int q = 0 ; q < hisCards.length ; q++)
      {
        hisPoints += cardDetails[cards[hisCards[q]]]![0] + cardDetails[cards[hisCards[q]]]![1] ;
      }
      gameUp = true ;
      heIsPlayingNow = true ;
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) => WillPopScope(
              onWillPop: ()async {
                Navigator.pop(context);
                return false ;
              },
              child: AlertDialog(
                shape: BeveledRectangleBorder(),
                backgroundColor: WHI,
                title: Text(
                  'WARNING',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: BLA),
                ),
                content: Wrap(
                  children: [
                    Text(
                      " Player 1 wins >> $hisPoints ",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: BLA),
                    ),
                  ],
                ),
                contentPadding: EdgeInsetsDirectional.only(
                    start: 20, end: 20, top: 19, bottom: 11),
                actions: [
                  TextButton(
                    onPressed: () {
                      addRound();
                      Navigator.pop(context); // Close the dialog
                    },
                    child: Text(
                      'OK',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: GRE, fontSize: 15),
                    ),
                  ),
                ],
                actionsPadding:
                const EdgeInsetsDirectional.only(bottom: 8, end: 8),
              ),
            ),
          ));
    }
    emit(l3biFo2State());
  }
  void myBeginning(index,context) {
    initially.add(index);
    myCards.remove(index);
    mySelectedCards.removeLast();
    supportAndMyCards.remove(index);
    for( int j = 0 ; j < myCards.length ; j++)
    {
      mySelectedCards[j] = false;
    }
    selected = false;
    initial = true ;
    theAvailableLeft = cardDetails[cards[index]]![0];
    theAvailableRight = cardDetails[cards[index]]![1];
    print(theAvailableRight);
    print(theAvailableLeft);
    IAmPlayingNow = false ;
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) =>
                WillPopScope(
                  onWillPop: ()async
                  {
                    FocusManager.instance.primaryFocus?.unfocus();
                    checkHisPasswordController.text = '';
                    Navigator.pop(context);
                    acceptingPlayer2PasswordAppearance = false;
                    heIsPlayingNow = false ;
                    myTurn = true ;
                    holdState = true ;
                    hisHoldState = true ;
                    myHoldState = false ;
                    return false ;
                  },
                  child: AlertDialog(
                    shape: BeveledRectangleBorder(),
                    backgroundColor: WHI,
                    title: Text(
                      'Please, enter player 2 password ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: BLA),
                    ),
                    content: SizedBox(
                      height: 61,
                      child: Column(
                        children: [
                          Form(
                              key: checkHisPasswordKey,
                              child: TextFormField(
                                enableInteractiveSelection: false,
                                style: Theme.of(
                                    context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                    color:
                                    BLA),
                                cursorColor: GREY,
                                onChanged: (value) {
                                  checkingPlayer2PasswordToPlay();
                                  setState(() {});
                                },
                                validator: (value) {
                                  if (value!
                                      .isEmpty) {
                                    return;
                                  }
                                  return null;
                                },
                                controller: checkHisPasswordController,
                                decoration: InputDecoration(
                                  focusedBorder:
                                  OutlineInputBorder(),
                                  enabledBorder:
                                  OutlineInputBorder(),
                                  hintText:
                                  'password',
                                  hintStyle: Theme.of(
                                      context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                      color:
                                      GREY),
                                ),
                              )),
                        ],
                      ),
                    ),
                    contentPadding:
                    EdgeInsetsDirectional.only(
                        start: 20,
                        end: 20,
                        top: 19,
                        bottom: 11),
                    actions: [
                      MaterialButton(
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          checkHisPasswordController.text = '';
                          Navigator.pop(context);
                          heIsPlayingNow = false ;
                          acceptingPlayer2PasswordAppearance = false;
                          holdState = true ;
                          hisHoldState = true ;
                          myHoldState = false ;
                          myTurn = true ;
                        },
                        child: Text('cancel',style: TextStyle(color: Colors.green),),
                      ),
                      Padding(
                        padding:
                        const EdgeInsetsDirectional
                            .only(end: 10),
                        child: ConditionalBuilder(
                          condition: acceptingPlayer2PasswordAppearance,
                          builder:
                              (context) =>
                              MaterialButton(
                                  minWidth: 1,
                                  padding: EdgeInsets.zero,
                                  onPressed:
                                      () {
                                    acceptingPlayer2PasswordAppearance = false;
                                    heIsPlayingNow = true ;
                                    holdState = false ;
                                    hisHoldState = false ;
                                    myHoldState = false ;
                                    checkHisPasswordController.text = '';
                                    myTurn = false ;
                                    Navigator.pop(context);
                                    emit(BdaytiState());
                                  },
                                  child: Text(
                                    'go',style: TextStyle(color: Colors.green),)),
                          fallback: (context) =>
                              MaterialButton(
                                minWidth: 1,
                                padding: EdgeInsets.zero,
                                onPressed: null,
                                child: Text(
                                  'go',
                                  style: TextStyle(
                                      color: GREY),
                                ),
                              ),
                        ),
                      ),
                    ],
                    actionsPadding:
                    EdgeInsetsDirectional.only(
                        bottom: 8),
                  ),
                ),
          ));
    emit(BdaytiState());
  }
  void hisBeginning(index,context) {
    initially.add(index);
    hisCards.remove(index);
    hisSelectedCards.removeLast();
    supportAndHisCards.remove(index);
    for( int j = 0 ; j < hisCards.length ; j++)
    {
      hisSelectedCards[j] = false;
    }
    selected = false;
    initial = true ;
    theAvailableLeft = cardDetails[cards[index]]![0];
    theAvailableRight = cardDetails[cards[index]]![1];
    print(theAvailableRight);
    print(theAvailableLeft);
    heIsPlayingNow = false ;
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) =>
                WillPopScope(
                  onWillPop: ()async
                  {
                    FocusManager.instance.primaryFocus?.unfocus();
                    checkMyPasswordController.text = '';
                    Navigator.pop(context);
                    acceptingPlayer1PasswordAppearance = false;
                    IAmPlayingNow = false ;
                    myTurn = false ;
                    holdState = true ;
                    myHoldState = true ;
                    hisHoldState = false ;
                    return false ;
                  },
                  child: AlertDialog(
                    shape: BeveledRectangleBorder(),
                    backgroundColor: WHI,
                    title: Text(
                      'Please, enter player 1 password ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: BLA),
                    ),
                    content: SizedBox(
                      height: 61,
                      child: Column(
                        children: [
                          Form(
                              key: checkMyPasswordKey,
                              child: TextFormField(
                                enableInteractiveSelection: false,
                                style: Theme.of(
                                    context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                    color:
                                    BLA),
                                cursorColor: GREY,
                                onChanged: (value) {
                                  checkingPlayer1PasswordToPlay();
                                  setState(() {});
                                },
                                validator: (value) {
                                  if (value!
                                      .isEmpty) {
                                    return;
                                  }
                                  return null;
                                },
                                controller: checkMyPasswordController,
                                decoration: InputDecoration(
                                  focusedBorder:
                                  OutlineInputBorder(),
                                  enabledBorder:
                                  OutlineInputBorder(),
                                  hintText:
                                  'password',
                                  hintStyle: Theme.of(
                                      context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                      color:
                                      GREY),
                                ),
                              )),
                        ],
                      ),
                    ),
                    contentPadding:
                    EdgeInsetsDirectional.only(
                        start: 20,
                        end: 20,
                        top: 19,
                        bottom: 11),
                    actions: [
                      MaterialButton(
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          checkMyPasswordController.text = '';
                          Navigator.pop(context);
                          IAmPlayingNow = false ;
                          acceptingPlayer1PasswordAppearance = false;
                          holdState = true ;
                          myHoldState = true ;
                          hisHoldState = false ;
                          myTurn = false ;
                        },
                        child: Text('cancel',style: TextStyle(color: Colors.green),),
                      ),
                      Padding(
                        padding:
                        const EdgeInsetsDirectional
                            .only(end: 10),
                        child: ConditionalBuilder(
                          condition: acceptingPlayer1PasswordAppearance,
                          builder:
                              (context) =>
                              MaterialButton(
                                  minWidth: 1,
                                  padding: EdgeInsets.zero,
                                  onPressed:
                                      () {
                                    acceptingPlayer1PasswordAppearance = false;
                                    IAmPlayingNow = true ;
                                    holdState = false ;
                                    myHoldState = false ;
                                    hisHoldState = false ;
                                    checkMyPasswordController.text = '';
                                    myTurn = true ;
                                    Navigator.pop(context);
                                    emit(BdaytohState());
                                  },
                                  child: const Text(
                                    'go',style: TextStyle(color: Colors.green),)),
                          fallback: (context) =>
                              MaterialButton(
                                minWidth: 1,
                                padding: EdgeInsets.zero,
                                onPressed: null,
                                child: Text(
                                  'go',
                                  style: TextStyle(
                                      color: GREY),
                                ),
                              ),
                        ),
                      ),
                    ],
                    actionsPadding:
                    EdgeInsetsDirectional.only(
                        bottom: 8),
                  ),
                ),
          ));
    emit(BdaytohState());
  }
  void himPlayingRight(index,context) {
    if (cardDetails[cards[index]]![0] == theAvailableRight)
    {
      theAvailableRight = cardDetails[cards[index]]![1];
      rightGround.add(index);
    }
    else
    {
      theAvailableRight = cardDetails[cards[index]]![0];
      rightGround.add(index+28);
    }
    for( int j = 0 ; j < hisCards.length ; j++)
    {
      hisSelectedCards[j] = false;
    }
    hisCards.remove(index);
    hisSelectedCards.removeLast();
    supportAndHisCards.remove(index);
    selected = false;
    if (hisCards.isNotEmpty)
    {
      for (int t = 0; t < supportAndMyCards.length; t++) {
        if ((theAvailableLeft == cardDetails[cards[supportAndMyCards[t]]]![0] ||
                theAvailableLeft == cardDetails[cards[supportAndMyCards[t]]]![1]) ||
            (theAvailableRight == cardDetails[cards[supportAndMyCards[t]]]![0] ||
                theAvailableRight == cardDetails[cards[supportAndMyCards[t]]]![1])) {
          myTurn = true;
          break;
        }
      }
      heIsPlayingNow = false;
      if (myTurn)
      {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => StatefulBuilder(
                  builder: (context, setState) => WillPopScope(
                  onWillPop: ()async{
                      FocusManager.instance.primaryFocus?.unfocus();
                      checkMyPasswordController.text = '';
                      Navigator.pop(context);
                      acceptingPlayer1PasswordAppearance = false;
                      IAmPlayingNow = false;
                      holdState = true;
                      myHoldState = true;
                      hisHoldState = false;
                      return false ;
                    },
                    child: AlertDialog(
                      shape: BeveledRectangleBorder(),
                      backgroundColor: WHI,
                      title: Text(
                        'Please, enter player 1 password ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: BLA),
                      ),
                      content: SizedBox(
                        height: 61,
                        child: Column(
                          children: [
                            Form(
                                key: checkMyPasswordKey,
                                child: TextFormField(
                                  enableInteractiveSelection: false,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: BLA),
                                  cursorColor: GREY,
                                  onChanged: (value) {
                                    checkingPlayer1PasswordToPlay();
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return;
                                    }
                                    return null;
                                  },
                                  controller: checkMyPasswordController,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(),
                                    hintText: 'password',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: GREY),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      contentPadding: EdgeInsetsDirectional.only(
                          start: 20, end: 20, top: 19, bottom: 11),
                      actions: [
                        MaterialButton(
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            checkMyPasswordController.text = '';
                            Navigator.pop(context);
                            IAmPlayingNow = false;
                            holdState = true;
                            myHoldState = true;
                            hisHoldState = false;
                            acceptingPlayer1PasswordAppearance = false;
                          },
                          child: Text(
                            'cancel',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: 10),
                          child: ConditionalBuilder(
                            condition: acceptingPlayer1PasswordAppearance,
                            builder: (context) => MaterialButton(
                                minWidth: 1,
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  acceptingPlayer1PasswordAppearance = false;
                                  IAmPlayingNow = true;
                                  holdState = false;
                                  myHoldState = false;
                                  hisHoldState = false;
                                  checkMyPasswordController.text = '';
                                  Navigator.pop(context);
                                  emit(l3bohT7tState());
                                },
                                child: Text(
                                  'go',
                                  style: TextStyle(color: Colors.green),
                                )),
                            fallback: (context) => MaterialButton(
                              minWidth: 1,
                              padding: EdgeInsets.zero,
                              onPressed: null,
                              child: Text(
                                'go',
                                style: TextStyle(color: GREY),
                              ),
                            ),
                          ),
                        ),
                      ],
                      actionsPadding: EdgeInsetsDirectional.only(bottom: 8),
                    ),
                  ),
                ));
      }
      else
      {
        for (int t = 0; t < supportAndHisCards.length; t++) {
          if ((theAvailableLeft == cardDetails[cards[supportAndHisCards[t]]]![0] ||
                  theAvailableLeft == cardDetails[cards[supportAndHisCards[t]]]![1]) ||
              (theAvailableRight == cardDetails[cards[supportAndHisCards[t]]]![0] ||
                  theAvailableRight == cardDetails[cards[supportAndHisCards[t]]]![1])) {
            myCards = [];
            mySelectedCards = [];
            for (int k = 0; k < supportAndMyCards.length; k++) {
              myCards.add(supportAndMyCards[k]);
              mySelectedCards.add(false);
            }
            aboveSupport = [];
            belowSupport = [];
            heIsPlayingNow = true;
            didNotClosed = true;
            break;
          }
          else {
            didNotClosed = false;
          }
        }
        if (!didNotClosed) {
          for (int q = 0 ; q < myCards.length ; q++)
          {
            myPoints += cardDetails[cards[myCards[q]]]![0] + cardDetails[cards[myCards[q]]]![1] ;
          }
          for (int q = 0 ; q < hisCards.length ; q++)
          {
            hisPoints += cardDetails[cards[hisCards[q]]]![0] + cardDetails[cards[hisCards[q]]]![1] ;
          }
          myPointsWhileClosing = myPoints ;
          HisPointsWhileClosing = hisPoints ;
          if (myPoints > hisPoints)
          {
            IWinWhileClosing = false ;
            myPoints = myPoints - hisPoints ;
            hisPoints = 0 ;
          }
          else if (hisPoints > myPoints)
          {
            IWinWhileClosing = true ;
            hisPoints = hisPoints - myPoints ;
            myPoints = 0 ;
          }
          else
          {
            IWinWhileClosing = null ;
          }
          IAmPlayingNow = true;
          heIsPlayingNow = true;
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => StatefulBuilder(
                    builder: (context, setState) => WillPopScope(
                      onWillPop: ()async
                     {
                        Navigator.pop(context);
                        return false ;
                      },
                      child: AlertDialog(
                        shape: BeveledRectangleBorder(),
                        backgroundColor: WHI,
                        title: Text(
                          'WARNING',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: BLA),
                        ),
                        content: Wrap(
                          children: [
                            Text(
                              IWinWhileClosing != null ?
                              IWinWhileClosing! ?
                              "it's قفلة ... Player 1 points >> $myPointsWhileClosing ... Player 2 points >> $HisPointsWhileClosing ... Player 1 wins >> $hisPoints"
                                  :
                              "it's قفلة ... Player 1 points >> $myPointsWhileClosing ... Player 2 points >> $HisPointsWhileClosing ... Player 2 wins >> $myPoints"

                                  :

                              "it's باطل ... Player 1 points >> $myPointsWhileClosing ... Player 2 points >> $HisPointsWhileClosing",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: BLA),
                            ),
                          ],
                        ),
                        contentPadding: EdgeInsetsDirectional.only(
                            start: 20, end: 20, top: 19, bottom: 11),
                        actions: [
                          TextButton(
                            onPressed: () {
                              addRound();
                              Navigator.pop(context); // Close the dialog
                            },
                            child: Text(
                              'OK',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: GRE, fontSize: 15),
                            ),
                          ),
                        ],
                        actionsPadding:
                            EdgeInsetsDirectional.only(bottom: 8, end: 8),
                      ),
                    ),
                  ));
        }
      }
    }
    else
    {
      for (int q = 0 ; q < myCards.length ; q++)
        {
          myPoints += cardDetails[cards[myCards[q]]]![0] + cardDetails[cards[myCards[q]]]![1] ;
        }
      gameUp = true ;
      IAmPlayingNow = true ;
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) => WillPopScope(
            onWillPop: ()async{
                Navigator.pop(context);
                return false ;
              },
              child: AlertDialog(
                shape: BeveledRectangleBorder(),
                backgroundColor: WHI,
                title: Text(
                  'WARNING',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: BLA),
                ),
                content: Wrap(
                  children: [
                    Text(
                      " Player 2 wins >> $myPoints ",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: BLA),
                    ),
                  ],
                ),
                contentPadding: EdgeInsetsDirectional.only(
                    start: 20, end: 20, top: 19, bottom: 11),
                actions: [
                  TextButton(
                    onPressed: () {
                      addRound();
                      Navigator.pop(context); // Close the dialog
                    },
                    child: Text(
                      'OK',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: GRE, fontSize: 15),
                    ),
                  ),
                ],
                actionsPadding:
                EdgeInsetsDirectional.only(bottom: 8, end: 8),
              ),
            ),
          ));
    }
    emit(l3bohT7tState());
  }
  void himPlayingLeft(index,context) {
    if (cardDetails[cards[index]]![1] == theAvailableLeft)
    {
      theAvailableLeft = cardDetails[cards[index]]![0];
      leftGround.add(index);
    }
    else
    {
      theAvailableLeft = cardDetails[cards[index]]![1];
      leftGround.add(index+28);
    }
    hisCards.remove(index);
    hisSelectedCards.removeLast();
    supportAndHisCards.remove(index);
    for( int j = 0 ; j < hisCards.length ; j++)
    {
      hisSelectedCards[j] = false;
    }
    selected = false;
    if (hisCards.isNotEmpty)
    {
      for (int t = 0; t < supportAndMyCards.length; t++) {
        if ((theAvailableLeft == cardDetails[cards[supportAndMyCards[t]]]![0] ||
                theAvailableLeft == cardDetails[cards[supportAndMyCards[t]]]![1]) ||
            (theAvailableRight == cardDetails[cards[supportAndMyCards[t]]]![0] ||
                theAvailableRight == cardDetails[cards[supportAndMyCards[t]]]![1])) {
          myTurn = true;
          break;
        }
      }
      heIsPlayingNow = false;
      if (myTurn)
      {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => StatefulBuilder(
                  builder: (context, setState) => WillPopScope(
                    onWillPop: ()async{
                      FocusManager.instance.primaryFocus?.unfocus();
                      checkMyPasswordController.text = '';
                      Navigator.pop(context);
                      acceptingPlayer1PasswordAppearance = false;
                      IAmPlayingNow = false;
                      holdState = true;
                      myHoldState = true;
                      hisHoldState = false;
                      return false ;
                    },
                    child: AlertDialog(
                      shape: BeveledRectangleBorder(),
                      backgroundColor: WHI,
                      title: Text(
                        'Please, enter player 1 password ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: BLA),
                      ),
                      content: SizedBox(
                        height: 61,
                        child: Column(
                          children: [
                            Form(
                                key: checkMyPasswordKey,
                                child: TextFormField(
                                  enableInteractiveSelection: false,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: BLA),
                                  cursorColor: GREY,
                                  onChanged: (value) {
                                    checkingPlayer1PasswordToPlay();
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return;
                                    }
                                    return null;
                                  },
                                  controller: checkMyPasswordController,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(),
                                    hintText: 'password',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: GREY),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      contentPadding: EdgeInsetsDirectional.only(
                          start: 20, end: 20, top: 19, bottom: 11),
                      actions: [
                        MaterialButton(
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            checkMyPasswordController.text = '';
                            Navigator.pop(context);
                            IAmPlayingNow = false;
                            acceptingPlayer1PasswordAppearance = false;
                            holdState = true;
                            myHoldState = true;
                            hisHoldState = false;
                          },
                          child: Text(
                            'cancel',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: 10),
                          child: ConditionalBuilder(
                            condition: acceptingPlayer1PasswordAppearance,
                            builder: (context) => MaterialButton(
                                minWidth: 1,
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  acceptingPlayer1PasswordAppearance = false;
                                  IAmPlayingNow = true;
                                  checkMyPasswordController.text = '';
                                  holdState = false;
                                  myHoldState = false;
                                  hisHoldState = false;
                                  Navigator.pop(context);
                                  emit(l3bohFo2State());
                                },
                                child: Text(
                                  'go',
                                  style: TextStyle(color: Colors.green),
                                )),
                            fallback: (context) => MaterialButton(
                              minWidth: 1,
                              padding: EdgeInsets.zero,
                              onPressed: null,
                              child: Text(
                                'go',
                                style: TextStyle(color: GREY),
                              ),
                            ),
                          ),
                        ),
                      ],
                      actionsPadding: EdgeInsetsDirectional.only(bottom: 8),
                    ),
                  ),
                ));
      }
      else
      {
        for (int t = 0; t < supportAndHisCards.length; t++) {
          if ((theAvailableLeft == cardDetails[cards[supportAndHisCards[t]]]![0] ||
                  theAvailableLeft == cardDetails[cards[supportAndHisCards[t]]]![1]) ||
              (theAvailableRight == cardDetails[cards[supportAndHisCards[t]]]![0] ||
                  theAvailableRight ==
                      cardDetails[cards[supportAndHisCards[t]]]![1])) {
            myCards = [];
            mySelectedCards = [];
            for (int k = 0; k < supportAndMyCards.length; k++) {
              myCards.add(supportAndMyCards[k]);
              mySelectedCards.add(false);
            }
            aboveSupport = [];
            belowSupport = [];
            heIsPlayingNow = true;
            didNotClosed = true;
            break;
          } else {
            didNotClosed = false;
          }
        }
        if (!didNotClosed) {
          for (int q = 0 ; q < myCards.length ; q++)
          {
            myPoints += cardDetails[cards[myCards[q]]]![0] + cardDetails[cards[myCards[q]]]![1] ;
          }
          for (int q = 0 ; q < hisCards.length ; q++)
          {
            hisPoints += cardDetails[cards[hisCards[q]]]![0] + cardDetails[cards[hisCards[q]]]![1] ;
          }
          myPointsWhileClosing = myPoints ;
          HisPointsWhileClosing = hisPoints ;
          if (myPoints > hisPoints)
            {
              IWinWhileClosing = false ;
              myPoints = myPoints - hisPoints ;
              hisPoints = 0 ;
            }
          else if (hisPoints > myPoints)
            {
              IWinWhileClosing = true ;
              hisPoints = hisPoints - myPoints ;
              myPoints = 0 ;
            }
          else
            {
              IWinWhileClosing = null ;
            }
          IAmPlayingNow = true;
          heIsPlayingNow = true;
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => StatefulBuilder(
                    builder: (context, setState) => WillPopScope(
                    onWillPop: ()async{
                        Navigator.pop(context);
                        return false ;
                      },
                      child: AlertDialog(
                        shape: BeveledRectangleBorder(),
                        backgroundColor: WHI,
                        title: Text(
                          'WARNING',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: BLA),
                        ),
                        content: Wrap(
                          children: [
                            Text(
                              IWinWhileClosing != null ?
                                  IWinWhileClosing! ?
                                  "it's قفلة ... Player 1 points >> $myPointsWhileClosing ... Player 2 points >> $HisPointsWhileClosing ... Player 1 wins >> $hisPoints"
                                     :
                                 "it's قفلة ... Player 1 points >> $myPointsWhileClosing ... Player 2 points >> $HisPointsWhileClosing ... Player 2 wins >> $myPoints"

                                  :

                              "it's باطل ... Player 1 points >> $myPointsWhileClosing ... Player 2 points >> $HisPointsWhileClosing",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: BLA),
                            ),
                          ],
                        ),
                        contentPadding: EdgeInsetsDirectional.only(
                            start: 20, end: 20, top: 19, bottom: 11),
                        actions: [
                          TextButton(
                            onPressed: () {
                              addRound();
                              Navigator.pop(context); // Close the dialog
                            },
                            child: Text(
                              'OK',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: GRE, fontSize: 15),
                            ),
                          ),
                        ],
                        actionsPadding:
                            EdgeInsetsDirectional.only(bottom: 8, end: 8),
                      ),
                    ),
                  ));
        }
      }
    }
    else
    {
      for (int q = 0 ; q < myCards.length ; q++)
      {
        myPoints += cardDetails[cards[myCards[q]]]![0] + cardDetails[cards[myCards[q]]]![1] ;
      }
      gameUp = true ;
      IAmPlayingNow = true ;
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) => WillPopScope(
            onWillPop: ()async{
                Navigator.pop(context);
                return false ;
              },
              child: AlertDialog(
                shape: BeveledRectangleBorder(),
                backgroundColor: WHI,
                title: Text(
                  'WARNING',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: BLA),
                ),
                content: Wrap(
                  children: [
                    Text(
                      " Player 2 wins >> $myPoints ",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: BLA),
                    ),
                  ],
                ),
                contentPadding: EdgeInsetsDirectional.only(
                    start: 20, end: 20, top: 19, bottom: 11),
                actions: [
                  TextButton(
                    onPressed: () {
                      addRound();
                      Navigator.pop(context); // Close the dialog
                    },
                    child: Text(
                      'OK',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: GRE, fontSize: 15),
                    ),
                  ),
                ],
                actionsPadding:
                EdgeInsetsDirectional.only(bottom: 8, end: 8),
              ),
            ),
          ));
    }
    emit(l3bohFo2State());
  }

  /*
  * This method is Responsible for handling playing.
  */

  void checkingThatPlayer1PasswordIsNotEmpty() {
    creatingPlayer1PasswordAppearance = true ;
    if (myPasswordCreationController.text == '' || myPasswordCreationController.text.trim() == '' )
    {
      creatingPlayer1PasswordAppearance = false ;
    }
    emit(TwoZhorElGo1Stata());
  }
  void checkingThatPlayer2PasswordIsNotEmpty() {
    creatingPlayer2PasswordAppearance = true ;
    if (hisPasswordCreationController.text == '' || hisPasswordCreationController.text.trim() == '' )
    {
      creatingPlayer2PasswordAppearance = false ;
    }
    emit(TwoZhorElGo2Stata());
  }
  void checkingPlayer1PasswordToPlay() {
    acceptingPlayer1PasswordAppearance = false ;
    if (checkMyPasswordController.text == player1password )
    {
      acceptingPlayer1PasswordAppearance = true ;
    }
    emit(TwoZhorElGo3Stata());
  }
  void checkingPlayer2PasswordToPlay() {
    acceptingPlayer2PasswordAppearance = false ;
    if (checkHisPasswordController.text == player2password )
    {
      acceptingPlayer2PasswordAppearance = true ;
    }
    emit(TwoZhorElGo4Stata());
  }

  /*
  * This method is Responsible for handling Secrecy playing.
  */

  void hold(context) {
    if (holdState)
      {
        if (myHoldState)
          {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => StatefulBuilder(
                  builder: (context, setState) =>
                      WillPopScope(
                        onWillPop: ()async
                        {
                          FocusManager.instance.primaryFocus?.unfocus();
                          checkMyPasswordController.text = '';
                          Navigator.pop(context);
                          acceptingPlayer1PasswordAppearance = false;
                          IAmPlayingNow = false ;
                          myTurn = false ;
                          holdState = true ;
                          myHoldState = true ;
                          return false ;
                        },
                        child: AlertDialog(
                          shape: BeveledRectangleBorder(),
                          backgroundColor: WHI,
                          title: Text(
                            'Please, enter player 1 password ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: BLA),
                          ),
                          content: SizedBox(
                            height: 61,
                            child: Column(
                              children: [
                                Form(
                                    key: checkMyPasswordKey,
                                    child: TextFormField(
                                      enableInteractiveSelection: false,
                                      style: Theme.of(
                                          context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                          color:
                                          BLA),
                                      cursorColor: GREY,
                                      onChanged: (value) {
                                        checkingPlayer1PasswordToPlay();
                                        setState(() {});
                                      },
                                      validator: (value) {
                                        if (value!
                                            .isEmpty) {
                                          return;
                                        }
                                        return null;
                                      },
                                      controller: checkMyPasswordController,
                                      decoration: InputDecoration(
                                        focusedBorder:
                                        OutlineInputBorder(),
                                        enabledBorder:
                                        OutlineInputBorder(),
                                        hintText:
                                        'password',
                                        hintStyle: Theme.of(
                                            context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                            color:
                                            GREY),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          contentPadding:
                          EdgeInsetsDirectional.only(
                              start: 20,
                              end: 20,
                              top: 19,
                              bottom: 11),
                          actions: [
                            MaterialButton(
                              minWidth: 1,
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                checkMyPasswordController.text = '';
                                Navigator.pop(context);
                                IAmPlayingNow = false ;
                                acceptingPlayer1PasswordAppearance = false;
                                holdState = true ;
                                myHoldState = true ;
                                myTurn = false ;
                              },
                              child: Text('cancel',style: TextStyle(color: Colors.green),),
                            ),
                            Padding(
                              padding:
                              const EdgeInsetsDirectional
                                  .only(end: 10),
                              child: ConditionalBuilder(
                                condition: acceptingPlayer1PasswordAppearance,
                                builder:
                                    (context) =>
                                    MaterialButton(
                                        minWidth: 1,
                                        padding: EdgeInsets.zero,
                                        onPressed:
                                            () {
                                          acceptingPlayer1PasswordAppearance = false;
                                          IAmPlayingNow = true ;
                                          holdState = false ;
                                          myHoldState = false ;
                                          checkMyPasswordController.text = '';
                                          myTurn = true ;
                                          Navigator.pop(context);
                                          emit(TwoHoldState());
                                        },
                                        child: Text(
                                          'go',style: TextStyle(color: Colors.green),)),
                                fallback: (context) =>
                                    MaterialButton(
                                      minWidth: 1,
                                      padding: EdgeInsets.zero,
                                      onPressed: null,
                                      child: Text(
                                        'go',
                                        style: TextStyle(
                                            color: GREY),
                                      ),
                                    ),
                              ),
                            ),
                          ],
                          actionsPadding:
                          EdgeInsetsDirectional.only(
                              bottom: 8),
                        ),
                      ),
                ));
          }
        else if (hisHoldState)
          {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => StatefulBuilder(
                  builder: (context, setState) =>
                      WillPopScope(
                      onWillPop: ()async
                        {
                          FocusManager.instance.primaryFocus?.unfocus();
                          checkHisPasswordController.text = '';
                          Navigator.pop(context);
                          acceptingPlayer2PasswordAppearance = false;
                          heIsPlayingNow = false ;
                          myTurn = true ;
                          holdState = true ;
                          hisHoldState = true ;
                          return false ;
                        },
                        child: AlertDialog(
                          shape: BeveledRectangleBorder(),
                          backgroundColor: WHI,
                          title: Text(
                            'Please, enter player 2 password ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: BLA),
                          ),
                          content: SizedBox(
                            height: 61,
                            child: Column(
                              children: [
                                Form(
                                    key: checkHisPasswordKey,
                                    child: TextFormField(
                                      enableInteractiveSelection: false,
                                      style: Theme.of(
                                          context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                          color:
                                          BLA),
                                      cursorColor: GREY,
                                      onChanged: (value) {
                                        checkingPlayer2PasswordToPlay();
                                        setState(() {});
                                      },
                                      validator: (value) {
                                        if (value!
                                            .isEmpty) {
                                          return;
                                        }
                                        return null;
                                      },
                                      controller: checkHisPasswordController,
                                      decoration: InputDecoration(
                                        focusedBorder:
                                        OutlineInputBorder(),
                                        enabledBorder:
                                        OutlineInputBorder(),
                                        hintText:
                                        'password',
                                        hintStyle: Theme.of(
                                            context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                            color:
                                            GREY),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          contentPadding:
                          EdgeInsetsDirectional.only(
                              start: 20,
                              end: 20,
                              top: 19,
                              bottom: 11),
                          actions: [
                            MaterialButton(
                              minWidth: 1,
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                checkHisPasswordController.text = '';
                                Navigator.pop(context);
                                heIsPlayingNow = false ;
                                acceptingPlayer2PasswordAppearance = false;
                                holdState = true ;
                                hisHoldState = true ;
                                myTurn = true ;
                              },
                              child: Text('cancel',style: TextStyle(color: Colors.green),),
                            ),
                            Padding(
                              padding:
                              const EdgeInsetsDirectional
                                  .only(end: 10),
                              child: ConditionalBuilder(
                                condition: acceptingPlayer2PasswordAppearance,
                                builder:
                                    (context) =>
                                    MaterialButton(
                                        minWidth: 1,
                                        padding: EdgeInsets.zero,
                                        onPressed:
                                            () {
                                          acceptingPlayer2PasswordAppearance = false;
                                          heIsPlayingNow = true ;
                                          holdState = false ;
                                          hisHoldState = false ;
                                          checkHisPasswordController.text = '';
                                          myTurn = false ;
                                          Navigator.pop(
                                              context);
                                          emit(TwoHoldState());
                                        },
                                        child: Text(
                                          'go',style: TextStyle(color: Colors.green),)),
                                fallback: (context) =>
                                    MaterialButton(
                                      minWidth: 1,
                                      padding: EdgeInsets.zero,
                                      onPressed: null,
                                      child: Text(
                                        'go',
                                        style: TextStyle(
                                            color: GREY),
                                      ),
                                    ),
                              ),
                            ),
                          ],
                          actionsPadding:
                          EdgeInsetsDirectional.only(
                              bottom: 8),
                        ),
                      ),
                ));
          }
      }
    emit(TwoHoldState());
  }

  /*
  * This method is Responsible for handling resuming after pressing cancel before me or him play.
  */

  void holdCr(context) {
    if (holdCreate)
    {
      if (player1password == null)
      {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (context, setState) =>
                  WillPopScope(
                    onWillPop: ()async
                    {
                      FocusManager.instance.primaryFocus?.unfocus();
                      myPasswordCreationController.text = '';
                      Navigator.pop(context);
                      creatingPlayer1PasswordAppearance = false;
                      holdCreate = true ;
                      return false ;
                    },
                    child: AlertDialog(
                      shape: BeveledRectangleBorder(),
                      backgroundColor: WHI,
                      title: Text(
                        'Please, create player 1 password ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: BLA),
                      ),
                      content: SizedBox(
                        height: 61,
                        child: Column(
                          children: [
                            Form(
                                key: myPasswordCreationKey,
                                child: TextFormField(
                                  enableInteractiveSelection: false,
                                  style: Theme.of(
                                      context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                      color:
                                      BLA),
                                  cursorColor: GREY,
                                  onChanged: (value) {
                                    checkingThatPlayer1PasswordIsNotEmpty();
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    if (value!
                                        .isEmpty) {
                                      return;
                                    }
                                    return null;
                                  },
                                  controller: myPasswordCreationController,
                                  decoration: InputDecoration(
                                    focusedBorder:
                                    OutlineInputBorder(),
                                    enabledBorder:
                                    OutlineInputBorder(),
                                    hintText:
                                    'password',
                                    hintStyle: Theme.of(
                                        context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                        color:
                                        GREY),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      contentPadding:
                      EdgeInsetsDirectional.only(
                          start: 20,
                          end: 20,
                          top: 19,
                          bottom: 11),
                      actions: [
                        MaterialButton(
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            Navigator.pop(context);
                            myPasswordCreationController.text = '';
                            creatingPlayer1PasswordAppearance = false;
                            holdCreate = true ;
                          },
                          child: Text('cancel',style: TextStyle(color: Colors.green),),
                        ),
                        Padding(
                          padding:
                          const EdgeInsetsDirectional
                              .only(end: 10),
                          child: ConditionalBuilder(
                            condition: creatingPlayer1PasswordAppearance,
                            builder:
                                (context) =>
                                MaterialButton(
                                    minWidth: 1,
                                    padding: EdgeInsets.zero,
                                    onPressed:
                                        () {
                                      Navigator.pop(context);
                                      player1password = myPasswordCreationController.text;
                                      myPasswordCreationController.text = '';
                                      creatingPlayer1PasswordAppearance = false;
                                      holdCreate = false ;
                                      playerTwoPasswordSyslog(context);
                                    },
                                    child: Text(
                                      'save',style: TextStyle(color: Colors.green),)),
                            fallback: (context) =>
                                MaterialButton(
                                  minWidth: 1,
                                  padding: EdgeInsets.zero,
                                  onPressed: null,
                                  child: Text(
                                    'save',
                                    style: TextStyle(
                                        color: GREY),
                                  ),
                                ),
                          ),
                        ),
                      ],
                      actionsPadding:
                      EdgeInsetsDirectional.only(
                          bottom: 8),
                    ),
                  ),
            ));
      }
      else
      {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (context, setState) =>
                  WillPopScope(
                    onWillPop: ()async
                    {
                      FocusManager.instance.primaryFocus?.unfocus();
                      hisPasswordCreationController.text = '';
                      Navigator.pop(context);
                      creatingPlayer2PasswordAppearance = false;
                      holdCreate = true ;
                      return false ;
                    },
                    child: AlertDialog(
                      shape: BeveledRectangleBorder(),
                      backgroundColor: WHI,
                      title: Text(
                        'Please, create player 2 password ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: BLA),
                      ),
                      content: SizedBox(
                        height: 61,
                        child: Column(
                          children: [
                            Form(
                                key: hisPasswordCreationKey,
                                child: TextFormField(
                                  enableInteractiveSelection: false,
                                  style: Theme.of(
                                      context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                      color:
                                      BLA),
                                  cursorColor: GREY,
                                  onChanged: (value) {
                                    checkingThatPlayer2PasswordIsNotEmpty();
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    if (value!
                                        .isEmpty) {
                                      return;
                                    }
                                    return null;
                                  },
                                  controller: hisPasswordCreationController,
                                  decoration: InputDecoration(
                                    focusedBorder:
                                    OutlineInputBorder(),
                                    enabledBorder:
                                    OutlineInputBorder(),
                                    hintText:
                                    'password',
                                    hintStyle: Theme.of(
                                        context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                        color:
                                        GREY),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      contentPadding:
                      EdgeInsetsDirectional.only(
                          start: 20,
                          end: 20,
                          top: 19,
                          bottom: 11),
                      actions: [
                        MaterialButton(
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            Navigator.pop(context);
                            hisPasswordCreationController.text = '';
                            holdCreate = true ;
                            creatingPlayer2PasswordAppearance = false;
                          },
                          child: Text('cancel',style: TextStyle(color: Colors.green),),
                        ),
                        Padding(
                          padding:
                          const EdgeInsetsDirectional
                              .only(end: 10),
                          child: ConditionalBuilder(
                            condition: creatingPlayer2PasswordAppearance,
                            builder:
                                (context) =>
                                MaterialButton(
                                    minWidth: 1,
                                    padding: EdgeInsets.zero,
                                    onPressed:
                                        () {
                                      player2password = hisPasswordCreationController.text;
                                      Navigator.pop(
                                          context);
                                      restart(context);
                                      creatingPlayer2PasswordAppearance = false;
                                      hisPasswordCreationController.text = '';
                                      holdCreate = false ;
                                    },
                                    child: Text(
                                      'save',style: TextStyle(color: Colors.green),)),
                            fallback: (context) =>
                                MaterialButton(
                                  minWidth: 1,
                                  padding: EdgeInsets.zero,
                                  onPressed: null,
                                  child: Text(
                                    'save',
                                    style: TextStyle(
                                        color: GREY),
                                  ),
                                ),
                          ),
                        ),
                      ],
                      actionsPadding:
                      EdgeInsetsDirectional.only(
                          bottom: 8),
                    ),
                  ),
            ));
      }
    }
    emit(StateState());
  }
  void playerTwoPasswordSyslog(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) =>
              WillPopScope(
              onWillPop: ()async
                {
                  FocusManager.instance.primaryFocus?.unfocus();
                  hisPasswordCreationController.text = '';
                  Navigator.pop(context);
                  creatingPlayer2PasswordAppearance = false;
                  holdCreate = true ;
                  return false ;
                },
                child: AlertDialog(
                  shape: BeveledRectangleBorder(),
                  backgroundColor: WHI,
                  title: Text(
                    'Please, create player 2 password ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: BLA),
                  ),
                  content: SizedBox(
                    height: 61,
                    child: Column(
                      children: [
                        Form(
                            key: hisPasswordCreationKey,
                            child: TextFormField(
                              enableInteractiveSelection: false,
                              style: Theme.of(
                                  context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                  color:
                                  BLA),
                              cursorColor: GREY,
                              onChanged: (value) {
                                checkingThatPlayer2PasswordIsNotEmpty();
                                setState(() {});
                              },
                              validator: (value) {
                                if (value!
                                    .isEmpty) {
                                  return;
                                }
                                return null;
                              },
                              controller: hisPasswordCreationController,
                              decoration: InputDecoration(
                                focusedBorder:
                                OutlineInputBorder(),
                                enabledBorder:
                                OutlineInputBorder(),
                                hintText:
                                'password',
                                hintStyle: Theme.of(
                                    context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                    color:
                                    GREY),
                              ),
                            )),
                      ],
                    ),
                  ),
                  contentPadding:
                  const EdgeInsetsDirectional.only(
                      start: 20,
                      end: 20,
                      top: 19,
                      bottom: 11),
                  actions: [
                    MaterialButton(
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.pop(context);
                        hisPasswordCreationController.text = '';
                        holdCreate = true ;
                        creatingPlayer2PasswordAppearance = false;
                      },
                      child: Text('cancel',style: TextStyle(color: Colors.green),),
                    ),
                    Padding(
                      padding:
                      const EdgeInsetsDirectional
                          .only(end: 10),
                      child: ConditionalBuilder(
                        condition: creatingPlayer2PasswordAppearance,
                        builder:
                            (context) =>
                            MaterialButton(
                                minWidth: 1,
                                padding: EdgeInsets.zero,
                                onPressed:
                                    () {
                                  player2password = hisPasswordCreationController.text;
                                  Navigator.pop(context);
                                  restart(context);
                                  creatingPlayer2PasswordAppearance = false;
                                  hisPasswordCreationController.text = '';
                                  holdCreate = false ;
                                },
                                child: const Text(
                                  'save',style: TextStyle(color: Colors.green),)),
                        fallback: (context) =>
                            MaterialButton(
                              minWidth: 1,
                              padding: EdgeInsets.zero,
                              onPressed: null,
                              child: Text(
                                'save',
                                style: TextStyle(
                                    color: GREY),
                              ),
                            ),
                      ),
                    ),
                  ],
                  actionsPadding:
                  const EdgeInsetsDirectional.only(
                      bottom: 8),
                ),
              ),
        ));
  }

  /*
  * This method is Responsible for handling resuming after pressing cancel before me or him creating password.
  */

}
