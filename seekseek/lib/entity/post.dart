class postEntity {
  int _postsId;
  String _postsTitle;
  int _postsBelongs;
  String _subjectName;
  int _postsCreator;
  String _creatorName;
  int _postsLikes;
  int _postsDislikes;
  int _collections;
  int _repliesCount;

  int get postsId => _postsId;

  set postsId(int value) {
    _postsId = value;
  }

  postEntity(
    this._postsId,
    this._postsTitle,
    this._postsBelongs,
    this._subjectName,
    this._postsCreator,
    this._creatorName,
    this._postsLikes,
    this._postsDislikes,
    this._collections,
    this._repliesCount,
  );

  String get postsTitle => _postsTitle;

  int get repliesCount => _repliesCount;

  set repliesCount(int value) {
    _repliesCount = value;
  }

  int get collections => _collections;

  set collections(int value) {
    _collections = value;
  }

  int get postsDislikes => _postsDislikes;

  set postsDislikes(int value) {
    _postsDislikes = value;
  }

  int get postsLikes => _postsLikes;

  set postsLikes(int value) {
    _postsLikes = value;
  }

  String get creatorName => _creatorName;

  set creatorName(String value) {
    _creatorName = value;
  }

  int get postsCreator => _postsCreator;

  set postsCreator(int value) {
    _postsCreator = value;
  }

  String get subjectName => _subjectName;

  set subjectName(String value) {
    _subjectName = value;
  }

  int get postsBelongs => _postsBelongs;

  set postsBelongs(int value) {
    _postsBelongs = value;
  }

  set postsTitle(String value) {
    _postsTitle = value;
  }
}
