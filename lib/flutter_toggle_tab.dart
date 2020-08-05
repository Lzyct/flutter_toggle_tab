// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'button_tab.dart';
import 'data_tab.dart';
import 'helper.dart';

///*********************************************
/// Created by ukieTux on 22/04/2020 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class FlutterToggleTab extends StatefulWidget {
  const FlutterToggleTab({
    Key key,
    @required this.labels,
    @required this.initialLabelIndex,
    @required this.selectedLabelIndex,
    this.width,
    this.selectedDecoration,
    this.unSelectedDecoration,
    this.borderRadius,
    this.selectedTextStyle,
    this.unSelectedTextStyle,
    this.height,
    this.icons,
  }) : super(key: key);

  final List<String> labels;
  final List<Icon> icons;
  final int initialLabelIndex;
  final double width;
  final double height;
  final BoxDecoration selectedDecoration;
  final BoxDecoration unSelectedDecoration;
  final TextStyle selectedTextStyle;
  final TextStyle unSelectedTextStyle;
  final Function(int) selectedLabelIndex;
  final double borderRadius;

  @override
  _FlutterToggleTabState createState() => _FlutterToggleTabState();
}

class _FlutterToggleTabState extends State<FlutterToggleTab> {
  var _labels = List<DataTab>();

  _setDefaultSelected() {
    setState(() {
      if (_labels.isNotEmpty) {
        for (int x = 0; x < _labels.length; x++) {
          _labels[x].title = widget.labels[x];
        }
      } else {
        for (int x = 0; x < widget.labels.length; x++) {
          if (x == widget.initialLabelIndex) {
            _labels.add(DataTab(title: widget.labels[x], isSelected: true));
          } else {
            _labels.add(DataTab(title: widget.labels[x], isSelected: false));
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _setDefaultSelected();
    var width = widget.width != null
        ? widthInPercent(widget.width, context)
        : widthInPercent(100, context);

    return widget.labels.length <= 1
        ? Text(
            "Error : Label should >1",
            style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          )
        : Container(
            width: width,
            height: widget.height ?? 45,
            child: ListView.builder(
              itemCount: _labels.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    ButtonsTab(
                      width: width / widget.labels.length,
                      title: _labels[index].title,
                      icon: widget.icons != null ? widget.icons[index] : null,
                      selectedDecoration: widget.selectedDecoration,
                      unSelectedDecoration: widget.unSelectedDecoration,
                      selectedTextStyle: widget.selectedTextStyle,
                      isFirst: index == 0,
                      isLast: index == _labels.length - 1,
                      unSelectedTextStyle: widget.unSelectedTextStyle,
                      isSelected: _labels[index].isSelected,
                      radius: widget.borderRadius,
                      onPressed: () {
                        try {
                          for (int x = 0; x < _labels.length; x++) {
                            setState(() {
                              if (_labels[index] == _labels[x]) {
                                _labels[x].isSelected = true;
                                widget.selectedLabelIndex(index);
                              } else
                                _labels[x].isSelected = false;
                            });
                          }
                        } catch (e) {
                          print("err : $e");
                        }
                      },
                    ),
                    Visibility(
                      visible: index != _labels.length - 1,
                      child: VerticalDivider(
                        width: 1,
                        indent: 1,
                        endIndent: 1,
                      ),
                    )
                  ],
                );
              },
            ));
  }
}
