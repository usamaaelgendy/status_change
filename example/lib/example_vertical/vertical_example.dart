import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:status_change/status_change.dart';

import '../finish_view.dart';
import '../helper/constance.dart';

class VerticalExample extends StatefulWidget {
  const VerticalExample({super.key});

  @override
  VerticalExampleState createState() => VerticalExampleState();
}

class VerticalExampleState extends State<VerticalExample> {
  int _processIndex = 0;

  Color getColor(int index) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return Colors.teal;
    } else {
      return todoColor;
    }
  }

  final _processes = [
    'Order Signed',
    'Order Processed',
    'Shipped ',
    'Out for delivery ',
    'Delivered ',
  ];

  final _content = [
    '23/12',
    '23/12',
    '23/12',
    '23/12',
    '23/12',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          "Order Status",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: StatusChange.tileBuilder(
                theme: StatusChangeThemeData(
                  direction: Axis.vertical,
                  connectorTheme:
                      const ConnectorThemeData(space: 1.0, thickness: 1.0),
                ),
                builder: StatusChangeTileBuilder.connected(
                  // itemWidth: (_) =>
                  //     MediaQuery.of(context).size.width / _processes.length,
                  nodeAlign: StatusChangeNodeAlign.basic,
                  contentWidgetBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        _processes[index],
                        style: const TextStyle(
                          color: Colors
                              .teal, // change color with dynamic color --> can find it with example section
                        ),
                      ),
                    );
                  },
                  nameWidgetBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        _content[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: getColor(index),
                        ),
                      ),
                    );
                  },
                  indicatorWidgetBuilder: (_, index) {
                    if (index <= _processIndex) {
                      return DotIndicator(
                        size: 35.0,
                        border:
                            Border.all(color: Colors.teal.shade400, width: 1),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.teal.shade400,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const OutlinedDotIndicator(
                        size: 35,
                        borderWidth: 1.0,
                        color: todoColor,
                      );
                    }
                  },
                  lineWidgetBuilder: (index) {
                    if (index > 0) {
                      if (index == _processIndex) {
                        final prevColor = getColor(index - 1);
                        final color = getColor(index);
                        return DecoratedLineConnector(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                          prevColor,
                          color
                        ]
                            ),
                          ),
                        );
                      } else {
                        return SolidLineConnector(
                          color: getColor(index),
                        );
                      }
                    } else {
                      return null;
                    }
                  },
                  itemCount: _processes.length,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (kDebugMode) {
            print(_processIndex);
          }
          setState(() {
            _processIndex++;

            if (_processIndex == 5) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FinishView()));
            }
          });
        },
        backgroundColor: inProgressColor,
        child: const Icon(Icons.skip_next),
      ),
    );
  }
}
