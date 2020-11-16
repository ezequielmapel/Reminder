import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder/services/databaseSqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:reminder/models/typeReminder.dart';

class ReminderService {
  final String TABLE_NAME = 'typeReminder';
  DatabaseSqflite _database = new DatabaseSqflite();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  ReminderService(){
    this.flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  }

  saveTypeReminder(Map<String, dynamic> typeReminder) async {
    if (this._database != null) {

      // Check if the value already exists
      List response = await this
          ._database
          .getWithName(this.TABLE_NAME, typeReminder["name"]);

      if (response.isNotEmpty) {
        return await this._database.updateTable(this.TABLE_NAME, typeReminder);
      }

      await this._database.insertInTable(
          this.TABLE_NAME, typeReminder, ConflictAlgorithm.replace);
    }
  }

  Future<List> getTypeReminder() async {
    return await this._database.getValuesFromTable(this.TABLE_NAME);
  }

  Future<bool> getTypeReminderStatus(String name) async {
    return (await this._database.getWithName(this.TABLE_NAME, name) as List<TypeReminder>).first.getAtivado ;

  }

  Future<List<TypeReminder>> getTypeReminderFromBase() async{
    List<Map<String, dynamic>> reminders = await this.getTypeReminder();
    // Fazer o tramaento de reminders para List<TypeReminder>

    List<TypeReminder> parseReminders = [];

    if(reminders != null && reminders.isNotEmpty){
      reminders?.forEach((typeReminder){
        parseReminders.add(TypeReminder.factory(typeReminder, typeReminder["id"]-1));
      });
    }
    return parseReminders;
  }

  setup() async {
    await this._database.setup();
    await this._setupTable();
    await _setupDefaultValues();
    await _setupSchedulerNotification();
  }

  _setupTable() async {
    if(this._database != null){
      await this._database.createTable(
          this.TABLE_NAME, 'id INTEGER PRIMARY KEY, name TEXT, cards TEXT, ativado INT');
    }
  }

  _setupDefaultValues() async {
    List reminders = await this.getTypeReminder();
    if(reminders.isEmpty){
      typeReminders.forEach((typeReminder) {
        this.saveTypeReminder(typeReminder.toMap());
      });
    }
  }


  Future sendNotification(DateTime datetime, String message, String subtext, int hashcode, {String sound}){
    const androidChannel =  AndroidNotificationDetails(
      'channelId', 'channelName', 'channelDescription',
      importance: Importance.max,
      priority: Priority.max
    );

    const iosChannel = IOSNotificationDetails();
    const plataformChannel = NotificationDetails(android: androidChannel, iOS: iosChannel);

    this.flutterLocalNotificationsPlugin.zonedSchedule(
        hashcode,
        message,
        subtext,
        datetime,
        plataformChannel,
        uiLocalNotificationDateInterpretation: null,
        androidAllowWhileIdle: false,
        payload: hashCode.toString());
  }

  void _setupSchedulerNotification() async {
    var initializeAndroid = AndroidInitializationSettings('ic_launcher');
    var initializeIOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(android: initializeAndroid, iOS: initializeIOS);

    await this.flutterLocalNotificationsPlugin.initialize(initSettings);

  }
}
