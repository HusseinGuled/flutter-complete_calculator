import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:math_expressions/math_expressions.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool flag = false;

  String equation = '';
  String expression = '';

  void btnPressed(String btnTxt) {
    setState(() {
      if (btnTxt == 'C') {
        equation = '';
      } else if (btnTxt == '⌫') {
        equation = equation.substring(0, equation.length - 1);
      } else if (btnTxt == '=') {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          equation = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          equation = 'Error';
        }
      } else {
        if (equation == '0') {
          equation = btnTxt;
        } else {
          equation = equation + btnTxt;
        }
      }
    });
  }

  Widget reusableButton(String btnTxt, double btnWidth, Color btnColor) {
    return Container(
      margin: EdgeInsets.only(left: 15),
      alignment: Alignment.center,
      height: 38,
      width: btnWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11), color: btnColor),
      child: TextButton(
        onPressed: () => btnPressed(btnTxt),
        child: Text(
          btnTxt,
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 19, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color dynamic = flag ? Colors.black : Colors.white;
    Color displayerColor = flag ? Colors.black54 : Colors.white70;

    return Scaffold(
        backgroundColor: flag ? Colors.white : Colors.black,
        appBar: AppBar(
          backgroundColor: flag ? Colors.white : Colors.black,
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: (() {
                  setState((() {
                    flag = !flag;
                  }));
                }),
                icon: flag
                    ? Icon(
                        Icons.brightness_2,
                        color: Colors.black,
                      )
                    : Icon(
                        Icons.sunny,
                        color: Colors.white,
                      ),
              ),
            ),
          ],
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(13)),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                height: 60,
                margin: EdgeInsets.only(top: 20, right: 40),
                child: Text(
                  equation,
                  style: TextStyle(
                      color: displayerColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 23),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  children: [
                    reusableButton('C', 40, Color.fromARGB(255, 130, 131, 134)),
                    reusableButton('⌫', 40, Color.fromARGB(255, 130, 131, 134)),
                    reusableButton('%', 40, Color.fromARGB(255, 130, 131, 134)),
                    reusableButton('÷', 40, Color(0xffC66C07)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    reusableButton('7', 40, Color.fromARGB(255, 55, 55, 57)),
                    reusableButton('8', 40, Color.fromARGB(255, 55, 55, 57)),
                    reusableButton('9', 40, Color.fromARGB(255, 55, 55, 57)),
                    reusableButton('×', 40, Color(0xffC66C07)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    reusableButton('4', 40, Color.fromARGB(255, 55, 55, 57)),
                    reusableButton('5', 40, Color.fromARGB(255, 55, 55, 57)),
                    reusableButton('6', 40, Color.fromARGB(255, 55, 55, 57)),
                    reusableButton('-', 40, Color(0xffC66C07)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    reusableButton('1', 40, Color.fromARGB(255, 55, 55, 57)),
                    reusableButton('2', 40, Color.fromARGB(255, 55, 55, 57)),
                    reusableButton('3', 40, Color.fromARGB(255, 55, 55, 57)),
                    reusableButton('+', 40, Color(0xffC66C07)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    reusableButton('0', 95, Color.fromARGB(255, 55, 55, 57)),
                    reusableButton('.', 40, Color.fromARGB(255, 55, 55, 57)),
                    reusableButton('=', 40, Color(0xffC66C07)),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
