import '../../domain/model/item.dart';
import '../../domain/repository/item_repository.dart';
import '../local/dao/item_local_datasource.dart';
import '../model/item_model.dart';
import '../remote/api/api_service.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ApiService apiService;
  final ItemLocalDataSource localDataSource;

  ItemRepositoryImpl({required this.apiService, required this.localDataSource});

  @override
  Future<List<Item>> fetchRemoteItems() async {
    final models = await apiService.fetchItems();
    return models.map((m) => Item(id: m.id, title: m.title)).toList();
  }

  @override
  Future<void> addLocalItem(Item item) async {
    final model = ItemModel(id: item.id, title: item.title);
    await localDataSource.addItem(model);
  }

  @override
  Future<List<Item>> getLocalItems() async {
    final models = await localDataSource.getAllItems();
    return models.map((m) => Item(id: m.id, title: m.title)).toList();
  }

  @override
  Future<void> deleteLocalItem(String id) async {
    await localDataSource.deleteItem(id);
  }
}
