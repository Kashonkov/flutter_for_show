
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_talent/app.dart';
import 'package:i_talent/core/bloc/bloc_instance_provider.dart';
import 'package:i_talent/core/extensions/color_scheme_extensions.dart';
import 'package:i_talent/core/extensions/string_extensions.dart';
import 'package:i_talent/core/resources/constants.dart';
import 'package:i_talent/core/widgets/body_text_1.dart';
import 'package:i_talent/core/widgets/body_text_2.dart';
import 'package:i_talent/core/widgets/caption_text.dart';
import 'package:i_talent/core/widgets/custom_check_box.dart';
import 'package:i_talent/core/widgets/elevated_main_button.dart';
import 'package:i_talent/core/widgets/formatters/phone_formatter.dart';
import 'package:i_talent/core/widgets/image_button.dart';
import 'package:i_talent/core/widgets/input_field.dart';
import 'package:i_talent/core/widgets/international_phone_input/utils/phone_number.dart';
import 'package:i_talent/core/widgets/international_phone_input/utils/selector_config.dart';
import 'package:i_talent/core/widgets/international_phone_input/widgets/input_widget.dart';
import 'package:i_talent/core/widgets/local_text_provider.dart';
import 'package:i_talent/core/widgets/next_icon_button.dart';
import 'package:i_talent/core/widgets/positioned_aligned.dart';
import 'package:i_talent/core/widgets/subtitle_text.dart';
import 'package:i_talent/feature/authorization/presentation/registration/registration_page/bloc/registration_bloc.dart';
import 'package:i_talent/feature/authorization/presentation/registration/registration_page/bloc/registration_event.dart';
import 'package:i_talent/feature/authorization/presentation/registration/registration_page/bloc/registration_state.dart';
import 'package:i_talent/feature/authorization/presentation/registration/registration_page/registration_step.dart';
import 'package:i_talent/feature/authorization/presentation/widgets/authorization_page_body.dart';
import 'package:i_talent/feature/terms/presentation/content_terms_widget.dart';
import 'package:i_talent/navigator/main_navigator.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => isNewDesign ? _NewRegistrationPageState() : _RegistrationPageState();
}

class _RegistrationPageState extends StateWithBloc<RegistrationBloc, RegistrationPage> with LocaleTextProvider {
  late TextEditingController _loginController;
  late TextEditingController _passwordController;
  late TextEditingController _repeatPasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: bloc,
      listener: (context, RegistrationState state) {},
      builder: (context, RegistrationState state) => AuthorizationPageBody(
        title: local.registration,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 58, right: 20, left: 20),
            child: InputField(
              inputFormatters: [PhoneFormatter()],
              inputType: TextInputType.phone,
              controller: _loginController,
              hint: local.phone_number,
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 36, right: 20, left: 20),
                  child: ObscuringInputField(
                    controller: _passwordController,
                    onChange: (value) {
                      _formKey.currentState!.validate();
                    },
                    hint: local.password,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 36, right: 20, left: 20),
                  child: ObscuringInputField(
                    controller: _repeatPasswordController,
                    hint: local.repeat_password,
                    onChange: (value) {
                      _formKey.currentState!.validate();
                    },
                    validator: (value) {
                      if (value.isNullOrEmpty() || value == _passwordController.text) {
                        return null;
                      } else {
                        return local.password_are_not_equals;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28, right: 20, left: 4),
            child: Row(
              children: [
                Checkbox(
                  value: state.isTermsAccepted,
                  onChanged: (value) => bloc.add(AcceptedTermsEvent(value ?? false)),
                  checkColor: Theme.of(context).colorScheme.primary,
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return Theme.of(context).colorScheme.background;
                    } else {
                      return Theme.of(context).colorScheme.primary;
                    }
                  }),
                ),
                Expanded(
                    child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: BodyText2(
                        local.user_accept,
                      ),
                    ),
                    ContentTermsWidget(
                      text: local.user_term,
                      paddings: EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ],
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28, right: 20, left: 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubtitleText(local.already_have_account),
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Navigator.of(context).pop();
                      },
                      child: SubtitleTextUnderline(
                        local.sign_in,
                      ),
                    )
                  ],
                ),
                if (state.isTermsAccepted)
                  NextIconButton(
                    isLoading: state.isLoading,
                    isEnable: state.isTermsAccepted,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      bloc.add(OnRegisterClickedEvent(
                        _loginController.text,
                      )); //_passwordController.text, _repeatPasswordController.text)
                    },
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32, right: 14, left: 14),
            child: Row(
              children: [
                ImageAssetButton(
                  imageName: 'vk.png',
                  width: 82,
                  height: 68,
                ),
                ImageAssetButton(
                  imageName: 'fb.png',
                  width: 82,
                  height: 68,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
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
                          MainNavigator.navigateToTermsPage();
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
            selectorConfig: SelectorConfig(
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
        // InputField(
        //   labelText: local.your_phone,
        //   hint: local.phone_hint,
        //   inputFormatters: [PhoneFormatter()],
        //   controller: _phoneController,
        //   onChange: (value) {
        //     bloc.add(OnPhoneChangeEvent(value));
        //   },
        // ),
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
                      borderRadius: BorderRadius.all(Radius.circular(32.0) //                 <--- border radius here
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
                        Padding(
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
