// import 'package:adaptive_theme/adaptive_theme.dart';
// import 'package:client_id/app/di/init_di.dart';
// import 'package:client_id/app/domain/app_api.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:client_id/app/domain/error_entity.dart/error_entity.dart';
import 'package:client_id/app/ui/app_loader.dart';
//import 'package:client_id/app/ui/app_theme_widget.dart';
import 'package:client_id/app/ui/components/app_dialog.dart';
import 'package:client_id/app/ui/components/app_snack_bar.dart';
import 'package:client_id/app/ui/components/app_text_button.dart';
import 'package:client_id/app/ui/components/app_text_field.dart';
import 'package:client_id/feature/auth/domain/auth_state/auth_cubit.dart';
//import 'package:client_id/feature/auth/domain/entities/user_entity/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<AuthCubit>().logOut();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
        state.whenOrNull(authorized: (userEntity) {
          if (userEntity.userState?.hasData == true) {
            AppSnackBar.showSnackBarWithMessage(
                context, userEntity.userState?.data);
          }
          if (userEntity.userState?.hasError == true) {
            AppSnackBar.showSnackBarWithError(context,
                ErrorEntity.fromException(userEntity.userState?.error));
          }
        });
      }, builder: (context, state) {
        final userEntity =
            state.whenOrNull(authorized: (userEntity) => userEntity);
        if (userEntity?.userState?.connectionState == ConnectionState.waiting) {
          return const AppLoader();
        }
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.red,
                child: Text(
                    style: const TextStyle(fontSize: 50),
                    userEntity?.username.split("").first ?? "Unnamed"),
              ),
              const SizedBox(width: 16),
              Column(
                children: [
                  Container(
                      child: Column(children: [
                    Text(
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        userEntity?.username ?? "Unnamed"),
                    Text(
                        style: const TextStyle(fontSize: 20),
                        userEntity?.email ?? "Unnamed"),
                  ]))
                ],
              ),
            ]),
            const Padding(padding: EdgeInsets.only(top: 50)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AppDialog(
                              val1: "Old Password",
                              val2: "New Password",
                              onPressed: (v1, v2) {
                                context.read<AuthCubit>().passwordUpdate(
                                    newPassword: v2, oldPassword: v1);
                              }));
                    },
                    child: const Text(
                        style: TextStyle(fontSize: 23), "Edit Password")),
                TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AppDialog(
                              val1: "Username",
                              val2: "Email",
                              onPressed: (v1, v2) {
                                context
                                    .read<AuthCubit>()
                                    .userUpdate(email: v2, username: v1);
                              }));
                    },
                    child: const Text(
                        style: TextStyle(fontSize: 23), "Edit Data")),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 50)),
            const Text(
              'You can switch between light and dark theme using the switch below.',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Light',
                    style: TextStyle(
                      fontSize: 16,
                    )),
                const SizedBox(width: 10),
                Switch(
                  value: AdaptiveTheme.of(context).mode.isDark,
                  onChanged: (value) {
                    if (value) {
                      AdaptiveTheme.of(context).setDark();
                    } else {
                      AdaptiveTheme.of(context).setLight();
                    }
                  },
                ),
                const SizedBox(width: 10),
                const Text(
                  'Dark',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ]),
        );
      }),
    );
  }
}
