import 'package:expence_tracker/model/expence.dart';
import 'package:expence_tracker/widgets/expence_list/expence_item.dart';
import 'package:flutter/material.dart';

class ExpencesList extends StatelessWidget {
  const ExpencesList({
    required this.expences,
    super.key,
    required this.onRemoveExpence,
  });

  final void Function(Expence expence) onRemoveExpence;
  final List<Expence> expences;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expences.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expences[index]),
        onDismissed: (direction) {
          onRemoveExpence(expences[index]);
        },
        child: ExpencesItem(expences[index]),
      ),
    );
  }
}
