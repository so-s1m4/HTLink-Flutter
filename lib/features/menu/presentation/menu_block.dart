import 'package:flutter/material.dart';
import 'package:htlink/core/theme/app_styles.dart';
import 'package:htlink/core/utils/widget_list_utils.dart';

class Menublock extends StatelessWidget {
  const Menublock({super.key, required this.children, this.title});

  final List<Widget> children;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(left: 22, bottom: 5),
            child: Text(
              title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: blockStyle,
          child: Column(
            children: children.length > 1
                ? WidgetListUtils.insertDividers(
                    children,
                    const FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Divider(color: Colors.grey, height: 1),
                    ),
                  )
                : children,
          ),
        ),
      ],
    );
  }
}
