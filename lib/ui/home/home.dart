import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
    final storage = const FlutterSecureStorage();

    apiClient.authLogin(request:
        LoginRequest(
          email: 'admin@git.hansul.kr',
          password: 'qwer1234!@#\$'
        ))
        .then((response) {
          // 로그인 성공하면 바로 엑세스 토큰을 SecureStorage 에 저장합니다.
          storage.write(key: 'ACCESS_TOKEN', value: response.data.accessToken);
          storage.write(key: 'REFRESH_TOKEN', value: response.data.refreshToken);

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