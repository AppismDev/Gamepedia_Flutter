import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:google_fonts/google_fonts.dart';

class TwitchDialog extends StatelessWidget {
  TwitchDialog({Key? key,required this.onAccept}) : super(key: key);

  VoidCallback onAccept;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Navigator.of(context).pop(),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          child: Center(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: ()=>null,
                  child: Container(
                    width: context.dynamicWidth(0.8),
                    height: context.dynamicHeight(0.3),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // TODO i18n Yapılacak :)
                        Padding(
                          padding: context.paddingAllMedium,
                          child: Text(
                              "Twitch'te İzle",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.white
                            ),
                          ),
                        ),
                        Padding(
                          padding: context.paddingAllMedium,
                          child: Text(
                            "Bu Oyunu Twitch'te Canlı Olarak İzlemek İster misin ?",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Colors.white
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 20),
                            TextButton(
                                onPressed: ()=>Navigator.of(context).pop(),
                                style: TextButton.styleFrom(
                                  primary: Colors.red
                                ),
                                child: Text(
                                    "Vazgeç",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                            ),
                            Spacer(),
                            TextButton.icon(
                              icon: Icon(MaterialCommunityIcons.exit_to_app),
                              onPressed: () async => onAccept.call(),
                              style: TextButton.styleFrom(
                                  primary: Colors.white
                              ),
                              label: Text(
                                  "Twitch'e Git",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                          ],
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xff6441a5),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff262626),
                          blurRadius: 1,
                          offset: Offset(1, 1),
                        )
                      ],

                    ),
                  ),
                ),

                Positioned(
                  top: 20,
                  left: -60,
                  child: Transform.rotate(
                    angle: -30 *  pi/180,
                    child: Icon(
                      Feather.twitch,
                      size: 200,
                      color: Colors.white.withOpacity(0.05),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
