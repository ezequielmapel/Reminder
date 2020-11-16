import 'dart:convert';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:reminder/base/cardConfigurationController.dart';
import 'package:reminder/models/menuCircle.dart';
import 'package:reminder/models/typeReminder.dart';
import 'package:reminder/services/databaseSqflite.dart';
import 'package:reminder/services/reminderService.dart';
import 'package:reminder/widgets/cardConfiguration.dart';
import 'package:reminder/widgets/menuCircleWidget.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
//import 'dart:js' as dartjs;

class ReminderViewPage extends StatefulWidget {
  @override
  _ReminderViewPageState createState() => _ReminderViewPageState();
}

class _ReminderViewPageState extends State<ReminderViewPage>
    with SingleTickerProviderStateMixin {
  int menuSelected = 0;
  String _backgroundImage = '';
  final cardsFormKey = new GlobalKey<FormState>();
  String _localTimezone;

  // Animation
  AnimationController _imageAnimationController;
  Animation _imageAnimation;
  bool _animationCompleted;
  double _marginLeftSize = 0;
  double _marginBottomSize = 20;
  double _animatedBottomSun = 40;

  // Audio
  AudioCache _audioCache;

  // Services
  ReminderService _reminderService = new ReminderService();
  List<TypeReminder> _reminders;

  @override
  void initState() {
    super.initState();

    // Animations
    this._imageAnimationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 0));
    this._imageAnimation =
        new Tween(begin: 0.0, end: 1.0).animate(this._imageAnimationController);

    // Audio
    this._audioCache =
        new AudioCache(prefix: 'audios/', fixedPlayer: AudioPlayer());

    // Others
    _tryGetTimezone();
    this._reminderService.setup();


  }

  @override
  Widget build(BuildContext context) {
    // Screen size
    final double width = MediaQuery.of(context).size.width;

    // First Background
    this._backgroundImage = typeReminders[menuSelected].getImage;

    // First animation
    this._imageAnimationController.forward();

    // State Controller
    final cardConfigurationController =
        GetIt.I.get<CardConfigurationController>();

    // Precache images
    typeReminders.forEach((typeReminder) =>
        precacheImage(new AssetImage(typeReminder.getImage), context));

    this._getTypeReminderFromBase();

    setState(() {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).backgroundColor,
        systemNavigationBarColor: Theme.of(context).backgroundColor,
      ));
    });
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton(
          onPressed: () {
            playClick();
            onTapReminder();
          },
          backgroundColor: Color(menuCircles[menuSelected].getBackgroundColor),
          heroTag: 'HeroTagFloatingActionButton',
          child: Icon(
            Icons.access_alarm,
            size: 32.0,
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                'Reminder',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: menuCircles
                .map((e) => GestureDetector(
                      onTap: () {
                        playClick();
                        this._imageAnimationController.reset();
                        onTapMenuCircle(menuCircles.indexOf(e));
                        this._imageAnimationController.forward();

                        int indexMenuCircles = menuCircles.indexOf(e);

                        this._animatedBottomSun = indexMenuCircles < 1
                            ? 30
                            : 40.0 * menuCircles.indexOf(e);
                      },
                      child: MenuCircleWidget(
                        menuCircle: e,
                      ),
                    ))
                .toList(),
          ),
          SizedBox(
            height: 25,
          ),
          Stack(
            children: [
              AnimatedPositioned(
                curve: Curves.easeOut,
                duration: new Duration(milliseconds: 1300),
                bottom: _animatedBottomSun,
                left: (width / 2) - (55),
                child: Container(
                  alignment: AlignmentDirectional.center,
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFFA6A6A6)),
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  height: 90,
                  color: Color(0xFF22303D),
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Image(
                  image: AssetImage(this._backgroundImage),
                  fit: BoxFit.fitWidth,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 130.0),
            child: Stack(
              children: this._reminders != null ? _reminders.map((typeReminder) {
                return (typeReminder.name == menuCircles[menuSelected].name)
                    ? CardConfigurationWidget(
                  typeReminder: typeReminder,
                  formKey: cardsFormKey,
                )
                    : Text('');
              }).toList(): [Text("")],
            ),
          ),
        ],
      ),
    );
  }

  @override
  dispose() {
    _imageAnimationController.dispose();
    super.dispose();
  }

  onTapMenuCircle(int selected) {
    setState(() {
      this.menuSelected = selected;
      this._backgroundImage = typeReminders[menuSelected].getImage;
    });
  }

  playClick() {
    // Check if is the app runing in web or mobile
    if (kIsWeb) {
      //dartjs.context.callMethod('playAudio', ['assets/audios/click5.wav']);
    } else {
      this._audioCache.play('click5.wav');
    }
  }

  onTapReminder() async {
    if (this.cardsFormKey.currentState.validate()) {
      typeReminders[menuSelected].setAtivado =
          !typeReminders[menuSelected].getAtivado;
      typeReminders[menuSelected]
          .cards
          .forEach((card) => print(card.selectedOption));

      // Reminder Service
      //await _reminderService.setup();

     
      // Save in local database
      await _reminderService
          .saveTypeReminder(typeReminders[menuSelected].toMap());


      // Setup notification schedule
      tz.initializeTimeZones();
      var datetime = tz.TZDateTime.now( tz.getLocation(this._localTimezone) ).add(new Duration(seconds: 10));

      //await _reminderService.sendNotification(datetime, "Reminder - Lembrete Ativado", "Seu lembrete foi ativado.", 239238923);

    }
  }

  Future<void> _tryGetTimezone() async {
    String localTimezone;
    try{
      localTimezone = await FlutterNativeTimezone.getLocalTimezone();
    } on PlatformException {
      localTimezone = 'Failed to get Local Timezone';
    }

    if(!mounted) return;
    setState(() {
      this._localTimezone = localTimezone;
    });
  }

  _getTypeReminderFromBase() async{
    List reminders = await this._reminderService.getTypeReminderFromBase();
    // Fazer o tramaento de reminders para List<TypeReminder>
    setState(() {
      this._reminders = reminders;
    });
  }
}
