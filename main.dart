import 'package:flutter/material.dart';
import 'dart:convert';

const String menuJson = '''
{
    "Menu1": {
        "submenu1": {
            "innersub1": {
                "Title": "inner title",
                "body": "inner page description"
            },
            "innersub2": {
                "Title": "inner title 2",
                "body": "inner page 2 description"
            }
        },
        "submenu2": {
            "innersub": {
                "Title": "inner title",
                "body": "inner page description"
            }
        }
    },
    "Menu2": {
        "submenu1": {
            "Title": "inner title",
            "body": "inner page description"
        }
    },
    "Menu3": {
        "submenu1": {
            "Title": "inner title",
            "body": "inner page description"
        }
    },
    "Menu4": {
        "submenu1": {
            "Title": "inner title",
            "body": "inner page description"
        }
    },
    "Menu6": {
        "submenu1": {
            "Title": "inner title",
            "body": "inner page description"
        }
    },
    "Menu7": {
        "submenu1": {
            "Title": "inner title",
            "body": "inner page description"
        }
    },
    "Menu8": {
        "submenu1": {
            "Title": "inner title",
            "body": "inner page description"
        }
    }
}
''';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Menus',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuScreen(),
    );
  }
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final Map<String, dynamic> menuData = json.decode(menuJson);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Menu'),
      ),
      body: ListView.builder(
        itemCount: menuData.length,
        itemBuilder: (context, index) {
          final String menuKey = menuData.keys.elementAt(index);
          final Map<String, dynamic> submenu =
              menuData[menuKey] as Map<String, dynamic>;

          final List<Widget> children = submenu.keys.map((subKey) {
            final Map<String, dynamic> subMenu =
                submenu[subKey] as Map<String, dynamic>;
            final String title = subMenu['Title'] ?? 'inner title 2';
            final String body = subMenu['body'] ?? 'inner page 2 description';

            return ListTile(
              title: Text(subKey),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      title: title,
                      body: body,
                    ),
                  ),
                );
              },
            );
          }).toList();

          return ExpansionTile(
            title: Text(menuKey),
            children: children,
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String title;
  final String body;

  DetailScreen({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          children: [Text(body)],
        ));
  }
}
