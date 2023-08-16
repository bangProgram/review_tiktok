import 'package:flutter/material.dart';
import 'package:review_tiktok/constants/gaps.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/tutorial/widgets/tutorial_sub_page_widget.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

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
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size24,
                  vertical: Sizes.size10,
                ),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size24,
                  vertical: Sizes.size10,
                ),
                child: const TutorialSubPageWidget(
                  title: '2. 약관의 동의',
                  subscriptList: [
                    '본 약관은 귀하가 본 약관에 동의하고 관련 서비스 이용 요청을 전송하여 당사가 해당 요청을 수락하면 효력이 발생합니다. 또한 당사 서비스에 접근하고 이를 이용하는 경우, 당사 커뮤니티 가이드라인 및 커뮤니티 정책을 준수하여야 하며, 이는 본 플랫폼에서 직접 확인하시거나 본 플랫폼을 다운로드할 수 있는 곳, 모바일 기기의 관련 앱 스토어에서 확인하실 수 있으며, 본 약관에도 참조로 포함되어 있습니다.',
                    '하기 각 관할권의 이용자들에게 해당하는 추가 약관은 귀하가 해당 약관에 동의하여 관련 서비스 이용 요청을 전송하여 당사가 해당 요청을 수락하면 효력이 발생합니다. 귀하가 본 서비스에 접속 또는 이용하는 권할 지역과 관련된 추가 약관 – 관할 지역에 따른 조항 본 약관의 나머지 규정이 상충하는 경우, 해당 관할 지역의 추가 약관 – 관할 지역에 따른 조항이 우선합니다. 본 약관에 동의하지 않는다면, 당사의 본 서비스에 접속 또는 이를 이용하여서는 안 됩니다. 본 서비스를 이용하는 경우, 귀하는 개인정보처리방침의 규정에 동의하는 것입니다.',
                    '귀하가 회사 또는 단체를 위하여 본 서비스에 접속 또는 이를 이용하고 있다면, (a) 이하에서 “귀하”는 해당 회사 또는 단체를 포함하고 (b) 귀하는 본 약관에 구속력을 부여할 수 있는 권한을 가지고 있는 자로서, 회사 또는 단체의 수권된 대표자이며, 해당 단체를 대표하여 본 약관에 동의함을 표명하고 보증하며 (c) 귀하의 회사 또는 단체는 법적, 재정적으로 본 서비스의 접속 및 이용을 비롯하여 귀하와 직원, 대리인, 계약자 등 귀하와 관련된 사람들이 귀하의 계정에 접속하거나 이를 사용하는 것에 대하여 책임이 있습니다.',
                    '귀하는 귀하의 향후의 서비스 접속 및 이용이 약관의 동의로 간주된다는 점에 대하여 이해하며 동의합니다.',
                    '귀하는 보관을 위하여 본 약관의 복사본을 출력하거나 저장하여야 합니다.'
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size24,
                  vertical: Sizes.size10,
                ),
                child: const TutorialSubPageWidget(
                  title: '3. 약관의 변경',
                  subscriptList: [
                    '당사는 본 서비스의 기능을 업데이트하는 경우, 당사 혹은 계열회사가 운영하는 여러 앱이나 서비스를 한 개의 종합 서비스나 앱으로 통합하는 경우, 규제가 변경되는 경우 등에 수시로 변경합니다.',
                    '당사는 본 약관이 중대하게 변경되는 경우 상업적으로 합리적인 노력을 다하여 본 플랫폼 상의 공지사항 등을 통하여 이러한 변경을 모든 이용자에게 일반적으로 통지할 것입니다. 다만, 귀하는 변경 여부를 확인하기 위하여 본 약관을 주기적으로 보아야 합니다.',
                    '당사는 본 약관의 효력 발생일을 기재한 “최신 업데이트” 일자를 본 약관의 상단에 업데이트할 것입니다. 귀하가 약관의 변경 이후에 계속하여 본 서비스에 접속하거나 이를 이용하는 것은 변경된 약관에 대하여 동의하는 것입니다. 당사의 새로운 약관에 동의하지 않는다면, 본 서비스 접속 또는 이용을 중지하시기 바랍니다.',
                    '서비스 약관의 이전 버전을 확인하시려면 여기를 클릭하시기 바랍니다.',
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size24,
                  vertical: Sizes.size10,
                ),
                child: const TutorialSubPageWidget(
                  title: '4. 계정',
                  subscriptList: [
                    '본 서비스 중 일부에 접속하거나 이를 이용하기 위하여서는 계정을 생성하여야 합니다. 귀하는 계정 생성 시 정확한 최신의 정보를 제공하여야 합니다. 귀하의 정보를 최신 정보로 완전하게 유지하기 위하여서는, 당사에게 제공한 귀하의 상세정보 및 기타 정보를 관리하고 신속하게 업데이트하는 것이 중요합니다.',
                    '귀하는 계정 비밀번호를 비밀로 유지하고 이를 제3자에게 공개하여서는 안 됩니다. 제3자가 귀하의 비밀번호를 알고 있거나, 귀하의 계정에 접속한 사실을 알거나 의심하는 경우라면, 즉시 https://www.tiktok.com/legal/report/feedback을 통해 당사에 알려야 합니다.',
                    '귀하는 자신의 계정을 통하여 이루어지는 활동에 관하여 (당사와 다른 이용자들에 대하여) 전적으로 책임을 진다는 점에 동의합니다 (단, TikTok의 고의 또는 중과실로 인하여 야기되는 경우는 제외합니다). ',
                    '당사는 귀하가 본 약관을 준수하지 않았다고 판단할 합리적인 사유가 있는 경우 또는 귀하의 계정에서의 활동이 본 서비스에 대한 피해 또는 손상을 발생시키거나, 여하한 제3자의 권리를 침해하였거나, 여하한 관련 법령 또는 규제에 위반하였거나 그러할 가능성이 있다고 판단되는 경우, 귀하의 계정을 사용할 수 없도록 할 권리가 있습니다.',
                    '귀하가 더 이상 본 서비스를 이용하지 않고 계정 삭제를 원하는 경우, 당사가 이를 처리하여 드릴 수 있습니다. https://www.tiktok.com/legal/report/feedback을 통해 당사에 연락하시면, 귀하를 도와 드리고 관련 절차를 안내하여 드리겠습니다. 일단 계정을 삭제하면 귀하는 계정을 재활성화할 수 없으며 귀하가 추가한 콘텐츠 혹은 정보를 불러올 수 없습니다.',
                  ],
                ),
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
