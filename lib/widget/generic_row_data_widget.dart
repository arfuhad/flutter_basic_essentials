import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

///[GenericRowDataWidget] is for viewing two widget in row easily

class GenericRowDataWidget extends StatelessWidget {
  GenericRowDataWidget(
      {@required this.leftWidget,
      @required this.rightWidget,
      this.color = false,
      Key? key})
      : assert(leftWidget != null,
            'A non-null Widget must be provided to the GenericDataRow widget'),
        assert(rightWidget != null,
            'A non-null Widget must be provided to the GenericDataRow widget'),
        super(key: key);

  /// The [Widget] of left side or starting side
  final Widget? leftWidget;

  /// The [Widget] of right side or ending side
  final Widget? rightWidget;

  /// The [bool] for getting color [Colors.grey[300]] or [Colors.white]
  final bool color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ? Colors.grey[300] : Colors.white,
      child: Row(
        children: [
          leftWidget as Widget,
          Spacer(),
          rightWidget as Widget,
        ],
      ),
    );
  }
}
