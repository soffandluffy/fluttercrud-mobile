import 'package:flutter/material.dart';
import 'package:fluttercrud/application/classes/common/category.dart';
import 'package:fluttercrud/application/classes/common/country.dart';
import 'package:fluttercrud/application/classes/opportunity/form_fields/category_form_field.dart';
import 'package:fluttercrud/application/classes/opportunity/form_fields/country_form_field.dart';
import 'package:fluttercrud/application/classes/opportunity/form_fields/deadline_form_field.dart';
import 'package:fluttercrud/application/classes/opportunity/form_fields/description_form_field.dart';
import 'package:fluttercrud/application/classes/opportunity/form_fields/organizer_form_field.dart';
import 'package:fluttercrud/application/classes/opportunity/form_fields/title_form_field.dart';
import 'package:fluttercrud/application/classes/opportunity/opportunity_form_model.dart';
import 'package:fluttercrud/application/repositories/common_repository.dart';
import 'package:fluttercrud/application/state/common_state.dart';
import 'package:fluttercrud/application/state/opportunity_state.dart';
import 'package:fluttercrud/values/branding_color.dart';
import 'package:intl/intl.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class OpportunityAddPage extends StatefulWidget {
  OpportunityAddPage({Key key}) : super(key: key);

  @override
  _OpportunityAddPageState createState() => _OpportunityAddPageState();
}

class _OpportunityAddPageState extends State<OpportunityAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new Opportunity"),
      ),
      body: Injector(
        inject: [
          Inject<CommonRepository>(() => CommonRepositoryImpl()),
          Inject<CommonState>(() => CommonState(IN.get<CommonRepository>())),
        ],
        builder: (_) {
          return _AddNewOpportunity();
        },
      ),
    );
  }
}

class _AddNewOpportunity extends StatelessWidget {
  _AddNewOpportunity({Key key}) : super(key: key);

  final _commonState = RM.get<CommonState>();
  final _opportunityState = RM.get<OpportunityState>();

  // Form Fields Reactive Model
  final _titleRM = RM.create(TitleFormField(''));
  final _descriptionRM = RM.create(DescriptionFormField(''));
  final _categoryRM = RM.create(CategoryFormField(null));
  final _countryRM = RM.create(CountryFormField(null));
  final _deadlineRM = RM.create(DeadlineFormField(null));
  final _organizerRM = RM.create(OrganizerFormField(null));

  final _deadlineController = TextEditingController();

  bool get isValid =>
      _titleRM.hasData &&
      _descriptionRM.hasData &&
      _categoryRM.state.isValid() &&
      _countryRM.state.isValid() &&
      _deadlineRM.state.isValid() &&
      _organizerRM.hasData;

  Future _saveOpportunity() async {
    // Save Opportunity
    final OpportunityFormModel _data = OpportunityFormModel(
        title: _titleRM.state.title,
        description: _descriptionRM.state.description,
        category: _categoryRM.state.category,
        country: _countryRM.state.country,
        deadline: _deadlineRM.state.deadline,
        organizer: _organizerRM.state.organizer);

    // Opportunity State
    _opportunityState.setState((s) => s.saveOpportunity(_data));
  }

