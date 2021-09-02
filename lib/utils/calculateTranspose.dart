class TransposeCalculation { 
  final List<String> _notes = [
    'C','C#','D','D#','E','F','F#','G','G#','A','A#','B', 'Not Set'
  ];

  final Map<String, int> notesPosition = {
    'C': 0,
    'C#': 1,
    'D': 2,
    'D#': 3,
    'E': 4,
    'F': 5,
    'F#': 6,
    'G': 7,
    'G#': 8,
    'A': 9,
    'A#': 10,
    'B': 11
  };

  String getTransposedKey(String key, int transposeNumber) {
    int newOffset = notesPosition[key] + transposeNumber;
    if (newOffset > 11) {
      newOffset = newOffset - 12;
    } else if (newOffset < 0) {
      newOffset = 12 + newOffset;
    }

    return _notes[newOffset];
  }

  List<String> get listOfNotes => _notes;
}