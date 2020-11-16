import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder/base/cardConfigurationController.dart';
import 'package:reminder/models/menuCircle.dart';
import 'package:reminder/models/typeReminder.dart';
import 'package:get_it/get_it.dart';

class CardConfigurationWidget extends StatefulWidget {
  TypeReminder typeReminder;
  Key formKey;
  CardConfigurationWidget({Key key, this.typeReminder, this.formKey})
      : super(key: key);

  @override
  _CardConfigurationWidgetState createState() =>
      _CardConfigurationWidgetState();
}

class _CardConfigurationWidgetState extends State<CardConfigurationWidget> {
  bool reminderAtivo = false;
  List<String> dropdownValue = [];
  TypeReminder typeReminder;

  _CardConfigurationWidgetState();
  @override
  void initState() {
    typeReminder = widget.typeReminder;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    final cardConfigurationController =
        GetIt.I.get<CardConfigurationController>();

    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Titulo Lembretes
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 10.0),
                child: Text(
                  typeReminder.getLabel,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),

              // Status
              Spacer(),
              Text(
                'Status',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                width: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: reminderAtivo ? Colors.greenAccent : Colors.grey,
                      boxShadow: [
                        BoxShadow(blurRadius: 3.0, color: Colors.black)
                      ]),
                ),
              )
            ],
          ),

          // REMINDER CARDS
          Column(
            children: typeReminder.cards.map((card) {
              int _indexDropdown = typeReminder.getCards.indexOf(card);
              dropdownValue.add(
                  card.getOptionsToSelect[0].values.first.toString().trim());

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 22.0),
                    child: Text(
                      card.getLabel,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  Center(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      width: width * 0.9,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black38,
                                blurRadius: 5.0,
                                offset: Offset(0, 2))
                          ]),
                      child: Row(
                        children: [
                          Container(
                            alignment: AlignmentDirectional.center,
                            child: Image(image: AssetImage(card.getIcon)),
                            width: width * 0.30,
                            color: Colors.transparent,
                          ),
                          Container(
                            alignment: AlignmentDirectional.center,
                            width: width * 0.60,
                            color: Colors.transparent,

                            // DROPDOWN
                            child: DropdownButton(
                              itemHeight: 100,
                              dropdownColor: Theme.of(context).backgroundColor,
                              style: Theme.of(context).textTheme.headline3,
                              underline: Container(),
                              onChanged: (value) {
                                setState(() {
                                  dropdownValue[_indexDropdown] = value;
                                  var selectedOption = card.getOptionsToSelect
                                      .where((option) =>
                                          option.values.first == value)
                                      .first;
                                  card.selectedOption = selectedOption;
                                });
                              },
                              value: dropdownValue[_indexDropdown],
                              items: card.getOptionsToSelect.map((option) {
                                return DropdownMenuItem(
                                  value: option.values.first.toString().trim(),
                                  child: Text(
                                    option.values.first,
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  onChangeDropdownValue(int dropdown, String newValue) {
    if (dropdown == 1) {
      setState(() {
        //this.dropdownValue1 = newValue;
      });
    }
  }
}
