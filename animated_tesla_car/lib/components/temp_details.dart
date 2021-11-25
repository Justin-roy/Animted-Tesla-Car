import 'package:animated_tesla_car/components/tmp_btn.dart';
import 'package:animated_tesla_car/constraints.dart';
import 'package:animated_tesla_car/home_controller.dart';
import 'package:flutter/material.dart';

int temperatureInDe = 20;

class TempWidget extends StatelessWidget {
  const TempWidget({
    Key? key,
    required HomeController controller,
  })  : _controller = controller,
        super(key: key);

  final HomeController _controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(
                height: 120,
              ),
              TempBtn(
                isActive: _controller.isColorSelected,
                svgSrc: "assets/icons/coolShape.svg",
                title: "Cool",
                press: _controller.updateColorSelected,
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              TempBtn(
                isActive: !_controller.isColorSelected,
                svgSrc: "assets/icons/heatShape.svg",
                title: "Heat",
                press: _controller.updateColorSelected,
                activeColor: Colors.red,
              ),
            ],
          ),
          const Spacer(),
          const TemperatureIncreseDecrease(),
          const Spacer(),
          Text(
            "Current Temperature".toUpperCase(),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Row(
            children: [
              Column(
                children: [
                  Text("Inside".toUpperCase()),
                  Text(
                    "20" "\u2103",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Outside".toUpperCase(),
                    style: const TextStyle(color: Colors.white54),
                  ),
                  Text(
                    "50" "\u2103",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white54),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TemperatureIncreseDecrease extends StatefulWidget {
  const TemperatureIncreseDecrease({
    Key? key,
  }) : super(key: key);

  @override
  State<TemperatureIncreseDecrease> createState() =>
      _TemperatureIncreseDecreaseState();
}

class _TemperatureIncreseDecreaseState
    extends State<TemperatureIncreseDecrease> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              temperatureInDe += 1;
            });
          },
          icon: const Icon(
            Icons.arrow_drop_up,
            size: 50,
          ),
        ),
        Text(
          "$temperatureInDe" "\u2103", //\u2103 Means degree C
          style: const TextStyle(
            fontSize: 86,
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              temperatureInDe -= 1;
            });
          },
          icon: const Icon(
            Icons.arrow_drop_down,
            size: 50,
          ),
        ),
      ],
    );
  }
}
