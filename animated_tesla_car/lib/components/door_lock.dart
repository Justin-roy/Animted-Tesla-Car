import 'package:animated_tesla_car/constraints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoorLock extends StatelessWidget {
  const DoorLock({
    Key? key,
    required this.press,
    required this.isLock,
  }) : super(key: key);

  final VoidCallback press;
  final bool isLock;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: AnimatedSwitcher(
        duration: defaultDuration,
        switchInCurve: Curves.easeInOut,
        transitionBuilder: (child, animate) =>
            // ScaleTransition it work faded animation
            ScaleTransition(
          scale: animate,
          child: child,
        ),
        child: isLock
            ? SvgPicture.asset(
                "assets/icons/door_lock.svg",
                key: const ValueKey("Lock"),
              )
            : SvgPicture.asset(
                "assets/icons/door_unlock.svg",
                key: const ValueKey("UnLock"),
              ),
      ),
    );
  }
}
