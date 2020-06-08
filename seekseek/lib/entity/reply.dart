class replyEntity {
  int _replyId;
  int _replyParent;
  int _replyParentType;
  int _replyCreator;
  String _replyCreatorName;
  String _replyContent;
  String _replyCtime;
  int _replyLikes;
  int _replyDislikes;

  replyEntity(
      this._replyId,
      this._replyParent,
      this._replyParentType,
      this._replyCreator,
      this._replyCreatorName,
      this._replyContent,
      this._replyCtime,
      this._replyLikes,
      this._replyDislikes);

  int get replyId => _replyId;

  set replyId(int value) {
    _replyId = value;
  }

  int get replyParent => _replyParent;

  set replyParent(int value) {
    _replyParent = value;
  }

  int get replyParentType => _replyParentType;

  set replyParentType(int value) {
    _replyParentType = value;
  }

  int get replyCreator => _replyCreator;

  set replyCreator(int value) {
    _replyCreator = value;
  }

  String get replyCreatorName => _replyCreatorName;

  set replyCreatorName(String value) {
    _replyCreatorName = value;
  }

  String get replyContent => _replyContent;

  set replyContent(String value) {
    _replyContent = value;
  }

  String get replyCtime => _replyCtime;

  set replyCtime(String value) {
    _replyCtime = value;
  }

  int get replyLikes => _replyLikes;

  set replyLikes(int value) {
    _replyLikes = value;
  }

  int get replyDislikes => _replyDislikes;

  set replyDislikes(int value) {
    _replyDislikes = value;
  }
}
