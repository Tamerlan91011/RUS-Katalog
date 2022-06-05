import 'package:flutter/material.dart';
import 'package:rus_katalog/Models/client.dart';
import 'package:rus_katalog/api.dart';
import 'package:rus_katalog/constants.dart';
import 'package:rus_katalog/localdata.dart';

class LoginMobile extends StatefulWidget {
  const LoginMobile({Key? key, this.showLogin = true}) : super(key: key);

  final bool showLogin;

  @override
  _LoginMobileState createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  final _loginController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool showLogin = true;

  @override
  void initState() {
    super.initState();
    showLogin = widget.showLogin;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: singleSpace * 2, vertical: singleSpace * 3),
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width < mobileWidth
                  ? (MediaQuery.of(context).size.width / 3 * 2)
                  : (desktopWidth / 3)),
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(companyName,
                  style: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                              const Shadow(
                                  color: Colors.white,
                                  blurRadius: singleSpace * 3)
                            ])
                      : Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          shadows: [
                              const Shadow(
                                  color: kPrimaryColor,
                                  blurRadius: singleSpace * 3)
                            ])),
              const SizedBox(height: singleSpace * 4),
              const SizedBox(height: singleSpace * 2),
              Column(
                  children: showLogin
                      ? buildLoginFields()
                      : buildRegisterFields()),
              const SizedBox(height: singleSpace * 2),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Пароль"),
              ),
              const SizedBox(height: singleSpace * 4),
              showLogin
                  ? ElevatedButton(
                      onPressed: () async {
                        if (_loginController.text.isEmpty ||
                            _passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "Введены не все поля!",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              backgroundColor: kBadgeColor));
                          return;
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(_loginController.text);
                        bool phoneValid = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                            .hasMatch(_loginController.text);
                        if (emailValid || phoneValid) {
                          String? token = await Api.loginClient(
                              _loginController.text,
                              _passwordController.text,
                              phoneValid);
                          if (token == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  "Неверный логин или пароль!",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                backgroundColor: kBadgeColor));
                          } else {
                            LocalData.saveUser(token);
                            Navigator.pop(context);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Неверный логин!",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            backgroundColor: kBadgeColor,
                          ));
                          return;
                        }
                      },
                      child: const Text("Войти"))
                  : ElevatedButton(
                      onPressed: () async {
                        if (_nameController.text.isEmpty ||
                            _emailController.text.isEmpty ||
                            _phoneController.text.isEmpty ||
                            _passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "Введены не все поля!",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              backgroundColor: kBadgeColor));
                          return;
                        }
                        if (_nameController.text.split(" ").length < 2) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "Неверно введено ФИО!",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              backgroundColor: kBadgeColor));
                          return;
                        }
                        bool phoneValid = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                            .hasMatch(_phoneController.text);
                        if (!phoneValid) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "Неверно введен номер телефона!",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              backgroundColor: kBadgeColor));
                          return;
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(_emailController.text);
                        if (!emailValid) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "Неверно введена электронная почта!",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              backgroundColor: kBadgeColor));
                          return;
                        }
                        Client client = Client(
                            id: 1,
                            email: _emailController.text,
                            phone: _phoneController.text,
                            password: _passwordController.text,
                            fullname: _nameController.text,
                            isAdmin: false);
                        String? token = await Api.registerCLient(client);
                        if (token == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "Ошибка регистрации!",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              backgroundColor: kBadgeColor));
                        } else {
                          LocalData.saveUser(token);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Регистрация")),
              const SizedBox(height: singleSpace * 2),
              TextButton(
                  onPressed: () {
                    setState(() {
                      showLogin = !showLogin;
                      _loginController.clear();
                      _emailController.clear();
                      _phoneController.clear();
                      _passwordController.clear();
                      _nameController.clear();
                    });
                  },
                  child: Text(showLogin
                      ? "Еще не зарегестрированы?"
                      : "Уже зарегистрированы?"))
            ]),
          ),
        ),
      ),
    );
  }

  List<Widget> buildRegisterFields() {
    List<Widget> fields = [];

    fields.addAll([
      TextField(
        controller: _nameController,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
            hintText: "ФИО"),
      ),
      const SizedBox(height: singleSpace * 2),
      TextField(
        controller: _phoneController,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.phone),
            hintText: "Телефон"),
      ),
      const SizedBox(height: singleSpace * 2),
      TextField(
        controller: _emailController,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
            hintText: "Email"),
      ),
    ]);

    return fields;
  }

  List<Widget> buildLoginFields() {
    List<Widget> fields = [];

    fields.addAll([
      TextField(
        controller: _loginController,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
            hintText: "Телефон / email"),
      ),
    ]);

    return fields;
  }
}
