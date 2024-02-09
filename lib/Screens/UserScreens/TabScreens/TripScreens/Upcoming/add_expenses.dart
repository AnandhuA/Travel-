import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Styles/colors.dart';

class AddExpenses extends StatefulWidget {
  final int tripId;
  final ExpensesModel? editExpenses;

  const AddExpenses({super.key, required this.tripId, this.editExpenses});

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  Color _selectedColor = red100;
  String _selectedText = "General";
  IconData _selectedIcon = Icons.line_style_sharp;
  DateTime _selectedDate = DateTime.now();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    if (widget.editExpenses != null) {
      _selectedColor = widget.editExpenses!.color;
      _selectedText = widget.editExpenses!.category;
      _selectedIcon = widget.editExpenses!.icon;
      _selectedDate = widget.editExpenses!.date;
      amountController.text = widget.editExpenses!.amount;
      descriptionController.text = widget.editExpenses!.description ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expenses"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      _changeCategorie(context: context);
                    },
                    child: Stack(
                      children: [
                        categorieType(
                          context: context,
                          color: _selectedColor,
                          text: _selectedText,
                          icon: _selectedIcon,
                        ),
                        Positioned(
                          right: 0,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: grey200,
                            child: const Icon(
                              Icons.edit,
                              size: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.height * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("      Amount"),
                        TextField(
                          style: const TextStyle(fontSize: 30),
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "0.00",
                            prefixIcon: Icon(Icons.currency_rupee),
                            border: InputBorder.none,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              TextField(
                controller: descriptionController,
                maxLines: 2,
                decoration: InputDecoration(
                  label: const Text("Description (Optional)"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextButton.icon(
                onPressed: () async {
                  _selectedDate = await showDatePicker(
                        context: context,
                        currentDate: DateTime.now(),
                        initialDate: _selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2027),
                      ) ??
                      _selectedDate;
                  setState(() {
                    _selectedDate;
                  });
                },
                icon: const Icon(Icons.calendar_today_outlined),
                label: _selectedDate.day == DateTime.now().day &&
                        _selectedDate.year == DateTime.now().year &&
                        _selectedDate.month == DateTime.now().month
                    ? const Text("Today")
                    : Text(
                        DateFormat('MMM dd, yyyy')
                            .format(_selectedDate)
                            .toString(),
                      ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (amountController.text.isNotEmpty) {
                      await addExpenses(
                          expenses: ExpensesModel(
                        id: widget.editExpenses == null
                            ? DateTime.now().microsecondsSinceEpoch.toString()
                            : widget.editExpenses!.id,
                        tripId: widget.editExpenses == null
                            ? widget.tripId
                            : widget.editExpenses!.tripId,
                        amount: amountController.text,
                        category: _selectedText,
                        date: _selectedDate,
                        description: descriptionController.text,
                        color: _selectedColor,
                        icon: _selectedIcon,
                      ));
                      await expensesTolist(trip: widget.tripId);
                      Navigator.pop(context);
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: _selectedColor),
                  child: const Text(
                    "Add",
                    style: TextStyle(color: black),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _changeCategorie({required context}) {
    final size = MediaQuery.of(context).size;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select a category"),
          content: Container(
            width: size.height * 0.5,
            height: size.height * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedColor = red100;
                      _selectedText = "General";
                      _selectedIcon = Icons.line_style_sharp;
                    });
                    Navigator.pop(context);
                  },
                  child: categorieType(
                      context: context,
                      color: red100,
                      text: "General",
                      icon: Icons.line_style_sharp),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedColor = purple100;
                      _selectedText = "Meals";
                      _selectedIcon = Icons.food_bank_outlined;
                    });
                    Navigator.pop(context);
                  },
                  child: categorieType(
                      context: context,
                      color: purple100,
                      text: "Meals",
                      icon: Icons.food_bank_outlined),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedColor = orange100;
                      _selectedText = "Drinks";
                      _selectedIcon = Icons.coffee;
                    });
                    Navigator.pop(context);
                  },
                  child: categorieType(
                      context: context,
                      color: orange100,
                      text: "Drinks",
                      icon: Icons.coffee),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedColor = green100;
                      _selectedText = "Snacks";
                      _selectedIcon = Icons.fastfood_outlined;
                    });
                    Navigator.pop(context);
                  },
                  child: categorieType(
                      context: context,
                      color: green100,
                      text: "Snacks",
                      icon: Icons.fastfood_outlined),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedColor = grey;
                      _selectedText = "Hotel";
                      _selectedIcon = Icons.castle_outlined;
                    });
                    Navigator.pop(context);
                  },
                  child: categorieType(
                      context: context,
                      color: grey,
                      text: "Hotel",
                      icon: Icons.castle_outlined),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedColor = cyan100;
                      _selectedText = "Taxi";
                      _selectedIcon = Icons.local_taxi_outlined;
                    });
                    Navigator.pop(context);
                  },
                  child: categorieType(
                      context: context,
                      color: cyan100,
                      text: "Taxi",
                      icon: Icons.local_taxi_outlined),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            )
          ],
        );
      },
    );
  }

  Widget categorieType({
    required BuildContext context,
    required Color color,
    required String text,
    required IconData icon,
  }) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.height * 0.08,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          Text(
            text,
          )
        ],
      ),
    );
  }
}
