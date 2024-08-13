import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login/login.dart';
import 'package:flutter_application_1/models/partido.dart';
import 'package:flutter_application_1/screens/deputados/deputados.dart';
import 'package:flutter_application_1/screens/partidos/partidos.dart';
import '../components/rodape.dart';
import '../models/deputadoGet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.userName, this.deputadosBuscados, this.partidosBuscados, this.selectedIndex});
  final String userName;
  final List<DeputadoGet>? deputadosBuscados;
  final List<Partido>? partidosBuscados;
  final int? selectedIndex;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _selectedIndex;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Olá, ${widget.userName}.'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: IndexedStack(
              index: _selectedIndex,
              children: <Widget>[
                DeputadosScreen(deputados: widget.deputadosBuscados, userName: widget.userName),
                PartidosScreen(partido: widget.partidosBuscados, userName: widget.userName),
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
