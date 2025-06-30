import 'package:flutter/material.dart';
import 'package:on_woori/data/service/auth_api_service.dart';
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

  Future<void> _testLoginOnStart() async {
    print("로그인 테스트좀 해보겠습니다아아아아아아");
    final authService = AuthApiService();

    const email = 'admin@git.hansul.kr';
    const password = 'qwer1234!@#\$';

    try {
      final responseData = await authService.authLogin(
        email: email,
        password: password,
      );
      print('로그인 성공했어요!!!!!! : $responseData');
    } catch (e) {
      print('로그인 실패했어요!!!!!! : $e');
    } finally {
      print('테스트 종료 싱글톤 ApiClient 테스트 종료');
    }
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