import 'package:flutter/foundation.dart';
import 'package:inventory_record/helpers/dbHelper.dart';
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
    _item = dataList
        .map(
          (currentItem) => Record(
            id: currentItem['id'].toString(),
            clientName: currentItem['clientName'],
            purchaseDate: DateTime.parse(currentItem['purchaseDate']),
            purchasePrice: double.parse(currentItem['purchasePrice']),
            retailPrice: double.parse(currentItem['retailPrice']),
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> addRecord(Record record) async {
    _item.add(Record(
        id: '${_item.length + 1}',
        clientName: record.clientName,
        purchaseDate: record.purchaseDate,
        purchasePrice: record.purchasePrice,
        retailPrice: record.retailPrice));

    await DBHelper.insert(
      clientName: record.clientName,
      purchaseDate: record.purchaseDate,
      purchasePrice: record.purchasePrice,
      retailPrice: record.retailPrice,
    );
    notifyListeners();
  }

  Future<void> deleteRecord(String id) async {
    _item.removeWhere((element) => element.id == id);

    await DBHelper.remove(id);
    print("Record Provider: "+id+" is deleted");
    notifyListeners();
  }



}
