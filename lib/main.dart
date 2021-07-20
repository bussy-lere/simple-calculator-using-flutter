import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'calculator',
      theme: ThemeData(
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String expression = '';
  String history = '';

  void addExpression(String text) {
    setState(() {
      expression += text;
    });
  }

  void clearExpression(String text) {
    setState(() {
      expression = '';
    });
  }

  void clearAllExpression(String text) {
    setState(() {
      expression = '';
      history = '';
    });
  }

  void evaluate(String text) {
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    setState(() {
      history = expression;
      expression = eval.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  history,
                  style: TextStyle(color: Colors.grey, fontSize: 17),
                ),
                alignment: Alignment.bottomRight,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  expression,
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                alignment: Alignment.bottomRight,
              ),
              Container(
                color: Colors.white,
                height: 1,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CalcButton(
                    label: 'AC',
                    callback: clearAllExpression,
                  ),
                  CalcButton(label: 'C', callback: clearExpression),
                  CalcButton(label: '/', callback: addExpression),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CalcButton(label: '7', callback: addExpression),
                  CalcButton(label: '8', callback: addExpression),
                  CalcButton(label: '9', callback: addExpression),
                  CalcButton(label: '*', callback: addExpression),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CalcButton(label: '4', callback: addExpression),
                  CalcButton(label: '5', callback: addExpression),
                  CalcButton(label: '6', callback: addExpression),
                  CalcButton(label: '-', callback: addExpression),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CalcButton(
                    label: '1',
                    callback: addExpression,
                  ),
                  CalcButton(label: '2', callback: addExpression),
                  CalcButton(label: '3', callback: addExpression),
                  CalcButton(label: '+', callback: addExpression),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CalcButton(label: '00', callback: addExpression),
                  CalcButton(label: '0', callback: addExpression),
                  CalcButton(label: '.', callback: addExpression),
                  CalcButton(
                    label: '=',
                    callback: evaluate,
                  ),
                ],
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CalcButton extends StatelessWidget {
  final String label;
  final Function callback;

  CalcButton({this.label, this.callback});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        callback(label);
      },
    );
  }
}
