import 'package:education_system/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'productforhome_item.dart';

class HomeList extends StatefulWidget {
  const HomeList({Key? key}) : super(key: key);

  @override
  State<HomeList> createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  var _inIt = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    // ignore: todo
    // TODO: implement didChangeDependencies
    if (_inIt) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetData().then(((value) {
        setState(() {
          _isLoading = false;
        });
      }));
    }
    _inIt = false;
    super.didChangeDependencies();
  }

  Future<void> refreshIn() async {
    await Provider.of<Products>(context).fetchAndSetData();
  }

  @override
  Widget build(BuildContext context) {
    //  final provider = Provider.of<CourseNotifier>(context);
    final provider = Provider.of<Products>(context).items;

    return RefreshIndicator(
      onRefresh: () => refreshIn(),
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: ((context, i) => ChangeNotifierProvider.value(
                    value: provider[i],
                    child: ProductItem(),
                  )),
              itemCount: provider.length,
            ),
    );
  }
}
