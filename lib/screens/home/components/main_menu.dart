import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:car_license_exams/model/screen_arguments.dart';

class MainMenuState extends StatefulWidget {
  @override
  _MainMenuStateState createState() => _MainMenuStateState();
}

class _MainMenuStateState extends State<MainMenuState> {
  final menuByGroup = {
    'rules': [
      {
        'name': '選擇題',
        'iconClass': FontAwesomeIcons.book,
        'filepath': 'assets/data/car/rule_choice.json'
      },
      {
        'name': '是非題',
        'iconClass': FontAwesomeIcons.book,
        'filepath': 'assets/data/car/rule_bool.json'
      }
    ],
    'signs': [
      {
        'name': '選擇題',
        'iconClass': FontAwesomeIcons.sign,
        'filepath': 'assets/data/car/sign_choice.json'
      },
      {
        'name': '是非題',
        'iconClass': FontAwesomeIcons.sign,
        'filepath': 'assets/data/car/sign_bool.json'
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    dynamic menus = <Widget>[];

    menuByGroup.forEach((key, items) {
      // @TODO improve this key
      print("menu group $key");
      print("menu value $items");

      dynamic _cards = <Widget>[];

      items.forEach((item) {
        _cards.add(new GestureDetector(
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 10, 10),
              child: Container(
                child: Center(
                  child: Wrap(children: [
                    Text("${item["name"]}")
                  ]),
                ),
              ),
              decoration: new BoxDecoration(
                border: Border.all(color: Colors.white),
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: Color.fromRGBO(231, 233, 245, 1),
                    blurRadius: 6.0,
                    offset: new Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
            onTap: () async {
              String filePath = item["filepath"];

              print("Card tapped ${item["name"]}");

              // @TODO CircularProgressIndicator();

              if (filePath == '') {
                print('沒檔案');
              }

              String jsonString = await DefaultAssetBundle.of(context)
                  .loadString(item["filepath"]);
              final jsonResult = jsonDecode(jsonString);
              print(jsonResult);
              print(jsonResult);

              if (jsonResult == null) {
                return Scaffold(
                    appBar: AppBar(title: Text(item["name"]), elevation: 0.0),
                    body: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: new IconButton(
                              icon: Icon(Icons.error), color: Colors.red),
                        ),
                        Expanded(child: Text('File not exists'))
                      ],
                    ));
              }

              Navigator.pushNamed(context, '/overview',
                  arguments: ScreenArguments(
                      selectedOverview: item["name"], questions: jsonResult));
            }));
      });

      menus.add(Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
        child: Wrap(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                child: Text(key == 'rules' ? '汽車法規總覽' : '汽車標誌總覽',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(22, 56, 124, 1)))),
            // ..._cards
            new GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 2,
                shrinkWrap: true,
                children: _cards),
          ],
        ),
      ));
    });

    return Wrap(
      children: [...menus],
    );
  }
}
