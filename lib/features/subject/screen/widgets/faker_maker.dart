import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/features/auth/controllers/user_controller.dart';

class VerifyPage extends StatelessWidget {
  const VerifyPage({Key? key}) : super(key: key);

  void _onOtpCompleted(String code) {
    // 인증번호 4자리(code) 전송 또는 검증 로직
    print('입력된 OTP: $code');
    if (code == '3859') {
      print('GOOD');
      UserController.to.grantFakeToUser();
      Get.back();
    } else {
      print('BED');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Center(child: OtpInputField(onCompleted: _onOtpCompleted)),
      ),
    );
  }
}

class OtpInputField extends StatefulWidget {
  final void Function(String) onCompleted;
  const OtpInputField({Key? key, required this.onCompleted}) : super(key: key);

  @override
  _OtpInputFieldState createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    _focusNodes.forEach((f) => f.dispose());
    _controllers.forEach((c) => c.dispose());
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.length > 1) {
      // 붙여넣기 처리: 앞칸부터 채우고 포커스 이동
      final chars = value.characters.toList();
      for (int i = 0; i < chars.length && index + i < 4; i++) {
        _controllers[index + i].text = chars[i];
      }
      int next = index + chars.length;
      if (next < 4) {
        FocusScope.of(context).requestFocus(_focusNodes[next]);
      } else {
        _submit();
      }
      return;
    }

    if (value.isNotEmpty) {
      // 다음 칸으로 포커스 이동
      if (index < 3) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        _submit();
      }
    } else {
      // 지우면 이전 칸으로 포커스
      if (index > 0) {
        FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
      }
    }
  }

  void _submit() {
    final code = _controllers.map((c) => c.text).join();
    if (code.length == 4) {
      widget.onCompleted(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (i) {
        return SizedBox(
          width: 50,
          child: TextField(
            controller: _controllers[i],
            focusNode: _focusNodes[i],
            autofocus: i == 0,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (v) => _onChanged(i, v),
          ),
        );
      }),
    );
  }
}
