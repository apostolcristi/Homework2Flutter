import 'dart:math';

import 'package:flutter/material.dart';



class SecondHomeworkb extends StatelessWidget {
  SecondHomeworkb({Key? key}) : super(key: key);
  dynamic isFocussed = false;
  dynamic textFromInput;
  dynamic valueConverted;

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: mySecondHomeworkbPage());
  }
}

class mySecondHomeworkbPage extends StatefulWidget {
  const mySecondHomeworkbPage({Key? key}) : super(key: key);

  @override
  _mySecondHomeworkbPage createState() => _mySecondHomeworkbPage();
}

class _mySecondHomeworkbPage extends State<mySecondHomeworkbPage> {
  String? _checkNumber;
  final _textController = TextEditingController();
  dynamic isFocussed = false;
  bool firstPress = false;
  num? _valueToCheck;
  String? _textToFill;
  bool guessed = false;

  bool isInteger(num value) =>
      value is int || value == value.roundToDouble();

  void _check() {
    final double? enteredValue = double.tryParse(_textController.text);
    _valueToCheck = enteredValue?.toInt();
    int? _intermediateValue;
    bool isTriangle=false;
    for(int i=0;i<100;i++)
      {
        _intermediateValue=pow(i,3) as int?;
        if(_intermediateValue==_valueToCheck)
            {isTriangle=true;
            break;}
        else {isTriangle=false;}
      }

    setState(() {

        if (isTriangle &&
            isInteger(pow(_valueToCheck!, 1 / 2))) {
          _textToFill = "is both SQUARE and TRIANGULAR";
        }
        else if (isTriangle) {
          _textToFill = "is TRIANGULAR";
        }
        else if (isInteger(pow(_valueToCheck!, 1 / 2))) {
          _textToFill = "is SQUARE";

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Number Shapes'),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children:  <Widget>[
                    const Text(
                      "Please input a number to see if it's a cube or a square, or maybe both",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 32),
                    TextFormField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: "enter your number",
                      ),
                      keyboardType: TextInputType.number,
                      controller: _textController,
                    ),
                  ],
                ),
      ),]),),
        floatingActionButton: FloatingActionButton(
          onPressed: ()=>{_check(),showDialog<String>(
            context: context,
            builder: (BuildContext context) =>
                AlertDialog(
                  title:  Text('$_valueToCheck'),
                  content: Text("$_textToFill"),
                ),
          )},

          child: const Icon(Icons.check),
        ));}}