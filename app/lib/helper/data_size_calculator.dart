import 'dart:convert';

class DataSizeCalculator {
  ///Returns the size of the data in bytes
  int calculateSize(dynamic data) {
    if (data is String) {
      return _calculateStringSize(data);
    } else if (data is int) {
      String strData = data.toString();
      return _calculateStringSize(strData);
    } else if (data is double) {
      String strData = data.toString();
      return _calculateStringSize(strData);
    } else if (data is List || data is Set) {
      return _calculateListSize(data);
    } else if (data is Map) {
      return _calculateMapSize(data);
    } else {
      throw ArgumentError("Unsupported data type");
    }
  }

  int _calculateStringSize(String data) {
    return utf8.encode(data).length;
  }

  int _calculateListSize(Iterable data) {
    int size = 0;
    for (var element in data) {
      size += calculateSize(element);
    }
    return size;
  }

  int _calculateMapSize(Map data) {
    int size = 0;
    data.forEach((key, value) {
      size += calculateSize(key);
      size += calculateSize(value);
    });
    return size;
  }
}
