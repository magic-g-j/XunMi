class subjectEntity {
  int _subjectId;
  String _subjectName;

  int get subjectId => _subjectId;

  set subjectId(int value) {
    _subjectId = value;
  }

  subjectEntity(
      this._subjectId,
      this._subjectName,
      );

  String get subjectName => _subjectName;

  set subjectName(String value) {
    _subjectName = value;
  }
}
