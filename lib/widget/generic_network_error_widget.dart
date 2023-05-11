import 'package:flutter/material.dart';

class GenericNetworkErrorWidget extends StatefulWidget {
  final Function? checkingFunction;
  GenericNetworkErrorWidget({@required this.checkingFunction, Key? key})
      : assert(checkingFunction != null,
            'A non-null function must be provided to the GenericNetworkErrorView widget '),
        super(key: key);

  @override
  _GenericNetworkErrorWidgetState createState() =>
      _GenericNetworkErrorWidgetState();
}

class _GenericNetworkErrorWidgetState extends State<GenericNetworkErrorWidget> {
  late Function checkingFunction;

  @override
  void initState() {
    super.initState();
    checkingFunction = widget.checkingFunction as Function;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          child: Center(
        child: Text(
          "Please check your Network.\nTap To try again..",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      )),
      onTap: () {
        // _isLoaded = false;
        return _givenFunction();
      },
    );
  }

  void _givenFunction() {
    // ignore: unnecessary_statements
    checkingFunction;
  }
}
