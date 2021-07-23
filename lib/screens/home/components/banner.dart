import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/size_configure.dart';

class TileBanner extends StatelessWidget {
  const TileBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: double.infinity,
      height: getProportionateScreenWidth(150),
      child: Image.asset(
        'assets/images/banner.png',
        fit: BoxFit.contain,
      ),
      color: kprimaryColor,
    );
  }
}
