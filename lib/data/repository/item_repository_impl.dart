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
    print("Anhnt471: getLocalItems");
    print("Anhnt471 : size: " + models.length.toString() +", data:"+ models.toString());
    return models.map((m) => Item(id: m.id, title: m.title)).toList();
  }

  @override
  Future<void> deleteLocalItem(String id) async {
    print("Anhnt471 : delete:"+ id);
    await localDataSource.deleteItem(id);
  }

  @override
  Future<List<Item>> getItems() async {
    //get local first
    final localItems = await localDataSource.getAllItems();

    if (localItems.isNotEmpty) {
      print("Anhnt471: Data local not empty");
      print("Anhnt471 : size: " + localItems.length.toString() +", data:"+ localItems.toString());
      return localItems.map((m) => Item(id: m.id, title: m.title)).toList();
    }

    // Local rỗng -> gọi remote
    print("Anhnt471: Data local empty");
    final remoteItems = await apiService.fetchItems();
    await localDataSource.saveItems(remoteItems);
    return remoteItems.map((m) => Item(id: m.id, title: m.title)).toList();
  }

}
