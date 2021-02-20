import 'package:flutter/material.dart';

class Unauthenticated extends StatelessWidget {
  const Unauthenticated({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LitAuth(
      config: AuthConfig(
          title: Text(
            'Welcome to the Shories🔥',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4,
          ),
          googleButton: GoogleButtonConfig.light()),
    );
  }
}
