import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/home/components/body.dart';
import 'package:shop_app/size_configure.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfigure().init(context);
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size(double.infinity, 56), child: buildAppBar()),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kprimaryColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.list, color: kdarkColor),
        onPressed: () {},
      ),
      centerTitle: true,
      title: Container(
        alignment: Alignment.bottomCenter,
        height: getProportionateScreenHeight(85),
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Image.asset(
            'assets/icons/logo.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/cart.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {},
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
