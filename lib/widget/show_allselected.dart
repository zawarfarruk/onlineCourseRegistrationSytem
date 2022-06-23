import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/selected_product_provider.dart';

class ShowSelected extends StatefulWidget {
  const ShowSelected({Key? key}) : super(key: key);

  @override
  State<ShowSelected> createState() => _ShowSelectedState();
}

class _ShowSelectedState extends State<ShowSelected> {
  var _inIt = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {

    if (_inIt) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Selected>(context).fetchAndSetData().then(((value) {
        setState(() {
          _isLoading = false;
        });
      }));
    }
    _inIt = false;

    super.didChangeDependencies();
  }

  Future<void> refreshIn() async {
    await Provider.of<Selected>(context).fetchAndSetData();
  }

  // final response =
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Selected>(
      context,
    ).items;
    // final register=Provider.of<CourseNotifier>(context);
    // final product=register.favourite;

    return RefreshIndicator(
      onRefresh: () => refreshIn(),
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: ((context, index) => Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Image.network(
                            // product[index].image!,
                            provider[index].image!,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(provider[index].name!),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(provider[index].email!),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  )),
              itemCount: provider.length,
            ),
    );
  }
}
