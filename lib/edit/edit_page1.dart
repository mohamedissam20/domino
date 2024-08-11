import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/cubit/two/two_cubit.dart';
import 'package:project1/cubit/two/two_states.dart';
import 'package:project1/shared/constants.dart';

class EditPage1 extends StatelessWidget {

  final int index ;
  final String image;

  const EditPage1({super.key, required this.index, required this.image});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TwoCubit,TwoStates>(
        listener: (context , state){},
        builder: (context , state ){
          TwoCubit cubit = TwoCubit.get(context);
          return WillPopScope(
            onWillPop: enable == true ?
              () async
              {
                  {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => StatefulBuilder(
                      builder: (context, setState) =>
                          AlertDialog(
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
                                Text("Are you sure that you want to discard changes?",maxLines: 3,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA) ,),
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
                                child: Text('Cancel',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: GRE,
                                    fontSize: 15
                                ),),
                              ),
                              TextButton(
                                onPressed: () {
                                  player1Image = null;
                                  enable = false;
                                  croppedPlayer1Image = null;
                                  base64string = '';
                                  Navigator.pop(context); // Close the dialog
                                  Navigator.pop(context);
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
                    ));
              }
              return false;
            }
            :
              ()async
              {
              Navigator.pop(context);
              return false;
            },
            child: Scaffold(
              backgroundColor: BLA,
              appBar: AppBar(
                backgroundColor: BLA,
                elevation: 0,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: BLA,
                    statusBarIconBrightness: Brightness.light),
                leading: MaterialButton(
                    onPressed:enable == true ? (){
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => StatefulBuilder(
                              builder: (context, setState) =>
                                  AlertDialog(
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
                                        Text("Are you sure that you want to discard changes?",maxLines: 3,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA) ,),
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
                                        child: Text('Cancel',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                            color: GRE,
                                            fontSize: 15
                                        ),),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          player1Image = null;
                                          enable = false;
                                          croppedPlayer1Image = null;
                                          base64string = '';
                                          Navigator.pop(context);// Close the dialog
                                          Navigator.pop(context);
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
                            ));
                    }:(){Navigator.pop(context);},
                    child: Icon(
                      Icons.arrow_back_ios_sharp,color: WHI,
                    )
                ),
                title: Text(
                  'Image',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: WHI
                  ),
                ),
                centerTitle: true,
                actions: [
                  ConditionalBuilder(
                    condition: enable ,
                    builder:(context)=> Padding(
                      padding: const EdgeInsetsDirectional.only(
                          end: 2
                      ),
                      child: SizedBox(
                        height: 25,
                        child: MaterialButton(
                            minWidth: 1,
                            padding: EdgeInsets.zero,
                            onPressed:() {
                              cubit.addPlayer1PhotoToDatabase( base64string , index,context );
                            },
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  top: 2,
                                  start: 8,
                                  end: 8
                              ),
                              child: Text(
                                'UPDATE',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    height: 1.2, fontSize: 14,color: Colors.blue ),
                              ),
                            )
                        ),
                      ),
                    ),
                    fallback: (context)=> SizedBox(width: 1,),
                  ),
                ],
              ),
              body: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 4,
                              end: 4,
                          ),
                            child: image == '' ?
                              croppedPlayer1Image != null ?
                              Image (image : FileImage(croppedPlayer1Image!))
                              :
                              SizedBox()
                            :
                              croppedPlayer1Image != null ?
                              Image (image : FileImage(croppedPlayer1Image!))
                              :
                              Image.memory(base64Decode(image))
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: image == '' ? [] : [
                          if (enable != true)
                          Expanded(
                              child: Material(
                                color: WHI,
                                child: InkWell(
                                  onTap: ()
                                  {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) => StatefulBuilder(
                                          builder: (context, setState) =>
                                              AlertDialog(
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
                                                    Text("Are you sure that you want to delete this photo?",maxLines: 3,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA) ,),
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
                                                    child: Text('Cancel',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                        color: GRE,
                                                        fontSize: 15
                                                    ),),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      cubit.addPlayer1PhotoToDatabase('',index,context);
                                                      Navigator.pop(
                                                          context); // Close the dialog
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
                                        ));
                                  },
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                        'Delete',
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                            color: BLA
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ),
                          Expanded(
                              child: Material(
                                color: WHI,
                                child: InkWell(
                                  onTap: (){
                                    cubit.getPlayer1ImageC();
                                    },
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                        'Camera',
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          color: BLA
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ),
                          Expanded(
                              child: Material(
                                color: WHI,
                                child: InkWell(
                                  onTap: (){cubit.getPlayer1ImageG();},
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                        'Gallery',
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                            color: BLA
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
