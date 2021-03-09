import 'package:flutter/foundation.dart';
import 'package:inventory_record/helpers/dbHelper.dart';
import 'package:provider/provider.dart';
import '../models/record.dart';

class RecordProvider extends ChangeNotifier {
  List<Record> _item = [];

  List<Record> get item {
    // Returning Copy of _items
    return [..._item];
  }

  Record findByID(String id) {
    return _item.firstWhere((record) => record.id == id);
  }

  Future<void> fetchAndSetRecord() async {
    final dataList = await DBHelper.getData();
    _item = dataList.map(
      (currentItem) => Record(
        id: currentItem['id'],
        clientName: currentItem['clientName'],
        purchaseDate: currentItem['purchaseDate'],
        purchasePrice: currentItem['purchasePrice'],
        retailPrice: currentItem['retailPrice'],
      ),
    );
  }
}
