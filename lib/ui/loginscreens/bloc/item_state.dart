part of 'item_bloc.dart';

abstract class ItemState {}

class ItemInitial extends ItemState {}

class ItemLoading extends ItemState {}

class ItemLoaded extends ItemState {
  final List<Item> items;

  ItemLoaded(this.items);
}

class ItemError extends ItemState {
  final String message;

  ItemError(this.message);
}

class ItemActionSuccess extends ItemState {}
