
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_for_show/core/constants.dart';
import 'package:flutter_for_show/core/extensions/color_scheme_extensions.dart';
import 'package:flutter_for_show/core/bloc/bloc_instance_provider.dart';
import 'package:flutter_for_show/core/widgets/body_text_1.dart';
import 'package:flutter_for_show/core/widgets/body_text_2.dart';
import 'package:flutter_for_show/core/widgets/caption_text.dart';
import 'package:flutter_for_show/core/widgets/custom_check_box.dart';
import 'package:flutter_for_show/core/widgets/elevated_main_button.dart';
import 'package:flutter_for_show/core/widgets/international_phone_input/utils/phone_number.dart';
import 'package:flutter_for_show/core/widgets/international_phone_input/utils/selector_config.dart';
import 'package:flutter_for_show/core/widgets/international_phone_input/widgets/input_widget.dart';
import 'package:flutter_for_show/core/widgets/local_text_provider.dart';
import 'package:flutter_for_show/core/widgets/positioned_aligned.dart';
import 'package:flutter_for_show/feature/authorization/presentation/registration/registration_page/bloc/registration_bloc.dart';
import 'package:flutter_for_show/feature/authorization/presentation/registration/registration_page/bloc/registration_event.dart';
import 'package:flutter_for_show/feature/authorization/presentation/registration/registration_page/bloc/registration_state.dart';
import 'package:flutter_for_show/feature/authorization/presentation/registration/registration_page/registration_step.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _NewRegistrationPageState();
}

