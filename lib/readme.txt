# Flutter MVVM + UseCase + Repository Template


Template features
- Flutter project skeleton using MVVM (ViewModel via Bloc), UseCase, Repository pattern
- Networking: Dio
- State management: Bloc (flutter_bloc)
- Local DB: Hive
- Single `di` folder using `get_it` for dependency injection
- Demo app implements: API list fetch (using a placeholder public API) + CRUD local items with Hive


---


## How to use
1. Create a new flutter project (or clone this structure into your project root).
2. Replace your `pubspec.yaml` with the provided dependencies and run `flutter pub get`.
3. Run the app: `flutter run`.


> Note: Hive adapter registration and Hive.initFlutter() are already called in `main.dart`.


---


## Files overview (under `lib/`)


```
lib/
├─ main.dart
├─ di/
│ └─ locator.dart
├─ data/
│ ├─ models/
│ │ └─ item_model.dart
│ ├─ local/
│ │ └─ item_local_datasource.dart
│ ├─ remote/
│ │ └─ api_service.dart
│ └─ repository/
│ └─ item_repository_impl.dart
├─ domain/
│ ├─ models/
│ │ └─ item.dart
│ ├─ repository/
│ │ └─ item_repository.dart
│ └─ usecase/
│ ├─ get_items_usecase.dart
│ └─ add_item_usecase.dart
├─ presentation/
│ ├─ bloc/
│ │ └─ item_bloc.dart
│ ├─ pages/
│ │ └─ home_page.dart
│ └─ widgets/
│ └─ item_tile.dart
└─ utils/
└─ constants.dart
```


---