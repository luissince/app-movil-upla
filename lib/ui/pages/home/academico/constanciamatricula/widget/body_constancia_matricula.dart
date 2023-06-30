import 'package:flutter/material.dart';
import 'package:upla/constants.dart';

class BodyConstanciaMatricula extends StatelessWidget {
  final List<Widget> children;
  final RefreshCallback onRefresh;
  const BodyConstanciaMatricula({
    Key? key,
    required this.children,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 248, 250, 1),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          "Constancia Matrícula",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(children: children),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
