import 'package:flutter/material.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';

class CardListView extends StatelessWidget {
  int itemCount;
  Widget Function(BuildContext, int) itemBuilder;
  String? title;
  double itemHeight;

  CardListView({Key? key, required this.itemBuilder, this.title, required this.itemCount,  required this.itemHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                title!,
                style: context.textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
          SizedBox(
            width: context.screenWidth,
            height: itemHeight,
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: itemCount,
                itemBuilder: itemBuilder),
          ),
        ],
      ),
    );
  }
}
