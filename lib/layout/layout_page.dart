import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/cubit/two/two_cubit.dart';
import 'package:project1/cubit/two/two_states.dart';

import '../shared/constants.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});


  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> with TickerProviderStateMixin{
  late final AnimationController animationController;
  late final Animation<Offset> animationTween ;
  late final AnimationController animationController2;
  late final Animation<Offset> animationTween2 ;
  late final AnimationController animationController3;
  late final Animation<Offset> animationTween3 ;
  late final AnimationController animationController4;
  late final Animation<double> animationTween4 ;
  ScrollController k = ScrollController();

  void _scrollListener() {
    if (animationController4.value == 1)
      {
        k.position.animateTo((k.position.maxScrollExtent + k.position.minScrollExtent)/2, duration: Duration(milliseconds: 400), curve: Curves.decelerate);
      }
  }

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1)
    );
    animationTween = Tween<Offset>(begin: Offset(.44,0),end: Offset(0,0)).animate(animationController);
    animationController2 = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400)
    );
    animationTween2 = Tween<Offset>(begin: Offset(0,0),end: Offset(0,.08)).animate(animationController2);
    animationController3 = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400)
    );
    animationTween3 = Tween<Offset>(begin: Offset(0,0),end: Offset(0,-.08)).animate(animationController3);
    animationController4 = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400)
    );
    animationTween4 = Tween<double>(begin:1.0,end: 0.35).animate(animationController4);
    k.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    animationController2.dispose();
    animationController3.dispose();
    animationController4.dispose();
    k.removeListener(_scrollListener);
    k.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer< TwoCubit , TwoStates>(
        listener: (context , state){},
        builder: (context , state ){
          TwoCubit cubit = TwoCubit.get(context);
            if (animationController4.value == 1) {
              k.position.animateTo(
                  (k.position.maxScrollExtent + k.position.minScrollExtent) / 2,
                  duration: Duration(milliseconds: 800),
                  curve: Curves.decelerate);
            }
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.teal,
              leading: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: ()
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
                                            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
                  icon: Icon(Icons.arrow_back,color: WHI,)),
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.black38,
                  statusBarIconBrightness: Brightness.light
              ),
              actions: [
                IAmPlayingNow == true  || heIsPlayingNow == true ?
                SizedBox()
                    :
                MaterialButton(onPressed: ()
                {
                  if (player2password != null )
                  {
                    cubit.hold(context);
                  }
                  else
                  {
                    cubit.holdCr(context);
                  }
                } ,
                  color: Colors.blue,
                  child: Text('resume',style: TextStyle(color: Colors.black,fontSize: 20),),),

                player1password != null && player2password != null ?
                MaterialButton(
                  onPressed: (){
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
                                      Text("Are you sure that you want to restart ?",maxLines: 3,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA) ,),
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
                                            Navigator.pop(context);
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
                                                          content: Wrap(
                                                            children: [
                                                              Text(" who would start the game ?",maxLines: 3,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA) ,),
                                                            ],
                                                          ),
                                                          contentPadding:
                                                          EdgeInsetsDirectional.only(
                                                              start: 20,
                                                              end: 20,
                                                              top: 19,
                                                              bottom: 11),
                                                          actions: [
                                                            Padding(
                                                              padding:
                                                              const EdgeInsetsDirectional
                                                                  .only(end: 10),
                                                              child: MaterialButton(
                                                                  minWidth: 1,
                                                                  padding: EdgeInsets.zero,
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(context);
                                                                    cubit.restartWithOne(context);
                                                                  },
                                                                  child: Text(
                                                                    'Player 1',style: TextStyle(color: Colors.green),)),
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
                                                                    Navigator.pop(context);
                                                                    cubit.restart(context);
                                                                  },
                                                                  child: Text(
                                                                    'Randomly',style: TextStyle(color: Colors.green),)),
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
                                                                    Navigator.pop(context);
                                                                    cubit.restartWithTwo(context);

                                                                  },
                                                                  child: Text(
                                                                    'Player 2',style: TextStyle(color: Colors.green),)),
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
                  } ,
                  color: Colors.green,
                  child: Text('rematch',style: TextStyle(color: Colors.black,fontSize: 20),),
                )
                    :
                MaterialButton(
                  disabledColor: Colors.grey,
                  onPressed: null ,
                  color: Colors.green,
                  child: Text('rematch',style: TextStyle(color: Colors.black,fontSize: 20),),
                ),

                player2password != null ? MaterialButton(
                  
                  color:Colors.purple.shade400,onPressed: (){
                  animationController.value == 0 ?
                  animationController.forward()
                      :
                  animationController.reverse()
                  ;
                },
                  child: Text("support",style: TextStyle(color: Colors.black,fontSize: 20),) ,
                ):  MaterialButton(
                  
                  onPressed: null,disabledColor: Colors.grey,
                  child: Text("support",style: TextStyle(color: Colors.black,fontSize: 20),) ,
                ),
                MaterialButton(color:Colors.amber,onPressed: (){
                  if(animationController4.value == 0)
                  {
                    k.position.animateTo((k.position.maxScrollExtent + k.position.minScrollExtent)/2, duration: Duration(milliseconds: 400), curve: Curves.decelerate);
                    animationController4.forward();
                  }
                  else
                  {
                    animationController4.reverse();
                  }

                },
                  child: Text("Scale",style: TextStyle(color: Colors.black,fontSize: 20),) ,
                )
              ],
            ),
            body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/rrr.jpg"),
                    fit: BoxFit.cover,
                  )
              ),
              child: Stack(
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.black,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: ConditionalBuilder(
                              condition: ((myTurn && player2password != null) && IAmPlayingNow == true && !holdState) || !didNotClosed || gameUp,
                              builder:(context)
                              {
                                return Container(
                                  width: 8*cardWidth!,
                                  color: Colors.black54,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 2,
                                            height: cardHeight!+10,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          SizedBox(
                                            width: (8*cardWidth!)-20,
                                            height: cardHeight!,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child:
                                                  ListView.separated(
                                                      scrollDirection: Axis.horizontal,
                                                      physics: BouncingScrollPhysics(),
                                                      itemBuilder: (context, index) => GestureDetector(
                                                          onTap:
                                                              () {
                                                            if (mySelectedCards[index])
                                                            {
                                                              cubit.unselectMyCard(index);
                                                            }
                                                            else
                                                            {
                                                              cubit.selectingMyCard(index);
                                                              animationController2.repeat(reverse: true);
                                                            }
                                                          },
                                                          child: mySelectedCards[index]
                                                              ?
                                                          SlideTransition(
                                                              position: animationTween2,
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(6),
                                                                  border: Border.all(color: Colors.blue),),
                                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                child: cards[myCards[index]],
                                                              )
                                                          )
                                                              :
                                                          cards[myCards[index]]),
                                                      separatorBuilder: (context, index) => SizedBox(width: 5,),
                                                      itemCount: myCards.length),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                            width: 2,
                                            height: cardHeight!+10,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: cardWidth!*8,
                                        height:2,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                );
                              },
                              fallback: (context)=> Container(
                                width: cardWidth!*8,
                                color: Colors.black54,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 2,
                                          height:cardHeight!+10,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        SizedBox(
                                          width: (8*cardWidth!)-20,
                                          height: cardHeight!,
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: ListView.separated(
                                                      scrollDirection: Axis.horizontal,
                                                      physics: BouncingScrollPhysics(),
                                                      itemBuilder: (context, index) =>
                                                          Container(
                                                            height: cardHeight!,
                                                            width: cardWidth!,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(5),
                                                              color: WHI,
                                                            ),
                                                            clipBehavior:
                                                            Clip.antiAliasWithSaveLayer,
                                                          ),
                                                      separatorBuilder: (context, index) => SizedBox(width: 5,),
                                                      itemCount: myCards.length),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                          width: 2,
                                          height:cardHeight!+10 ,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 8*cardWidth!,
                                      height: 2,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ConditionalBuilder(
                              condition: ((! myTurn && player2password != null) && heIsPlayingNow == true && !holdState) || !didNotClosed || gameUp,
                              builder:(context)
                              {
                                return Container(
                                  width: 8*cardWidth!,
                                  color: Colors.black54,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 8*cardWidth!,
                                        height:2,
                                        color: Colors.white,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 2,
                                            height: cardHeight!+10,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          SizedBox(
                                            width: (cardWidth!*8)-20,
                                            height: cardHeight!,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: ListView.separated(
                                                      scrollDirection: Axis.horizontal,
                                                      physics:
                                                      BouncingScrollPhysics(),
                                                      itemBuilder: (context,
                                                          index) =>
                                                          GestureDetector(
                                                              onTap:
                                                                  () {
                                                                if (hisSelectedCards[index])
                                                                  {
                                                                    cubit.unselectHisCard(index);
                                                                  }

                                                                else
                                                                {
                                                                  cubit.selectHisCard(index);
                                                                  animationController3.repeat(reverse: true);
                                                                }
                                                              },
                                                              child: hisSelectedCards[
                                                              index]
                                                                  ? SlideTransition(
                                                                position: animationTween3,
                                                                child: Container(
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(6),
                                                                    border: Border.all(color: Colors.blue),),
                                                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                  child: cards[hisCards[index]],
                                                                ),
                                                              )
                                                                  : cards[hisCards[
                                                              index]]),
                                                      separatorBuilder:
                                                          (context,
                                                          index) =>
                                                          SizedBox(
                                                            width:
                                                            5,
                                                          ),
                                                      itemCount:
                                                      hisCards
                                                          .length),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                            width: 2,
                                            height: cardHeight!+10,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              fallback: (context)=> Container(
                                width: 8*cardWidth!,
                                color: Colors.black54,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 8*cardWidth!,
                                      height: 2,
                                      color: Colors.white,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 2,
                                          height:cardHeight!+10,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        SizedBox(
                                          width: (8*cardWidth!)-20,
                                          height: cardHeight!,
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: ListView.separated(
                                                      scrollDirection: Axis.horizontal,
                                                      physics: BouncingScrollPhysics(),
                                                      itemBuilder: (context, index) =>
                                                          Container(
                                                            width: cardWidth!,
                                                            height: cardHeight!,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(5),
                                                              color: WHI,
                                                            ),
                                                            clipBehavior:
                                                            Clip.antiAliasWithSaveLayer,
                                                          ),
                                                      separatorBuilder: (context, index) => SizedBox(width: 5,),
                                                      itemCount: hisCards.length),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                          width: 2,
                                          height: cardHeight!+10,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child:  SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          SlideTransition(
                            position: animationTween,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                  height: (cardHeight!*2)+(cardHeight!/7.8),
                                  width: (7*cardWidth!)+49,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 2 ,color: Colors.white),
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.black54
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          width: (cardWidth!*7)+30,
                                          height: cardHeight!,
                                          child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context,index)=> Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onDoubleTap: (){
                                                      if ( !myTurn)
                                                      {
                                                        cubit.supportHimFromAbove(aboveSupport[index]);
                                                      }
                                                      else
                                                      {
                                                        cubit.supportMeFromAbove(aboveSupport[index]);
                                                      }
                                                    },
                                                    child: Container(
                                                      height: cardHeight!,
                                                      width: cardWidth!,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        color: WHI,
                                                      ),
                                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              separatorBuilder: (context,index)=>SizedBox(width: 5),
                                              itemCount: aboveSupport.length
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          width: (cardWidth!*7)+30,
                                          height: cardHeight!,
                                          child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context,index)=> Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onDoubleTap: (){
                                                      if ( !myTurn)
                                                      {
                                                        cubit.supportHimFromBelow(belowSupport[index]);
                                                      }
                                                      else
                                                      {
                                                        cubit.supportMeFromBelow(belowSupport[index]);
                                                      }
                                                    },
                                                    child: Container(
                                                      height: cardHeight!,
                                                      width: cardWidth!,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        color: WHI,
                                                      ),
                                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              separatorBuilder: (context,index)=>SizedBox(width:5),
                                              itemCount: belowSupport.length
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: cardHeight,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: cardHeight,
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: SingleChildScrollView(
                                            controller: k,
                                            physics: BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            child: ScaleTransition(
                                              scale: animationTween4,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        if(initial)
                                                          if (selected == true)
                                                            Row(
                                                              children: [
                                                                SizedBox(width: 1,),
                                                                if (theAvailableLeft == cardDetails[cards[selectedCard]]![0] || theAvailableLeft == cardDetails[cards[selectedCard]]![1] )
                                                                  cubit.symmetricalityCheck(selectedCard) ?
                                                                  GestureDetector(
                                                                    onTap: (){
                                                                      if ( !myTurn)
                                                                      {
                                                                        cubit.himPlayingLeft(selectedCard,context);
                                                                      }
                                                                      else
                                                                      {
                                                                        cubit.mePlayingLeft(selectedCard,context);
                                                                      }
                                                                    },
                                                                    child: Container(
                                                                      width: cardWidth!,
                                                                      height: cardHeight!,
                                                                      decoration: BoxDecoration(
                                                                        border: animationController4.value == 0 ? Border.all(color: Colors.blue,width : 1) : Border.all(color: Colors.blue,width : 3),
                                                                      ),
                                                                    ),
                                                                  )
                                                                      :
                                                                  GestureDetector(
                                                                    onTap: (){
                                                                      if ( !myTurn)
                                                                      {
                                                                        cubit.himPlayingLeft(selectedCard,context);
                                                                      }
                                                                      else
                                                                      {
                                                                        cubit.mePlayingLeft(selectedCard,context);
                                                                      }
                                                                    },
                                                                    child: Container(
                                                                      width: cardHeight!,
                                                                      height: cardWidth!,
                                                                      decoration: BoxDecoration(
                                                                        border: animationController4.value == 0 ? Border.all(color: Colors.blue,width : 1) : Border.all(color: Colors.blue,width : 3),
                                                                      ),
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                        SizedBox(width: 2,),
                                                        ListView.separated(
                                                          scrollDirection: Axis.horizontal,
                                                          physics: BouncingScrollPhysics(),
                                                          shrinkWrap: true,
                                                          reverse: true,
                                                          itemBuilder: (context,index) => cubit.symmetricalityCheck2(leftGround[index]) ?
                                                          Center(child: cards[leftGround[index]])
                                                              :
                                                          Center(child: rotatedCards[leftGround[index]]),
                                                          separatorBuilder: (context,index) => SizedBox(width: 2,),
                                                          itemCount: leftGround.length,
                                                        ),
                                                        SizedBox(width: 2,),
                                                        if(!initial)
                                                          selectedCard != null ?
                                                          Row(
                                                            children: [
                                                              cubit.symmetricalityCheck(selectedCard) ?
                                                              GestureDetector(
                                                                onTap: (){
                                                                  if (!myTurn){
                                                                    cubit.hisBeginning(selectedCard,context);
                                                                  }
                                                                  else
                                                                  {
                                                                    cubit.myBeginning(selectedCard,context);
                                                                  }
                                                                },
                                                                child: Container(
                                                                  width: cardWidth!,
                                                                  height: cardHeight!,
                                                                  decoration: BoxDecoration(
                                                                    border: animationController4.value == 0 ? Border.all(color: Colors.blue,width : 1) : Border.all(color: Colors.blue,width : 3),
                                                                  ),
                                                                ),
                                                              )
                                                                  :
                                                              GestureDetector(
                                                                onTap: (){
                                                                  if ( !myTurn)
                                                                  {
                                                                    cubit.hisBeginning(selectedCard,context);
                                                                  }
                                                                  else
                                                                  {
                                                                    cubit.myBeginning(selectedCard,context);
                                                                  }
                                                                },
                                                                child: Container(
                                                                  width: cardHeight!,
                                                                  height:  cardWidth!,
                                                                  decoration: BoxDecoration(
                                                                    border: animationController4.value == 0 ? Border.all(color: Colors.blue,width : 1) : Border.all(color: Colors.blue,width : 3),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                              :
                                                          SizedBox(),
                                                        if (initially.isNotEmpty)
                                                          Container(
                                                            child: cubit.symmetricalityCheck(initially[0]) ?
                                                            Center(child: cards[initially[0]])
                                                                :
                                                            Center(child: rotatedCards[initially[0]]),
                                                          ),
                                                        SizedBox(width: 2,),
                                                        ListView.separated(
                                                          scrollDirection: Axis.horizontal,
                                                          physics: BouncingScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemBuilder: (context,index) => cubit.symmetricalityCheck2(rightGround[index]) ?
                                                          Center(child: cards[rightGround[index]])
                                                              :
                                                          Center(child: rotatedCards[rightGround[index]]),
                                                          separatorBuilder: (context,index) => SizedBox(width: 2,),
                                                          itemCount: rightGround.length,
                                                        ),
                                                        SizedBox(width: 2,),
                                                        if(initial)
                                                          if (selected == true)
                                                            Row(
                                                              children: [
                                                                if (theAvailableRight == cardDetails[cards[selectedCard]]![0] || theAvailableRight == cardDetails[cards[selectedCard]]![1] )
                                                                  cubit.symmetricalityCheck(selectedCard) ?
                                                                  GestureDetector(
                                                                    onTap: (){
                                                                      if ( !myTurn)
                                                                      {
                                                                        cubit.himPlayingRight(selectedCard,context);
                                                                      }
                                                                      else
                                                                      {
                                                                        cubit.mePlayingRight(selectedCard,context);
                                                                      }
                                                                    },
                                                                    child: Container(
                                                                      width: cardWidth!,
                                                                      height: cardHeight!,
                                                                      decoration: BoxDecoration(
                                                                        border: animationController4.value == 0 ? Border.all(color: Colors.blue,width : 1) : Border.all(color: Colors.blue,width : 3),
                                                                      ),
                                                                    ),
                                                                  )
                                                                      :
                                                                  GestureDetector(
                                                                    onTap: (){
                                                                      if ( !myTurn)
                                                                      {
                                                                        cubit.himPlayingRight(selectedCard,context);
                                                                      }
                                                                      else
                                                                      {
                                                                        cubit.mePlayingRight(selectedCard,context);
                                                                      }
                                                                    },
                                                                    child: Container(
                                                                      width: cardHeight!,
                                                                      height: cardWidth!,
                                                                      decoration: BoxDecoration(
                                                                        border: animationController4.value == 0 ? Border.all(color: Colors.blue,width : 1) : Border.all(color: Colors.blue,width : 3),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                SizedBox(width: 1,)
                                                              ],
                                                            ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: cardHeight!+10,)
                        ],
                      ),
                    )
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}


Widget rotatedCard(upperWidget, lowerWidget) {
  return Container(
    height: cardWidth!,
    width: cardHeight!,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: WHI,
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Row(
      children: [
        upperWidget(),
        rotatedSeparator(),
        lowerWidget(),
      ],
    ),
  );
}

Widget card(upperWidget, lowerWidget) {
  return Container(
    height: cardHeight!,
    width: cardWidth!,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: WHI,
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Column(
      children: [
        upperWidget(),
        separator(),
        lowerWidget(),
      ],
    ),
  );
}

Widget dot() {
  return Container(
    width: dotDimensions,
    height: dotDimensions,
    decoration: BoxDecoration(shape: BoxShape.circle, color: BLA),
    clipBehavior: Clip.antiAliasWithSaveLayer,
  );
}

Widget separator() {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        height: separatorBlackLineHeight,
        color: BLA,
      ),
      Container(
        width: separatorBigYellowPointDimensions,
        height: separatorBigYellowPointDimensions,
        decoration: BoxDecoration(shape: BoxShape.circle, color: GOLD),
      ),
      Container(
        width: separatorSmallBlackPointDimensions,
        height: separatorSmallBlackPointDimensions,
        decoration: BoxDecoration(shape: BoxShape.circle, color: WHI),
      ),
    ],
  );
}

Widget rotatedSeparator() {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        height: cardWidth!,
        width: separatorBlackLineHeight,
        color: Colors.black,
      ),
      Container(
        width: separatorBigYellowPointDimensions,
        height: separatorBigYellowPointDimensions,
        decoration: BoxDecoration(shape: BoxShape.circle, color: GOLD),
      ),
      Container(
        width: separatorSmallBlackPointDimensions,
        height: separatorSmallBlackPointDimensions,
        decoration: BoxDecoration(shape: BoxShape.circle, color: WHI),
      ),
    ],
  );
}

Widget rotatedSix() {
  return Expanded(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsetsDirectional.only(top: (cardHeight!/7.8), bottom: (cardHeight!/7.8)),
              child: Column(
                children: [
                  dot(),
                  Spacer(),
                  dot(),
                ],
              ),
            ),
            SizedBox(
              width: 5.5,
            ),
            Padding(
              padding:  EdgeInsetsDirectional.only(top: (cardHeight!/7.8), bottom: (cardHeight!/7.8)),
              child: Column(
                children: [
                  dot(),
                  Spacer(),
                  dot(),
                ],
              ),
            ),
            SizedBox(
              width: 5.5,
            ),
            Padding(
              padding:  EdgeInsetsDirectional.only(top: (cardHeight!/7.8), bottom: (cardHeight!/7.8)),
              child: Column(
                children: [
                  dot(),
                  Spacer(),
                  dot(),
                ],
              ),
            ),
          ],
        ),
      ));
}

Widget six() {
  return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsetsDirectional.only(start: (cardHeight!/7.8), end: (cardHeight!/7.8)),
              child: Row(
                children: [
                  dot(),
                  Spacer(),
                  dot(),
                ],
              ),
            ),
            SizedBox(
              height: 5.5,
            ),
            Padding(
              padding:  EdgeInsetsDirectional.only(start: (cardHeight!/7.8), end: (cardHeight!/7.8)),
              child: Row(
                children: [
                  dot(),
                  Spacer(),
                  dot(),
                ],
              ),
            ),
            SizedBox(
              height: 5.5,
            ),
            Padding(
              padding:  EdgeInsetsDirectional.only(start: (cardHeight!/7.8), end: (cardHeight!/7.8)),
              child: Row(
                children: [
                  dot(),
                  Spacer(),
                  dot(),
                ],
              ),
            ),
          ],
        ),
      ));
}

