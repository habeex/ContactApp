import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reqresapp/bloc/user_bloc.dart';
import 'package:reqresapp/feature/widget/edit_text.dart';
import 'package:reqresapp/model/user_model.dart';
import 'package:reqresapp/utils/input_validator.dart';

class AddUserScreen extends StatefulWidget {
  AddUserScreen({Key? key, required this.bloc}) : super(key: key);
  UserCubit bloc;

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  User userForm = User(id: 0);
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new contact',
            style: TextStyle(color: Colors.white, fontSize: 24)),
        centerTitle: false,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: BlocListener<UserCubit, UserState>(
              bloc: widget.bloc,
              listener: (context, state) {
                if (state is LoadedUserState) {
                  isLoading = true;
                  errorMessage = '';
                  setState(() {});
                }
                if (state is ErrorAddUserState) {
                  isLoading = false;
                  errorMessage = state.exception;
                  setState(() {});
                }
                if (state is AddUserSuccessState) {
                  Navigator.of(context).pop();
                }
              },
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    EditText(
                      labelText: 'Firstname',
                      keyboardType: TextInputType.name,
                      validator: InputValidator.text,
                      autovalidateMode: autovalidateMode,
                      onSaved: (value) {
                        userForm.firstName = value?.trim();
                      },
                    ),
                    const SizedBox(height: 8),
                    EditText(
                      labelText: 'Lastname',
                      keyboardType: TextInputType.name,
                      validator: InputValidator.text,
                      autovalidateMode: autovalidateMode,
                      onSaved: (value) {
                        userForm.lastName = value?.trim();
                      },
                    ),
                    const SizedBox(height: 8),
                    EditText(
                      labelText: 'Email Address',
                      keyboardType: TextInputType.emailAddress,
                      validator: InputValidator.text,
                      autovalidateMode: autovalidateMode,
                      onSaved: (value) {
                        userForm.email = value?.trim();
                      },
                    ),
                    const SizedBox(height: 16),
                    isLoading
                        ? const SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: _addNewUser,
                            child: const Text('Add contact')),
                    if (errorMessage.isNotEmpty)
                      Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.red),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _addNewUser() async {
    final form = _formKey.currentState;
    if (form?.validate() ?? false) {
      form?.save();
      setState(() {
        isLoading = true;
      });
      widget.bloc.addUser(userForm);
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.onUserInteraction;
      });
    }
  }
}
