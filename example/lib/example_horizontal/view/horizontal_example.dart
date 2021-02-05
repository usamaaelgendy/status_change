import 'package:flutter/material.dart';
import 'package:status_change/status_change.dart';

import '../../finish_view.dart';
import '../../helper/constance.dart';
import 'widgets/add_address.dart';
import 'widgets/delevery_time.dart';
import 'widgets/summary.dart';

class HorizontalExample extends StatefulWidget {
  @override
  _HorizontalExampleState createState() => _HorizontalExampleState();
}

class _HorizontalExampleState extends State<HorizontalExample> {
  int _processIndex = 0;
  Pages pages = Pages.DeliveryTime;

  Color getColor(int index) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return Colors.green;
    } else {
      return todoColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "CheckOut",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 100,
            child: StatusChange.tileBuilder(
              theme: StatusChangeThemeData(
                direction: Axis.horizontal,
                connectorTheme: ConnectorThemeData(space: 1.0, thickness: 1.0),
              ),
              builder: StatusChangeTileBuilder.connected(
                itemWidth: (_) =>
                    MediaQuery.of(context).size.width / _processes.length,
                nameWidgetBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      _processes[index],
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
                      border: Border.all(color: Colors.green, width: 1),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return OutlinedDotIndicator(
                      size: 30,
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
                      var gradientColors;
                      gradientColors = [
                        prevColor,
                        Color.lerp(prevColor, color, 0.5)
                      ];
                      return DecoratedLineConnector(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradientColors,
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
          pages == Pages.DeliveryTime
              ? DeliveryTime()
              : pages == Pages.AddAddress
                  ? AddAddress()
                  : Summary()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.skip_next),
        onPressed: () {
          print(_processIndex);
          setState(() {
            _processIndex++;
            if (_processIndex == 1) {
              pages = Pages.AddAddress;
            } else if (_processIndex == 2) {
              pages = Pages.Summary;
            } else if (_processIndex == 3) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FinishView()));
            }
          });
        },
        backgroundColor: inProgressColor,
      ),
    );
  }
}

final _processes = [
  'Delivery',
  'Address',
  'Summer',
];