Widget rotatedFive() {
  return Expanded(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsetsDirectional.only(top: (cardHeight!/7.8), bottom: (cardHeight!/7.8)),
              child: Column(
                children: [
                  dot(),
                  Spacer(),
                  dot(),
                ],
              ),
            ),
            SizedBox(
              width: 5.5,
            ),
            Padding(
              padding:  EdgeInsetsDirectional.only(top: (cardHeight!/7.8), bottom: (cardHeight!/7.8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  dot(),
                ],
              ),
            ),
            SizedBox(
              width: 5.5,
            ),
            Padding(
              padding:  EdgeInsetsDirectional.only(top: (cardHeight!/7.8), bottom: (cardHeight!/7.8)),
              child: Column(
                children: [
                  dot(),
                  Spacer(),
                  dot(),
                ],
              ),
            ),
          ],
        ),
      ));
}

Widget five() {
  return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsetsDirectional.only(start: (cardHeight!/7.8), end: (cardHeight!/7.8)),
              child: Row(
                children: [
                  dot(),
                  Spacer(),
                  dot(),
                ],
              ),
            ),
            SizedBox(
              height: 5.5,
            ),
            Padding(
              padding:  EdgeInsetsDirectional.only(start: (cardHeight!/7.8), end: (cardHeight!/7.8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  dot(),
                ],
              ),
            ),
            SizedBox(
              height: 5.5,
            ),
            Padding(
              padding:  EdgeInsetsDirectional.only(start: (cardHeight!/7.8), end: (cardHeight!/7.8)),
              child: Row(
                children: [
                  dot(),
                  Spacer(),
                  dot(),
                ],
              ),
            ),
          ],
        ),
      ));
}

