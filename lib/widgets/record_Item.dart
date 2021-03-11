import 'package:flutter/material.dart';
import 'package:inventory_record/models/record.dart';

class RecordItem extends StatelessWidget {
  final Record record;
  final Function removeItem;

  RecordItem({@required this.record, @required this.removeItem});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        if (DismissDirection.endToStart == direction) {
          removeItem(context, record.id);
        }
        if (DismissDirection.startToEnd == direction) {

        }
      },
      key: ValueKey(record.id),
      background: slideRightBackground(),
      secondaryBackground: slideLeftBackground(),
      confirmDismiss: (direction) {
          return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Are you Sure?'),
              content: Text('Do you want to remove this record?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('yes'),
                ),
              ],
            ),
          );
      },
      child: ListTile(
        leading: CircleAvatar(
          child: Text('# ${record.id}'),
        ),
        title: Text('Name:' + record.clientName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date of Purchase Date: ' + record.purchaseDate.toString()),
            Text('Purchase Price: ' + record.purchasePrice.toString()),
            Text('Retail Price:' + record.retailPrice.toString()),
          ],
        ),
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.check,
              color: Colors.white,
            ),
            Text(
              " Details",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
}
