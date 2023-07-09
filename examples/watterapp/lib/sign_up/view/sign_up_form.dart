import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watterApp/sign_up/sign_up.dart';
import 'package:formz/formz.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            _EmailInput(),
            const SizedBox(height: 8),
            _PasswordInput(),
            const SizedBox(height: 8),
            _ConfirmPasswordInput(),
           // const SizedBox(height: 8),
          //  _SocietyKey(),
            const SizedBox(height: 8),
            _SignUpButton(),
            
          ],
        ),
      ),
    );
  }
}
/*
class _SocietyKey extends StatelessWidget { @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
           padding: const EdgeInsets.symmetric(horizontal:8.0),
          child: TextField(
            key: const Key('signUpForm_emailInput_textField'),
            onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            decoration: 
            InputDecoration(
              labelText: 'SocietyKey',
                helperText: '',
                filled: true,
                fillColor: Colors.grey[200], // Use light grey color
                errorText: state.email.invalid ? 'Invalid Key' : null,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                // Add these properties to change the text color
                hintStyle: TextStyle(color: Colors.black),
                labelStyle:TextStyle(color: Colors.black),
                errorStyle: TextStyle(color: Colors.black),
                suffixStyle:TextStyle(color: Colors.black),
                prefixStyle: TextStyle(color: Colors.black),
                counterStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
          ),
        );
      },
    );
  }

}
*/

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
           padding: const EdgeInsets.symmetric(horizontal:8.0),
          child: TextField(
            key: const Key('signUpForm_emailInput_textField'),
            onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            decoration: 
            InputDecoration(
              labelText: 'Email',
                helperText: '',
                filled: true,
                fillColor: Colors.grey[200], // Use light grey color
                errorText: state.email.invalid ? 'Invalid Email' : null,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                // Add these properties to change the text color
                hintStyle: TextStyle(color: Colors.black),
                labelStyle:TextStyle(color: Colors.black),
                errorStyle: TextStyle(color: Colors.black),
                suffixStyle:TextStyle(color: Colors.black),
                prefixStyle: TextStyle(color: Colors.black),
                counterStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
         padding: const EdgeInsets.symmetric(horizontal:8.0),
          child: TextField(
            key: const Key('signUpForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<SignUpCubit>().passwordChanged(password),
            obscureText: true,
            decoration: InputDecoration(
               labelText: 'Password',
                helperText: '',
                filled: true,
                fillColor: Colors.grey[200], // Use light grey color
                errorText: state.password.invalid ? 'Invalid Password' : null,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                // Add these properties to change the text color
                hintStyle: TextStyle(color: Colors.black),
                labelStyle:TextStyle(color: Colors.black),
                errorStyle: TextStyle(color: Colors.black),
                suffixStyle:TextStyle(color: Colors.black),
                prefixStyle: TextStyle(color: Colors.black),
                counterStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return Padding(
           padding: const EdgeInsets.symmetric(horizontal:8.0),
          child: TextField(
            key: const Key('signUpForm_confirmedPasswordInput_textField'),
            onChanged: (confirmPassword) => context
                .read<SignUpCubit>()
                .confirmedPasswordChanged(confirmPassword),
            obscureText: true,
            decoration: InputDecoration(
               labelText: 'Confirm Password',
                helperText: '',
                filled: true,
                fillColor: Colors.grey[200], // Use light grey color
               errorText: state.confirmedPassword.invalid
                  ? 'Passwords do not match'
                  : null,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                // Add these properties to change the text color
                hintStyle: TextStyle(color: Colors.black),
                labelStyle:TextStyle(color: Colors.black),
                errorStyle: TextStyle(color: Colors.black),
                suffixStyle:TextStyle(color: Colors.black),
                prefixStyle: TextStyle(color: Colors.black),
                counterStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
           
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('signUpForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.blue,
                ),
                onPressed: state.status.isValidated
                    ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                    : null,
                child: const Text('SIGN UP'),
              );
      },
    );
  }
}
