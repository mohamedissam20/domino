import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project1/layout/layout_page.dart';
import 'package:sqflite/sqflite.dart';

Widget? widget;


Color WHI = HexColor('#ffffff');
Color BLA = HexColor('#000000');
Color GRE = HexColor('#4caf50');
Color Burgundy = HexColor('#852E2E');
Color a7mr = HexColor('#FF0000');
Color GREY = HexColor('#8C8C8C');
Color GOLD = HexColor('#B68800');

var playerOneKey = GlobalKey<FormState>();
var playerTwoKey = GlobalKey<FormState>();
var saveKey = GlobalKey<FormState>();
TextEditingController playerOneController = TextEditingController();
TextEditingController playerTwoController = TextEditingController();
TextEditingController saveController = TextEditingController();
bool save_appearance = false ;
bool creatingPlayer1PasswordAppearance = false ;
bool creatingPlayer2PasswordAppearance = false ;
bool acceptingPlayer1PasswordAppearance = false ;
bool acceptingPlayer2PasswordAppearance = false ;

List<GlobalKey<FormState>> keys1 = [];

List<int> player1 = [];
List<int> player2 = [];

int roundsNum = 0;

Database? dataBase ;
List<int> getInnerPlayerOneScores = [];
List<int> getInnerPlayerTwoScores = [];
String getInnerPlayerOneName = '';
String getInnerPlayerTwoName = '';
String getPlayerOneImage = '';
String getPlayerTwoImage = '';
int getInnerPlayerOneFinalScore = 0;
int getInnerPlayerTwoFinalScore = 0;
List<int> getPlayerOneFinalScores = [];
List<int> getPlayerTwoFinalScores = [];
List<String> getPlayerOneNames = [];
List<String> getPlayerTwoNames = [];
List<String> getGameNames = [];
List<String> getDates = [];
String getInnerDate = '';
String getGameName = '';
List<Map> users = [];
int getNumberOfRounds = 0 ;

// handling saving list into database

String temp1 = '';
String temp2 = '';
List<int> temp1List = [];
List<int> temp2List = [];
List<String> tempString1List = [];
List<String> tempString2List = [];
String tempString = '';


File? player1Image;
File? player2Image;
File? croppedPlayer1Image;
File? croppedPlayer2Image;
String? base64string;


List<int> delList = [];
List<Color> whiteList = [];
List<bool> selectedList = [];
List<int> intSelectedList = [];
bool selectBool = false;



bool enable = false;


List<String> hack = [];
bool check = false;
// List<String> wrong = [];
List<String> gameNameHack = [];


bool isEditState = false ;
var editGameName = GlobalKey<FormState>();
var editGameNameController = TextEditingController(text:getGameName);
bool update_appearance = false;



bool selected = false;


List<int>leftGround = [];
List<int>rightGround = [];
List<int>initially = [];
List<int>aboveSupport = [];
List<int>belowSupport = [];
List<int>myCards = [];
List<int>hisCards = [];
List<bool> mySelectedCards = [];
List<bool> hisSelectedCards = [];

int? theAvailableLeft ;
int? theAvailableRight ;

double? cardWidth ;
double? cardHeight ;
double dotDimensions = cardWidth!/8 ;
double separatorBlackLineHeight = 3 ;
double separatorBigYellowPointDimensions = 2 ;
double separatorSmallBlackPointDimensions = 1 ;
bool scaled = false ;

Map<int,Widget Function()> halfCard = {6:six,5:five,4:four,3:three,2:two,1:one,0:zero};
Map<int,Widget Function()> rotatedHalfCard = {6:rotatedSix,5:rotatedFive,4:rotatedFour,3:rotatedThree,2:rotatedTwo,1:one,0:zero};


