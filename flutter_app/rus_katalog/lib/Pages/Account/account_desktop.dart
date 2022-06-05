import 'package:flutter/material.dart';
import 'package:rus_katalog/Models/client.dart';
import 'package:rus_katalog/api.dart';
import 'package:rus_katalog/localdata.dart';

import 'package:rus_katalog/constants.dart';
import 'package:rus_katalog/main.dart';

// Виджет корзины для ПК
class DesktopAccount extends StatefulWidget {
  const DesktopAccount({Key? key, required this.showAccountOverlay})
      : super(key: key);

  final void Function() showAccountOverlay;

  @override
  State<DesktopAccount> createState() => _DesktopAccountState();
}

class _DesktopAccountState extends State<DesktopAccount> {
  bool darkMode = false;
  bool test = false;
  Client? user;
  Widget body = const Center(child: CircularProgressIndicator());

  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    String? userToken = await LocalData.getUser();
    if (userToken != null) {
      user = await Api.getClientByToken(userToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    darkMode = Theme.of(context).brightness == Brightness.dark;
    body = buildAccount(context);
    return Align(
      alignment: Alignment.topRight,
      child: Container(
          margin: EdgeInsets.fromLTRB(
              0,
              0,
              ((MediaQuery.of(context).size.width - desktopWidth) / 2) > 0
                  ? ((MediaQuery.of(context).size.width - desktopWidth) / 2)
                  : 0,
              0),
          padding: const EdgeInsets.all(singleSpace),
          constraints: const BoxConstraints(maxWidth: desktopWidth),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: Theme.of(context).primaryColor.withOpacity(opacity)),
          child: Material(child: body)),
    );
  }

  Widget buildAccount(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(maxWidth: desktopWidth / 3),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.person, size: 64),
              const SizedBox(height: singleSpace),
              user == null
                  ? ElevatedButton(
                      onPressed: () async {
                        widget.showAccountOverlay();
                        await Navigator.pushNamed(context, "/login");
                        widget.showAccountOverlay();
                        getData();
                      },
                      child: const Text("Вход/Регистрация"))
                  : Text("Добро пожаловать, ${user!.fullname.split(' ')[1]}",
                      style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: singleSpace),
              SwitchListTile(
                  title: Text("Темная тема",
                      style: Theme.of(context).textTheme.titleMedium),
                  value: darkMode,
                  onChanged: (bool value) {
                    setState(() {
                      value
                          ? MyApp.of(context)?.changeTheme(ThemeMode.dark)
                          : MyApp.of(context)?.changeTheme(ThemeMode.light);
                      darkMode = value;
                    });
                  }),
              const SizedBox(height: singleSpace),
              Visibility(
                visible: user != null,
                child: ListTile(
                  title: Text("Мои заказы",
                      style: Theme.of(context).textTheme.titleMedium),
                  onTap: () async {
                    widget.showAccountOverlay();
                    Navigator.pushNamed(context, "/orders");
                  },
                ),
              ),
              const SizedBox(height: singleSpace),
              Visibility(
                  visible: user != null,
                  child: ListTile(
                    textColor: Colors.red,
                    iconColor: Colors.red,
                    leading: const Icon(Icons.exit_to_app),
                    title: Text("Выйти из аккаунта",
                        style: Theme.of(context).textTheme.titleMedium),
                    onTap: () {
                      widget.showAccountOverlay();
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Выход из аккаунта",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                content: Text(
                                  "Вы действительно хотите выйти из аккаунта",
                                  maxLines: 3,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                actions: [
                                  TextButton.icon(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        widget.showAccountOverlay();
                                      },
                                      icon: const Icon(Icons.close),
                                      label: const Text("Нет")),
                                  TextButton.icon(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        widget.showAccountOverlay();
                                        String? userToken =
                                            await LocalData.getUser();
                                        Api.logoutClient(userToken!);
                                        LocalData.removeUser();
                                        user = null;
                                        body = buildAccount(context);
                                      },
                                      icon: const Icon(Icons.check),
                                      label: const Text("Да")),
                                ],
                              ));
                    },
                  )),
            ],
          ),
        ));
  }
}
