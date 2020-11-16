// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cardConfigurationController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CardConfigurationController on CardConfigurationBase, Store {
  final _$typeRemindersAtom = Atom(name: 'CardConfigurationBase.typeReminders');

  @override
  ObservableList<TypeReminder> get typeReminders {
    _$typeRemindersAtom.reportRead();
    return super.typeReminders;
  }

  @override
  set typeReminders(ObservableList<TypeReminder> value) {
    _$typeRemindersAtom.reportWrite(value, super.typeReminders, () {
      super.typeReminders = value;
    });
  }

  final _$CardConfigurationBaseActionController =
      ActionController(name: 'CardConfigurationBase');

  @override
  dynamic addTypeReminder(TypeReminder typeReminder) {
    final _$actionInfo = _$CardConfigurationBaseActionController.startAction(
        name: 'CardConfigurationBase.addTypeReminder');
    try {
      return super.addTypeReminder(typeReminder);
    } finally {
      _$CardConfigurationBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeTypeReminder(int index) {
    final _$actionInfo = _$CardConfigurationBaseActionController.startAction(
        name: 'CardConfigurationBase.removeTypeReminder');
    try {
      return super.removeTypeReminder(index);
    } finally {
      _$CardConfigurationBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
typeReminders: ${typeReminders}
    ''';
  }
}
