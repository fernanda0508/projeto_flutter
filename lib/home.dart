import 'package:flutter/material.dart';
import 'rodape.dart';
import 'cabecalho.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Índice atual selecionado

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex =
          index; // Atualiza o índice selecionado e reconstrói o widget
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        // O conteúdo que muda com base na navegação
        child: IndexedStack(
          index: _selectedIndex,
          children: const <Widget>[
            Text('Página de Proposições'),
            Text('Página de Deputados'),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