class _NewRegistrationPageState extends StateWithBloc<RegistrationBloc, RegistrationPage>
    with TickerProviderStateMixin, LocaleTextProvider {
  late TextEditingController _phoneController;

  final Duration animationDuration = Duration(milliseconds: 350);
  late Animation<double> animation;
  late AnimationController controller;

  RegistrationStep currentStep = RegistrationStep.terms;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();

    controller = AnimationController(duration: animationDuration, vsync: this);

    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (bloc.state.step == RegistrationStep.phone_input) {
            _phoneController.clear();
            bloc.add(OnBackClickedEvent());
            return false;
          } else {
            return true;
          }
        },
        child: BlocConsumer(
            bloc: bloc,
            listener: (context, RegistrationState state) {
              if (state.step != currentStep) {
                if (currentStep == RegistrationStep.welcome && state.step == RegistrationStep.phone_input) {
                  controller.forward();
                } else if (currentStep == RegistrationStep.phone_input && state.step == RegistrationStep.welcome) {
                  controller.reverse();
                }
                currentStep = state.step;
              }
            },
            builder: (context, RegistrationState state) {
              if (state.isLoading) {
                return SafeArea(
                  child: Center(
                    child: SizedBox(
                      height: 48,
                      width: 48,
                      child: AnimatedCrossFade(
                        firstChild: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                            backgroundColor: Theme.of(context).colorScheme.background,
                          ),
                        ),
                        secondChild: SvgPicture.asset(
                          "$SVG_PATH/successfylly_registration_icon.svg",
                          width: 44,
                          height: 44,
                        ),
                        duration: animationDuration,
                        crossFadeState:
                            state.isRegistrationSuccessful ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                      ),
                    ),
                  ),
                );
              }
              return SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) => Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: Stack(
                      children: [
                        ..._buildLogo(state, constraints),
                        ..._buildChild(state),
                        ..._buildPhone(state),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Size getLogoSize() {
    final fullWidth = 212;
    final shrinkWidth = 35;
    final fullHeight = 134;
    final shrinkHeight = 22;

    return Size(
      fullWidth - (fullWidth - shrinkWidth) * animation.value,
      fullHeight - (fullHeight - shrinkHeight) * animation.value,
    );
  }

  Size getLabelSize() {
    final fullWidth = 167;
    final shrinkWidth = 57;
    final fullHeight = 22;
    final shrinkHeight = 10;

    return Size(
      fullWidth - (fullWidth - shrinkWidth) * animation.value,
      fullHeight - (fullHeight - shrinkHeight) * animation.value,
    );
  }

  List<Widget> _buildLogo(RegistrationState state, BoxConstraints constraints) {
    final logoSize = getLogoSize();
    final labelSize = getLabelSize();
    return [
      Positioned(
        left: 4,
        child: AnimatedOpacity(
          opacity: state.step == RegistrationStep.phone_input ? 1 : 0,
          duration: animationDuration,
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: BackButton(
                onPressed: state.step == RegistrationStep.phone_input
                    ? () {
                        _phoneController.clear();
                        bloc.add(OnBackClickedEvent());
                      }
                    : null),
          ),
        ),
      ),
      Positioned(
        top: 92 - (75 * animation.value),
        left: 56 + (constraints.maxWidth / 2 - logoSize.width / 2 - 56) * (1 - animation.value),
        child: Image.asset(
          "assets/graphics/i_talent_logo.png",
          width: logoSize.width,
          height: logoSize.height,
        ),
      ),
      Positioned(
        top: 238 - (215 * animation.value),
        left: 96 + (constraints.maxWidth / 2 - labelSize.width / 2 - 96) * (1 - animation.value),
        child: Image.asset(
          "assets/graphics/i_talent_label.png",
          width: labelSize.width,
          height: labelSize.height,
        ),
      ),
    ];
  }

  List<Widget> _buildChild(RegistrationState state) {
    switch (state.step) {
      case RegistrationStep.terms:
        return _buildTerms(state);
      case RegistrationStep.welcome:
      case RegistrationStep.phone_input:
        return _buildWelcome(state);
    }
  }

  List<Widget> _buildTerms(RegistrationState state) {
    return [
      Positioned(
          top: 371,
          left: 47,
          right: 47,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomCheckbox(
                value: state.isTermsAccepted,
                onChanged: (value) {
                  bloc.add(AcceptedTermsEvent(value!));
                },
                side: BorderSide(color: Theme.of(context).colorScheme.primary),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                checkColor: Theme.of(context).colorScheme.primary,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 17, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BodyText2(local.accept_read_terms, color: Theme.of(context).colorScheme.optional2),
                      InkWell(
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: "In real app redirect to Terms",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8.0,
                            right: 8,
                          ),
                          child: BodyText2(
                            local.user_agreement,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
      PositionedAligned(
        top: 488,
        left: 56,
        right: 56,
        child: ElevatedMainButton(
          title: local.continue_title,
          onTap: state.isTermsAccepted
              ? () {
                  setState(() {
                    bloc.add(OnTermsNextCLicked());
                  });
                }
              : null,
          width: 270,
          height: 56,
        ),
      ),
    ];
  }

  List<Widget> _buildWelcome(RegistrationState state) {
    if (animation.value > 0.75) return [];

    var opacity = (0.5 - animation.value) * 2;
    if (opacity < 0) opacity = 0;

    var offset = (72) * animation.value * 2;
    if (offset > 72) offset = 72;

    double mainOpacity;
    if (animation.value <= 0.5) {
      mainOpacity = 1;
    } else {
      mainOpacity = (1 - (animation.value - 0.5) * 4);
      if (mainOpacity < 0) mainOpacity = 0;
    }

    return [
      PositionedAligned(
        top: 378 - offset,
        left: 56,
        right: 56,
        child: Opacity(
          opacity: mainOpacity,
          child: Align(
            alignment: Alignment.center,
            child: ElevatedMainButton(
              title: local.phone_signing,
              onTap: () {
                setState(() {
                  bloc.add(OnRegisterButtonClickedEvent());
                });
              },
              width: 270,
              height: 56,
            ),
          ),
        ),
      ),
      if(Platform.isIOS)
      PositionedAligned(
        top: 485 + (200) * animation.value,
        left: 56,
        right: 56,
        child: Opacity(
          opacity: opacity,
          child: _buildSignButton(
              icon: Image.asset(
                "assets/graphics/apple_icon.png",
                width: 31,
                height: 31,
              ),
              onPressed: () {
                bloc.add(OnAppleCLickedEvent());
              },
              title: local.apple_signing),
        ),
      ),
      PositionedAligned(
        top: 551 + (200) * animation.value,
        left: 56,
        right: 56,
        child: Opacity(
          opacity: opacity,
          child: _buildSignButton(
              icon: SvgPicture.asset(
                "$SVG_PATH/google_icon.svg",
                width: 31,
                height: 31,
              ),
              onPressed: () {
                bloc.add(OnGoogleCLickedEvent());
              },
              title: local.google_signing),
        ),
      ),
      PositionedAligned(
        top: 617 + (200) * animation.value,
        left: 56,
        right: 56,
        child: Opacity(
          opacity: opacity,
          child: _buildSignButton(
              icon: SvgPicture.asset(
                "$SVG_PATH/fb_icon.svg",
                width: 31,
                height: 31,
              ),
              onPressed: () {
                bloc.add(OnFacebookCLickedEvent());
              },
              title: local.fb_signing),
        ),
      ),
    ];
  }

  List<Widget> _buildPhone(RegistrationState state) {
    if (animation.value < 0.5) return [];

    final opacity = (animation.value - 0.5) * 2;

    double mainOpacity;
    if (animation.value <= 0.75) {
      mainOpacity = 0;
    } else {
      mainOpacity = (animation.value - 0.75) * 4;
      if (mainOpacity > 1) mainOpacity = 1;
    }

    return [
      Positioned(
        top: 221,
        left: 56,
        right: 56,
        child: Opacity(
          opacity: opacity,
          child: InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              bloc.add(OnPhoneChangeEvent(number));
            },
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            ignoreBlank: false,
            initialValue: state.phoneNumber ?? PhoneNumber(isoCode: "RU"),
            autoValidateMode: AutovalidateMode.disabled,
            textFieldController: _phoneController,
            formatInput: false,
            labelText: local.your_phone,
            hintText: local.phone_hint,
            countrySelectorScrollControlled: true,
            keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
          ),
        ),
      ),
      if (animation.value > 0.75)
        PositionedAligned(
          top: 306,
          left: 56,
          right: 56,
          child: Opacity(
            opacity: mainOpacity,
            child: Align(
              alignment: Alignment.center,
              child: AnimatedCrossFade(
                  firstChild: Container(
                    width: 270,
                    height: 56,
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.optional),
                      borderRadius: const BorderRadius.all(Radius.circular(32.0) //                 <--- border radius here
                          ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 34.0),
                          child: Text(
                            local.number_input,
                            style: Theme.of(context).textTheme.button,
                          ),
                        )),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 38), child: Icon(Icons.arrow_upward_outlined)),
                      ],
                    ),
                  ),
                  secondChild: Container(
                    margin: EdgeInsets.only(bottom: 16, left: 4, right: 4),
                    child: ElevatedMainButton(
                      title: local.send_code,
                      onTap: () {
                        setState(() {
                          bloc.add(OnRegisterClickedEvent(_phoneController.text));
                        });
                      },
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      titleALign: Alignment.centerLeft,
                      suffixIcon: Icon(
                        Icons.arrow_forward_outlined,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      width: 270,
                      height: 56,
                    ),
                  ),
                  crossFadeState: state.canSendSms ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: animationDuration),
            ),
          ),
        ),
      Positioned(
        top: 407,
        left: 56,
        right: 56,
        child: AnimatedOpacity(
          opacity: state.canSendSms ? 1 : 0,
          duration: animationDuration,
          child: CaptionText(
            local.accept_personal_process,
            color: Theme.of(context).colorScheme.optional2,
          ),
        ),
      )
    ];
  }

  Widget _buildSignButton({required Widget icon, required String title, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        children: [
          icon,
          Padding(
            padding: const EdgeInsets.only(left: 42),
            child: BodyText1(title),
          ),
        ],
      ),
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.resolveWith((states) => Size(306.0, 52.0)),
          padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.symmetric(horizontal: 26)),
          backgroundColor: MaterialStateProperty.resolveWith((states) => Theme.of(context).colorScheme.surface),
          // elevation: MaterialStateProperty.resolveWith((states) => 0.0),
          shape: MaterialStateProperty.resolveWith(
              (states) => RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))))),
    );
  }
}
