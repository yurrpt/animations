import 'package:animated_builder_and_transform/example4/person/person.dart';
import 'package:flutter/material.dart';
import '../constants/palette.dart';

class PersonDetailsPage extends StatelessWidget {
  final Person person;
  const PersonDetailsPage({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Hero(
          flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
            switch (flightDirection) {
              case HeroFlightDirection.push:
                return Material(
                  color: ColorsConstants.primaryColor,
                  child: ScaleTransition(
                      scale: animation.drive(
                        Tween<double>(
                          begin: 0.0,
                          end: 1.0,
                        ).chain(
                          CurveTween(curve: Curves.fastOutSlowIn),
                        ),
                      ),
                      child: toHeroContext.widget),
                );

              case HeroFlightDirection.pop:
                return Material(
                  color: ColorsConstants.primaryColor,
                  child: toHeroContext.widget,
                );
            }
          },
          tag: person.name,
          child: Text(person.emoji,
              style: const TextStyle(
                fontSize: 30,
              )),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              person.name,
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              person.age.toString(),
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
