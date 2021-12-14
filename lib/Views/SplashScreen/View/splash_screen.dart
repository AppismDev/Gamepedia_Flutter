import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gamepedia/Views/ErrorPage/View/error_page_view.dart';
import 'package:gamepedia/Views/HomePage/View/home_page_view.dart';
import 'package:gamepedia/Views/SplashScreen/ViewModels/splash_screen_viewmodel.dart';
import 'package:gamepedia/Widgets/Logo/gamepedia_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashScreenViewModel _viewModel = SplashScreenViewModel();

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GamepediaLogo(
              size: 30,
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xffE50914)),
            ),
          ],
        ),
      ),
    );
  }
}
