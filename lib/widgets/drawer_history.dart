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
              children: [
                Icon(Icons.timer_rounded, color: Colors.white),
                Text("No History", style: TextStyle(color: Colors.white)),
              ],
            ),
          )
        : ListView.builder(
            itemCount: equationHistory.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 28, 28, 28),
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Color.fromARGB(255, 135, 134, 139),
                    ),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          equationHistory[index],
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 135, 134, 139),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          resultHistory[index],
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
