import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompaniesScreen extends StatelessWidget {
  static final String route = "$CompaniesScreen";

  const CompaniesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SvgPicture.asset("assets/svg/tractian.svg")),
    );
  }
}
