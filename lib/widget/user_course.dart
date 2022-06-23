// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '../provider/user_selected.dart';
import 'package:provider/provider.dart';
class UserCourse extends StatelessWidget {
  const UserCourse(this.id,this.image,this.description,this.price,this.prodId);
  final String? id;
  final String? prodId;
  final String? image;
  final String? description;
  final String? price;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child:const Icon(Icons.delete,color: Colors.white,size: 80,),
        alignment: Alignment.centerRight,
      ),
      
      child: Card(margin:const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
      elevation: 10,
      child: Padding(padding:const EdgeInsets.all(8),child: Column(
        children: [
          Text("ProdId  $id"),
        const  SizedBox(height: 10,),
        Image.network(image!,fit: BoxFit.fill,),
        const SizedBox(
                height: 10,
              ),
          // Text("Description   $description "),
          const SizedBox(
                height: 10,
              ),
          Text("price:  $price")
    
        ],
      ),),
        
      ),
    );
  }
}