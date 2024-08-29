import 'package:flutter/material.dart';
import 'package:expense_tracker/core/viewmodels/home_model.dart';

class PickMonthOverlay extends StatelessWidget {
  final HomeModel model;
  final bool showOrHide;

  const PickMonthOverlay({
    Key? key,
    required this.model,
    required this.showOrHide,
    required BuildContext context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!showOrHide) {
      return const SizedBox.shrink();
    }

    return Positioned(
      // Customize the position as needed
      left: 0,
      bottom: 0,
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: 200,
          padding: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 5),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3,
                spreadRadius: 10,
              )
            ],
          ),
          child: buildGridView(model),
        ),
      ),
    );
  }

  Widget buildGridView(HomeModel model) {
    return GridView.count(
      crossAxisCount: 6,
      children: model.months.map((month) {
        return InkWell(
          onTap: () {
            model.monthClicked(month);
          },
          child: Center(
            child: Text(
              month,
              style: TextStyle(
                color: model.getColor(month),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
