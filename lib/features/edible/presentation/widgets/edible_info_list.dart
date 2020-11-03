import 'package:flutter/material.dart';

class EdibleInfoList extends StatelessWidget {
  const EdibleInfoList({
    this.nutritionalData,
    this.selectedUnit,
  });

  final nutritionalData;
  final selectedUnit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: nutritionalData.elementAt(selectedUnit).length,
      itemBuilder: (context, index) {
        final edible = nutritionalData.elementAt(selectedUnit);
        return ListTile(
          title: Text(
            '${edible.keys.elementAt(index)}:  ${edible.values.elementAt(index).value.toStringAsFixed(2)}',
          ),
        );
      },
    );
  }
}
