import 'package:flutter/material.dart';
import './navbar.dart';

class CustomNavBar extends StatelessWidget {
  // String for text button
  final List<List<String>>? actionWidgetStringsLists;
  // Callback for text button
  final List<List<VoidCallback>>? actionWidgetCallbacksLists;
  // TextStyle for primary big button
  final TextStyle primaryBigTextStyle;
  // TextStyle for primary small buttons
  final TextStyle primarySmallTextStyle;
  // TextStyle for secondary big button
  final TextStyle secondaryBigTextStyle;
  // TextStyle for secondary small buttons
  final TextStyle secondarySmallTextStyle;
  final Color backgroundColor;
  final VoidCallback goBack;
  
 CustomNavBar({
    super.key,
    List<List<String>>? actionWidgetStringsLists,
    List<List<VoidCallback>>? actionWidgetCallbacksLists,
    required this.primaryBigTextStyle,
    required this.primarySmallTextStyle,
    required this.secondaryBigTextStyle,
    required this.secondarySmallTextStyle,
    required this.backgroundColor,
    required this.goBack,
  })  : actionWidgetStringsLists = actionWidgetStringsLists ?? [["Click me, I'm silly!", "Press me for wisdom!"]],
        actionWidgetCallbacksLists = actionWidgetCallbacksLists ?? [[
          () => debugPrint("Clicked: Click me, I'm silly!"),
          () => debugPrint("Clicked: Press me for wisdom!"),
        ]];

  @override
  Widget build(BuildContext context) {
    List<Widget> navbarStack = [];
    double currentHeight = 60.0;

    TextStyle bigTextStyle = primaryBigTextStyle;
    TextStyle smallTextStyle = primarySmallTextStyle;
    for (int i = 0; i < actionWidgetStringsLists!.length; i++) {
       navbarStack.add(
         SizedBox(
           height: currentHeight,
           child: NavBar(
             goBack: goBack,
             actionWidgetStrings:actionWidgetStringsLists![i],
             actionWidgetCallbacks: actionWidgetCallbacksLists![i],
             bigTextStyle: bigTextStyle,
             smallTextStyle: smallTextStyle,
             backgroundColor: backgroundColor,
           )
         )
       );
       if (i == 0) {
         bigTextStyle = secondaryBigTextStyle;
         smallTextStyle = secondarySmallTextStyle;
         currentHeight = 40.0;
       }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: navbarStack
    );
  }
}
