import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project1/home/home_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../shared/local/cache_helper.dart';

class BoardingModel {
  String? image;
  String? title;
  String? body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  var boardingController = PageController();

  List<BoardingModel> boardingModels = [
    BoardingModel(
        image: 'assets/images/1.JPEG',
        title: "1",
        body: "after you open the game you will face two options:\n- NEW GAME\n- Challenges\n...to start a new game, click NEW GAME and will navigate you to this board, just write your names and click TO THE GAME button and the score will be calculated automatically after you finish the game."
    ),
    BoardingModel(
        image: 'assets/images/2.JPEG',
        title: "2",
        body: "body"
    ),
    BoardingModel(
        image: 'assets/images/3.JPEG',
        title: "3",
        body: "body"
    ),
  ];

  bool islast = false;
  void submit(){
    CacheHelper.saveData(key: 'onBoardingSkip', value: true).then((value) {
      if (value == true )
      {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context)=>HomePage()),
                (route)
            {
              return false ;
            });
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.greenAccent,
              statusBarIconBrightness: Brightness.dark,
            ),
          actions: [
            TextButton(
                onPressed: (){
                  submit();
                },
                child: Text(
                  'skip',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                )
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged:(index){
                    if (index == boardingModels.length-1 )
                    {
                      setState(() {
                        islast = true;
                      });
                    }else
                    {
                      setState(() {
                        islast = false;
                      });
                    }
                  },
                  physics: BouncingScrollPhysics(),
                  controller: boardingController,
                  itemBuilder: (context,index) => buildOnboardingItem( boardingModels[index]),
                  itemCount: 3,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardingController,
                    count: boardingModels.length,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Colors.green,
                        dotHeight: 10,
                        expansionFactor: 1.0000001,
                        dotWidth: 10,
                        spacing: 5
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: (){
                      if (islast == true )
                      {
                        submit();
                      }
                      else
                      {
                        boardingController.nextPage(
                            duration: Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn
                        );
                      }
                    },
                    child:Icon(
                        Icons.arrow_forward_ios
                    ),
                  )
                ],
              )
            ],
          ),
        )
    );
  }

  Widget buildOnboardingItem (BoardingModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(child: Text(model.title!))
    ],
  );
}