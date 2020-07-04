import 'package:auto_route/auto_route.dart';
import 'package:coup/components/base/base_load_btn.dart';
import 'package:coup/firebase/callers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class JoinTableDialog extends StatefulWidget {
  const JoinTableDialog({Key key}) : super(key: key);

  @override
  _JoinTableDialogState createState() => _JoinTableDialogState();
}

class _JoinTableDialogState extends State<JoinTableDialog> {
  bool loading = false;
  TextEditingController tableId = TextEditingController(text: 'TJ1036');
  //todo:remove

  joinTableFn() async {
    bool state = false;
    try {
      toggleLoading();
      Fluttertoast.showToast(msg: "Joining Table");
      await FirebaseCallers.joinTableWithId(tableId.text);
      state = true;
      // ExtendedNavigator.rootNavigator.pop(state);
      return state;
    } on PlatformException catch (error) {
      Fluttertoast.showToast(
        msg: error.details['message'],
        backgroundColor: Colors.redAccent,
      );
      print("Join Table 1: $error");
      state = false;
    } on ErrorWidget catch (error) {
      Fluttertoast.showToast(
        msg: error.message,
        backgroundColor: Colors.redAccent,
      );
      print("Join Table 1: $error");
      state = false;
    } catch (error) {
      print("Join Table 2: $error");
      state = false;
    } finally {
      toggleLoading();
    }
  }

  toggleLoading() {
    if (this.mounted)
      setState(() {
        loading = !loading;
      });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.white70,
      child: Container(
        height: 300,
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            TextField(
              inputFormatters: [UpperCaseTextFormatter()],
              textAlign: TextAlign.center,
              controller: tableId,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 1),
                ),
                labelText: 'Table ID',
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            BaseLoadBtn(
              action: joinTableFn,
              text: "Join Table",
              isLoading: loading,
            )
          ],
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
