//Delete import html.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = Locale('fa');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      // localizationsDelegates: [
      //   AppLocalizations.delegate, // Add this line
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: [
      //   Locale('en', ''), // English, no country code
      //   Locale('fa', '98'), // Spanish, no country code
      // ],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,

      theme: _themeMode == ThemeMode.dark
          ? MyAppThemeConfig.dark().getTheme(_locale.languageCode)
          : MyAppThemeConfig.light().getTheme(_locale.languageCode),
      home: MyHomePage(
        toggleThemeMode: () {
          setState(() {
            if (_themeMode == ThemeMode.dark) {
              _themeMode = ThemeMode.light;
            } else {
              _themeMode = ThemeMode.dark;
            }
          });
        },
        selectedLangugeChangedByUser: (_Language newSelectedLangugeByUser) {
          setState(() {
            _locale = (newSelectedLangugeByUser == _Language.fa)
                ? Locale('fa')
                : Locale('en');
          });
        },
      ),
    );
  }
}

class MyAppThemeConfig {
  static const faPrimaryFontFamily = 'BYekan';
  //static const Color surfaceColor = Color(0x0DFFFFFF); //white 5%
  final Color primaryColor = Colors.pink.shade400;
  final Color primaryTextColor;
  final Color secoundryTextColor;
  final Color surfaceColor;
  final Color backgroundColor;
  final Color appbarColor;
  final Color appbarTextColor;
  final Brightness brightness;

  MyAppThemeConfig.dark()
      : primaryTextColor = Colors.white,
        secoundryTextColor = Colors.white70,
        surfaceColor = const Color(0x0dffffff), //white 5%
        backgroundColor = const Color.fromARGB(255, 30, 30, 30),
        appbarColor = Colors.black,
        appbarTextColor = Colors.white,
        brightness = Brightness.dark;

  MyAppThemeConfig.light()
      : primaryTextColor = Colors.grey.shade900,
        secoundryTextColor = Colors.grey.shade900.withOpacity(0.8),
        surfaceColor = const Color(0x0d000000),
        backgroundColor = Colors.white,
        appbarColor = const Color.fromARGB(255, 235, 235, 235),
        appbarTextColor = Colors.grey.shade900,
        brightness = Brightness.light;

  ThemeData getTheme(String languageCode) {
    return ThemeData(
      // This is the theme of your application.
      primarySwatch: Colors.pink,
      // primaryColor: primaryColor,

      brightness: brightness, //Brightness.dark,
      scaffoldBackgroundColor:
          backgroundColor, //const Color.fromARGB(255, 35, 35, 35),
      appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: appbarColor,
          foregroundColor: primaryTextColor),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: surfaceColor,
      ),
      dividerTheme: DividerThemeData(
        color: surfaceColor,
        thickness: 0.8,
        indent: 2,
        endIndent: 2,
        space: 5,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
        ),
      ),
      textTheme:
          (languageCode == 'fa') ? faParimaryTextTheme : enPrimaryTextTheme,
    );
  }

  TextTheme get enPrimaryTextTheme => GoogleFonts.latoTextTheme(TextTheme(
        bodyText2: TextStyle(
          fontSize: 16,
          color: primaryTextColor,
        ),
        bodyText1: TextStyle(fontSize: 13, color: secoundryTextColor),
        headline6: TextStyle(
          fontWeight: FontWeight.w900,
          color: primaryTextColor,
        ),
        subtitle1: TextStyle(
          fontWeight: FontWeight.w700,
          color: primaryTextColor,
        ),
      ));

  TextTheme get faParimaryTextTheme => TextTheme(
        bodyText2: TextStyle(
          fontSize: 16,
          color: primaryTextColor,
          fontFamily: faPrimaryFontFamily,
        ),
        bodyText1: TextStyle(
          fontSize: 13,
          height: 1.5,
          color: secoundryTextColor,
          fontFamily: faPrimaryFontFamily,
        ),
        headline6: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w700,
          color: primaryTextColor,
          fontFamily: faPrimaryFontFamily,
        ),
        subtitle1: TextStyle(
          fontWeight: FontWeight.w700,
          color: primaryTextColor,
          fontFamily: faPrimaryFontFamily,
        ),
        caption: const TextStyle(
          fontFamily: faPrimaryFontFamily,
        ),
        button: const TextStyle(fontFamily: faPrimaryFontFamily),
      );
}

class MyHomePage extends StatefulWidget {
  final Function() toggleThemeMode;
  final Function(_Language _language) selectedLangugeChangedByUser;

  const MyHomePage(
      {Key? key,
      required this.toggleThemeMode,
      required this.selectedLangugeChangedByUser})
      : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum _SkillType { photoshop, xd, illustartor, afterEffect, lightRoom }

enum _Language { fa, en }

class _MyHomePageState extends State<MyHomePage> {
  _SkillType _selectedSkill = _SkillType.photoshop; // State this page
  _Language _language = _Language.fa; // other state in this page