Map<int,Widget> cards = {
  27:card(halfCard[6],halfCard[6]),
  26:card(halfCard[5],halfCard[5]),
  25:card(halfCard[4],halfCard[4]),
  24:card(halfCard[3],halfCard[3]),
  23:card(halfCard[2],halfCard[2]),
  22:card(halfCard[1],halfCard[1]),
  21:card(halfCard[0],halfCard[0]),
  20:card(halfCard[6],halfCard[5]),
  19:card(halfCard[6],halfCard[4]),
  18:card(halfCard[6],halfCard[3]),
  17:card(halfCard[6],halfCard[2]),
  16:card(halfCard[6],halfCard[1]),
  15:card(halfCard[6],halfCard[0]),
  14:card(halfCard[5],halfCard[4]),
  13:card(halfCard[5],halfCard[3]),
  12:card(halfCard[5],halfCard[2]),
  11:card(halfCard[5],halfCard[1]),
  10:card(halfCard[5],halfCard[0]),
  9:card(halfCard[4],halfCard[3]),
  8:card(halfCard[4],halfCard[2]),
  7:card(halfCard[4],halfCard[1]),
  6:card(halfCard[4],halfCard[0]),
  5:card(halfCard[3],halfCard[2]),
  4:card(halfCard[3],halfCard[1]),
  3:card(halfCard[3],halfCard[0]),
  2:card(halfCard[2],halfCard[1]),
  1:card(halfCard[2],halfCard[0]),
  0:card(halfCard[1],halfCard[0]),
  55:card(halfCard[6],halfCard[6]),
  54:card(halfCard[5],halfCard[5]),
  53:card(halfCard[4],halfCard[4]),
  52:card(halfCard[3],halfCard[3]),
  51:card(halfCard[2],halfCard[2]),
  50:card(halfCard[1],halfCard[1]),
  49:card(halfCard[0],halfCard[0]),
  48:card(halfCard[5],halfCard[6]),
  47:card(halfCard[4],halfCard[6]),
  46:card(halfCard[3],halfCard[6]),
  45:card(halfCard[2],halfCard[6]),
  44:card(halfCard[1],halfCard[6]),
  43:card(halfCard[0],halfCard[6]),
  42:card(halfCard[4],halfCard[5]),
  41:card(halfCard[3],halfCard[5]),
  40:card(halfCard[2],halfCard[5]),
  39:card(halfCard[1],halfCard[5]),
  38:card(halfCard[0],halfCard[5]),
  37:card(halfCard[3],halfCard[4]),
  36:card(halfCard[2],halfCard[4]),
  35:card(halfCard[1],halfCard[4]),
  34:card(halfCard[0],halfCard[4]),
  33:card(halfCard[2],halfCard[3]),
  32:card(halfCard[1],halfCard[3]),
  31:card(halfCard[0],halfCard[3]),
  30:card(halfCard[1],halfCard[2]),
  29:card(halfCard[0],halfCard[2]),
  28:card(halfCard[0],halfCard[1]),
};
Map<int,Widget> rotatedCards = {
  27:rotatedCard(rotatedHalfCard[6],rotatedHalfCard[6]),
  26:rotatedCard(rotatedHalfCard[5],rotatedHalfCard[5]),
  25:rotatedCard(rotatedHalfCard[4],rotatedHalfCard[4]),
  24:rotatedCard(rotatedHalfCard[3],rotatedHalfCard[3]),
  23:rotatedCard(rotatedHalfCard[2],rotatedHalfCard[2]),
  22:rotatedCard(rotatedHalfCard[1],rotatedHalfCard[1]),
  21:rotatedCard(rotatedHalfCard[0],rotatedHalfCard[0]),
  20:rotatedCard(rotatedHalfCard[6],rotatedHalfCard[5]),
  19:rotatedCard(rotatedHalfCard[6],rotatedHalfCard[4]),
  18:rotatedCard(rotatedHalfCard[6],rotatedHalfCard[3]),
  17:rotatedCard(rotatedHalfCard[6],rotatedHalfCard[2]),
  16:rotatedCard(rotatedHalfCard[6],rotatedHalfCard[1]),
  15:rotatedCard(rotatedHalfCard[6],rotatedHalfCard[0]),
  14:rotatedCard(rotatedHalfCard[5],rotatedHalfCard[4]),
  13:rotatedCard(rotatedHalfCard[5],rotatedHalfCard[3]),
  12:rotatedCard(rotatedHalfCard[5],rotatedHalfCard[2]),
  11:rotatedCard(rotatedHalfCard[5],rotatedHalfCard[1]),
  10:rotatedCard(rotatedHalfCard[5],rotatedHalfCard[0]),
  9:rotatedCard(rotatedHalfCard[4],rotatedHalfCard[3]),
  8:rotatedCard(rotatedHalfCard[4],rotatedHalfCard[2]),
  7:rotatedCard(rotatedHalfCard[4],rotatedHalfCard[1]),
  6:rotatedCard(rotatedHalfCard[4],rotatedHalfCard[0]),
  5:rotatedCard(rotatedHalfCard[3],rotatedHalfCard[2]),
  4:rotatedCard(rotatedHalfCard[3],rotatedHalfCard[1]),
  3:rotatedCard(rotatedHalfCard[3],rotatedHalfCard[0]),
  2:rotatedCard(rotatedHalfCard[2],rotatedHalfCard[1]),
  1:rotatedCard(rotatedHalfCard[2],rotatedHalfCard[0]),
  0:rotatedCard(rotatedHalfCard[1],rotatedHalfCard[0]),
  55:rotatedCard(rotatedHalfCard[6],rotatedHalfCard[6]),
  54:rotatedCard(rotatedHalfCard[5],rotatedHalfCard[5]),
  53:rotatedCard(rotatedHalfCard[4],rotatedHalfCard[4]),
  52:rotatedCard(rotatedHalfCard[3],rotatedHalfCard[3]),
  51:rotatedCard(rotatedHalfCard[2],rotatedHalfCard[2]),
  50:rotatedCard(rotatedHalfCard[1],rotatedHalfCard[1]),
  49:rotatedCard(rotatedHalfCard[0],rotatedHalfCard[0]),
  48:rotatedCard(rotatedHalfCard[5],rotatedHalfCard[6]),
  47:rotatedCard(rotatedHalfCard[4],rotatedHalfCard[6]),
  46:rotatedCard(rotatedHalfCard[3],rotatedHalfCard[6]),
  45:rotatedCard(rotatedHalfCard[2],rotatedHalfCard[6]),
  44:rotatedCard(rotatedHalfCard[1],rotatedHalfCard[6]),
  43:rotatedCard(rotatedHalfCard[0],rotatedHalfCard[6]),
  42:rotatedCard(rotatedHalfCard[4],rotatedHalfCard[5]),
  41:rotatedCard(rotatedHalfCard[3],rotatedHalfCard[5]),
  40:rotatedCard(rotatedHalfCard[2],rotatedHalfCard[5]),
  39:rotatedCard(rotatedHalfCard[1],rotatedHalfCard[5]),
  38:rotatedCard(rotatedHalfCard[0],rotatedHalfCard[5]),
  37:rotatedCard(rotatedHalfCard[3],rotatedHalfCard[4]),
  36:rotatedCard(rotatedHalfCard[2],rotatedHalfCard[4]),
  35:rotatedCard(rotatedHalfCard[1],rotatedHalfCard[4]),
  34:rotatedCard(rotatedHalfCard[0],rotatedHalfCard[4]),
  33:rotatedCard(rotatedHalfCard[2],rotatedHalfCard[3]),
  32:rotatedCard(rotatedHalfCard[1],rotatedHalfCard[3]),
  31:rotatedCard(rotatedHalfCard[0],rotatedHalfCard[3]),
  30:rotatedCard(rotatedHalfCard[1],rotatedHalfCard[2]),
  29:rotatedCard(rotatedHalfCard[0],rotatedHalfCard[2]),
  28:rotatedCard(rotatedHalfCard[0],rotatedHalfCard[1]),
};

