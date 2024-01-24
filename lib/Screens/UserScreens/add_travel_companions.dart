import 'package:flutter/material.dart';
import 'package:travel/Widgets/button.dart';
import 'package:travel/Widgets/text_field_widet.dart';
import 'package:travel/colors.dart';

class AddCompanionsScreen extends StatefulWidget {
  const AddCompanionsScreen({super.key});

  @override
  State<AddCompanionsScreen> createState() => _AddCompanionsScreenState();
}

String selectedGroup = "";
int number = 2;

class _AddCompanionsScreenState extends State<AddCompanionsScreen> {
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
                heading: "Travel Companions",
                icon: Icons.group,
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              const Text("   Select your travel group type"),
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
              selectedGroup == "Family" || selectedGroup == "Friends"
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
              addButton(onpress: () {}, color: blue, add: "Next"),
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
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
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
                if (number != 0) {
                  number--;
                }
              });
            },
            icon: Icon(
              Icons.horizontal_rule,
              color: number == 0 ? grey : black,
            ),
          ),
          Text(
            "${number.toString()} People",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            tooltip: "Add people",
            onPressed: () {
              setState(() {
                number++;
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
          selectedGroup = text;
        });
      },
      child: Container(
        width: screenWidth * 0.19,
        height: screenHeight * 0.1,
        decoration: BoxDecoration(
          color: selectedGroup == text ? blue : grey200,
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
                color: selectedGroup == text ? white : black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
