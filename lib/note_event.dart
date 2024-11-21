abstract class NoteEvent {}

class FetchNotesEvent extends NoteEvent {}

class DeleteNoteEvent extends NoteEvent {
  final String noteId;

  DeleteNoteEvent(this.noteId);
}
