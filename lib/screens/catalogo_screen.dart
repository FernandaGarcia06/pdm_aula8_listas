import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../widgets/produto_card.dart';

class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  final List<Produto> _produtos = [
    const Produto(
      id: '1',
      nome: 'Smartphone Galaxy S24',
      preco: 4500.00,
      categoria: 'Eletrônicos',
      icone: '📱',
    ),
    const Produto(
      id: '2',
      nome: 'Notebook Dell XPS',
      preco: 8900.00,
      categoria: 'Informática',
      icone: '💻',
    ),
    const Produto(
      id: '3',
      nome: 'Fone Bluetooth Sony',
      preco: 1200.00,
      categoria: 'Áudio',
      icone: '🎧',
    ),
    const Produto(
      id: '4',
      nome: 'Smartwatch Garmin',
      preco: 2300.00,
      categoria: 'Wearables',
      icone: '⌚',
    ),
    const Produto(
      id: '5',
      nome: 'Teclado Mecânico RGB',
      preco: 450.00,
      categoria: 'Periféricos',
      icone: '⌨️',
    ),
  ];

  void _adicionarProduto() {
    setState(() {
      final novoProduto = Produto(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        nome: 'Novo Produto ${_produtos.length + 1}',
        preco: 99.90,
        categoria: 'Novos',
        icone: '🛍️',
      );

      _produtos.add(novoProduto);
    });
  }

  void _removerProduto(int index) {
    final produto = _produtos[index];

    setState(() {
      _produtos.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${produto.nome} removido'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _mostrarDetalhes(Produto produto) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              produto.nome,
              textAlign: TextAlign.center,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 35,
                child: Text(
                  produto.icone,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Categoria: ${produto.categoria}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Preço: R\$ ${produto.preco.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'ID: ${produto.id}',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Fechar'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Produtos'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'Itens: ${_produtos.length}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _produtos.length,
        itemBuilder: (context, index) {
          final produto = _produtos[index];

          return Dismissible(
            key: Key(produto.id),
            direction: DismissDirection.endToStart,
            background: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              color: Colors.red,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) {
              _removerProduto(index);
            },
            child: ProdutoCard(
              produto: produto,
              onTap: () {
                _mostrarDetalhes(produto);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarProduto,
        child: const Icon(Icons.add),
      ),
    );
  }
}