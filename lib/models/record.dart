import 'package:flutter/foundation.dart';

class Record {
  String id;
  String clientName;
  DateTime purchaseDate;
  double purchasePrice;
  double retailPrice;

  Record({
    @required this.id,
    @required this.clientName,
    @required this.purchaseDate,
    @required this.purchasePrice,
    @required this.retailPrice,
  });
}
