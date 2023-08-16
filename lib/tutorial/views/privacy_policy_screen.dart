import 'package:flutter/material.dart';
import 'package:review_tiktok/constants/sizes.dart';
import 'package:review_tiktok/tutorial/widgets/tutorial_sub_page_widget.dart';

enum Page { first, second }

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  Page _currPage = Page.first;

  void _navPop(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    print(details.delta.dx);
    if (details.delta.dx > 3) {
      _currPage = Page.first;
    } else if (details.delta.dx < -3) {
      _currPage = Page.second;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Policy'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close_outlined),
            onPressed: () => _navPop(context),
          ),
        ],
      ),
      body: GestureDetector(
        onPanUpdate: _onPanUpdate,
        child: AnimatedCrossFade(
          firstChild: Container(
            color: Colors.white,
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
          secondChild: Container(
            color: Colors.white,
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
          firstCurve: Curves.linear,
          secondCurve: Curves.linear,
          crossFadeState: _currPage == Page.first
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(
            milliseconds: 300,
          ),
        ),
      ),
    );
  }
}
