import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gamepedia/Core/Constans/Enums/theme_enums.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Views/ErrorPage/View/error_page_view.dart';
import 'package:gamepedia/Views/HomePage/View/home_page_view.dart';
import 'package:gamepedia/Views/SplashScreen/ViewModels/splash_screen_viewmodel.dart';
import 'package:gamepedia/Widgets/Logo/gamepedia_logo.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  SplashScreenViewModel _viewModel = SplashScreenViewModel();
  late AnimationController animationControllerG;
  late AnimationController animationControllerP;
  late Animation<double> animation;
  late Animation<double> animation2;


  @override
  void initState() {
    super.initState();
    animationControllerG = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    animationControllerP = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    animation = Tween<double>(begin: 0, end: 48).animate(animationControllerG)
      ..addListener(() {
        setState(() {});
      });
    animation2 = Tween<double>(begin: 0, end: 48).animate(animationControllerP)
      ..addListener(() {
        setState(() {});
      });

    animationControllerG.forward().then((value) {
      animationControllerP.forward().then((value) {});
    });


    _viewModel.checkAccessToken().then((accessToken) {
      Future.delayed(Duration(seconds: 2)).then((_) {
        if(accessToken != null){
          MaterialPageRoute route = MaterialPageRoute(builder: (context) => HomePageView());
          Navigator.of(context).pushReplacement(route);
        }else{
          MaterialPageRoute route = MaterialPageRoute(builder: (context) => ErrorPageView());
          Navigator.of(context).pushReplacement(route);
        }
      });
    });
  }
// TODO harfler tek tek çıkacak
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  child: Text(
                    "G",
                    style: GoogleFonts.prompt(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Color(0xffE50914),
                        fontSize: 48),
                    // style: context.textTheme.headline3!.copyWith(
                    //   fontWeight: FontWeight.bold,
                    //   fontSize: 48,
                    //   color: Color(0xffE50914),
                    // ),
                  ),
                ),
                Container(
                  child: Text(
                    "ame",
                    style: GoogleFonts.prompt(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Color(0xffE50914),
                        fontSize: animation.value),
                  ),
                ),
              ],
            ),
            SizedBox(),
            Row(
              children: [
                Container(
                  child: Text("p",
                      style: GoogleFonts.prompt(
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic,
                          fontSize: 48,
                          color: context.currentAppThemeEnum == ThemeEnums.LIGHT_MODE
                              ? Colors.grey.shade800
                              : Colors.grey.shade200)),
                ),
                Container(
                  child: Text("edia",
                      style: GoogleFonts.prompt(
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic,
                          fontSize: animation2.value,
                          color: context.currentAppThemeEnum == ThemeEnums.LIGHT_MODE
                              ? Colors.grey.shade800
                              : Colors.grey.shade200)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
