import 'package:flutter/material.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Screens/UserScreens/EditTrip/edit_trip_plan.dart';
import 'package:travel/Widgets/button.dart';
import 'package:travel/Widgets/text_field_widet.dart';
import 'package:travel/Styles/colors.dart';

class EditCompanionsScreen extends StatefulWidget {
  final TripModel editTrip;
  const EditCompanionsScreen({super.key, required this.editTrip});

  @override
  State<EditCompanionsScreen> createState() => _EditCompanionsScreenState();
}

int? editedNumberOfPeople;
String? editedTravelType;
int? editedBudget;

String _selectedGroup = "Solo";
int _number = 2;

class _EditCompanionsScreenState extends State<EditCompanionsScreen> {
  TextEditingController budgetController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _selectedGroup = widget.editTrip.travelType;
    _number = widget.editTrip.numberOfPeople;
    budgetController.text = widget.editTrip.budget.toString();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headingWidget(
                context: context,
                heading: "Edit Travel Companions",
                icon: Icons.group,
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              const Text("  Edit Select your travel group type"),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  travelTypeWidget(
                    text: "Solo",
                    icon: Icons.man,
                    context: context,
                  ),
                  travelTypeWidget(
                    text: "Couple",
                    icon: Icons.group,
                    context: context,
                  ),
                  travelTypeWidget(
                    text: "Family",
                    icon: Icons.family_restroom,
                    context: context,
                  ),
                  travelTypeWidget(
                    text: "Friends",
                    icon: Icons.groups_sharp,
                    context: context,
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              _selectedGroup == "Family" || _selectedGroup == "Friends"
                  ? addPeopleWidget(context: context)
                  : const SizedBox(),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              headingWidget(
                  context: context,
                  heading: "Your Budget",
                  icon: Icons.attach_money_outlined),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: textField(
                    controller: budgetController,
                    keyboard: const TextInputType.numberWithOptions(),
                    label: "Budget",
                    icon: const Icon(
                      Icons.monetization_on_outlined,
                      color: orange,
                    )),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              addButton(
                  onpress: () {
                    if (budgetController.text.isNotEmpty) {
                      if (_selectedGroup == "Solo") {
                        editedTravelType = "Solo";
                        editedNumberOfPeople = 1;
                      } else if (_selectedGroup == "Couple") {
                        editedTravelType = "Couple";
                        editedNumberOfPeople = 2;
                      } else if (_selectedGroup == "Family") {
                        editedTravelType = "Family";
                        editedNumberOfPeople = _number;
                      } else {
                        editedTravelType = "Friends";
                        editedNumberOfPeople = _number;
                      }
                      editedBudget = int.parse(budgetController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditTripPlan(editTrip: widget.editTrip),
                          ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("select all feilds"),
                        backgroundColor: red,
                      ));
                    }
                  },
                  color: blue,
                  add: "Next"),
              SizedBox(
                height: screenHeight * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget headingWidget(
      {required BuildContext context,
      required String heading,
      required IconData icon}) {
    // final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: white,
          child: Icon(
            icon,
            color: orange,
          ),
        ),
        SizedBox(
          width: screenWidth * 0.04,
        ),
        Text(
          heading,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        )
      ],
    );
  }

  Widget addPeopleWidget({required BuildContext context}) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      width: double.infinity,
      height: screenHeight * 0.05,
      decoration: BoxDecoration(
        color: grey200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                if (_number > 2) {
                  _number--;
                }
              });
            },
            icon: Icon(
              Icons.horizontal_rule,
              color: _number == 2 ? grey : black,
            ),
          ),
          Text(
            "${_number.toString()} People",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            tooltip: "Add people",
            onPressed: () {
              setState(() {
                _number++;
              });
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
    );
  }

  Widget travelTypeWidget(
      {required String text,
      required IconData icon,
      required BuildContext context}) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        setState(() {
          _selectedGroup = text;
        });
      },
      child: Container(
        width: screenWidth * 0.2,
        height: screenHeight * 0.1,
        decoration: BoxDecoration(
          color: _selectedGroup == text ? blue : grey200,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              backgroundColor: white,
              child: Icon(
                icon,
                color: orange,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: _selectedGroup == text ? white : black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
