import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/partido.dart';
import 'package:flutter_application_1/screens/deputados/deputados.dart';
import 'package:flutter_application_1/screens/partidos/partidos.dart';
import '../components/rodape.dart';
import '../models/deputadoGet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.deputadosBuscados, this.partidosBuscados});
  final List<DeputadoGet>? deputadosBuscados;
  final List<Partido>? partidosBuscados;

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
      body: Center(
        // O conteúdo que muda com base na navegação
        child: IndexedStack(
          index: _selectedIndex,
          children: <Widget>[
            DeputadosScreen(deputados: widget.deputadosBuscados),
            PartidosScreen(partido: widget.partidosBuscados,),
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
