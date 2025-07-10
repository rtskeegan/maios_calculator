import 'package:flutter/material.dart';

class DrawerHistory extends StatelessWidget {
  const DrawerHistory({
    super.key,
    required this.equationHistory,
    required this.resultHistory,
  });

  final List<String> equationHistory;
  final List<String> resultHistory;

  @override
  Widget build(BuildContext context) {
    return equationHistory.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Icon(Icons.timer_rounded), Text("No History")],
            ),
          )
        : ListView.builder(
            itemCount: equationHistory.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    Center(child: Text(equationHistory[index])),
                    Center(child: Text(resultHistory[index])),
                  ],
                ),
              );
            },
          );
  }
}
