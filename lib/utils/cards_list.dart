import 'package:flutter/material.dart';
import 'package:jellywaves/services/auth.dart';
import 'package:jellywaves/services/jellyfin_api.dart';
import 'package:jellywaves/models/jellyfin_items.dart';
import 'package:jellywaves/utils/cards.dart';

class CardsList<T extends JellyfinItem> extends StatefulWidget {
  final String? itemType;
  final String? fields;
  final String endpoint;
  final T Function(Map<String, dynamic>) fromJson;
  final String Function(T)? subtitleBuilder;

  const CardsList({
    super.key,
    this.itemType,
    this.fields,
    required this.endpoint,
    required this.fromJson,
    this.subtitleBuilder
  });

  @override 
  State<CardsList<T>> createState() => _CardsListState<T>();
}

class _CardsListState<T extends JellyfinItem> extends State<CardsList<T>> {
  late final Future<_ItemsData<T>> _itemsFuture;
  final authStorage = AuthStorage();

  Future<_ItemsData<T>> _loadItems() async {
    final accessToken = await authStorage.getToken();
    final userId = await authStorage.getUserId();

    final items = await JellyfinApi.instance.getItems(
      accessToken: accessToken!,
      userId: userId!,
      itemType: widget.itemType,
      fields: widget.fields,
      endpoint: widget.endpoint,
      fromJson: widget.fromJson
    );

    return _ItemsData<T>(
      items: items,
      accessToken: accessToken,
    );
  }

  @override 
  void initState() {
    super.initState();

    _itemsFuture = _loadItems();
  }

  @override 
  Widget build(BuildContext context) {
    return FutureBuilder<_ItemsData>(
      future: _itemsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator()
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Could not load Items:\n${snapshot.error}",
              style: TextStyle(color: Colors.white)
            )
          );
        }

        final data = snapshot.data!;

        return ListView.separated(
          itemCount: data.items.length,
          separatorBuilder: (context, index) {
            return SizedBox(height: 10);
          },
          itemBuilder: (context, index) {
            final item = data.items[index];

            final imageId = 
              item is Song && item.albumId != null 
                ? item.albumId!
                : item.id;

            final imageUrl = JellyfinApi.instance.getImageUrl(
              id: imageId
            ).toString();

            return ItemCard(
              title: item.name,
              subtitle: widget.subtitleBuilder?.call(item),
              imageUrl: imageUrl,
              onTap: () {}
            );
          }
        );
      }
    );
  }
}

class _ItemsData<T> {
  final List<T> items;
  final String accessToken;

  _ItemsData({
    required this.items,
    required this.accessToken
  });
}
