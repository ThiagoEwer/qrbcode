import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



  final TextEditingController _codigoController = TextEditingController();
  String _descricao;

  Future<void> _enviarRequisicao() async {
    final String codigo = _codigoController.text;
    final response = await http.post(
      Uri.parse('https://exemplo.com/requisicao'),
      body: {'codigo': codigo},
    );
    final desc = jsonDecode(response.body);
    /*
    setState(() {
      _descricao = desc['descricao'];
    });
    */
  }
