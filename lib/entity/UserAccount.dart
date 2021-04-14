class UserAccount {
  String uid;
  String _name;
  String _email;
  String _RiskZone;
  bool _SurveyDone;
  int _SurveyScore;
  List<String> _SavedLocations;
  List<String> _Reminders;

  UserAccount({
    String name,
    String email,
    String RiskZone,
    bool SurveyDone,
    int SurveyScore,
    List<String> SavedLocations,
    List<String> Reminders,
    String uid,
    //String uid,
  })  : _name = name,
        _email = email,
        _RiskZone = RiskZone,
        _SurveyDone = SurveyDone,
        _SurveyScore = SurveyScore,
        _Reminders = Reminders,
        _SavedLocations = SavedLocations;
  //uid = this.uid;

  String get name => _name;
  String get email => _email;
  String get RiskZone => _RiskZone;
  bool get SurveyDone => _SurveyDone;
  int get SurveyScore => _SurveyScore;
  List<String> get SavedLocations => _SavedLocations;
  List<String> get Reminders => _Reminders;
  set name(String name) {
    _name = name;
  }

  set email(String email) {
    _email = email;
  }

  set RiskZone(String RiskZone) {
    _RiskZone = RiskZone;
  }

  set SurveyDone(bool SurveyDone) {
    _SurveyDone = SurveyDone;
  }

  set SurveyScore(int SurveyScore) {
    _SurveyScore = SurveyScore;
  }

  set SavedLocations(List<String> SavedLocations) {
    _SavedLocations = SavedLocations;
  }

  set Reminders(List<String> Reminders) {
    _Reminders = Reminders;
  }
}
