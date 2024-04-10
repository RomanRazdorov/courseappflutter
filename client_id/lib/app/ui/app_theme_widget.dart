import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class AppThemeWidget extends StatelessWidget {
  const AppThemeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dark Theme Widget'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                  "Show the power of AdaptiveTheme!.\nSwitch between light and dark mode."),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Light Theme"),
                  const SizedBox(height: 16),
                  Switch(
                    value: AdaptiveTheme.of(context).mode.isDark,
                    onChanged: (value) {
                      if (value) {
                        AdaptiveTheme.of(context).setDark();
                      } else {
                        AdaptiveTheme.of(context).setLight();
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text("Dark Theme"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
