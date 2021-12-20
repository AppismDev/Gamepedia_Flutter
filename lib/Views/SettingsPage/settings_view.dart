import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gamepedia/Core/Constans/Application/app_constants.dart';
import 'package:gamepedia/Core/Constans/Enums/preferences_keys.dart';
import 'package:gamepedia/Core/Constans/Enums/theme_enums.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:gamepedia/Core/Init/Language/language_manager.dart';
import 'package:gamepedia/Core/Init/Language/locale_keys.g.dart';
import 'package:gamepedia/Providers/Language/language_provider.dart';
import 'package:gamepedia/Providers/Theme/theme_provider.dart';
import 'package:gamepedia/Widgets/Bounce/bounce.dart';
import 'package:gamepedia/Widgets/Bounce/bounce_without_hover.dart';
import 'package:gamepedia/Widgets/Logo/gamepedia_logo.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GamepediaLogo(
          size: 18,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: context.mediumValue, bottom: context.lowValue),
              child: Text(
                LocaleKeys.settingsPage_settings.tr(),
                style: context.textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: context.lowValue, left: context.lowValue, right: context.lowValue),
              child: BounceWithoutHover(
                duration: Duration(milliseconds: 100),
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      builder: (context) => bottomSheetLanguage(context));
                },
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: Icon(Icons.language),
                    title: Text(LocaleKeys.settingsPage_languages.tr()),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: context.lowValue, right: context.lowValue, top: context.veryLowValue),
              child: BounceWithoutHover(
                duration: Duration(milliseconds: 100),
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      builder: (context) => bottomSheetTheme(context));
                },
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: Icon(Icons.brightness_4),
                    title: Text(LocaleKeys.settingsPage_themes.tr()),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: context.lowValue, right: context.lowValue, top: context.veryLowValue),
              child: BounceWithoutHover(
                duration: Duration(milliseconds: 100),
                onPressed: () {
                },
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: Icon(FontAwesome.shield),
                    title: Text(LocaleKeys.settingsPage_privacyPolicy.tr()),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: context.lowValue, right: context.lowValue, top: context.veryLowValue),
              child: BounceWithoutHover(
                duration: Duration(milliseconds: 100),
                onPressed: () {
                },
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: Icon(MaterialCommunityIcons.information_outline),
                    title: Text(LocaleKeys.settingsPage_termsOfService.tr()),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
            )


          ],
        ),
      ),
    );
  }
  Widget bottomSheetTheme(BuildContext context) {
    ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: context.paddingAllLow,
          width: context.dynamicWidth(0.25),
          height: 4,
          decoration: BoxDecoration(color: context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.white : Colors.black, borderRadius: BorderRadius.circular(12)),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: context.paddingAllMedium,
            child: Text(
              "Tema seçiniz",
              style: context.textTheme.headline6,
            ),
          ),
        ),
        ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Bounce(
                onPressed: () async {
                  _themeProvider.changeTheme(PreferencesKeys.DARK_THEME);
                  Navigator.pop(context);
                },
                duration: Duration(milliseconds: 100),
                child: ListTile(
                  leading: Icon(FontAwesome5Solid.moon, color: Colors.black38,),
                  title: Text("Karanlık Mod"),
                ),
              ),
            ),
            //TODO animasyonlu bişiler
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Bounce(
                onPressed: () async {
                  _themeProvider.changeTheme(PreferencesKeys.LIGHT_THEME);
                  Navigator.pop(context);
                },
                duration: Duration(milliseconds: 100),
                child: ListTile(
                  leading: Icon(MaterialIcons.wb_sunny, color: Colors.orange,),
                  title: Text("Aydınlık Mod"),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }


  Widget bottomSheetLanguage(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: context.paddingAllLow,
          width: context.dynamicWidth(0.25),
          height: 4,
          decoration: BoxDecoration(color: context.currentAppThemeEnum == ThemeEnums.DARK_MODE ? Colors.white : Colors.black, borderRadius: BorderRadius.circular(12)),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: context.paddingAllMedium,
            child: Text(
              "Dil seçiniz",
              style: context.textTheme.headline6,
            ),
          ),
        ),
        ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Bounce(
                onPressed: () async {
                  await Provider.of<LanguageProvider>(context, listen: false)
                      .setCurrentLocale(LanguageManager.instance.enLocale, context);
                  Navigator.pop(context);
                },
                duration: Duration(milliseconds: 100),
                child: ListTile(
                  leading: Image.asset(
                    AppConstants.instance.ICON_ASSET_PATH + "english.png",
                    height: 40,
                  ),
                  title: Text("English"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Bounce(
                onPressed: () async {
                  await Provider.of<LanguageProvider>(context, listen: false)
                      .setCurrentLocale(LanguageManager.instance.trLocale, context);
                  Navigator.pop(context);
                },
                duration: Duration(milliseconds: 100),
                child: ListTile(
                  leading: Image.asset(
                    AppConstants.instance.ICON_ASSET_PATH + "turkey.png",
                    height: 40,
                  ),
                  title: Text("Türkçe"),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
