import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/model/item.dart';
import '../bloc/item_bloc.dart';
import 'item_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ItemBloc()..add(LoadRemoteItemsEvent()),
      child: Scaffold(
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
                      itemBuilder: (context, index) =>
                          ItemTile(item: state.items[index]),
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
              child: ElevatedButton(
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
            ),
          ],
        ),
      ),
    );
  }
}
