import 'package:flutter/material.dart';

class PropostasScreen extends StatefulWidget {
  const PropostasScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PropostasScreenState createState() => _PropostasScreenState();
}


class _PropostasScreenState extends State<PropostasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: const Text('Propostas', style: TextStyle(fontSize: 40),),
            ),
            Container(
              child: const Text('Tema selecionado', style: TextStyle(fontSize: 15),),
            ),
          ],
        ),
      ),
    );
  }
}