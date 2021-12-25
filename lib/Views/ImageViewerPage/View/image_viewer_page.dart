import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Widgets/Logo/gamepedia_logo.dart';

class ImageViewerPage extends StatefulWidget {
  ImageViewerPage({Key? key, required this.url}) : super(key: key);

  String url;

  @override
  State<ImageViewerPage> createState() => _ImageViewerPageState();
}

class _ImageViewerPageState extends State<ImageViewerPage> {

  @override
  void initState() {
    super.initState();


    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        return true;
      },
      child: Scaffold(
        body: Hero(
          tag: widget.url,
          child: Container(
            width: context.screenWidth,
            height: context.screenHeight,
            child: CachedNetworkImage(
              imageUrl: "${widget.url}",
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              placeholder: (c, url) {
                return Center(child: GamepediaLogo(size: 40));
              },
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        )
      ),
    );
  }
}
