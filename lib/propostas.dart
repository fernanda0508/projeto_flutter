import 'package:flutter/material.dart';

class PropostasScreen extends StatefulWidget {
  const PropostasScreen({super.key});

  @override
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
              child: const Text('Propostas', style: TextStyle(fontSize: 40)),
            ),
            const Text('Tema selecionado', style: TextStyle(fontSize: 15)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 90,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: const Text('Fotografia no título de eleitor', style: TextStyle(fontSize: 20),),
                    ),
                    const SizedBox(height: 10), // Adicionando espaçamento entre os itens da lista
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 90,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: const Text('Jogo ou Aposta', style: TextStyle(fontSize: 20)),
                    ),
                    const SizedBox(height: 10), // Adicionando espaçamento entre os itens da lista
                    Container(
                      height: 90,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: const Text('02 de julho como data histórica', style: TextStyle(fontSize: 20)),
                    ),
                    const SizedBox(height: 10), // Adicionando espaçamento entre os itens da lista
                    Container(
                      height: 90,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: const Text('Objeto da patente em Território Nacional', style: TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}