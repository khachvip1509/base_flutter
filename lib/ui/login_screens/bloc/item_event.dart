part of 'item_bloc.dart';

abstract class ItemEvent {}

class LoadRemoteItemsEvent extends ItemEvent {}

class AddLocalItemEvent extends ItemEvent {
  final Item item;

  AddLocalItemEvent(this.item);
}

class DeleteLocalItemEvent extends ItemEvent {
  final Item item;
  DeleteLocalItemEvent(this.item);
}