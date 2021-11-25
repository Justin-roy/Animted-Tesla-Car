import 'package:animated_tesla_car/components/battery_status.dart';
import 'package:animated_tesla_car/components/door_lock.dart';
import 'package:animated_tesla_car/components/temp_details.dart';
import 'package:animated_tesla_car/components/tesla_bottom_nav.dart';
import 'package:animated_tesla_car/components/tyre_psi_card.dart';
import 'package:animated_tesla_car/components/tyres.dart';
import 'package:animated_tesla_car/constraints.dart';
import 'package:animated_tesla_car/home_controller.dart';
import 'package:animated_tesla_car/models/tyre_psi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final HomeController _controller = HomeController();
  late AnimationController _batteryAnimationController;
  late Animation<double> _animationbattery;
  late Animation<double> _batteryStatusAnimation;
  // Second Animation..
  late AnimationController _tempAnimationController;
  late Animation<double> _animationCarShift;
  late Animation<double> _animationShowTempInfo;
  late Animation<double> _animationCoolGlow;

  //Tyre Card Animation...

  late AnimationController _tyreAnimationController;
  late Animation<double> _animationTyre1psi;
  late Animation<double> _animationTyre2psi;
  late Animation<double> _animationTyre3psi;
  late Animation<double> _animationTyre4psi;
  late List<Animation<double>> _tyreAnimation;
  //Temperature Animation
  void setupTempAnimation() {
    _tempAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animationCarShift = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.2, 0.4),
    );

    _animationShowTempInfo = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.45, 0.65),
    );
    _animationCoolGlow = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.7, 1),
    );
  }

  //Battery Animation
  void setupBatteryAnimation() {
    _batteryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animationbattery = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: const Interval(0.0, 0.5),
    );
    _batteryStatusAnimation = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: const Interval(0.6, 1),
    );
  }

  //Tyre Animation
  void setupTyreAnimation() {
    _tyreAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animationTyre1psi = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: const Interval(0.34, 0.5),
    );
    _animationTyre2psi = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: const Interval(0.5, 0.66),
    );
    _animationTyre3psi = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: const Interval(0.66, 0.82),
    );
    _animationTyre4psi = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: const Interval(0.82, 1),
    );
  }

  @override
  void initState() {
    super.initState();
    setupBatteryAnimation();
    setupTempAnimation();
    setupTyreAnimation();
    _tyreAnimation = [
      _animationTyre1psi,
      _animationTyre2psi,
      _animationTyre3psi,
      _animationTyre4psi
    ];
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    _tempAnimationController.dispose();
    _tyreAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([
          _controller,
          _batteryAnimationController,
          _tempAnimationController,
          _tyreAnimationController,
        ]),
        builder: (context, _) {
          return Scaffold(
            bottomNavigationBar: TeslaBottomNavBar(
                onTap: (index) {
                  if (index == 1) {
                    _batteryAnimationController.forward();
                  } else if (_controller.selectedBottomTab == 1 && index != 1) {
                    _batteryAnimationController.reverse(from: 0.7);
                  }
                  if (index == 2) {
                    _tempAnimationController.forward();
                  } else if (_controller.selectedBottomTab == 2 && index != 2) {
                    _tempAnimationController.reverse(from: 0.4);
                  }

                  if (index == 3) {
                    _tyreAnimationController.forward();
                  } else if (_controller.selectedBottomTab == 3 && index != 3) {
                    _tyreAnimationController.reverse();
                  }
                  // Make Call Before Use....
                  _controller.updateTyreStatus(index);
                  _controller.updateShowTyre(index);
                  _controller.changeBottomNavTab(index);
                },
                selectedTab: _controller.selectedBottomTab),
            body: SafeArea(
              child: LayoutBuilder(builder: (context, constrains) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                    ),
                    Positioned(
                      left: constrains.maxWidth / 2 * _animationCarShift.value,
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: constrains.maxHeight * 0.1),
                        child: SvgPicture.asset(
                          "assets/icons/Car.svg",
                          width: double.infinity,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      right: _controller.selectedBottomTab == 0
                          ? constrains.maxWidth * 0.04
                          : constrains.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isRightDoorLock,
                          press: _controller.updateRightDoorLook,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      left: _controller.selectedBottomTab == 0
                          ? constrains.maxWidth * 0.04
                          : constrains.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isLeftDoorLock,
                          press: _controller.updateLeftDoorLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      top: _controller.selectedBottomTab == 0
                          ? constrains.maxWidth * 0.24
                          : constrains.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isBonnetLock,
                          press: _controller.updateBonnetLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      bottom: _controller.selectedBottomTab == 0
                          ? constrains.maxWidth * 0.32
                          : constrains.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isTrunkLock,
                          press: _controller.updateTrunkLock,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: _animationbattery.value,
                      child: SvgPicture.asset(
                        "assets/icons/Battery.svg",
                        width: constrains.maxWidth * 0.45,
                      ),
                    ),
                    Positioned(
                      top: 50 * (1 - _batteryStatusAnimation.value),
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      child: Opacity(
                        opacity: _batteryStatusAnimation.value,
                        child: BatteryStatus(
                          constraints: constrains,
                        ),
                      ),
                    ),
                    //Car Temperature Details
                    Positioned(
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      top: 60 * (1 - _animationShowTempInfo.value),
                      child: Opacity(
                        opacity: _animationShowTempInfo.value,
                        child: TempWidget(controller: _controller),
                      ),
                    ),
                    //Car Temperature Images
                    Positioned(
                      right: -180 * (1 - _animationCoolGlow.value),
                      child: AnimatedSwitcher(
                        duration: defaultDuration,
                        child: _controller.isColorSelected
                            ? Image.asset(
                                "assets/images/Cool_glow_2.png",
                                width: 200,
                                key: const ValueKey("Cool_Glow"),
                              )
                            : Image.asset(
                                "assets/images/Hot_glow_4.png",
                                width: 200,
                                key: const ValueKey("Hot_Glow"),
                              ),
                      ),
                    ),

                    //Tyres..
                    if (_controller.isShowTyre) ...tyres(constrains),

                    if (_controller.isTyreStatus)
                      GridView.builder(
                        itemCount: 4,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: defaultPadding,
                          crossAxisSpacing: defaultPadding,
                          childAspectRatio:
                              constrains.maxWidth / constrains.maxHeight,
                        ),
                        itemBuilder: (context, index) => ScaleTransition(
                          scale: _tyreAnimation[index],
                          child: TyrePsiCard(
                            isBottomTwoTyre: index > 1,
                            tyrePsi: demoPsi[index],
                          ),
                        ),
                      ),
                  ],
                );
              }),
            ),
          );
        });
  }
}
