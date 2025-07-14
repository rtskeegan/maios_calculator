import 'package:flutter/material.dart';

class CalcOutput extends StatelessWidget {
  const CalcOutput({
    super.key,
    required this.leftOperand,
    required this.operator,
    required this.rightOperand,
    required this.previousCalculation,
  });

  final String leftOperand;
  final String operator;
  final String rightOperand;
  final String previousCalculation;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: EdgeInsets.all(16),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: IntrinsicWidth(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  textAlign: TextAlign.right,
                  previousCalculation.isEmpty ? "" : previousCalculation,
                  style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 92, 92, 95),
                  ),
                ),
              ),
              Text(
                "$leftOperand$operator$rightOperand".isEmpty
                    ? "0"
                    : "$leftOperand$operator$rightOperand",
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
