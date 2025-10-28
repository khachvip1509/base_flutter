import 'package:bloc/bloc.dart';
import 'package:untitled/domain/usecase/delete_item_usecase.dart';
import 'package:untitled/domain/usecase/update_list_item_usecase.dart';

import '../../../di/locator.dart';
import '../../../domain/model/item.dart';
import '../../../domain/usecase/add_item_usecase.dart';
import '../../../domain/usecase/get_items_usecase.dart';

part 'item_event.dart';

part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final GetItemsUseCase getItemsUseCase = locator<GetItemsUseCase>();
  final AddItemUseCase addItemUseCase = locator<AddItemUseCase>();
  final DeleteItemUseCase deleteLocalItemUseCase = locator<DeleteItemUseCase>();
  final UpdateListItemUseCase updateListItemUseCase = locator<UpdateListItemUseCase>();

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

    on<DeleteLocalItemEvent>((event, emit) async {
      try {
        await deleteLocalItemUseCase(event.item);
        final updatedItems = await updateListItemUseCase();
        emit(ItemLoaded(updatedItems));
      } catch (e) {
        emit(ItemError('Delete failed $e'));
      }
    });

  }
}