Widget rotatedFour() {
  return Expanded(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsetsDirectional.only(top: (cardHeight!/7.8), bottom: (cardHeight!/7.8)),
              child: Column(
                children: [
                  dot(),
                  Spacer(),
                  dot(),
                ],
              ),
            ),
            SizedBox(
              width: 15.5,
            ),
            Padding(
              padding:  EdgeInsetsDirectional.only(top: (cardHeight!/7.8), bottom: (cardHeight!/7.8)),
              child: Column(
                children: [
                  dot(),
                  Spacer(),
                  dot(),
                ],
              ),
            ),
          ],
        ),
      ));
}

Widget four() {
  return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsetsDirectional.only(start: (cardHeight!/7.8), end: (cardHeight!/7.8)),
              child: Row(
                children: [
                  dot(),
                  Spacer(),
                  dot(),
                ],
              ),
            ),
            SizedBox(
              height: 15.5,
            ),
            Padding(
              padding:  EdgeInsetsDirectional.only(start: (cardHeight!/7.8), end: (cardHeight!/7.8)),
              child: Row(
                children: [
                  dot(),
                  Spacer(),
                  dot(),
                ],
              ),
            ),
          ],
        ),
      ));
}

Widget rotatedThree() {
  return Expanded(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsetsDirectional.only(top: (cardHeight!/7.8), bottom: (cardHeight!/7.8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  dot(),
                ],
              ),
            ),
            SizedBox(
              width: 5.5,
            ),
            Padding(
              padding:  EdgeInsetsDirectional.only(top: (cardHeight!/7.8), bottom: (cardHeight!/7.8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  dot(),
                ],
              ),
            ),
            SizedBox(
              width: 5.5,
            ),
            Padding(
              padding:  EdgeInsetsDirectional.only(top: (cardHeight!/7.8), bottom: (cardHeight!/7.8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  dot(),
                ],
              ),
            ),
          ],
        ),
      ));
}

