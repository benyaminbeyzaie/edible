import 'package:edible/features/edible/data/models/edible_model.dart';
import 'package:edible/features/edible/presentation/pages/edible_info_page.dart';
import 'package:flutter/material.dart';

class EdibleItem extends StatelessWidget {
  final edibles;
  const EdibleItem({this.edibles});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: edibles.length,
      itemBuilder: (BuildContext context, int index) {
        final EdibleModel edible = edibles.elementAt(index);
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EdibleInfoPage(
                        edibleModel: edible,
                      )),
            );
          },
          child: ListTile(
            title: Text(edible.name),
            subtitle: Text(edible.token),
          ),
        );
      },
    );
  }
}
