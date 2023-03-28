import 'package:flutter/material.dart';
import 'package:qrbcode/controller/themecontroller.dart';
import 'package:qrbcode/screen/produto.dart';
import 'package:qrbcode/screen/qrbar.dart';

class Menu extends StatefulWidget {
  const Menu({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<Menu> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Menu> {
//atualização do relógio/data
  Stream<int> timerStream =
      Stream.periodic(const Duration(seconds: 1), (i) => i);
//troca de paginas do bottombar
  int _paginaAtual = 0;
  void aoMudarDeAba(int indice) {
    setState(() {
      _paginaAtual = indice;
    });
  }

  final List<Widget> _telas = [
    const Qrbar(),
    const Produtos(),
    const Produtos(), //novo tela para pedidos
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //colocar pra mudar o tema no switch
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsetsDirectional.only(end: 60),
              child: const Text('QRBCode',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
            ),
            //transform usado para englobar o switch e diminuir o seu tamanho.
            Transform.scale(
              scale: 0.8,
              child: Switch(
                  value: ThemeController.intance.isDarktheme,
                  onChanged: (value) {
                    ThemeController.intance.changeTheme();
                  }),
            ),
          ],
        ),
      ),
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        const UserAccountsDrawerHeader(
          accountEmail: Text("user@rava.com.br"),
          accountName: Text("Expedidor"),
          currentAccountPicture: CircleAvatar(
            child: Icon(Icons.person),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text("Crachá"),
          onTap: () {
            Navigator.pop(context);
            //Navegar para outra página
          },
        ),
        ListTile(
          leading: const Icon(Icons.history),
          title: const Text("Cód Barras"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Qrbar()),
            );
            //Navegar para outra página
          },
        ),
        ListTile(
          leading: const Icon(Icons.inventory_2),
          title: const Text("Produtos"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Produtos()),
            );
            //Navegar para outra página
          },
        ),
        ListTile(
          leading: const Icon(Icons.warning_sharp),
          title: const Text("Divergências"),
          onTap: () {
            Navigator.pop(context);
            //Navegar para outra página
          },
        )
      ])),
      body:
          /* Column(
        children: [
          Container(
            height: 28,
            width: double.infinity,
            color: Colors.white,
            //data/hora
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //adicionado para pegar o conteudo de "date"
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: StreamBuilder(
                      //StreamBuilder colocado para o recarregar o FutureBuilder a cada 1segundo.
                      stream: timerStream,
                      builder:
                          (BuildContext context, AsyncSnapshot<int> snapshot) {
                        //Função FutureBuilder sempre vai ser usado para trabalhar com API's
                        return FutureBuilder(
                          //future requer a função já setada de uma api, um get já feito por exemplo, nesse caso a função fetch.
                          future: fetch(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            //adicionei um verificador de conexão para relatar erro caso não tenha acesso a requisição http.
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return Text('Erro: ${snapshot.error}');
                              } else {
                                //se não der erro, vai retornar o que foi pedido dentro da função fetch, nesse caso o date e time.
                                final date = snapshot.data['date'];
                                final time = snapshot.data['time'];
                                //formatação da data.
                                final parsedDate =
                                    DateTime.parse(date.toString());
                                final formattedDate =
                                    DateFormat('dd/MM/yyyy').format(parsedDate);
                                final formattedTime = time;
                                //exibição da data já formatada na tela.
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      formattedDate,
                                      style: const TextStyle(
                                          color: Colors.blue, fontSize: 10),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        // ignore: unnecessary_string_interpolations
                                        formattedTime,
                                        style: const TextStyle(
                                            color: Colors.blue, fontSize: 10),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            } else {
                              return const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator());
                            }
                          },
                        );
                      }),
                ),
              ],
            ),
          ), */
          _telas[_paginaAtual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _paginaAtual,
        onTap: aoMudarDeAba,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: "QRBAR",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2),
            label: "PRODUTOS",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: "HISTÓRICO",
          ),
        ],
      ),
    );
  }
}
