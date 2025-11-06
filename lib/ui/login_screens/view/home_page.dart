import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/model/item.dart';
import '../bloc/item_bloc.dart';
import 'item_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MVVM Anh Template')),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ItemBloc, ItemState>(
              builder: (context, state) {
                if (state is ItemLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ItemLoaded) {
                  return ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];

                      final isSynced = item.id.contains('remote');
                      // tạm phân loại trạng thái (bạn có thể thay bằng flag trong DB)

                      return TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration: Duration(milliseconds: 300 + (index * 80)),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              child: ItemTile(
                                item: item,
                                isSynced: isSynced,
                                onEdit: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Edit ${item.title}'),
                                    ),
                                  );
                                },
                                onDelete: () {
                                  context.read<ItemBloc>().add(
                                    DeleteLocalItemEvent(item),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
                if (state is ItemError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text('Empty'));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final newItem = Item(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: 'Local Item ${DateTime.now().second}',
                    );
                    context.read<ItemBloc>().add(AddLocalItemEvent(newItem));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added local item')),
                    );
                  },
                  child: const Text('Add Local Item'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    context.read<ItemBloc>().add(LoadRemoteItemsEvent());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Refresh item')),
                    );
                  },
                  child: const Text('Refresh Item'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
