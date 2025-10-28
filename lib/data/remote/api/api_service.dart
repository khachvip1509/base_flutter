import 'package:dio/dio.dart';

import '../../model/item_model.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<List<ItemModel>> fetchItems() async {
    try {
      final response = await dio.get(
        "https://jsonplaceholder.typicode.com/todos?_limit=10",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json; charset=utf-8",
          },
          validateStatus: (status) {
            return status != null && status < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data as List;
        return data
            .map((json) => ItemModel(id: json["id"].toString(), title: json["title"].toString()))
            .toList();
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      print("a $e");
      rethrow;
    }
  }
}
