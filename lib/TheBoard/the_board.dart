import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:project1/cubit/two/two_cubit.dart';
import 'package:project1/cubit/two/two_states.dart';
import 'package:project1/layout/layout_page.dart';
import 'package:pip_view/pip_view.dart';

import '../shared/constants.dart';

class TheBoard extends StatelessWidget {
  const TheBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<TwoCubit, TwoStates>(
          listener: (context, state) {},
          builder: (context, state) {
            TwoCubit cubit = TwoCubit.get(context);
            return WillPopScope(
              onWillPop: ()async
              {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => StatefulBuilder(
                      builder: (context, setState) =>
                          WillPopScope(
                            onWillPop: ()async
                            {
                              Navigator.pop(context);
                              return false;
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
                                  Text("Are you sure that you want to leave the game ?",maxLines: 3,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA) ,),
                                ],
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
                                    Navigator.pop(context); // Close the dialog
                                  },
                                  child: Text('cancel',style: TextStyle(color: Colors.green),),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsetsDirectional
                                      .only(end: 10),
                                  child: MaterialButton(
                                            minWidth: 1,
                                            padding: EdgeInsets.zero,
                                            onPressed:
                                                () {
                                              //////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                  cubit.remove();
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'yes',style: TextStyle(color: Colors.green),)),
                                ),
                              ],
                              actionsPadding:
                              EdgeInsetsDirectional.only(
                                  bottom: 8,
                                  end: 8
                              ),
                            ),
                          ),
                    ));
                return false ;
              },
              child: PIPView(
                builder: (context , isFloating)
                {
                  return WillPopScope(
                    onWillPop: () async {
                      Navigator.pop(context);
                      return false; // Prevent default back button behavior
                    },
                    child: Scaffold(
                      resizeToAvoidBottomInset : false,
                      appBar: AppBar(
                        systemOverlayStyle: SystemUiOverlayStyle(
                            statusBarColor: Colors.black26,
                            statusBarIconBrightness: Brightness.light
                        ),
                        backgroundColor: Burgundy,
                        elevation: 0,
                        centerTitle: true,
                        title: Text(
                          'Board',maxLines: 1,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: WHI,fontSize: 20),
                        ),
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                      builder: (context, setState) =>
                                          WillPopScope(
                                            onWillPop: ()async
                                            {
                                              Navigator.pop(context);
                                              return false;
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
                                                  Text("Are you sure that you want to leave the game ?",maxLines: 3,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA) ,),
                                                ],
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
                                                    Navigator.pop(context); // Close the dialog
                                                  },
                                                  child: Text('cancel',style: TextStyle(color: Colors.green),),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional
                                                      .only(end: 10),
                                                  child: MaterialButton(
                                                      minWidth: 1,
                                                      padding: EdgeInsets.zero,
                                                      onPressed:
                                                          () {
                                                        //////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                        cubit.remove();
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'yes',style: TextStyle(color: Colors.green),)),
                                                ),
                                              ],
                                              actionsPadding:
                                              EdgeInsetsDirectional.only(
                                                  bottom: 8,
                                                  end: 8
                                              ),
                                            ),
                                          ),
                                    ));
                              },
                              tooltip: 'Back',
                              icon: Icon(Icons.arrow_back,color: WHI,)),),
                        actions: [
                          TextButton(
                              onPressed: () {
                                if( playerOneController.text != '' && playerOneController.text.trim() != '')
                                {
                                  if ( playerTwoController.text != '' && playerTwoController.text.trim() != '' )
                                  {
                                    if (cubit.checkText(playerOneController.text,hack) == false)
                                    {
                                      if (cubit.checkText(playerTwoController.text,hack) == false )
                                      {
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
                                                        saveController.text = '';
                                                        save_appearance = false;
                                                        Navigator.pop(context);
                                                        return false;
                                                      },
                                                      child: AlertDialog(
                                                        shape: BeveledRectangleBorder(),
                                                        backgroundColor: WHI,
                                                        title: Text(
                                                          'Please, name the game',
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
                                                                  key: saveKey,
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
                                                                      cubit
                                                                          .saveAppearance();
                                                                      setState(() {});
                                                                    },
                                                                    validator: (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        return;
                                                                      }
                                                                      return null;
                                                                    },
                                                                    controller:
                                                                    saveController,
                                                                    decoration:
                                                                    InputDecoration(
                                                                      focusedBorder:
                                                                      OutlineInputBorder(),
                                                                      enabledBorder:
                                                                      OutlineInputBorder(),
                                                                      hintText:
                                                                      'game name',
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
                                                              Navigator.pop(
                                                                  context); // Close the dialog
                                                              saveController.text = '';
                                                              save_appearance = false;
                                                            },
                                                            child: Text('cancel',style: TextStyle(color: Colors.green),),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsetsDirectional
                                                                .only(end: 10),
                                                            child: ConditionalBuilder(
                                                              condition: save_appearance,
                                                              builder:
                                                                  (context) =>
                                                                  MaterialButton(
                                                                      minWidth: 1,
                                                                      padding: EdgeInsets.zero,
                                                                      onPressed: () {
                                                                        for (int o = 0; o < player1.length; o++) {
                                                                          temp1List.add(player1[o]);
                                                                          temp2List.add(player2[o]);
                                                                        }
                                                                        temp1 = temp1List.toString();
                                                                        temp2 = temp2List.toString();
                                                                        temp1 = temp1.replaceAll(']','');
                                                                        temp2 = temp2.replaceAll(']','');
                                                                        temp1 = temp1.replaceAll('[','');
                                                                        temp2 = temp2.replaceAll('[','');
                                                                        temp1 = temp1.replaceAll(' ','');
                                                                        temp2 = temp2.replaceAll(' ','');
                                                                        cubit.insertToDatabase();
                                                                        Navigator.pop(context); // Close the dialog
                                                                      },
                                                                      child: Text('save',style: TextStyle(color: Colors.green),)),
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
                                                      saveController.text = '';
                                                      save_appearance = false;
                                                      Navigator.pop(context);
                                                      return false;
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
                                                      content: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Text("Player 2:",maxLines: 3,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA) ,),
                                                          Row(
                                                            children: [
                                                              Text("[ ",maxLines: 3,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA) ,),
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: [
                                                                    Text(
                                                                      '${playerTwoController.text} ',maxLines: 1,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                                        color: BLA),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(flex: 3,child: Text("] can't be used,",maxLines: 3,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA) ,)),
                                                            ],
                                                          ),
                                                          Text("Verify that you entered correct name",maxLines: 3,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA) ,),
                                                        ],
                                                      ),
                                                      contentPadding:
                                                      EdgeInsetsDirectional.only(
                                                          start: 20,
                                                          end: 20,
                                                          top: 19,
                                                          bottom: 11),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context); // Close the dialog
                                                          },
                                                          child: Text('OK',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                              color: GRE,
                                                              fontSize: 15
                                                          ),),
                                                        ),
                                                      ],
                                                      actionsPadding:
                                                      EdgeInsetsDirectional.only(
                                                          bottom: 8,
                                                          end: 8
                                                      ),
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
                                            builder: (context, setState) =>
                                                WillPopScope(
                                                  onWillPop: ()async
                                                  {
                                                    saveController.text = '';
                                                    save_appearance = false;
                                                    Navigator.pop(context);
                                                    return false;
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
                                                    content: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text("Player 1:",maxLines: 3,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA) ,),
                                                        Row(
                                                          children: [
                                                            Text("[ ",maxLines: 3,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA) ,),
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    '${playerOneController.text} ',maxLines: 1,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                                      color: BLA),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(flex: 3,child: Text("] can't be used,",maxLines: 3,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA) ,)),
                                                          ],
                                                        ),
                                                        Text("Verify that you entered correct name",maxLines: 3,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA) ,),
                                                      ],
                                                    ),
                                                    contentPadding:
                                                    EdgeInsetsDirectional.only(
                                                        start: 20,
                                                        end: 20,
                                                        top: 19,
                                                        bottom: 11),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context); // Close the dialog
                                                        },
                                                        child: Text('OK',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                            color: GRE,
                                                            fontSize: 15
                                                        ),),
                                                      ),
                                                    ],
                                                    actionsPadding:
                                                    EdgeInsetsDirectional.only(
                                                        bottom: 8,
                                                        end: 8
                                                    ),
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
                                          builder: (context, setState) =>
                                              WillPopScope(
                                                onWillPop: ()async
                                                {
                                                  saveController.text = '';
                                                  save_appearance = false;
                                                  Navigator.pop(context);
                                                  return false;
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
                                                      Text("can't save because player 2 is empty",maxLines: 3,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA) ,),
                                                    ],
                                                  ),
                                                  contentPadding:
                                                  EdgeInsetsDirectional.only(
                                                      start: 20,
                                                      end: 20,
                                                      top: 19,
                                                      bottom: 11),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context); // Close the dialog
                                                      },
                                                      child: Text('OK',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                          color: GRE,
                                                          fontSize: 15
                                                      ),),
                                                    ),
                                                  ],
                                                  actionsPadding:
                                                  EdgeInsetsDirectional.only(
                                                      bottom: 8,
                                                      end: 8
                                                  ),
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
                                        builder: (context, setState) =>
                                            WillPopScope(
                                              onWillPop: ()async
                                              {
                                                saveController.text = '';
                                                save_appearance = false;
                                                Navigator.pop(context);
                                                return false;
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
                                                    Text("can't save because player 1 is empty",maxLines: 3,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA) ,),
                                                  ],
                                                ),
                                                contentPadding:
                                                EdgeInsetsDirectional.only(
                                                    start: 20,
                                                    end: 20,
                                                    top: 19,
                                                    bottom: 11),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context); // Close the dialog
                                                    },
                                                    child: Text('OK',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                        color: GRE,
                                                        fontSize: 15
                                                    ),),
                                                  ),
                                                ],
                                                actionsPadding:
                                                EdgeInsetsDirectional.only(
                                                    bottom: 8,
                                                    end: 8
                                                ),
                                              ),
                                            ),
                                      ));
                                }
                              },
                              child: Text(
                                'save',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                  color: WHI,
                                ),
                              ))
                        ],
                      ),
                      body: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5 ,
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 2,
                                                color: BLA,
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.only(
                                                    start: 5,
                                                    end: 5
                                                ),
                                                child: Container(
                                                  child: Form(
                                                      key: playerOneKey,
                                                      onChanged: () {},
                                                      child: TextFormField(
                                                        enableInteractiveSelection: false,
                                                        textAlign: TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(color: BLA),
                                                        cursorColor: GREY,
                                                        onChanged: (value) {
                                                          //cubit.postCommentTextUpdateEnable();
                                                        },
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return;
                                                          }
                                                          return null;
                                                        },
                                                        controller: playerOneController,
                                                        decoration: InputDecoration(
                                                          focusedBorder:
                                                          UnderlineInputBorder(
                                                              borderSide:
                                                              BorderSide.none),
                                                          enabledBorder:
                                                          UnderlineInputBorder(
                                                              borderSide:
                                                              BorderSide.none),
                                                          hintText: 'Player 1',
                                                          hintStyle: Theme.of(context)
                                                              .textTheme
                                                              .bodyLarge!
                                                              .copyWith(color: GREY),
                                                        ),
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              color: BLA,
                                              width: 2,
                                              height: double.infinity,
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 2,
                                                color: BLA,
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.only(
                                                    start: 5,
                                                    end: 5
                                                ),
                                                child: Container(
                                                  child: Form(
                                                      key: playerTwoKey,
                                                      child: TextFormField(
                                                        enableInteractiveSelection: false,
                                                        textAlign: TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(color: BLA),
                                                        cursorColor: GREY,
                                                        onChanged: (value) {
                                                          //cubit.postCommentTextUpdateEnable();
                                                        },
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return;
                                                          }
                                                          return null;
                                                        },
                                                        controller: playerTwoController,
                                                        decoration: InputDecoration(
                                                          focusedBorder:
                                                          UnderlineInputBorder(
                                                              borderSide:
                                                              BorderSide.none),
                                                          enabledBorder:
                                                          UnderlineInputBorder(
                                                              borderSide:
                                                              BorderSide.none),
                                                          hintText: 'Player 2',
                                                          hintStyle: Theme.of(context)
                                                              .textTheme
                                                              .bodyLarge!
                                                              .copyWith(color: GREY),
                                                        ),
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 2,
                                    color: BLA,
                                  ),
                                  SizedBox(
                                    height: 9,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 2,
                                    color: BLA,
                                  ),
                                  SizedBox(
                                    height: 43,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsetsDirectional.only(
                                                    start: 5,
                                                    end: 5
                                                ),
                                                child: Text(
                                                  player1.isEmpty ? "0":'${player1.reduce((value, element) => value + element)}',
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              color: BLA,
                                              width: 2,
                                              height: double.infinity,
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsetsDirectional.only(
                                                    start: 5,
                                                    end: 5
                                                ),
                                                child: Text(
                                                  player2.isEmpty ? "0" : '${player2.reduce((value, element) => value + element)}',
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(color: BLA),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 2,
                                    color: BLA,
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    "ROUNDS",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: BLA),
                                  ),
                                  if ( roundsNum == 0 )
                                    Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 2,
                                          color: BLA,
                                        ),
                                        SizedBox(
                                          height: 48,
                                          child: Row(

                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .only(start: 5,end: 5),
                                                      child: Container(
                                                        child: Center(
                                                          child: Text("0",style: TextStyle(color: Colors.black),),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    color: Burgundy,
                                                    width: 48,
                                                    height: double.infinity,
                                                    child: Center(
                                                      child: Text(
                                                        "${roundsNum + 1}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                            color: WHI),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .only(start: 5,end: 5),
                                                      child: Container(
                                                        child: Center(
                                                          child: Text("0",style: TextStyle(color: Colors.black),),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 2,
                                          color: BLA,
                                        )
                                      ],
                                    ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  ListView.separated(
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) => index == 0
                                          ? Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 2,
                                            color: BLA,
                                          ),
                                          SizedBox(
                                            height: 48,
                                            child: Row(

                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsetsDirectional
                                                            .only(start: 5,end: 5),
                                                        child: Container(
                                                          child: Center(
                                                            child: Text("${player1[index]}",style: TextStyle(color: Colors.black),),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      color: Burgundy,
                                                      width: 48,
                                                      height: double.infinity,
                                                      child: Center(
                                                        child: Text(
                                                          "${index + 1}",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyLarge!
                                                              .copyWith(
                                                              color: WHI),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsetsDirectional
                                                            .only(start: 5,end: 5),
                                                        child: Container(
                                                          child: Center(
                                                            child: Text("${player2[index]}",style: TextStyle(color: Colors.black),),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 2,
                                            color: BLA,
                                          )
                                        ],
                                      )
                                          : Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 2,
                                            color: BLA,
                                          ),
                                          Slidable(
                                            endActionPane: ActionPane(
                                              motion: const StretchMotion(),
                                              children: [
                                                SlidableAction(
                                                    backgroundColor: a7mr,
                                                    icon: Icons.delete,
                                                    label: "Delete",
                                                    onPressed: (context) {
                                                      cubit.delete(
                                                          index, context);
                                                    }),
                                              ],
                                            ),
                                            key: ValueKey(keys1[index].toString()),
                                            child: SizedBox(
                                              height: 48,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsetsDirectional
                                                              .only(start: 5,end: 5),
                                                          child: Container(
                                                              child:Center(
                                                                child: Text("${player1[index]}",style: TextStyle(color: Colors.black),),
                                                              )
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        color: Burgundy,
                                                        width: 48,
                                                        height: double.infinity,
                                                        child: Center(
                                                          child: Text(
                                                            "${index + 1}",
                                                            style:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyLarge!
                                                                .copyWith(
                                                                color:
                                                                WHI),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsetsDirectional
                                                              .only(start: 5,end: 5),
                                                          child: Container(
                                                              child: Center(
                                                                child: Text("${player2[index]}",style: TextStyle(color: Colors.black),),
                                                              )
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 2,
                                            color: BLA,
                                          )
                                        ],
                                      ),
                                      separatorBuilder: (context, index) => SizedBox(
                                        height: 4,
                                      ),
                                      itemCount: roundsNum),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: WHI,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(90)),
                                    height: 36,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: MaterialButton(
                                      color: Burgundy,
                                      onPressed: () {
                                        PIPView.of(context)!.presentBelow(LayoutPage());
                                        if (player1password == null) {
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
                                                        return false;
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
                                                                      cubit.checkingThatPlayer1PasswordIsNotEmpty();
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
                                                                        player1password = myPasswordCreationController.text;
                                                                        Navigator.pop(context);
                                                                        myPasswordCreationController.text = '';
                                                                        creatingPlayer1PasswordAppearance = false;
                                                                        holdCreate = false ;
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
                                                                                      return false;
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
                                                                                                    cubit.checkingThatPlayer2PasswordIsNotEmpty();
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
                                                                                                      cubit.restart(context);
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
                                      },
                                      child: Text(
                                        'TO THE GAME',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(color: WHI),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                floatingHeight: 100,
                floatingWidth: 200,
                initialCorner: PIPViewCorner.bottomLeft,
              ),
            );
          });
    });
  }
}
