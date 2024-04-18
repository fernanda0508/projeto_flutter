import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/deputados/deputados.dart';
import 'package:flutter_application_1/screens/propostas/propostas.dart';
import '../components/rodape.dart';
import '../components/cabecalho.dart';

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
            PropostasScreen(),
            DeputadosScreen(),
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
