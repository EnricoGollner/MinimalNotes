class Validator {
  static String? isRequired(String? text) {
    if(text == null || text.isEmpty) {
      return 'Text required to create a note!';
    }

    return null;
  }
}