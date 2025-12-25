import 'package:flutter/material.dart';

class TabViewPage extends StatelessWidget {
  const TabViewPage({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineMedium),
            if (subtitle != null && subtitle!.isNotEmpty)
              Text(
                subtitle![0].toUpperCase() + subtitle!.substring(1),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
          ],
        ),
      ),
    );
  }
}
