//gets name and location from user
//gets phone number and type of user

import 'package:flutter/material.dart';

class PersonalInfoScr extends StatelessWidget {
  const PersonalInfoScr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Funny Joke App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "_currentJoke",
                style: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // _getJoke();
                },
                child: Text('Get a Joke'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
