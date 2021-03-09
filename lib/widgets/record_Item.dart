import 'package:flutter/material.dart';
import 'package:inventory_record/models/record.dart';

class RecordItem extends StatelessWidget {
  final Record _record;
  RecordItem(this._record);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text('#'+_record.id),
      ),
      title: Text('Name:'+_record.clientName),
      subtitle: Row(
        children: [
          Text('Date of Purchase Date: '+_record.purchaseDate.toString()),
          Text('Purchase Price: '+_record.purchasePrice.toString()),
          Text('Retail Price:'+_record.retailPrice.toString()),
        ],
      ),
    );
  }
}
