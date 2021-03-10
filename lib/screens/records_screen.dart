import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/record_provider.dart';
import '../widgets/bottom_sheet.dart';
import '../widgets/custom_action_button.dart';
import '../widgets/record_Item.dart';

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
                      child: const Text(
                          'Dear Faisal: \nThere is no Records yet, try start adding some'),
                    ),
                  ),
      ),
      floatingActionButton: CustomActionButton(
        onPressed: () {
          _showTransactionModalSheet(context);
        },
        btnText: 'Add Record', icon: Icons.add,
      ),
    );
  }
}

//Show Bottom Sheet~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
void _showTransactionModalSheet(BuildContext ctx) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: CustomBottomSheet(),
          behavior: HitTestBehavior.opaque,
        );
      });
}
