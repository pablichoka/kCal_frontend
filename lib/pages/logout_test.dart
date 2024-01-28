
import 'package:flutter/material.dart';
import 'package:kcal_control_frontend/widgets/app_bar.dart';
import 'package:kcal_control_frontend/services/api_service.dart' as api;
import 'package:kcal_control_frontend/pages/index.dart';

class LogoutTest extends StatefulWidget {
  const LogoutTest({super.key});

  @override
  State<LogoutTest> createState() => _LogoutTestState();
}

class _LogoutTestState extends State<LogoutTest> {
  Map<String, dynamic> _response = {"":""};
  bool _isLoading = true;
  late final BuildContext? _navigationContext;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    try {
      final response = await api.ApiService.instance.getNoAuth("/get-data/${api.ApiService.instance.id}");
      setState(() {
        _response = response;
        print(_response);
        _isLoading = false;
      });
    } on Exception catch (e) {
      print('Hubo un error al obtener los datos: $e');
    }
  }

  Future<bool> _logout() async {
      try {
        _navigationContext = context;
        return await api.ApiService.instance.logout();
      } catch (e) {
        throw ('Error: $e');
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DAppBar(title: "logout", returnable: false),
      body: Column(
        children: [
          _isLoading
              ? const Center(
                  child:
                      CircularProgressIndicator())
              : Center(child: Text(_response['username'])),
          ElevatedButton(
            onPressed: () async {
              if (await _logout()) {
                Navigator.pushReplacement(_navigationContext!, MaterialPageRoute(builder: (ctx) => const WebIndex()));
              } else {
                ScaffoldMessenger.of(_navigationContext!).showSnackBar(
                  const SnackBar(
                    content: Text('There was an error during logout.'),
                  ),
                );
              }
            },
            child: Text('Logout', style: Theme.of(context).textTheme.headlineSmall),
          ),
        ],
      ),
    );
  }
}
