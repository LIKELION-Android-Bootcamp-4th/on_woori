import 'package:flutter/material.dart';
import 'package:on_woori/data/client/auth_api_client.dart';
import 'package:on_woori/data/entity/request/login_request.dart';
import 'package:on_woori/l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _testLoginOnStart();
  }

  Future<void> _testLoginOnStart() {
    print("로그인 테스트 코드");
    final apiClient = AuthApiClient();

    final request = LoginRequest(
        email: 'admin@git.hansul.kr',
        password: 'qwer1234!@#\$'
    );

    apiClient.authLogin(request: request)
        .then((response){
          print(response.data.accessToken);
        }).catchError((e) => print('로그인 실패: $e'))
        .whenComplete(() => print('테스트 종료'));

    return Future.value();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(l10n.appTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(l10n.mainSlogan),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: '증가',
        child: const Icon(Icons.add),
      ),
    );
  }
}