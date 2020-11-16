import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder/models/menuCircle.dart';

class MenuCircleWidget extends StatelessWidget {
  MenuCircle menuCircle;
  MenuCircleWidget({Key key, this.menuCircle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Color(menuCircle.getBackgroundColor),
          radius: 35,
          child: Image(
            image: AssetImage(menuCircle.getIcon),
            alignment: AlignmentDirectional.center,
            width: menuCircle.width,
            height: menuCircle.height,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(menuCircle.label, style: Theme.of(context).textTheme.bodyText1)
      ],
    );
  }
}
