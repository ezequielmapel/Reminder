import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:reminder/models/typeReminder.dart';

part 'cardConfigurationController.g.dart';

class CardConfigurationController = CardConfigurationBase
    with _$CardConfigurationController;

abstract class CardConfigurationBase with Store {
  @observable
  ObservableList<TypeReminder> typeReminders;

  @action
  addTypeReminder(TypeReminder typeReminder) => typeReminders.add(typeReminder);

  @action
  removeTypeReminder(int index) => typeReminders.removeAt(index);
}
