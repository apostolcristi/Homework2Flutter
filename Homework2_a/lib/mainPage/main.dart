import 'dart:math';

import 'package:flutter/material.dart';

Random random =  Random();
int randomNumber = random.nextInt(100) + 1;

class SecondHomeworkb extends StatelessWidget {
  SecondHomeworkb({Key? key}) : super(key: key);
  dynamic isFocussed = false;

  // TextEditingController textFromInput = new TextEditingController();
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
  String? _buttonText = "Guess";
  bool guessed = false;

  bool _check() {
    final double? enteredValue = double.tryParse(_textController.text);
    _valueToCheck = enteredValue?.toInt();
    bool _valid = false;
    setState(() {
      if (_valueToCheck! > randomNumber) {
        _checkNumber = "Try lower";
        _valid = false;

      } else if (_valueToCheck! < randomNumber) {
        _checkNumber = "Try higher";
        _valid = false;
      } else if (_valueToCheck == randomNumber) {
        _checkNumber = "You guessed right.";
        _valid = true;
      }

      firstPress = true;
    });
    return _valid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Guess my number'),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: const <Widget>[
                    Text(
                      "I'm thinking of a number between 1 and 100",
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32),
                    Text(
                      "It's your turn to guess my number",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                )),
            if (_checkNumber != null)
              Column(
                children: [
                  Text("You tried $_valueToCheck",
                      style: const TextStyle(
                          fontSize: 40,
                          color: Color.fromRGBO(165, 165, 165, 1.0))),
                  Text("$_checkNumber",
                      style: const TextStyle(
                          fontSize: 40,
                          color: Color.fromRGBO(165, 165, 165, 1.0))),
                ],
              ),
            Card(
              margin: const EdgeInsets.all(12),
              elevation: 4,
              color: const Color.fromRGBO(255, 255, 255, 1.0),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: Column(
                  children: <Widget>[
                    const Text(
                      "Try a number!",
                      style: TextStyle(
                          fontSize: 24,
                          color: Color.fromRGBO(165, 165, 165, 1.0)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: FocusScope(
                        child: Focus(
                          onFocusChange: (focus) => isFocussed = focus,
                          child: (TextFormField(
                            autofocus: true,
                            decoration: const InputDecoration(
                              hintText: "enter your number",
                            ),
                            keyboardType: TextInputType.number,
                            controller: _textController,
                          )),
                        ),
                      ),
                    ),
                    if (!guessed)
                      ElevatedButton(
                        onPressed: () => {
                          _check()
                              ? showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('You guessed right'),
                                    content: Text("It was $randomNumber"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => {
                                          setState(() {
                                            randomNumber =
                                                random.nextInt(100) + 1;
                                            _checkNumber = null;
                                            _buttonText = "Guess";
                                          }),
                                          Navigator.pop(context, 'Cancel'),
                                          _textController.clear(),
                                        },
                                        child: const Text('Try again!'),
                                      ),
                                      TextButton(
                                        onPressed: () => {
                                          setState(() {
                                            guessed = !guessed;
                                            _buttonText = "Reset!";
                                          }),
                                          Navigator.pop(context, "Cancel"),
                                          _textController.clear(),
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                )
                              : null,
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xDCE7E7E7))),
                        child: Text(
                          "$_buttonText",
                          style: const TextStyle(color: Colors.black),
                        ),
                      )
                    else
                      ElevatedButton(
                        onPressed: () => {
                          setState(() {
                            randomNumber = random.nextInt(100) + 1;
                            _checkNumber = null;
                            _buttonText = "Guess";
                            guessed = !guessed;
                          }),
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xDCE7E7E7))),
                        child: Text(
                          "$_buttonText",
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
