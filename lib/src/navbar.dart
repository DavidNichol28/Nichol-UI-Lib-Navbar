import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  // String for text button OR asset path
  final List<String> actionWidgetStrings;

  // Callback for text button
  final List<VoidCallback> actionWidgetCallbacks;

  // Styling
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

  bool _looksLikeAsset(String value) {
    return value.contains('/') &&
        (value.endsWith('.png') ||
            value.endsWith('.jpg') ||
            value.endsWith('.jpeg') ||
            value.endsWith('.webp'));
  }

  Widget _buildNavItem(String value, TextStyle style) {
    // Check if its an icon - not a string
    if (_looksLikeAsset(value)) {
      return Image.asset(
        value,
        height: 32,
        errorBuilder: (_, __, ___) {
          // Return as string if asset not found
          return Text(value, style: style);
        },
      );
    }

    // Returns Text if _looksLikeAsset == false
    return Text(value, style: style);
  }

  @override
  Widget build(BuildContext context) {
    // tappable nav items either Text or Icon
    List<Widget> actions = [
      // Button for dropdown
      PopupMenuButton<int>(
        icon: const Icon(Icons.menu, color: Colors.white, size: 24.0),
        color: backgroundColor,
        itemBuilder: (context) => List.generate(
          actionWidgetStrings.length - 1,
          (index) => PopupMenuItem(
            onTap: () {
              // Off-by-one because first item is title
              actionWidgetCallbacks[index + 1]();
            },
            child: _buildNavItem(
              // Off-by-one because first item is title
              actionWidgetStrings[index + 1],
              smallTextStyle,
            ),
          ),
        ),
      ),
    ];

    return AppBar(
      title: GestureDetector(
        onTap: () {
          actionWidgetCallbacks[0]();
        },
        child: _buildNavItem(actionWidgetStrings[0], bigTextStyle),
      ),
      elevation: 2,
      backgroundColor: backgroundColor,
      actions: actions,
      // Back button
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              goBack();
            },
          );
        },
      ),
    );
  }
}
