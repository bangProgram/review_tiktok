import 'package:flutter/material.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';

class TutorialSubScreen extends StatefulWidget {
  const TutorialSubScreen({super.key});

  @override
  State<TutorialSubScreen> createState() => _TutorialSubScreenState();
}

class _TutorialSubScreenState extends State<TutorialSubScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('일반 규정 – 모든 이용자'),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v16,
                    Text(
                      '1. 당사와의 관계',
                      style: TextStyle(
                        fontSize: Sizes.size28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v16,
                    Text(
                      'TikTok Pte. Ltd. 또는 그 계열사 중 한 곳(특히 미국의 경우, TikTok, Inc.) (이하 통칭하여 “TikTok” 또는 “당사”)이 제공하는 TikTok (이하 “본 플랫폼”)에 오신 것을 환영합니다.',
                      style: TextStyle(
                        fontSize: Sizes.size14,
                      ),
                    ),
                    Gaps.v16,
                    Text(
                        '본 약관은 당사 관련 웹사이트, 서비스, 어플리케이션, 제품 및 콘텐츠(이하 통칭하여 “본 서비스”) 이용을 위하여 귀하와 당사의 관계를 규정하는 서비스약관(이하 “본 약관”)입니다. 당사의 본 서비스는 사적이고 비상업적인 목적을 위하여 제공됩니다. 본 약관에서 “귀하”란 귀하와 기타 본 서비스 이용자들을 지칭합니다.'),
                    Gaps.v16,
                    Text(
                        '본 약관은 귀하와 당사 사이의 법적 효력이 있는 계약입니다. 이하 내용은 충분한 시간을 가지고 주의 깊게 읽어주십시오.'),
                    Gaps.v16,
                    Text(
                        '미국 이용자들에 대한 중재 통지: 본 약관은 중재 조항 및 당사를 상대로 하는 집단소송 제기권의 포기를 포함하고 있습니다. 위 중재 조항에 언급된 특정 유형의 분쟁을 제외하고, 귀하와 TIKTOK는 양 당사자들간의 분쟁을 강제적이고 구속력 있는 중재로 해결하며, 귀하와 TIKTOK는 집단소송 또는 집단적 중재에 참여할 권리를 포기하는 것에 동의합니다.'),
                  ],
                ),
              ),
              Container(
                child: const Text('2'),
              ),
              Container(
                child: const Text('3'),
              ),
              Container(
                child: const Text('4'),
              ),
              Container(
                child: const Text('5'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomAppBar(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: Sizes.size20),
                child: TabPageSelector(
                  selectedColor: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
