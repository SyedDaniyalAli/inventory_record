import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_record/widgets/custom_action_button.dart';

class CustomBottomSheet extends StatefulWidget {
  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<CustomBottomSheet> {
  final _clientNameController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _retailPriceController = TextEditingController();
  DateTime _purchaseDate;

  @override
  Widget build(BuildContext context) {
    //Function to Show Date Picker~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    void _displayDatePicker() {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2019),
              lastDate: DateTime.now())
          .then((pickedDate) {
        if (pickedDate == null) return;
        setState(() {
          _purchaseDate = pickedDate;
        });
      });
    }

    return Card(
      child: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
          bottom: MediaQuery.of(context).padding.bottom + 50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Records',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 24,
                  fontStyle: FontStyle.italic),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Client Name'),
              controller: _clientNameController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Purchase Price'),
              controller: _purchasePriceController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Retail Price'),
              controller: _retailPriceController,
            ),

            //Select Date~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _purchaseDate == null
                          ? "No date chosen!"
                          : "Selected Date: ${DateFormat.yMd().format(_purchaseDate)}",
                    ),
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.date_range),
                    label: Text("Chose Date"),
                    onPressed: _displayDatePicker,
                  )
                ],
              ),
            ),
            //  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            CustomActionButton(
              onPressed: () {},
              btnText: 'Add Now',
              icon: Icons.book,
            )
          ],
        ),
      ),
    );
  }
}
