import 'package:flutter/material.dart';
import 'package:outlook/constants.dart';

typedef void DialogyCompCallback(Map result);

class DialogyComp extends StatefulWidget {
  final DialogyCompCallback onSubmit;
  final String title;
  final String desc;
  final String buttonlabel;
  DialogyComp({this.onSubmit, this.title, this.desc, this.buttonlabel});

  @override
  DialogyDialogState createState() => DialogyDialogState();
}

class DialogyDialogState extends State<DialogyComp> {
  Map value = {};
  TextEditingController controller = new TextEditingController();
  onSearchTextChanged(String text) async {
    print(text);
    // _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Center(
              child: Text(
            widget.title,
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              // fontSize: 12
            ),
          )),
          SizedBox(
            height: 10,
          ),
        ],
      ),
      content: Container(
          width: double.maxFinite,
          child: Text(
            widget.desc,
            textAlign: TextAlign.center,
          )),
      actions: <Widget>[
        FlatButton(
          child: Text('CANCEL', style: TextStyle(color: Colors.redAccent)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(
            '${widget.buttonlabel}',
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: () {
            Navigator.pop(context);

            widget.onSubmit(value);
          },
        )
      ],
    );
  }
}