Widget three() {
  return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsetsDirectional.only(start: (cardHeight!/7.8), end: (cardHeight!/7.8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  dot(),
                ],
              ),
            ),
            SizedBox(
              height: 5.5,
            ),
            Padding(
              padding:  EdgeInsetsDirectional.only(start: (cardHeight!/7.8), end: (cardHeight!/7.8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  dot(),
                ],
              ),
            ),
            SizedBox(
              height: 5.5,
            ),
            Padding(
              padding:  EdgeInsetsDirectional.only(start: (cardHeight!/7.8), end: (cardHeight!/7.8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  dot(),
                ],
              ),
            ),
          ],
        ),
      ));
}

Widget rotatedTwo() {
  return Expanded(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsetsDirectional.only(top: (cardHeight!/7.8), bottom: (cardHeight!/7.8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  dot(),
                ],
              ),
            ),
            SizedBox(
              width: 15.5,
            ),
            Padding(
              padding:  EdgeInsetsDirectional.only(top: (cardHeight!/7.8), bottom: (cardHeight!/7.8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  dot(),
                ],
              ),
            ),
          ],
        ),
      ));
}

Widget two() {
  return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsetsDirectional.only(start: (cardHeight!/7.8), end: (cardHeight!/7.8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  dot(),
                ],
              ),
            ),
            SizedBox(
              height: 15.5,
            ),
            Padding(
              padding:  EdgeInsetsDirectional.only(start: (cardHeight!/7.8), end: (cardHeight!/7.8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  dot(),
                ],
              ),
            ),
          ],
        ),
      ));
}

Widget one() {
  return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            dot()
          ],
        ),
      ));
}

Widget zero() {
  return Expanded(child: Container());
}

