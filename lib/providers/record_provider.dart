import 'package:flutter/foundation.dart';
import 'package:inventory_record/helpers/dbHelper.dart';
import 'package:provider/provider.dart';
import '../models/record.dart';
import 'package:intl/intl.dart';

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
        id: currentItem['id'].toString(),
        clientName: currentItem['clientName'],
        purchaseDate: DateTime.parse(currentItem['purchaseDate']),
        purchasePrice: double.parse(currentItem['purchasePrice']),
        retailPrice: double.parse(currentItem['retailPrice']),
      ),
    ).toList();
    notifyListeners();
  }

  Future<void> addRecord(Record record) async {
    await DBHelper.insert(
      clientName: record.clientName,
      purchaseDate: record.purchaseDate,
      purchasePrice: record.purchasePrice,
      retailPrice: record.retailPrice,
    );
    notifyListeners();
  }
}
