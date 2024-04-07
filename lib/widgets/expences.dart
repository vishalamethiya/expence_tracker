import 'package:expence_tracker/chart/chart.dart';
import 'package:expence_tracker/widgets/expence_list/expencess_list.dart';
import 'package:expence_tracker/model/expence.dart';
import 'package:expence_tracker/widgets/new_expence.dart';
import 'package:flutter/material.dart';

class Expences extends StatefulWidget {
  const Expences({super.key});

  @override
  State<Expences> createState() {
    return _Expence();
  }
}

class _Expence extends State<Expences> {
  final List<Expence> _registeredExpenses = [
    Expence(
      title: 'Flutter Course',
      date: DateTime.now(),
      amount: 15,
      category: Category.work,
    ),
    Expence(
      title: 'Movies',
      date: DateTime.now(),
      amount: 18.36,
      category: Category.leisure,
    ),
  ];

  void _openAddExpenceOvely() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpence(onAddFunction: _addExpence),
    );
  }

  void _addExpence(Expence expence) {
    setState(() {
      _registeredExpenses.add(expence);
    });
  }

  void _removeExpence(Expence expence) {
    final expenceIndex = _registeredExpenses.indexOf(expence);
    setState(() {
      _registeredExpenses.remove(expence);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expence deleted.'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenceIndex, expence);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    Widget mainContent = const Center(
      child: Text('No Expence found. Start adding Some!!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpencesList(
          onRemoveExpence: _removeExpence, expences: _registeredExpenses);
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _openAddExpenceOvely,
            icon: const Icon(Icons.add),
          ),
        ],
        backgroundColor: Colors.blueAccent,
        title: const Text('Flutter Expence Tracker'),
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
