import 'package:flutter/material.dart';
import 'package:flutter_for_show/core/widgets/body_text_1.dart';
import 'package:flutter_for_show/core/widgets/body_text_2.dart';
import 'package:flutter_for_show/core/widgets/input_field.dart';
import 'package:flutter_for_show/core/widgets/international_phone_input/models/country_model.dart';
import 'package:flutter_for_show/core/widgets/international_phone_input/utils/test/test_helper.dart';
import 'package:flutter_for_show/core/widgets/international_phone_input/utils/util.dart';
import 'package:flutter_for_show/core/widgets/local_text_provider.dart';

/// Creates a list of Countries with a search textfield.
class CountrySearchListWidget extends StatefulWidget {
  final List<Country> countries;
  final InputDecoration? searchBoxDecoration;
  final String? locale;
  final ScrollController? scrollController;
  final bool autoFocus;
  final bool? showFlags;
  final bool? useEmoji;

  CountrySearchListWidget(this.countries, this.locale,
      {this.searchBoxDecoration,
      this.scrollController,
      this.showFlags,
      this.useEmoji,
      this.autoFocus = false});

  @override
  _CountrySearchListWidgetState createState() =>
      _CountrySearchListWidgetState();
}

class _CountrySearchListWidgetState extends State<CountrySearchListWidget> with LocaleTextProvider<CountrySearchListWidget> {
  late List<Country> filteredCountries;

  @override
  void initState() {
    filteredCountries = filterCountries("");
    super.initState();
  }

  /// Returns [InputDecoration] of the search box
  InputDecoration getSearchBoxDecoration() {
    return widget.searchBoxDecoration ??
        InputDecoration(labelText: 'Search by country name or dial code');
  }

  /// Filters the list of Country by text from the search box.
  List<Country> filterCountries(String query) {
    final value = query.trim();

    if (value.isNotEmpty) {
      return widget.countries
          .where(
            (Country country) =>
                country.alpha3Code!
                    .toLowerCase()
                    .startsWith(value.toLowerCase()) ||
                country.name!.toLowerCase().contains(value.toLowerCase()) ||
                getCountryName(country)!
                    .toLowerCase()
                    .contains(value.toLowerCase()) ||
                country.dialCode!.contains(value.toLowerCase()),
          )
          .toList();
    }

    return widget.countries;
  }

  /// Returns the country name of a [Country]. if the locale is set and translation in available.
  /// returns the translated name.
  String? getCountryName(Country country) {
    if (widget.locale != null && country.nameTranslations != null) {
      String? translated = country.nameTranslations![widget.locale!];
      if (translated != null && translated.isNotEmpty) {
        return translated;
      }
    }
    return country.name;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SearchField(
            key: Key(TestHelper.CountrySearchInputKeyValue),
            label: local.country_search_title,
            onChange: (value) =>
                setState(() => filteredCountries = filterCountries(value)),
          ),
        ),
        Flexible(
          child: ListView.builder(
            controller: widget.scrollController,
            shrinkWrap: true,
            itemCount: filteredCountries.length,
            itemBuilder: (BuildContext context, int index) {
              Country country = filteredCountries[index];
              return ListTile(
                key: Key(TestHelper.countryItemKeyValue(country.alpha2Code)),
                leading: widget.showFlags!
                    ? _Flag(country: country, useEmoji: widget.useEmoji)
                    : null,
                title: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: BodyText1('${getCountryName(country)}',
                        align: TextAlign.start)),
                subtitle: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: BodyText2('${country.dialCode ?? ''}',
                        align: TextAlign.start)),
                onTap: () => Navigator.of(context).pop(country),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}

class _Flag extends StatelessWidget {
  final Country? country;
  final bool? useEmoji;

  const _Flag({Key? key, this.country, this.useEmoji}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return country != null
        ? Container(
            child: useEmoji!
                ? Text(
                    Utils.generateFlagEmojiUnicode(country?.alpha2Code ?? ''),
                    style: Theme.of(context).textTheme.headline5,
                  )
                : country?.flagUri != null
                    ? CircleAvatar(
                        backgroundImage: AssetImage(
                          country!.flagUri,
                        ),
                      )
                    : SizedBox.shrink(),
          )
        : SizedBox.shrink();
  }
}
