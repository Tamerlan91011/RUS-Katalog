import 'package:flutter/material.dart';
import 'package:rus_katalog/Models/client.dart';
import 'package:rus_katalog/api.dart';
import 'package:rus_katalog/constants.dart';
import 'package:rus_katalog/localdata.dart';
import 'package:rus_katalog/main.dart';

class MobileAccount extends StatefulWidget {
  const MobileAccount({Key? key}) : super(key: key);

  @override
  State<MobileAccount> createState() => _MobileAccountState();
}

class _MobileAccountState extends State<MobileAccount> {
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
    setState(() {
      body = buildAccount(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    darkMode = Theme.of(context).brightness == Brightness.dark;
    body = buildAccount(context);
    return body;
  }

  Widget buildAccount(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(maxWidth: desktopWidth),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.person, size: 128),
              const SizedBox(height: singleSpace),
              user == null
                  ? ElevatedButton(
                      onPressed: () async {
                        await Navigator.pushNamed(context, "/login");
                        getData();
                        setState(() {});
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
                                      },
                                      icon: const Icon(Icons.close),
                                      label: const Text("Нет")),
                                  TextButton.icon(
                                      onPressed: () {
                                        LocalData.removeUser();
                                        setState(() {
                                          user = null;
                                          body = buildAccount(context);
                                        });
                                        Navigator.pop(context);
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
