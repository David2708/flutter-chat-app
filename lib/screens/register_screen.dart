import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/mostrar_alerta.dart';
import '../services/auth_services.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
              Logo(titulo: 'Registro',),
              _Form(),
              Labels(ruta: 'login', subtitulo: 'Ingresa ahora', titulo: 'Tienes una cuenta',),
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
  final nameCtrl = TextEditingController();

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
              hintText: 'Nombre',
              icon: Icons.perm_identity,
              keyboardType: TextInputType.text,
              textController: nameCtrl,
              isPassword: false,
            ),
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
              text: 'Registrarse',
              color: authService.autenticando ? Colors.grey : null,
              onPressed: authService.autenticando ? (){} : () async{

                FocusScope.of(context).unfocus();

                final registerOk = await authService.register(
                  nameCtrl.text.trim(), emailCtrl.text.trim(), passCtrl.text.trim()
                );

                if(registerOk == true){
                  // todo: conectar con socketserver
                  Navigator.pushReplacementNamed(context, 'users');
                } else{
                  mostrarAlerta(context, 'Registro incorrecto', registerOk);
                }



              },
            )
          ],
        ),
      ),
    );
  }
}