  @override
  Widget build(BuildContext context) {
    return WhenRebuilderOr(
      observeMany: [
        () => _commonState,
      ],
      initState: (_, __) async {
        await _commonState.setState((s) => s.getCategories());
        await _commonState.setState((s) => s.getCountries());
      },
      onWaiting: () => Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      builder: (_, __) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              children: [
                StateBuilder(
                  observe: () => _titleRM,
                  shouldRebuild: (_) => true,
                  builder: (_, __) {
                    return TextFormField(
                      onChanged: (String title) {
                        _titleRM.setState(
                            (_) => TitleFormField(title)..validate(),
                            catchError: true);
                      },
                      decoration: InputDecoration(
                          errorText:
                              _titleRM.hasError ? _titleRM.error.message : null,
                          hintText: "Enter Opportunity Title",
                          labelText: "Title",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                StateBuilder(
                  observe: () => _descriptionRM,
                  shouldRebuild: (_) => true,
                  builder: (_, __) {
                    return TextFormField(
                      onChanged: (String description) {
                        _descriptionRM.setState(
                            (_) =>
                                DescriptionFormField(description)..validate(),
                            catchError: true);
                      },
                      maxLines: 5,
                      decoration: InputDecoration(
                          errorText: _descriptionRM.hasError
                              ? _descriptionRM.error.message
                              : null,
                          hintText: "Enter Opportunity Description",
                          labelText: "Description",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                StateBuilder(
                  observe: () => _categoryRM,
                  shouldRebuild: (_) => true,
                  builder: (_, __) {
                    return DropdownButtonFormField<Category>(
                      onChanged: (Category category) {
                        print(category.id);
                        _categoryRM.setState(
                            (_) => CategoryFormField(category)..validate(),
                            catchError: true);
                      },
                      items: _commonState.state.categories
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.name),
                            ),
                          )
                          .toList(),
                      decoration: InputDecoration(
                          errorText: _categoryRM.hasError
                              ? _categoryRM.error.message
                              : null,
                          hintText: "Select Category",
                          labelText: "Category",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                StateBuilder(
                  observe: () => _countryRM,
                  shouldRebuild: (_) => true,
                  builder: (_, __) {
                    return DropdownButtonFormField<Country>(
                      onChanged: (Country country) {
                        print(country.id);
                        _countryRM.setState(
                            (_) => CountryFormField(country)..validate(),
                            catchError: true);
                      },
                      items: _commonState.state.countries
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.name),
                            ),
                          )
                          .toList(),
                      decoration: InputDecoration(
                          errorText: _countryRM.hasError
                              ? _countryRM.error.message
                              : null,
                          hintText: "Select Country",
                          labelText: "Country",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                StateBuilder(
                  observe: () => _deadlineRM,
                  shouldRebuild: (_) => true,
                  builder: (_, __) {
                    return TextFormField(
                      controller: _deadlineController,
                      onTap: () async {
                        DateTime _selectedDeadline = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 1000)));
                        if (_selectedDeadline != null) {
                          _deadlineController.text = DateFormat("yyyy-MM-dd")
                              .format(_selectedDeadline)
                              .toString();
                          _deadlineRM.setState((_) =>
                              DeadlineFormField(_selectedDeadline)..validate());
                        }
                      },
                      decoration: InputDecoration(
                          errorText: _deadlineRM.hasError
                              ? _deadlineRM.error.message
                              : null,
                          hintText: "Select Dateline",
                          labelText: "Deadline",
                          suffixIcon: Icon(Icons.event),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                StateBuilder(
                  observe: () => _organizerRM,
                  shouldRebuild: (_) => true,
                  builder: (_, __) {
                    return TextFormField(
                      onChanged: (String organizer) {
                        _organizerRM.setState(
                            (_) => OrganizerFormField(organizer)..validate(),
                            catchError: true);
                      },
                      decoration: InputDecoration(
                          errorText: _organizerRM.hasError
                              ? _organizerRM.error.message
                              : null,
                          hintText: "Enter Organizer name",
                          labelText: "Organizer",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                StateBuilder(
                  observeMany: [
                    () => _titleRM,
                    () => _descriptionRM,
                    () => _categoryRM,
                    () => _countryRM,
                    () => _deadlineRM,
                    () => _organizerRM,
                  ],
                  shouldRebuild: (_) => true,
                  builder: (_, __) {
                    return MaterialButton(
                      color: brandingColor,
                      disabledColor: Colors.red,
                      onPressed: isValid
                          ? () {
                              _saveOpportunity();
                            }
                          : null,
                      shape: OutlineInputBorder(borderSide: BorderSide.none),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        "Add Opportunity",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
