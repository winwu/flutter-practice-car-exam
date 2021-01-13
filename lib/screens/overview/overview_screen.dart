// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:car_license_exams/model/screen_arguments.dart';
import 'package:car_license_exams/model/question.dart';

// https://stackoverflow.com/questions/49991444/create-a-rounded-button-button-with-border-radius-in-flutter
class OverviewScreen extends StatefulWidget {
  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  bool _isPreviewAns = false;
  final Map<dynamic, String> _answered = {};

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    final dynamic questions = args.questions;

    print("in build _isPreviewAns ${_isPreviewAns.toString()}");
    print("in build _ansAry ${_answered.toString()}");

    void _togglePreviewAns() {
      setState(() {
        _isPreviewAns = !_isPreviewAns;
      });
    }

    void _setAns(String qn, String val) {
      print("更新題號 $qn 的答案為 $val");
      setState(() {
        _answered[qn] = val;
      });
    }

    _getColorOfOption(Question q, String optionVal) {
      // 正確解答
      final String correctAns = q.ans;
      // 使用者是否已作答
      final isAnswered = _answered.containsKey(q.qn);
      // 使用者提供的答案為何
      final String userAns = isAnswered ? _answered[q.qn] : '';
      final isCorrect = isAnswered && _answered[q.qn] == correctAns;

      if (_isPreviewAns == true) {
        return optionVal == correctAns ? Colors.lightGreen : Colors.white;
      } else {
        if (isCorrect) {
          if (optionVal == correctAns) {
            return Colors.green;
          } else {
            return Colors.white;
          }
        } else {
          if (isAnswered && optionVal == correctAns) {
              // highlight 正確解答
              return Colors.green;
          }
          if (optionVal == userAns) {
            // 使用者選這個項目而且是錯的
            return Colors.red;
          } else {
            // 尚未作答
            return Colors.white;
          }
        }
      }
    }

    _renderCard(Question question, idx) {
      var renders = <Widget>[];

      renders.add(Container(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text("題號 ${question.qn}", style: TextStyle( color: Colors.grey[500], fontWeight: FontWeight.w400, fontSize: 12)),
      ));

      if (question.qType == 'sign') {
        renders.add(
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Image.asset(
                "assets/images/${question.vehicle}/${question.qType}-${question.ansType}/image${question.image}", width: 100, height: 100),
          ));
      }

      renders.add(Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(question.title,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey[800],
                  height: 1.5,
                ))),
      ));

      if (question.ansType == 'choice') {
        // 選擇題

        renders.add(Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: RaisedButton(
                  color: _getColorOfOption(question, '1'),
//                  shape: StadiumBorder(),
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(9.0),
//                      side: BorderSide(color: Colors.red)
//                  ),
                  elevation: 2,
                  child: Row(
                    children: [
                      /* FaIcon(FontAwesomeIcons.check, size: 14,), */
                      Text('1', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold))
                    ],
                  ),
                  onPressed: () {
                    _setAns(question.qn, '1');
                  }),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: RaisedButton(
                  color: _getColorOfOption(question, '2'),
                  // shape: StadiumBorder(),
                  child: Text('2', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    _setAns(question.qn, '2');
                  })
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: RaisedButton(
                  color: _getColorOfOption(question, '3'),
                  // shape: StadiumBorder(),
                  child: Text('3', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    _setAns(question.qn, '3');
                  })
            )
          ],
        ));
      } else {
        // 是非題
        renders.add(Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: RaisedButton(
                color: _getColorOfOption(question, '1'),
                // shape: StadiumBorder(),
                child: Row(
                  children: [
                    /* FaIcon(FontAwesomeIcons.check, size: 14,), */ Text('是', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold))
                  ],
                ),
                onPressed: () {
                  _setAns(question.qn, '1');
                },
              )
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: RaisedButton(
                color: _getColorOfOption(question, '0'),
                // shape: StadiumBorder(),
                child: Text('否', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                onPressed: () {
                  _setAns(question.qn, '0');
                }),
            )
          ],
        ));
      }
      return renders;
    }

    return WillPopScope(
      onWillPop: () async {

        if (_isPreviewAns) {
          return true;
        }

        final ans = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  '你確定嗎要中斷作答嗎?',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color.fromRGBO(22, 56, 124, 1)),),
                content: Text(
                  'Are you sure you want to stop answering these questions?',
                  style: TextStyle(fontSize: 12, color: Colors.grey[800])
                ),
                actions: <Widget>[
                    FlatButton(
                      child: Text('否'),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      }
                    ),
                    FlatButton(
                      child: Text('是'),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    )
                ],
              );
            }
        );

        return ans == true;
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(args.selectedOverview,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(80, 85, 111, 1))),
            elevation: 0.0,
            actions: <Widget>[
              Builder(builder: (BuildContext context) {
                return IconButton(
                    icon: _isPreviewAns == false
                        ? FaIcon(FontAwesomeIcons.eyeSlash)
                        : FaIcon(FontAwesomeIcons.eye),
                    onPressed: _togglePreviewAns,
                    iconSize: 14.0);
              })
            ]),
        body: Builder(
            builder: (context) => Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: (ListView.builder(
                    itemCount: questions == null ? 0 : questions.length,
                    itemBuilder: (BuildContext context, int index) {
                      Question question = Question.fromJson(questions[index]);
                      // print("---question index ${index.toString()}---");
                      // print(jsonEncode(question));
                      return Card(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 15),
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: _renderCard(question, index))));
                    })))),
      )
    );
  }
}
