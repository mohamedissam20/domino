import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/challenges/challenges_page.dart';
import 'package:project1/cubit/two/two_cubit.dart';
import 'package:project1/cubit/two/two_states.dart';
import 'package:project1/TheBoard/the_board.dart';
import 'package:project1/shared/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TwoCubit, TwoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // TwoCubit cubit = TwoCubit.get(context);
          return Scaffold(
            appBar: AppBar(
                backgroundColor: Burgundy,
                elevation: 0,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.black26,
                    statusBarIconBrightness: Brightness.light),
                centerTitle: true,
                title: Text(
                  'Dosh',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: WHI, fontSize: 22, fontWeight: FontWeight.bold),
                )),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 5,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      width: double.infinity,
                      height: 80,
                      color: Burgundy,
                      child: Material(
                        color: Burgundy,
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>TheBoard()));
                            },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 25,),
                              Text(
                                "NEW GAME",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: WHI,
                                        fontSize: 27,
                                        fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Spacer(),
                              Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Icon(Icons.arrow_forward_ios, color: WHI,)),
                              SizedBox(width: 10,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 16,
                    end: 16,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 5,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      width: double.infinity,
                      height: 80,
                      color: Burgundy,
                      child: Material(
                        color: Burgundy,
                        child: InkWell(
                          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ChallengesPage()));},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 25,),
                              Text(
                                "Challenges",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                    color: WHI,
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Spacer(),
                              Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Icon(Icons.arrow_forward_ios,color: WHI,)),
                              SizedBox(width: 10,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
