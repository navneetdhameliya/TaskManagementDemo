import 'package:flutter/material.dart';
import 'package:task_manager/components/widgets.dart';
import 'package:task_manager/utils/color_constants.dart';

class PageNotFound extends StatefulWidget {
  const PageNotFound({super.key});

  @override
  State<PageNotFound> createState() => _PageNotFoundState();
}

class _PageNotFoundState extends State<PageNotFound> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.whiteColor,
        body: Center(child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          buildText(
              'Page not found',
              ColorConstants.blackColor,
              30,
              FontWeight.w600,
              TextAlign.center,
              TextOverflow.clip),
          const SizedBox(height: 10,),
          buildText(
              'Something went wrong',
              ColorConstants.blackColor,
              10,
              FontWeight.normal,
              TextAlign.center,
              TextOverflow.clip),
        ],)));
  }
}
