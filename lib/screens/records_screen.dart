import 'package:flutter/material.dart';
import 'package:inventory_record/providers/record.dart';
import '../models/record.dart';
import 'package:inventory_record/widgets/record_Item.dart';
import 'package:provider/provider.dart';

class RecordsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Records'),
      ),
      body: FutureBuilder(
        future: Provider.of<RecordProvider>(context, listen: false)
            .fetchAndSetRecord(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<RecordProvider>(
                    builder: (context, currentRecord, child) =>
                        currentRecord.item.length <= 0
                            ? child
                            : ListView.builder(
                                itemCount: currentRecord.item.length,
                                itemBuilder: (ctx, i) =>
                                    RecordItem(currentRecord.item[i]),
                              ),
                    child: Center(
                      child: const Text('Got no places yes, start adding some'),
                    ),
                  ),
      ),
    );
  }
}
