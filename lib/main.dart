import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white))),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "0";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        output = "0";
      } else if (buttonText == "=") {
        try {
          output = evaluateExpression(output);
        } catch (e) {
          output = "error";
        }
      } else {
        if (output == "0") {
          output = buttonText;
        } else {
          output += buttonText;
        }
      }
    });
  }

  String evaluateExpression(String expression) {
    final parsedExpression = Expression.parse(expression);
    final evaluator = ExpressionEvaluator();
    final result = evaluator.eval(parsedExpression, {});
    return result.toString();
  }

  Widget buildButton(String buttonText, Color color,
      {double widthFactor = 1.0}) {
    return Expanded(
        flex: widthFactor.toInt(),
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 22),
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                  elevation: 0),
              onPressed: () => buttonPressed(buttonText),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Container(
              padding: EdgeInsets.only(right: 24.0, bottom: 24.0),
              alignment: Alignment.bottomRight,
              child: Text(
                output,
                style: TextStyle(fontSize: 80.0, color: Colors.white),
              ),
            )),
            Column(
              children: [
                Row(
                  children: [
                    buildButton("C", Colors.grey.shade600),
                    buildButton("+/-", Colors.grey.shade600),
                    buildButton("%", Colors.grey.shade600),
                    buildButton("/", Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton("7", Colors.grey.shade700),
                    buildButton("8", Colors.grey.shade700),
                    buildButton("9", Colors.grey.shade700),
                    buildButton("*", Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton("4", Colors.grey.shade700),
                    buildButton("5", Colors.grey.shade700),
                    buildButton("6", Colors.grey.shade700),
                    buildButton("-", Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton("1", Colors.grey.shade700),
                    buildButton("2", Colors.grey.shade700),
                    buildButton("3", Colors.grey.shade700),
                    buildButton("+", Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton("0", Colors.grey.shade700),
                    buildButton(".", Colors.grey.shade700),
                    buildButton("=", Colors.orange),
                  ],
                )
              ],
            )
          ],
        ));
  }
}
