import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:travel/Styles/colors.dart';

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Transaction"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.currency_rupee),
                Text("  Enter Amount"),
              ],
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            const TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: "Amount",
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            const TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                labelText: "Purpose",
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            const Text(
              "Select Expence Type",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: size.height * 0.02,
                  mainAxisSpacing: size.height * 0.02,
                ),
                children: [
                  transactionType(
                      text: "Booking", image: "Assets/Animations/ticket.json"),
                  transactionType(
                      text: "Food", image: "Assets/Animations/food.json"),
                  transactionType(
                      text: "Hotel Booking",
                      image: "Assets/Animations/hotel.json"),
                  transactionType(
                      text: "Taxi", image: "Assets/Animations/taxi.json"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget transactionType({required String text, required String image}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: orange100),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [Lottie.asset(image, width: 70), Text(text)],
      ),
    );
  }
}
