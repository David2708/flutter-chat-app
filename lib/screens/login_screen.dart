import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Logo(titulo: 'Messeger'),

                  _Form(),

                  Labels(
                    ruta: 'register',
                    titulo: 'No Tienes una cuenta',
                    subtitulo: 'Crea una ahora',
                  ),

                  Text('Terminos y condiciones de uso')
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  const _Form({
    Key? key,
  }) : super(key: key);

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);


    return SizedBox(
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            CustomInput(
              hintText: 'Correo',
              icon: Icons.mail_outline_outlined,
              keyboardType: TextInputType.emailAddress,
              textController: emailCtrl,
              isPassword: false,
            ),
            CustomInput(
              hintText: 'Contraseña',
              icon: Icons.lock_outline,
              textController: passCtrl,
              isPassword: true,
            ),
            BotonAzul(
              text: 'Ingresar',
              color: authService.autenticando ? Colors.grey : Colors.blue,
              onPressed: authService.autenticando ? (){} : () async {
                print(emailCtrl.text);
                print(passCtrl.text);

                FocusScope.of(context).unfocus();

                final loginOk =  await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());

                if( loginOk ){
                  //todo: conectar al socket server
                  Navigator.pushReplacementNamed(context, 'users');
                } else{
                  mostrarAlerta(context, 'Login incorrecto', 'Revise sus credenciales nuevamente');
                }
                
              },
            )
          ],
        ),
      ),
    );
  }
}
