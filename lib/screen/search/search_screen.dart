import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search/search_provider.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/static/search_result_state.dart';
import '../home/restaurant_card_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      final searchProvider = context.read<SearchProvider>();
      if (searchProvider.searchQuery.isNotEmpty) {
        searchProvider.fetchSearch(searchProvider.searchQuery);
      }
    });
  }

  

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<SearchProvider>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            icon: const Icon(Icons.search),
            hintText: "Search...",
            border: InputBorder.none,
            hintStyle: TextStyle(color: isDarkMode ? Colors.white60 : Colors.black54),
          ),
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
          onChanged: (query) {
            searchProvider.updateSearchQuery(query.toLowerCase());
          },
        ),
      ),
      body: searchProvider.searchQuery.isEmpty
          ? const Center(
              child: Text(
                "Search for restaurants...",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Consumer<SearchProvider>(
              builder: (context, value, child) {
                if (value.resultState is SearchLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (value.resultState is SearchLoadedState) {
                  final restaurantList =
                      (value.resultState as SearchLoadedState).data;

                  if (restaurantList.isEmpty) {
                    return const Center(
                      child: Text(
                        "No restaurants found",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: restaurantList.length,
                    itemBuilder: (context, index) {
                      final restaurant = restaurantList[index];

                      return RestaurantCard(
                        restaurant: restaurant,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            NavigationRoute.detailRoute.name,
                            arguments: restaurant.id,
                          );
                        },
                      );
                    },
                  );
                } else if (value.resultState is SearchErrorState) {
                  final message = (value.resultState as SearchErrorState).error;
                  return Center(child: Text(message));
                } else {
                  return const SizedBox();
                }
              },
            ),
    );
  }
}
