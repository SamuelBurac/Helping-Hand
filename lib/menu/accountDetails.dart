import 'package:flutter/material.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:helping_hand/services/auth.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:helping_hand/services/models.dart';
import 'package:provider/provider.dart';
part 'accountDetailsController.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Details'),
      ),
      body: SingleChildScrollView(
        child: ChangeNotifierProvider(
          create: (context) => AccountDetailsController(context),
          child: Consumer<AccountDetailsController>(
            builder: (context, controller, child) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    EditTextWithButton(
                      controller: controller.firstNameController,
                      labelText: "First Name",
                      onPressed: () async {
                        controller.setIsEditingFName =
                            !controller.getIsEditingFName;
                        if (!controller.isEditing &&
                            controller.verifyInputs()) {
                          try {
                            await controller.updateProfile();
                          } catch (e) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Banner(
                                  message:
                                      'An error occurred. Please try again.',
                                  location: BannerLocation.topEnd,
                                  color: Colors.red,
                                  layoutDirection: TextDirection.ltr,
                                  child: Container(),
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                    const Divider(),
                    EditTextWithButton(
                      controller: controller.lastNameController,
                      labelText: "Last Name",
                      onPressed: () async {
                        controller.setIsEditingLName =
                            !controller.getIsEditingLName;
                        if (!controller.isEditing &&
                            controller.verifyInputs()) {
                          try {
                            await controller.updateProfile();
                          } catch (e) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Banner(
                                  message:
                                      'An error occurred. Please try again.',
                                  location: BannerLocation.topEnd,
                                  color: Colors.red,
                                  layoutDirection: TextDirection.ltr,
                                  child: Container(),
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                    const Divider(),
                    EditTextWithButton(
                      controller: controller.emailController,
                      labelText: "Email",
                      onPressed: () async {
                        controller.setIsEditingEmail =
                            !controller.getIsEditingEmail;
                        if (!controller.isEditing &&
                            controller.verifyInputs()) {
                          try {
                            String? password = await showDialog<String>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Reauthenticate'),
                                  content: TextField(
                                    controller: controller.passwordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                        labelText:
                                            'Enter your current password'),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop(null);
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Submit'),
                                      onPressed: () {
                                        Navigator.of(context).pop(
                                            controller.passwordController.text);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );

                            if (password == null || password.isEmpty) {
                              // User cancelled the reauthentication
                              controller.setIsEditingEmail = false;
                              return;
                            }
                            await controller.updateProfile();
                          } catch (e) {
                            print("in error");
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Banner(
                                  message:
                                      'An error occurred. Please try again.',
                                  location: BannerLocation.topEnd,
                                  color: Colors.red,
                                  layoutDirection: TextDirection.ltr,
                                  child: Container(),
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                    const Divider(),
                    EditTextWithButton(
                      controller: controller.phoneNumberController,
                      labelText: "Phone Number",
                      onPressed: () async {
                        controller.setIsEditingPhone =
                            !controller.getIsEditingPhone;
                        if (!controller.isEditing &&
                            controller.verifyInputs()) {
                          try {
                            await controller.updateProfile();
                          } catch (e) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Banner(
                                  message:
                                      'An error occurred. Please try again.',
                                  location: BannerLocation.topEnd,
                                  color: Colors.red,
                                  layoutDirection: TextDirection.ltr,
                                  child: Container(),
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                    const Divider(),
                    EditTextWithButton(
                      controller: controller.locationController,
                      labelText: "Location",
                      onPressed: () async {
                        controller.setIsEditingLocation =
                            !controller.getIsEditingLocation;
                        if (!controller.isEditing &&
                            controller.verifyInputs()) {
                          try {
                            await controller.updateProfile();
                          } catch (e) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Banner(
                                  message:
                                      'An error occurred. Please try again.',
                                  location: BannerLocation.topEnd,
                                  color: Colors.red,
                                  layoutDirection: TextDirection.ltr,
                                  child: Container(),
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                    const Divider(),
                    EditTextWithButton(
                      controller: controller.descriptionController,
                      labelText: "Description",
                      maxLines: 3,
                      onPressed: () async {
                        controller.setIsEditingDescription =
                            !controller.getIsEditingDescription;
                        if (!controller.isEditing &&
                            controller.verifyInputs()) {
                          try {
                            await controller.updateProfile();
                          } catch (e) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Banner(
                                  message:
                                      'An error occurred. Please try again.',
                                  location: BannerLocation.topEnd,
                                  color: Colors.red,
                                  layoutDirection: TextDirection.ltr,
                                  child: Container(),
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                    const Divider(),
                    CheckboxListTile(
                      title: const Text(
                        "Display phone number on profile page?",
                        style: TextStyle(fontSize: 20),
                      ),
                      activeColor: Colors.orange,
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: controller.displayPhoneNumber,
                      onChanged: (bool? value) {
                        controller.setDisplayPhoneNumber = value!;
                        if (!controller.isEditing &&
                            controller.verifyInputs()) {
                          controller.updateProfile();
                        }
                      },
                    ),
                    const Divider(),
                    CheckboxListTile(
                      title: const Text(
                        "Looking for work?",
                        style: TextStyle(fontSize: 20),
                      ),
                      activeColor: Colors.orange,
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: controller.lookingForWork,
                      onChanged: (bool? value) {
                        controller.setLookingForWork = value!;
                        if (!controller.isEditing &&
                            controller.verifyInputs()) {
                          controller.updateProfile();
                        }
                      },
                    ),
                    const Divider(),
                    CheckboxListTile(
                      title: const Text(
                        "Looking for workers?",
                        style: TextStyle(fontSize: 20),
                      ),
                      activeColor: Colors.orange,
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: controller.lookingForWorkers,
                      onChanged: (bool? value) {
                        controller.setLookingForWorkers = value!;
                        if (!controller.isEditing &&
                            controller.verifyInputs()) {
                          controller.updateProfile();
                        }
                      },
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(Icons.delete_forever_rounded),
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style!
                              .copyWith(
                                backgroundColor:
                                    WidgetStateProperty.all<Color>(Colors.red),
                              ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Delete Account"),
                                  content: const Text(
                                      "Are you sure you want to delete your account?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      style: Theme.of(context)
                                          .textButtonTheme
                                          .style!
                                          .copyWith(
                                            backgroundColor:
                                                WidgetStateProperty.all<Color>(
                                                    Colors.red),
                                          ),
                                      onPressed: () {
                                        FirestoreService().deleteUser(
                                            Provider.of<UserState>(context,
                                                    listen: false)
                                                .user);
                                        Provider.of<UserState>(context,
                                                listen: false)
                                            .user = User();
                                        Navigator.popAndPushNamed(context, "/");
                                      },
                                      child: const Text("Delete"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          label: const Text(
                            "Delete\n Account",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        ElevatedButton(
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style!
                              .copyWith(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    Colors.green.shade700),
                              ),
                          onPressed: () async {
                            try {
                              await AuthService()
                                  .resetPass(controller.getEmail);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AlertDialog(
                                    title: Text('Success'),
                                    content: Text(
                                        'Password reset email has been sent.'),
                                    actions: [
                                      Text('OK'),
                                    ],
                                  );
                                },
                              );
                              Navigator.of(context).popAndPushNamed("/");
                            } catch (e) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Error'),
                                    content: Text(
                                        'An error occurred. Please try again.$e'),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: const Text(
                            "Reset\n Password",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
