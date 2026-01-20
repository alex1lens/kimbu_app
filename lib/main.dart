import 'package:flutter/cupertino.dart'; // Библиотека в стиле iOS
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(CupertinoApp(home: KimbuSearch()));

class KimbuSearch extends StatefulWidget {
  @override
  _KimbuSearchState createState() => _KimbuSearchState();
}

class _KimbuSearchState extends State<KimbuSearch> {
  String status = "Введите номер";
  final TextEditingController _controller = TextEditingController();

  Future<void> checkNumber() async {
    final phone = _controller.text;
    final url = 'https://kimbu-backend.onrender.com/check/$phone';

    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);
      setState(() {
        status = "${data['name']}\n(${data['category']})";
      });
    } catch (e) {
      setState(() => status = "Ошибка связи");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text("Kimbu iOS")),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              CupertinoTextField(
                controller: _controller,
                placeholder: "Номер телефона",
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              CupertinoButton.filled(child: Text("Проверить"), onPressed: checkNumber),
              SizedBox(height: 40),
              Text(status, style: TextStyle(fontSize: 22), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}