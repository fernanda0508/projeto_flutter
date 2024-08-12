import 'package:flutter/material.dart';

class StylizedHeader extends StatelessWidget {
  const StylizedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final search = TextEditingController(); // Controller para o campo de pesquisa
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white38, // Adjust the color to match your style
        borderRadius: BorderRadius.circular(30), // Adjust for roundness
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Container()
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: <Widget>[
          Image.network(
            'https://avatars.githubusercontent.com/u/35045612?v=4', // Substitua com a URL do seu logo
            height: 40, // Ajuste a altura conforme necessário
          ),
          const SizedBox(width: 8), // Espaço entre o logo e a barra de pesquisa
          const Expanded(
            child: StylizedHeader(), // Sua barra de pesquisa personalizada
          ),
        ],
      ),
      backgroundColor:
          const Color.fromARGB(255, 4, 39, 100), // Cor de fundo do AppBar
      elevation: 0, // Remove a sombra do AppBar
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Altura padrão do AppBar
}
