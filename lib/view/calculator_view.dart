import 'package:flutter/material.dart';

import 'package:maios_calculator/widgets/drawer_history.dart';
import 'package:maios_calculator/widgets/calc_output.dart';
import 'package:maios_calculator/data/button_values.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  String leftOperand = "";
  String operator = "";
  String rightOperand = "";
  String previousCalculation = "";
  List<String> equationHistory = [];
  List<String> resultHistory = [];
  List<String> calcOption = [];

  @override
  void initState() {
    super.initState();
    calcOption = Btn.buttonValuesAC;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    if (leftOperand == "0" || leftOperand.isEmpty) {
      calcOption = Btn.buttonValuesAC;
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 170, 11)),
      ),
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: Color.fromARGB(255, 28, 28, 28),
          child: DrawerHistory(
            equationHistory: equationHistory,
            resultHistory: resultHistory,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Column(
            children: [
              Expanded(
                child: CalcOutput(
                  leftOperand: leftOperand,
                  operator: operator,
                  rightOperand: rightOperand,
                  previousCalculation: previousCalculation,
                ),
              ),
              Wrap(
                runSpacing: 10.0,
                children: calcOption
                    .map(
                      (value) => SizedBox(
                        width: screenSize.width / 4.3,
                        height: screenSize.width / 4.7,
                        child: buildButton(value),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(value) {
    return Material(
      color: getBtnColor(value),
      clipBehavior: Clip.hardEdge,
      shape: CircleBorder(),
      child: InkWell(
        onTap: () => onBtnTap(value),
        child: Center(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Calculator functionality
  void onBtnTap(value) {
    if (value == Btn.ac) {
      allClear();
      return;
    }
    if (value == Btn.del) {
      delete();
      return;
    }
    if (value == Btn.posNeg) {
      positiveNegative();
      return;
    }
    if (value == Btn.percent) {
      convertToPercentage();
      return;
    }
    if (value == Btn.equal) {
      calculate();
      return;
    }
    if (value == Btn.calcButton) {
      return;
    }
    appendValue(value);
  }

  //Calculate
  void calculate() {
    if (leftOperand.isEmpty || operator.isEmpty || rightOperand.isEmpty) {
      return;
    }
    final double left = double.parse(leftOperand);
    final double right = double.parse(rightOperand);
    String leftString = left.toString();
    String rightString = right.toString();
    var result = 0.0;
    leftString.endsWith(".0")
        ? leftString = leftString.substring(0, leftString.length - 2)
        : leftString;
    rightString.endsWith(".0")
        ? rightString = rightString.substring(0, rightString.length - 2)
        : rightString;
    previousCalculation = "$leftString$operator$rightString";

    switch (operator) {
      case Btn.add:
        result = left + right;
        break;
      case Btn.subtract:
        result = left - right;
        break;
      case Btn.multiply:
        result = left * right;
        break;
      case Btn.divide:
        //Cannot divide by 0
        if (right == 0) {
          break;
        }
        result = left / right;
        break;
      default:
    }
    setState(() {
      calcOption = Btn.buttonValuesAC;
      leftOperand = result.toString();
      if (leftOperand.endsWith(".0")) {
        leftOperand = leftOperand.substring(0, leftOperand.length - 2);
      }
      if (operator == Btn.divide && right == 0) {
        leftOperand = "Cannot divide by 0";
        operator = "";
        rightOperand = "";
        return;
      }
      equationHistory.add(previousCalculation);
      resultHistory.add(result.toString());
      operator = "";
      rightOperand = "";
    });
  }

  //Percentage
  void convertToPercentage() {
    if (leftOperand.isEmpty || leftOperand == "0") {
      return;
    }
    if (leftOperand.isNotEmpty &&
        operator.isNotEmpty &&
        rightOperand.isNotEmpty) {
      calculate();
    }
    if (operator.isNotEmpty) {
      //Cannot be converted to percentage, return
      return;
    }
    final number = double.parse(leftOperand);
    setState(() {
      leftOperand = "${number / 100}";
      operator = "";
      rightOperand = "";
    });
  }

  //Positive Negative
  void positiveNegative() {
    String number;
    num? result;
    //Determine which side of equation to apply pos/neg
    if (leftOperand.isNotEmpty && operator.isEmpty && rightOperand.isEmpty) {
      number = leftOperand;
    } else if (leftOperand.isNotEmpty &&
        operator.isNotEmpty &&
        rightOperand.isEmpty) {
      number = leftOperand;
    } else if (leftOperand.isNotEmpty &&
        operator.isNotEmpty &&
        rightOperand.isNotEmpty) {
      number = rightOperand;
    } else {
      return;
    }
    if (int.tryParse(number) == double.tryParse(number)) {
      result = int.tryParse(number);
    } else {
      result = double.tryParse(number);
    }
    //There is certainly a way to set the appropriate side to pos/neg without repeating the if checks
    if (leftOperand.isNotEmpty && operator.isEmpty && rightOperand.isEmpty) {
      leftOperand = (result! * -1).toString();
    } else if (leftOperand.isNotEmpty &&
        operator.isNotEmpty &&
        rightOperand.isEmpty) {
      leftOperand = (result! * -1).toString();
    } else if (leftOperand.isNotEmpty &&
        operator.isNotEmpty &&
        rightOperand.isNotEmpty) {
      rightOperand = (result! * -1).toString();
    }
    setState(() {});
  }

  //Delete
  void delete() {
    setState(() {
      if (rightOperand.isNotEmpty) {
        rightOperand = rightOperand.substring(0, rightOperand.length - 1);
      } else if (operator.isNotEmpty) {
        operator = "";
      } else if (leftOperand.isNotEmpty) {
        leftOperand = leftOperand.substring(0, leftOperand.length - 1);
      }
    });
  }

  //All Clear
  void allClear() {
    setState(() {
      leftOperand = "";
      operator = "";
      rightOperand = "";
      previousCalculation = "";
    });
  }

  void appendValue(value) {
    if (leftOperand == "Cannot divide by 0") {
      allClear();
      if (int.tryParse(value) != null) {
        leftOperand += value;
      }
      return;
    }
    // If operator is tapped and decimal is NOT tapped
    if (value != Btn.decimal && int.tryParse(value) == null) {
      if (operator.isNotEmpty && rightOperand.isNotEmpty) {
        calculate();
      }
      operator = value;
    } else if (leftOperand.isEmpty || operator.isEmpty) {
      if (value == Btn.decimal && leftOperand.contains(Btn.decimal)) return;
      if (value == Btn.decimal &&
          (leftOperand.isEmpty || leftOperand == Btn.n0)) {
        value = "0.";
      }
      leftOperand += value;
    } else if (rightOperand.isEmpty || operator.isNotEmpty) {
      if (value == Btn.decimal && rightOperand.contains(Btn.decimal)) return;
      if (value == Btn.decimal &&
          (rightOperand.isEmpty || rightOperand == Btn.n0)) {
        value = "0.";
      }
      rightOperand += value;
    }
    setState(() {
      calcOption = Btn.buttonValuesDel;
    });
  }

  // Determine button color based on button contents
  Color getBtnColor(value) {
    return [Btn.ac, Btn.del, Btn.posNeg, Btn.percent].contains(value)
        ? Color.fromARGB(255, 92, 92, 95)
        : [
            Btn.divide,
            Btn.multiply,
            Btn.subtract,
            Btn.add,
            Btn.equal,
          ].contains(value)
        ? Color.fromARGB(255, 255, 159, 10)
        : Color.fromARGB(255, 42, 42, 44);
  }
}