  void updateSelectedSkill(_SkillType _skillType) {
    setState(() {
      _selectedSkill = _skillType;
    });
  }

  void _updateSelectedLanguage(_Language language) {
    widget.selectedLangugeChangedByUser(language);
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.profileTitle),
            actions: [
              const Icon(CupertinoIcons.chat_bubble),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
                child: InkWell(
                    onTap: widget.toggleThemeMode,
                    child: const Icon(CupertinoIcons.ellipsis_vertical)),
              ),
            ]),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/profile_image.png',
                        width: 60,
                        height: 60,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localization.name,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(AppLocalizations.of(context)!.job),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.location,
                                size: 16,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                localization.location,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      CupertinoIcons.heart,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
                child: Text(localization.summery,
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      localization.slectedLanguage,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 13,
                          ),
                    ),
                    CupertinoSlidingSegmentedControl<_Language>(
                      groupValue: _language,
                      thumbColor: Theme.of(context).colorScheme.primary,
                      children: {
                        _Language.en: Text(
                          localization.enLanguage,
                          style: TextStyle(
                            fontSize: 13,
                            color: (_language == _Language.en)
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        _Language.fa: Text(
                          localization.faLanguage,
                          style: TextStyle(
                            fontSize: 13,
                            color: (_language == _Language.fa)
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      },
                      onValueChanged: (value) {
                        if (value != null) {
                          _updateSelectedLanguage(value);
                        }
                      },
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 8, 32, 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      localization.skills,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 13,
                          ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Icon(
                      CupertinoIcons.chevron_down,
                      size: 12,
                    ),
                  ],
                ),
              ),
              Center(
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    Skill(
                      type: _SkillType.photoshop,
                      skillTitle: 'Photoshop',
                      pathImage: 'assets/images/app_icon_01.png',
                      shadowColor: Colors.blue,
                      isActive: _selectedSkill == _SkillType.photoshop,
                      onTapFunc: () {
                        updateSelectedSkill(_SkillType.photoshop);
                      },
                    ),
                    Skill(
                      type: _SkillType.xd,
                      skillTitle: 'Adobe XD',
                      pathImage: 'assets/images/app_icon_05.png',
                      shadowColor: Colors.pink,
                      isActive: _selectedSkill == _SkillType.xd,
                      onTapFunc: () {
                        updateSelectedSkill(_SkillType.xd);
                      },
                    ),
                    Skill(
                      type: _SkillType.illustartor,
                      skillTitle: 'illustrator',
                      pathImage: 'assets/images/app_icon_04.png',
                      shadowColor: Colors.orange,
                      isActive: _selectedSkill == _SkillType.illustartor,
                      onTapFunc: () {
                        updateSelectedSkill(_SkillType.illustartor);
                      },
                    ),
                    Skill(
                      type: _SkillType.afterEffect,
                      skillTitle: 'After Effect',
                      pathImage: 'assets/images/app_icon_03.png',
                      shadowColor: Colors.purple.shade900,
                      isActive: _selectedSkill == _SkillType.afterEffect,
                      onTapFunc: () {
                        updateSelectedSkill(_SkillType.afterEffect);
                      },
                    ),
                    Skill(
                      type: _SkillType.lightRoom,
                      skillTitle: 'Light room',
                      pathImage: 'assets/images/app_icon_02.png',
                      shadowColor: Colors.blue,
                      isActive: _selectedSkill == _SkillType.lightRoom,
                      onTapFunc: () {
                        updateSelectedSkill(_SkillType.lightRoom);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localization.personalInformation,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 13,
                          ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: localization.email,
                        prefixIcon: Icon(CupertinoIcons.at),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: localization.password,
                          prefixIcon: Icon(
                            CupertinoIcons.lock,
                          )),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(localization.save),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class Skill extends StatelessWidget {
  final _SkillType type; //id
  final String skillTitle;
  final String pathImage;
  final Color shadowColor;
  final bool isActive;
  final Function() onTapFunc;

  const Skill({
    Key? key,
    required this.type,
    required this.skillTitle,
    required this.pathImage,
    required this.shadowColor,
    required this.isActive,
    required this.onTapFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BorderRadius defultBorderRadious = BorderRadius.circular(12);
    return InkWell(
      onTap: onTapFunc,
      borderRadius: defultBorderRadious,
      child: Container(
        width: 110,
        height: 110,
        decoration: isActive
            ? BoxDecoration(
                color: Colors.white10,
                borderRadius: defultBorderRadious,
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: isActive
                  ? BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: shadowColor.withOpacity(0.5),
                        blurRadius: 20,
                      )
                    ])
                  : null,
              child: Image.asset(
                pathImage,
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(skillTitle),
          ],
        ),
      ),
    );
  }
}
