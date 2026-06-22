import 'package:flutter/widgets.dart';

class WidgetListUtils {
  const WidgetListUtils._();

  static List<Widget> insertDividers(List<Widget> widgets, Widget divider) {
    final result = <Widget>[];

    for (var i = 0; i < widgets.length; i++) {
      result.add(widgets[i]);

      if (i < widgets.length - 1) {
        result.add(divider);
      }
    }

    return result;
  }
}