Map<Widget,List<int>> cardDetails = {
  cards[27]! : [6,6],
  cards[26]! : [5,5],
  cards[25]! : [4,4],
  cards[24]! : [3,3],
  cards[23]! : [2,2],
  cards[22]! : [1,1],
  cards[21]! : [0,0],
  cards[20]! : [6,5],
  cards[19]! : [6,4],
  cards[18]! : [6,3],
  cards[17]! : [6,2],
  cards[16]! : [6,1],
  cards[15]! : [6,0],
  cards[14]! : [5,4],
  cards[13]! : [5,3],
  cards[12]! : [5,2],
  cards[11]! : [5,1],
  cards[10]! : [5,0],
  cards[9]! : [4,3],
  cards[8]! : [4,2],
  cards[7]! : [4,1],
  cards[6]! : [4,0],
  cards[5]! : [3,2],
  cards[4]! : [3,1],
  cards[3]! : [3,0],
  cards[2]! : [2,1],
  cards[1]! : [2,0],
  cards[0]! : [1,0],
};


int ? selectedCard ;



List<int> forSupport = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27];

bool initial = false;

bool myTurn = true ;

List<int> supportAndMyCards = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27];
List<int> supportAndHisCards = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27];

int ? theHighestPriority ;
int? theHighestPriorityInMyCards;
int? theHighestPriorityInHisCards;
int? tempRandomChoice;


var myPasswordCreationKey = GlobalKey<FormState>();
var myPasswordCreationController = TextEditingController();
var hisPasswordCreationKey = GlobalKey<FormState>();
var hisPasswordCreationController = TextEditingController();

String ? player1password ;
String ? player2password ;

var checkMyPasswordKey = GlobalKey<FormState>();
var checkMyPasswordController = TextEditingController();
var checkHisPasswordKey = GlobalKey<FormState>();
var checkHisPasswordController = TextEditingController();



bool ? IAmPlayingNow ;
bool ? heIsPlayingNow ;

bool holdState = false ;
bool myHoldState = false ;
bool hisHoldState = false ;
bool holdCreate = false ;

bool didNotClosed = true ;

bool gameUp = false ;

int hisPoints = 0 ;
int myPoints = 0 ;


int myPointsWhileClosing = 0 ;
int HisPointsWhileClosing = 0 ;

bool ? IWinWhileClosing ;
