import 'package:animated_tesla_car/constraints.dart';
import 'package:flutter/material.dart';

class BatteryStatus extends StatelessWidget {
  const BatteryStatus({
    Key? key,
    required this.constraints,
  }) : super(key: key);
  final BoxConstraints constraints;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "220 mi",
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.white),
        ),
        const Text(
          "62%",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        const Spacer(),
        Text(
          "Charging".toUpperCase(),
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        const Text(
          "18 min remaining",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.14,
        ),
        DefaultTextStyle(
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("22 mi/hr"),
              Text("232v"),
            ],
          ),
        ),
        const SizedBox(
          height: defaultPadding,
        )
      ],
    );
  }
}
