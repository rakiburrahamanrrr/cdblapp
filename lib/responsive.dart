import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;

  const Responsive({
    Key key,
    this.mobile,
    this.tablet,
  }) : super(key: key);

  @deprecated
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  @deprecated
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1300 &&
      MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) {
    return getValueForScreenType<bool>(
      context: context,
      mobile: true,
      tablet: false,
      desktop: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          return mobile;
        } else if (sizingInformation.deviceScreenType ==
            DeviceScreenType.tablet) {
          return tablet;
        } else {
          return tablet;
        }
      },
    );
  }
}
