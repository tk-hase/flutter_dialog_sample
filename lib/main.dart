import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dialog Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Dialog Sample'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final _DialogResult? result = await _showConfirmDialog();
                String snackBarMessage;
                if (result == null) {
                  snackBarMessage = "ユーザーは何も選択しませんでした。";
                } else {
                  snackBarMessage = "ユーザーは ${result.name} を選択しました。";
                }
                // asyncメソッド内で `ScaffoldMessenger.of()` を呼び出すと警告が出るため、 `Future` でラップして実行する
                Future(
                  () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(snackBarMessage),
                      duration: const Duration(seconds: 2),
                    ),
                  ),
                );
              },
              child: const Text("確認ダイアログを表示"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final _DialogSelectedItem? selectedItem = await _showSelectedDialog();
                String snackBarMessage;
                if (selectedItem == null) {
                  snackBarMessage = "ユーザーは何も選択しませんでした。";
                } else {
                  switch (selectedItem) {
                    case _DialogSelectedItem.one:
                      snackBarMessage = "ユーザーは No.1 を選択しました。";
                      break;
                    case _DialogSelectedItem.two:
                      snackBarMessage = "ユーザーは No.2 を選択しました。";
                      break;
                    case _DialogSelectedItem.three:
                      snackBarMessage = "ユーザーは No.3 を選択しました。";
                      break;
                    default:
                      snackBarMessage = "ユーザーは No.4 を選択しました。";
                  }

                  // asyncメソッド内で `ScaffoldMessenger.of()` を呼び出すと警告が出るため、 `Future` でラップして実行する
                  Future(
                    () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(snackBarMessage),
                        duration: const Duration(seconds: 2),
                      ),
                    ),
                  );
                }
              },
              child: const Text("選択ダイアログを表示"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final _DialogResult? result = await _showConfirmCupertinoDialog();
                String snackBarMessage;
                if (result == null) {
                  snackBarMessage = "ユーザーは何も選択しませんでした。";
                } else {
                  snackBarMessage = "ユーザーは ${result.name} を選択しました。";
                }
                // asyncメソッド内で `ScaffoldMessenger.of()` を呼び出すと警告が出るため、 `Future` でラップして実行する
                Future(
                  () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(snackBarMessage),
                      duration: const Duration(seconds: 2),
                    ),
                  ),
                );
              },
              child: const Text("iOS風確認ダイアログを表示"),
            ),
          ],
        ),
      ),
    );
  }

  // 確認ダイアログを表示する
  Future<_DialogResult?> _showConfirmDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("確認です！"),
        content: const Text("XXXを実行します。\nよろしいですか？"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, _DialogResult.ok), // ボタン押下で閉じる、戻り値：OK
            child: const Text("OK"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, _DialogResult.cancel), // ボタン押下で閉じる、戻り値：キャンセル
            child: const Text("キャンセル"),
          ),
        ],
      ),
    );
  }

  Future<_DialogSelectedItem?> _showSelectedDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SimpleDialog(
        title: const Text("どれかを選択してください"),
        // SimpleDialogOptionを利用して選択肢を並べる
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, _DialogSelectedItem.one),
            child: const Text("選択肢 No.1"),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, _DialogSelectedItem.two),
            child: const Text("選択肢 No.2"),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, _DialogSelectedItem.three),
            child: const Text("選択肢 No.3"),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, _DialogSelectedItem.four),
            child: const Text("選択肢 No.4"),
          ),
        ],
      ),
    );
  }

  Future<_DialogResult?> _showConfirmCupertinoDialog() {
    return showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("iOS風確認ダイアログ"),
        content: const Text("確認です！"),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context, _DialogResult.ok),
            child: const Text("OK"),
          ),
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context, _DialogResult.cancel),
            child: const Text("キャンセル"),
          ),
        ],
      ),
    );
  }
}

enum _DialogResult {
  ok,
  cancel,
}

enum _DialogSelectedItem {
  one,
  two,
  three,
  four,
}
