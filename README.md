<p align="center">Easy timeline View package for Flutter! 👌</p>

> ***Caveat***: This package is an early stage. Not enough testing has been done to guarantee stability. Some APIs may change.

# Examples

| Virtical Status Change | Horizontal Status Change
| - | - |
| [![status_change](https://user-images.githubusercontent.com/48976562/107017567-f9053700-67a7-11eb-95bb-9d78beca7aa4.gif)| [![status_change](https://user-images.githubusercontent.com/48976562/107024942-623d7800-67b1-11eb-8d38-d3cec478242f.gif)]

# Features

### The Status Change and each components are all WIDGET.

* Vertical, horizontal direction.
* Combination with Flutter widgets(Row, Column, CustomScrollView, etc).

## Installation

#### 1. Depend on it

Add this to your package's pubspec.yaml file:
``` yaml
dependencies:
  status_change: ^[latest_version]
```

#### 2. Install it
You can install packages from the command line:

with Flutter:
``` console
$ flutter pub get
```

Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.

#### 3. Import it
Now in your Dart code, you can use:
``` dart
import 'package:status_change/status_change.dart';
```

## Basic Usage

``` dart
StatusChange.tileBuilder(
                theme: StatusChangeThemeData(
                  direction: Axis.vertical,
                  connectorTheme:
                      ConnectorThemeData(space: 1.0, thickness: 1.0),
                ),
                builder: StatusChangeTileBuilder.connected(
                  itemWidth: (_) =>
                      MediaQuery.of(context).size.width / _processes.length,
                  contentWidgetBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'add content here',
                        style: TextStyle(
                          color: Colors
                              .blue, // change color with dynamic color --> can find it with example section
                        ),
                      ),
                    );
                  },
                  nameWidgetBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'your text ',
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
```