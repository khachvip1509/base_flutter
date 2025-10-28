import 'package:bloc/bloc.dart';

import '../../../di/locator.dart';
import '../../../domain/model/item.dart';
import '../../../domain/usecase/add_item_usecase.dart';
import '../../../domain/usecase/get_items_usecase.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final GetItemsUseCase getItemsUseCase = locator<GetItemsUseCase>();
  final AddItemUseCase addItemUseCase = locator<AddItemUseCase>();

  ItemBloc() : super(ItemInitial()) {
    on<LoadRemoteItemsEvent>((event, emit) async {
      emit(ItemLoading());
      try {
        final items = await getItemsUseCase();
        emit(ItemLoaded(items));
      } catch (e) {
        emit(ItemError('Failed to load'));
      }
    });

    on<AddLocalItemEvent>((event, emit) async {
      await addItemUseCase(event.item);
      emit(ItemActionSuccess());
    });
  }
}
