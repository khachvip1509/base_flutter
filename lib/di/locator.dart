import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled/domain/usecase/delete_item_usecase.dart';
import 'package:untitled/domain/usecase/update_list_item_usecase.dart';

import '../data/local/dao/item_local_datasource.dart';
import '../data/remote/api/api_service.dart';
import '../data/repository/item_repository_impl.dart';
import '../domain/repository/item_repository.dart';
import '../domain/usecase/add_item_usecase.dart';
import '../domain/usecase/get_items_usecase.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // External
  locator.registerLazySingleton(
    () => Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com')),
  );

  // Data sources
  locator.registerLazySingleton(() => ApiService(locator<Dio>()));
  locator.registerLazySingleton(() => ItemLocalDataSource());

  // Repositories
  locator.registerLazySingleton<ItemRepository>(
    () => ItemRepositoryImpl(apiService: locator(), localDataSource: locator()),
  );

  // Use cases
  locator.registerLazySingleton(() => GetItemsUseCase(locator()));
  locator.registerLazySingleton(() => AddItemUseCase(locator()));
  locator.registerLazySingleton(() => DeleteItemUseCase(locator()));
  locator.registerLazySingleton(() => UpdateListItemUseCase(locator()));
}
