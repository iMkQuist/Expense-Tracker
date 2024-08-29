import 'package:flutter/material.dart';
import 'package:expense_tracker/ui/shared/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer(
    BuildContext context, {
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: backgroundColor,
            ),
            child: Image.asset(
              'assets/wallet.png',
              width: 100,
              height: 100,
              alignment: Alignment.centerLeft,
            ),
          ),
          ListTile(
            title: const Text('Chart'),
            leading: const Icon(Icons.pie_chart),
            onTap: () {
              Navigator.of(context).pushNamed("chart");
            },
          ),
          const Divider(
            thickness: 1,
          ),
          ListTile(
            title: const Text('Reminder'),
            leading: const Icon(Icons.notifications),
            onTap: () {
              Navigator.of(context).pushNamed("reminder");
            },
          ),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
