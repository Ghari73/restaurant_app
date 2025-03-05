import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/detail/post_provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';

class BodyOfDetailScreenWidget extends StatefulWidget {
  const BodyOfDetailScreenWidget({
    super.key,
    required this.restaurant,
  });

  final RestaurantDetail restaurant;

  @override
  State<BodyOfDetailScreenWidget> createState() =>
      _BodyOfDetailScreenWidgetState();
}

class _BodyOfDetailScreenWidgetState extends State<BodyOfDetailScreenWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;
      context.read<PostProvider>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Hero(
              tag: widget.restaurant.id,
              child: Image.network(
                widget.restaurant.pictureId,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox.square(dimension: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.restaurant.name,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.pin_drop),
                          const SizedBox.square(
                            dimension: 4,
                          ),
                          Expanded(
                            child: Text(
                              "${widget.restaurant.address}, ${widget.restaurant.city}",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    const SizedBox.square(dimension: 4),
                    Text(
                      widget.restaurant.rating.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox.square(dimension: 16),
            Text(
              widget.restaurant.description,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
            const SizedBox.square(dimension: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Categories",
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox.square(dimension: 8),
                Wrap(
                  spacing: 16.0,
                  children: widget.restaurant.categories
                      .map((category) => Chip(
                            label: Text(category.name),
                          ))
                      .toList(),
                ),
              ],
            ),
            const SizedBox.square(dimension: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Menus", style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox.square(dimension: 8),
                  Text("Foods:",
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox.square(dimension: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 12.0,
                    children: widget.restaurant.menus.foods
                        .map((food) => Chip(label: Text(food.name)))
                        .toList(),
                  ),
                  const SizedBox.square(dimension: 16),
                  Text("Drinks:",
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 12.0,
                    children: widget.restaurant.menus.drinks
                        .map(
                          (drink) => Chip(
                            label: Text(drink.name),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            const SizedBox.square(dimension: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Add a Review",
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox.square(dimension: 8),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Your Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox.square(dimension: 12),
                TextField(
                  controller: _reviewController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: "Your Review",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox.square(dimension: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 100,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        final postProvider = context.read<PostProvider>();

                        if (_nameController.text.isNotEmpty &&
                            _reviewController.text.isNotEmpty) {
                          postProvider.postReview(widget.restaurant.id,
                              _nameController.text, _reviewController.text);

                          context
                              .read<RestaurantDetailProvider>()
                              .fetchRestaurantDetail(widget.restaurant.id);

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Review Successfully Added")));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Name and Review cannot be empty")));
                        }
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox.square(dimension: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Customer Reviews",
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox.square(dimension: 8),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: widget.restaurant.customerReviews.length,
                    itemBuilder: (context, index) {
                      final review = widget.restaurant.customerReviews[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(review.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                Text(
                                  review.date,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                                const SizedBox.square(dimension: 8),
                                Text(review.review),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
