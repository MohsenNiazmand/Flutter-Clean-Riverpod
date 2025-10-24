import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_clean_riverpod/config/routes/routes.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/domain/entities/data_state.dart';
import 'package:flutter_clean_riverpod/features/notes/presentation/provider/fetch_notes_provider.dart';
import 'package:flutter_clean_riverpod/features/notes/presentation/provider/notes_state_manager.dart';
import 'package:flutter_clean_riverpod/features/notes/presentation/provider/selected_note_provider.dart';
import 'package:flutter_clean_riverpod/features/notes/presentation/widgets/note_grid.dart';
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/empty_state.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotesScreen extends HookConsumerWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use new state manager instead of deprecated provider
    final notes = ref.watch(notesStateProvider);
    final fetchState = ref.watch(fetchNotesProviderProvider);
    final homeLoading = useState(true);

    _initializeHome(ref);
    _handleLoadingState(homeLoading, fetchState);

    return Scaffold(
      backgroundColor: cBackground,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
        child: _buildBody(notes, homeLoading.value, fetchState),
      ),
      floatingActionButton:
          _buildFloatingActionButton(homeLoading.value, context, ref),
    );
  }

  Widget _buildBody(
    List<NoteModel> notes,
    bool isLoading,
    DataState<dynamic> fetchState,
  ) {
    // Show loading only if no local data and API is loading
    if (isLoading && notes.isEmpty && fetchState is DataLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Show empty state if no notes and not loading
    if (notes.isEmpty && !isLoading) {
      return const Center(child: EmptyState());
    }

    // Show notes grid
    return Center(child: NoteGrid(notes: notes));
  }

  Widget? _buildFloatingActionButton(
    bool isLoading,
    BuildContext context,
    WidgetRef ref,
  ) {
    if (isLoading) return null;

    return FloatingActionButton(
      backgroundColor: cPrimary50,
      child: const Icon(Icons.add),
      onPressed: () => _handleAddNote(context, ref),
    );
  }

  void _initializeHome(WidgetRef ref) {
    useEffect(
      () {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          ref.read(fetchNotesProviderProvider.notifier).fetchNotes();
        });
        return null;
      },
      [],
    );
  }

  void _handleLoadingState(
    ValueNotifier<bool> homeLoading,
    DataState<dynamic> fetchState,
  ) {
    useEffect(
      () {
        // Stop loading when fetch is complete or failed
        if (fetchState is DataSuccess || fetchState is DataFailed) {
          homeLoading.value = false;
        }

        // Also stop loading after timeout
        Future.delayed(Durations.long2, () {
          homeLoading.value = false;
        });
        return null;
      },
      [fetchState],
    );
  }

  void _handleAddNote(BuildContext context, WidgetRef ref) {
    ref.read(selectedNoteProvider.notifier).state = null;
    context.push(Routes.addNote);
  }
}
