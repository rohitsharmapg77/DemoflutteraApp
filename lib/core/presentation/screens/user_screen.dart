import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../apiwithmodels/viewmodels/user_viewmodel.dart';


class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("यूज़र लिस्ट")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => viewModel.fetchUserData(),
            child: Text("यूज़र्स लोड करें"),
          ),
          viewModel.isLoading
              ? CircularProgressIndicator()
              : Expanded(
            child: ListView.builder(
              itemCount: viewModel.users.length,
              itemBuilder: (context, index) {
                final user = viewModel.users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}