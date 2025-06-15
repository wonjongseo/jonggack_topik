import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/onboarding/controller/onboarding_controller.dart';

class Onboarding5 extends StatefulWidget {
  const Onboarding5({super.key});

  @override
  State<Onboarding5> createState() => _Onboarding5State();
}

class _Onboarding5State extends State<Onboarding5> {
  int _value = 0;

  // 누적 스크롤 양을 저장할 변수
  double _scrollAccumulator = 0;

  // 이 값보다 많은 누적량이 모여야 1씩 변경
  static const double _threshold = 24.0;

  void _onScroll(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      // 마우스 휠 ↑ 은 scrollDelta.dy < 0 이므로, 부호를 뒤집어 +로 축적
      _scrollAccumulator += -event.scrollDelta.dy;

      // 누적량이 임계치 이상이면 +1
      if (_scrollAccumulator >= _threshold) {
        setState(() {
          _value = (_value + 1).clamp(0, 1000);
        });
        _scrollAccumulator -= _threshold; // 사용한 만큼 빼줌
      }
      // 누적량이 –임계치 이하이면 –1
      else if (_scrollAccumulator <= -_threshold) {
        setState(() {
          _value = (_value - 1).clamp(0, 1000);
        });
        _scrollAccumulator += _threshold;
      }
    }
  }

  // 모바일 드래그용도 동일하게 임계치 적용
  void _onDrag(DragUpdateDetails details) {
    _scrollAccumulator += -details.delta.dy;
    if (_scrollAccumulator >= _threshold) {
      setState(() {
        _value = (_value + 1).clamp(0, 1000);
      });
      _scrollAccumulator -= _threshold;
    } else if (_scrollAccumulator <= -_threshold) {
      setState(() {
        _value = (_value - 1).clamp(0, 1000);
      });
      _scrollAccumulator += _threshold;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Listener(
        onPointerSignal: _onScroll,
        child: GestureDetector(
          onVerticalDragUpdate: _onDrag,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.primaryColor, width: 2),
                bottom: BorderSide(color: AppColors.primaryColor, width: 2),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('$_value', style: TextStyle(fontSize: 36)),
          ),
        ),
      ),
    );
  }
}

class Onboarding4 extends StatelessWidget {
  const Onboarding4({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Column(
        children: [
          SizedBox(height: 16),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(text: AppString.selectCountOfStudy.tr),
                TextSpan(text: '\n'),
                TextSpan(text: AppString.plzSelectCountOfStudy.tr),
              ],
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppString.countOfStudy.tr,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  Icon(Icons.keyboard_arrow_up),
                  GetBuilder<OnboardingController>(
                    builder: (controller) {
                      return Listener(
                        behavior:
                            HitTestBehavior.translucent, // ★ 부모가 먼저 이벤트 처리
                        onPointerSignal: controller.onScroll,
                        child: GestureDetector(
                          behavior:
                              HitTestBehavior.translucent, // ★ 부모가 먼저 이벤트 처리
                          onVerticalDragUpdate: controller.onDrag,
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: AppColors.primaryColor,
                                  width: 2,
                                ),
                                bottom: BorderSide(
                                  color: AppColors.primaryColor,
                                  width: 2,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: TextField(
                                controller: controller.teCtl,
                                showCursor: false,
                                scrollPhysics: NeverScrollableScrollPhysics(),
                                enableInteractiveSelection:
                                    false, // ★ 선택/돋보기 비활성
                                // ignore: deprecated_member_use
                                toolbarOptions: const ToolbarOptions(
                                  // ★ 툴바 메뉴 비활성
                                  copy: false,
                                  cut: false,
                                  paste: false,
                                  selectAll: false,
                                ),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 30),
                                maxLength: 3,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  counterText: "",
                                ),
                                keyboardType: TextInputType.numberWithOptions(),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ],
          ),

          Spacer(),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
