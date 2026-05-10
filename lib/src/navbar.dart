import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  // String for text button
  final List<String> actionWidgetStrings;
  // Callback for text button
  final List<VoidCallback> actionWidgetCallbacks;
  // TextStyle for big button
  final TextStyle bigTextStyle;
  final TextStyle smallTextStyle;
  final Color backgroundColor;
  final VoidCallback goBack;
  
  
  const NavBar({
      super.key,
      required this.actionWidgetStrings,
      required this.actionWidgetCallbacks,
      required this.bigTextStyle,
      required this.smallTextStyle,
      required this.backgroundColor,
      required this.goBack,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [
      PopupMenuButton<int>(
        icon: Icon(Icons.menu, color: Colors.white, size: 24.0), // Adjust icon color if needed
        color: backgroundColor,  // ✅ Matches navbar background
        itemBuilder: (context) => List.generate(
          actionWidgetStrings.length - 1,
          (index) => PopupMenuItem(
            child: Text(
              style: smallTextStyle,
              actionWidgetStrings[index + 1]
            ),
            onTap: () {
              actionWidgetCallbacks[index + 1]();
            }
        )),
      ),
    ];
    return AppBar(
      title: GestureDetector(
        onTap: () {
          actionWidgetCallbacks[0]();
        },
        child: Text(
          style: bigTextStyle,
          actionWidgetStrings[0]
        )
      ),
      elevation: 2,
      backgroundColor: backgroundColor,
      actions: actions,
  leading: Builder(
    builder: (BuildContext context) {
      return IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {

          // print("FUCK YOU MAN");
          goBack();
          }
      );
    },
  ),
    );
  }
}
