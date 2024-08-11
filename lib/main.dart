import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/shared/constants.dart';
import 'package:project1/shared/local/cache_helper.dart';
import 'package:flutter/services.dart';
import 'package:project1/style/dark_theme.dart';
import 'package:project1/style/light_theme.dart';
import 'cubit/bloc_observer.dart';
import 'cubit/two/two_cubit.dart';
import 'home/home_page.dart';
import 'onboarding/onboarding_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool? onBoardingSkip = CacheHelper.getData(key: 'onBoardingSkip') == null ? false : true;
  if (onBoardingSkip == true){
    widget = HomePage();
  }
  else
  {
    widget = OnboardingPage();
  }
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(MyApp(widget: widget));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,required widget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.width);
    // print(MediaQuery.of(context).size.height);
    cardHeight = MediaQuery.of(context).size.width/13.4236;//61.7633
    cardWidth = MediaQuery.of(context).size.width /22.4852;//36.8727272
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context){return TwoCubit()..creatingDatabase()..fillHack()..filling()..falseSelections();}),
      ],
      child: MaterialApp(
        title: 'Dosh',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: widget,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}