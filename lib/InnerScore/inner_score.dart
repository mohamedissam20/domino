import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/cubit/two/two_cubit.dart';
import 'package:project1/cubit/two/two_states.dart';
import 'package:project1/edit/edit_page1.dart';
import 'package:project1/edit/edit_page2.dart';
import 'package:project1/shared/constants.dart';

class InnerScorePage extends StatelessWidget {

  final int indexx;

  const InnerScorePage({super.key, required this.indexx});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TwoCubit,TwoStates>(
      listener: (context,state){},
      builder: (context,state){
        TwoCubit cubit = TwoCubit.get(context);
        return WillPopScope(
          onWillPop: isEditState ?
              ()async
              {
                FocusManager.instance.primaryFocus?.unfocus();
                isEditState = false;
                update_appearance = false ;
                editGameNameController.text = getGameName;
                cubit.makeEditFalse();
                return false ;
              }
              :
              ()async
              {
                Navigator.pop(context);
                return false ;
              },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: WHI,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: WHI,
                  statusBarIconBrightness: Brightness.dark
              ),
              leadingWidth: cardWidth!-10,
              centerTitle: isEditState ? false : true,
              leading: isEditState ?
              MaterialButton(
                padding: EdgeInsets.zero,
                  onPressed: (){
                    FocusManager.instance.primaryFocus?.unfocus();
                    isEditState = false;
                    update_appearance = false ;
                    editGameNameController.text = getGameName;
                    cubit.makeEditFalse();
                  },
                  child: Icon(Icons.undo_outlined,color: Colors.black,)
              )
                  :
              Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                      onPressed: ()
                      {
                        Navigator.pop(context);
                      },
                      tooltip: 'Back',
                      icon: Icon(Icons.arrow_back,color: BLA,))),
              actions: isEditState ?
              [
                MaterialButton(
                  padding: EdgeInsets.zero,
                  disabledTextColor: GREY,
                  minWidth: 1,
                  onPressed:update_appearance ?
                      ()
                  {
                    FocusManager.instance.primaryFocus?.unfocus();
                    cubit.updateGameName(editGameNameController.text, indexx);
                  }
                  :
                      null,
                  child: Text(
                    'Update',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(
                      color: update_appearance ?  BLA : Colors.grey[400],
                    ),
                  )
              ),
                SizedBox(width: 15,)
              ]
                  :
              [
                IconButton(
                padding: EdgeInsets.zero,
                onPressed: ()
                {
                  cubit.makeEditTrue();
                },
                tooltip: 'Edit game name',
                icon: Icon(Icons.edit_outlined,color: BLA,size: 23,)),
              ],
              title: isEditState ?
              Column(
                children: [
                  Container(
                    child: Form(
                        key: editGameName,
                        onChanged: () {},
                        child: TextFormField(
                          enableInteractiveSelection: false,
                          onFieldSubmitted: (value){
                            FocusManager.instance.primaryFocus?.unfocus();
                            cubit.updateGameName(editGameNameController.text, indexx);
                          },
                          autofocus: true,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: BLA),
                          cursorColor: GREY,
                          onChanged: (value) {
                            cubit.updateAppearance(getGameName);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return;
                            }
                            return null;
                          },
                          controller: editGameNameController,
                          decoration: InputDecoration(
                            focusedBorder:
                            UnderlineInputBorder(),
                            enabledBorder:
                            UnderlineInputBorder(
                                borderSide:
                                BorderSide.none),
                          ),
                        )),
                  )
                ],
              )
                  :
              Text(
                getGameName,maxLines: 1,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA,fontSize: 20),
              ),
            ),
            body: !isEditState ?
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Wrap(
                                              children: [
                                                Text(getInnerPlayerOneName,textAlign: TextAlign.center,maxLines: 3,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA,fontSize: 30,height: 1.2),),
                                              ],
                                            ),
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                if (getPlayerOneImage == '')
                                                {
                                                  showModalBottomSheet(
                                                      context: context,
                                                      builder: (BuildContext context) =>Container(
                                                        height: 50,
                                                        color: Burgundy,
                                                        child:Row(
                                                          children: [
                                                            Expanded(
                                                                child: Material(
                                                                  color: WHI,
                                                                  child: InkWell(
                                                                    onTap: (){
                                                                      Navigator.pop(context);
                                                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>edit_page1(index: indexx,image: getPlayerOneImage)));
                                                                      cubit.getPlayer1ImageCameraAdd(indexx);
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
                                                                    onTap: (){
                                                                      Navigator.pop(context);
                                                                      cubit.getPlayer1ImageGalleryAdd(indexx);
                                                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>edit_page1(index: indexx,image: getPlayerOneImage)));
                                                                    },
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
                                                  );
                                                }
                                                else
                                                {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EditPage1(index: indexx,image: getPlayerOneImage,)));
                                                }
                                              },
                                              child: Container(
                                                width: 110,
                                                height: 110,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: GREY,
                                                ),
                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                child: getPlayerOneImage == '' ? Icon(Icons.add_a_photo,color: WHI,size: 40,):Image.memory(base64Decode(getPlayerOneImage)),
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text('$getInnerPlayerOneFinalScore',textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA,fontSize: 32),),
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 40,),
                            ],
                          )
                      ),
                      Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Wrap(
                                              children: [
                                                Text(getInnerPlayerTwoName,maxLines: 3,textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA,fontSize: 30,height: 1.2),),
                                              ],
                                            ),
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                if (getPlayerTwoImage == '')
                                                {
                                                  showModalBottomSheet(
                                                      context: context,
                                                      builder: (BuildContext context) =>Container(
                                                        height: 50,
                                                        color: Burgundy,
                                                        child:Row(
                                                          children: [
                                                            Expanded(
                                                                child: Material(
                                                                  color: WHI,
                                                                  child: InkWell(
                                                                    onTap: (){
                                                                      Navigator.pop(context);
                                                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>edit_page2(index: indexx,image: getPlayerTwoImage,)));
                                                                      cubit.getPlayer2ImageCameraAdd(indexx);
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
                                                                    onTap: (){
                                                                      Navigator.pop(context);
                                                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>edit_page2(index: indexx,image: getPlayerTwoImage)));
                                                                      cubit.getPlayer2ImageGalleryAdd(indexx);
                                                                    },
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
                                                  );
                                                }
                                                else
                                                {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EditPage2(index: indexx,image: getPlayerTwoImage,)));
                                                }
                                              },
                                              child: Container(
                                                width: 110,
                                                height: 110,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: GREY,
                                                ),
                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                child: getPlayerTwoImage == '' ? Icon(Icons.add_a_photo,color: WHI,size: 40,):Image.memory(base64Decode(getPlayerTwoImage)),
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text('$getInnerPlayerTwoFinalScore',textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA,fontSize: 32),),
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 40,),
                            ],
                          )
                      )
                    ],
                  ),
                  ListView.separated(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context,index)=> Padding(
                        padding: EdgeInsetsDirectional.only(start: 5,end: 5),
                        child: Column(
                          children: [
                            if (index == roundsNum)
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: GREY,
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 1,
                                  color: GREY,
                                ),
                                Expanded(
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 3,
                                          end: 3
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(tempString1List[index],maxLines: 1,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA),),
                                        ],
                                      ),
                                    )
                                ),
                                Container(
                                  height: 30,
                                  width: 1,
                                  color: GREY,
                                ),
                                Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(tempString2List[index],maxLines: 1,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: BLA),),
                                      ],
                                    )
                                ),
                                Container(
                                  height: 30,
                                  width: 1,
                                  color: GREY,
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: GREY,
                            ),
                          ],
                        ),
                      ),
                      separatorBuilder: (context,index)=> SizedBox(),
                      itemCount: getNumberOfRounds
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(getInnerDate,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: GREY),)
                    ],
                  )
                ],
              ),
            )
                :
            SizedBox(),
          ),
        );
      },
    );
  }
}
