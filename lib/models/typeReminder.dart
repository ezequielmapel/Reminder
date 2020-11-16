import 'dart:collection';

import 'dart:convert';

class TypeReminder {
  String name;
  String label;
  int buttonColor;
  List<TypeCardReminder> cards;
  String image;
  bool ativado;

  TypeReminder(
      {this.name,
      this.label,
      this.cards,
      this.buttonColor,
      this.image,
      this.ativado = false});

  String get getName => name;
  set setName(String name) => this.name = name;

  String get getLabel => label;
  set setLabel(String label) => this.label = label;

  int get getButtonColor => buttonColor;
  set setButtonColor(int buttonColor) => this.buttonColor = buttonColor;

  List get getCards => cards;
  set setCards(List cards) => this.cards = cards;

  String get getImage => image;
  set setImage(String image) => this.image = image;

  bool get getAtivado => ativado;
  set setAtivado(bool ativado) => this.ativado = ativado;

  Map<String, dynamic> toMap() {
    List refinedCards = this.refineCardsForEncode();
    return {"name": this.getName,"ativado": this.ativado ? 0:1, "cards": jsonEncode(refinedCards)};
  }

  static TypeReminder factory(Map<String, dynamic> typeReminder, int id){
    TypeReminder defaultTypeReminder = typeReminders[id];
    defaultTypeReminder.setAtivado = typeReminder["ativado"] == 0 ? false : true;
    defaultTypeReminder.cards.forEach((card) {
      var cards = jsonDecode(typeReminder["cards"]);
      var selectedOption = cards[defaultTypeReminder.cards.indexOf(card)]["selectedOption"];

      if(selectedOption != null)
        card.setSelectedOption = Map<String,String>.from(selectedOption);

    });
    return defaultTypeReminder;
  }

  List<Map<String, dynamic>> refineCardsForEncode() {
    return this.getCards.map((card) {
      HashMap<String, dynamic> mapCard = new HashMap();
      mapCard["name"] = card.getLabel;
      mapCard["selectedOption"] = card.getSelectedOption;

      return mapCard;
    }).toList();
  }
}

class TypeCardReminder {
  String label;
  String icon;
  Map<String, String> selectedOption;
  List<Map> optionsToSelect;

  TypeCardReminder(
      {this.label, this.icon, this.optionsToSelect, this.selectedOption});

  String get getLabel => label;
  set setLabel(String label) => this.label = label;

  String get getIcon => icon;
  set setIcon(String icon) => this.icon = icon;

  List<Map> get getOptionsToSelect => optionsToSelect;
  set setOptionsToSelect(List<Map> optionsToSelect) =>
      this.optionsToSelect = optionsToSelect;

  Map<String, String> get getSelectedOption => selectedOption;
  set setSelectedOption(Map<String, String> selectedOption) =>
      this.selectedOption = selectedOption;
}

class TypeTimer extends TypeCardReminder {
  TypeTimer({optionsToSelect, label, icon, selectedOption})
      : super(
            label: label,
            icon: icon,
            optionsToSelect: optionsToSelect,
            selectedOption: selectedOption);
}

class TypeQuantity extends TypeCardReminder {
  TypeQuantity({optionsToSelect, label, icon, selectedOption})
      : super(
            label: label,
            icon: icon,
            optionsToSelect: optionsToSelect,
            selectedOption: selectedOption);
}

List<TypeReminder> typeReminders = [
  TypeReminder(
    name: 'tomarAgua',
    label: 'Tomar Água',
    buttonColor: 0xFF2885EB,
    image: 'assets/images/blue_mountain.png',
    cards: [
      new TypeTimer(
          label: 'Selecione o tempo',
          icon: 'assets/icons/clock.png',
          selectedOption: {
            '5': '5 Minutos'
          },
          optionsToSelect: [
            {'5': '5 Minutos'},
            {'15': '15 Minutos'},
            {'30': '30 Minutos'},
            {'60': '1 Hora'},
          ]),
      new TypeQuantity(
          label: 'Selecione a quantidade',
          icon: 'assets/icons/clock.png',
          selectedOption: {
            '50': '50 ML'
          },
          optionsToSelect: [
            {'50': '50 ML'},
            {'100': '100 ML'},
            {'200': '200 ML'},
            {'250': '250 ML'},
          ])
    ],
  ),
  TypeReminder(
    name: 'postura',
    label: 'Postura',
    buttonColor: 0xFFF4CDA5,
    image: 'assets/images/bege_mountain.png',
    cards: [
      new TypeTimer(
          label: 'Selecione o tempo',
          icon: 'assets/icons/clock.png',
          selectedOption:  {'5': '5 Minutos'},
          optionsToSelect: [
            {'5': '5 Minutos'},
            {'15': '15 Minutos'},
            {'30': '30 Minutos'},
            {'60': '1 Hora'},
          ])
    ],
  ),
  TypeReminder(
    name: 'alcoolgel',
    label: 'Álgool Gel',
    buttonColor: 0xFFF57A82,
    image: 'assets/images/red_mountain.png',
    cards: [
      new TypeTimer(
          label: 'Selecione o tempo',
          icon: 'assets/icons/clock.png',
          selectedOption:  {'60': '1 Hora'},
          optionsToSelect: [
            {'60': '1 Hora'},
            {'120': '2 Horas'},
            {'150': '2 Horas e Meia'},
            {'180': '3 Horas'},
          ])
    ],
  ),
  TypeReminder(
    name: 'alongar',
    label: 'Alongar',
    buttonColor: 0xFF5DB5A4,
    image: 'assets/images/green_mountain.png',
    cards: [
      new TypeTimer(
          label: 'Selecione o tempo',
          icon: 'assets/icons/clock.png',
          selectedOption: {'60': '1 Hora'},
          optionsToSelect: [
            {'60': '1 Hora'},
            {'120': '2 Horas'},
            {'150': '2 Horas e Meia'},
            {'180': '3 Horas'},
          ]),
    ],
  ),
];
