import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Screens/UserScreens/TabScreens/TripScreens/Upcoming/add_expenses.dart';
import 'package:travel/Styles/colors.dart';

class ExpensesScreen extends StatelessWidget {
  final int tripId;
  const ExpensesScreen({super.key, required this.tripId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: blue100,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddExpenses(tripId: tripId),
              ));
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: const Text("Expenses"),
      ),
      body: ValueListenableBuilder(
        valueListenable: expensesList,
        builder: (context, value, child) {
          int totalExpenses = 0;
          for (int i = 0; i < expensesList.value.length; i++) {
            totalExpenses =
                totalExpenses + int.parse(expensesList.value[i].amount);
          }

          return Column(
            children: [
              totalExpenses == 0
                  ? const SizedBox()
                  : Container(
                      margin: const EdgeInsets.all(20),
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: blue100,
                      ),
                      child: Center(
                          child: Text(
                        "Total Expenses:$totalExpenses",
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      )),
                    ),
              Expanded(
                child: ListView.builder(
                  itemCount: expensesList.value.length,
                  itemBuilder: (context, index) {
                    ExpensesModel expenses = expensesList.value[index];
                    return Slidable(
                      key: Key(expenses.id.toString()),
                      startActionPane: ActionPane(
                        motion: const StretchMotion(),
                        extentRatio: 0.2,
                        children: [
                          SlidableAction(
                            backgroundColor: Colors.blue.shade100,
                            autoClose: true,
                            onPressed: (contex) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddExpenses(
                                      tripId: tripId,
                                     editExpenses: expenses,
                                    ),
                                  ));
                            },
                            foregroundColor: Colors.blue,
                            icon: Icons.edit_note_sharp,
                            label: "Edit",
                          ),
                        ],
                      ),
                      endActionPane: ActionPane(
                        extentRatio: 0.2,
                        motion: const StretchMotion(),
                        children: [
                          SlidableAction(
                            backgroundColor: red50,
                            autoClose: true,
                            onPressed: (context) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text("Delete successfully"),
                                backgroundColor: Colors.black,
                              ));
                              deleteExpenses(expenses: expenses);
                              expensesTolist(trip: tripId);
                            },
                            foregroundColor: red,
                            icon: Icons.delete,
                            label: "Delect",
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: expenses.color,
                          child: Icon(expenses.icon),
                        ),
                        title: Text(expenses.category),
                        subtitle: expenses.description != null
                            ? Text(expenses.description!)
                            : null,
                        trailing: Text(
                          "₹${expenses.amount}",
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
