import 'package:animated_builder_and_transform/example4/person/person.dart';
import 'package:animated_builder_and_transform/example4/person/person_details_page.dart';
import 'package:flutter/material.dart';

class ExampleFour extends StatelessWidget {
  const ExampleFour({super.key});

  @override
  Widget build(BuildContext context) {
    const people = [
      Person(name: 'Alexa', age: 17, emoji: '🦸🏻'),
      Person(name: 'Arda', age: 18, emoji: '🤴🏼'),
      Person(name: 'John', age: 17, emoji: '🧔🏻'),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('People'),
      ),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PersonDetailsPage(
                    person: person,
                  ),
                ),
              );
            },
            leading: Hero(
              tag: person.name,
              child: Text(
                person.emoji,
                style: const TextStyle(fontSize: 40),
              ),
            ),
            title: Text(person.name),
            subtitle: Text('${person.age} years old'),
            trailing: const Icon(Icons.arrow_forward_ios),
          );
        },
      ),
    );
  }
}
