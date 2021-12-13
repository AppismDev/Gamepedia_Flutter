import 'package:flutter/material.dart';

class HomePageGameCard extends StatelessWidget {
  VoidCallback onTap;
  Widget child;
  double? width;
  double? height;
  double? borderRadius;
  double? elevation;
  EdgeInsets? padding;



  HomePageGameCard({Key? key, required this.onTap, required this.child, this.width, this.borderRadius, this.elevation, this.padding, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: InkWell(
        borderRadius:  BorderRadius.circular(borderRadius ?? 0),
        splashFactory: NoSplash.splashFactory,
        onTap: onTap,
        child: Card(
          elevation: elevation ?? 0,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 0)),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: height ?? 200,
                width: width ?? 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius ?? 0),
                  child: child,
                )),
          ),
        ),
      ),
    );
  }
}
