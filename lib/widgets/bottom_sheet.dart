import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_record/models/record.dart';
import 'package:provider/provider.dart';
import '../providers/record_provider.dart';
import '../widgets/custom_action_button.dart';
import '../helpers/dbHelper.dart';

class CustomBottomSheet extends StatefulWidget {
  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<CustomBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _clientNameController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _retailPriceController = TextEditingController();
  DateTime _purchaseDate;

  void _addRecord() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    if (_purchaseDate == null) {
      _showErrorDialog("Kindly Select Date");
      return;
    }

    Provider.of<RecordProvider>(context, listen: false).addRecord(
      Record(
        id: null,
        clientName: _clientNameController.text,
        purchaseDate: _purchaseDate,
        purchasePrice: double.parse(_purchasePriceController.text),
        retailPrice: double.parse(_retailPriceController.text),
      ),
    );
    Navigator.of(context).pop();
  }

  // Show Alert Dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An error occurred'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Okay'),
          ),
        ],
      ),
    );
  }

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
        child: Form(
          key: _formKey,
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Client Name'),
                controller: _clientNameController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Enter Client Name";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Purchase Price'),
                controller: _purchasePriceController,
                keyboardType: TextInputType.numberWithOptions(signed: false),
                validator: (value) {
                  if (value.isEmpty || int.tryParse(value).isNegative) {
                    return "Purchase price is not valid";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Retail Price'),
                controller: _retailPriceController,
                keyboardType: TextInputType.numberWithOptions(signed: false),
                validator: (value) {
                  if (value.isEmpty || int.tryParse(value).isNegative) {
                    return "Retail price is not valid";
                  }
                  return null;
                },
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
                onPressed: _addRecord,
                btnText: 'Add Now',
                icon: Icons.book,
              )
            ],
          ),
        ),
      ),
    );
  }
}
