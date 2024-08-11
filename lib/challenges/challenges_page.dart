import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/InnerScore/inner_score.dart';
import 'package:project1/cubit/two/two_cubit.dart';
import 'package:project1/cubit/two/two_states.dart';

import '../shared/constants.dart';
class ChallengesPage extends StatelessWidget {
  const ChallengesPage({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TwoCubit,TwoStates>(
      listener: (context,state){} ,
      builder: (context,state){
        TwoCubit cubit = TwoCubit.get(context);
        return WillPopScope(
          onWillPop: selectBool ?
              ()async{
            cubit.cancelSelection();
            return false;
          }
          :
              ()async{
            Navigator.pop(context);
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
                backgroundColor: Burgundy,
                elevation: 0,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.black26,
                    statusBarIconBrightness: Brightness.light
                ),
                leading: selectBool ?
              MaterialButton(
                  onPressed: (){
                    cubit.cancelSelection();
                  },
                  child: Icon(Icons.keyboard_return_rounded,color: Colors.white,)
              )
                :
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: ()
                {
                  Navigator.pop(context);
                },
                tooltip: 'Back',
                icon: Icon(Icons.arrow_back,color: WHI,)),
              centerTitle: true,
              title: Text(
                'Challenges',maxLines: 1,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: WHI,fontSize: 20),
              ),
              actions: selectBool ?
              [
                MaterialButton(
                  disabledTextColor: GREY,
                    minWidth: 1,
                    onPressed:intSelectedList.isEmpty ?
                    null
                        :
                    ()
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
                                    content: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("Are you sure that you want to delete selected item(s) ?",maxLines: 3,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA) ,),
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
                                          Navigator.pop(context); // Close the dialog
                                        },
                                        child: Text('Cancel',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                            color: GRE,
                                            fontSize: 15
                                        ),),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          cubit.deleteSelected().then((value){cubit.getData(dataBase!).then((value){Navigator.pop(context);});});
                                          cubit.cancelSelection();
                                        },
                                        child: Text('Yes',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                            color: GRE,
                                            fontSize: 15
                                        ),),
                                      ),
                                    ],
                                    actionsPadding:
                                    EdgeInsetsDirectional.only(
                                        bottom: 10,
                                        end: 8
                                    ),
                                  ),
                                ),
                          ));
                    },
                    child: Text(
                      'Delete',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(
                        color:intSelectedList.isEmpty ? Colors.grey[400] : WHI,
                      ),
                    )
                )
              ]
                  :
              [

              ]
            ),
            body: ConditionalBuilder(
              condition: users.isNotEmpty,
              builder: (context)=>Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                          itemBuilder: (context,index)=> Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  start: 8,
                                  end: 8,
                                ),
                                child: Material(
                                  color: whiteList[index],
                                  child: InkWell(
                                    onTap: selectBool ?
                                    ()
                                    {
                                      cubit.changeColor(index);
                                    }
                                    :
                                    ()
                                    {
                                      cubit.innerScore(index);
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>InnerScorePage(indexx: index,)));
                                    }  ,
                                    onLongPress: selectBool ?
                                        null
                                        :
                                        ()
                                    {
                                      cubit.changeColor(index);
                                      cubit.selectState();
                                    },
                                    child: Container(
                                      height: 120,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(),
                                        border: Border.all(color: BLA,width: 1),
                                      ),
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional.only(
                                                    start: 7,
                                                    end: 7
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(getGameNames[index],maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: BLA),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsetsDirectional.only(
                                                          start: 5,
                                                          end: 5
                                                      ),
                                                      child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(getPlayerOneNames[index],style: TextStyle(color: BLA),overflow: TextOverflow.ellipsis,maxLines: 1,),
                                                      ],
                                                  ),
                                                    ),),
                                                  Expanded(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8),
                                                        border: Border.all(color: BLA,width: 1),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Expanded(child: Text(' ${getPlayerOneFinalScores[index]} ',textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20,color: BLA),)),
                                                              Text(':',textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20,color: BLA),),
                                                              Expanded(child: Text(' ${getPlayerTwoFinalScores[index]} ',textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20,color: BLA),)),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsetsDirectional.only(
                                                            start: 5,
                                                            end: 5
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(getPlayerTwoNames[index],style: TextStyle(color: BLA),overflow: TextOverflow.ellipsis,maxLines: 1),
                                                    ],
                                                  ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(getDates[index],maxLines: 1,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: GREY),)
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          separatorBuilder: (context,index)=> SizedBox(height: 8,),
                          itemCount: getPlayerOneFinalScores.length
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context)=>SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('No Challenges',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: GREY,
                      fontSize: 25
                    ),)
                  ],
                ),
              ),
            )
          ),
        );
      },
    );
  }
}
