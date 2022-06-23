// ignore_for_file: use_key_in_widget_constructors

import 'package:education_system/Screens/details_screen.dart';
import 'package:education_system/model/course.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Course>(context);
    return Card(
      margin:const EdgeInsets.symmetric(horizontal: 18,vertical: 5),
      child: Padding(
        padding:const EdgeInsets.all(8),
        child: Column(children: [
          // Text("ProductId:  ${product.id}"),
          Image.network(
            product.image!,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 10,
          ),
          Text("ProductName: ${product.name!}"),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(DetailsScreen.routeName, arguments: product.id);
            },
            child: const Text("More Details"),
          )
          //  Text("Description:$description"),
        ]),
      ),
    );
  }
}
