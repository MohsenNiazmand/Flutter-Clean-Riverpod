import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_clean_riverpod/config/routes/routes.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/features/home/presentation/provider/home_provider.dart';
import 'package:flutter_clean_riverpod/features/home/presentation/widgets/note_grid.dart';
import 'package:flutter_clean_riverpod/shared/data/model/note_model.dart';
import 'package:flutter_clean_riverpod/shared/presentation/providers/note_provider.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/empty_state.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesProvider);
    final homeLoading = useState(true);

    _initializeHome(ref);
    _handleLoadingState(homeLoading);

    return Scaffold(
      backgroundColor: cBackground,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
        child: _buildBody(notes, homeLoading.value),
      ),
      floatingActionButton: _buildFloatingActionButton(
          homeLoading.value, context, ref),
    );
  }

  Widget _buildBody(List<NoteModel> notes, bool isLoading) {
    if (isLoading && notes.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!isLoading && notes.isEmpty) {
      return const Center(child: EmptyState());
    }

    return Center(child: NoteGrid(notes: notes));
  }

  Widget? _buildFloatingActionButton(bool isLoading, BuildContext context,
      WidgetRef ref) {
    if (isLoading) return null;

    return FloatingActionButton(
      backgroundColor: cPrimary50,
      child: const Icon(Icons.add),
      onPressed: () => _handleAddNote(context, ref),
    );
  }

  void _initializeHome(WidgetRef ref) {
    useEffect(() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ref.read(homePProvider.notifier).fetchHome();
      });
      return null;
    }, []);
  }

  void _handleLoadingState(ValueNotifier<bool> homeLoading) {
    useEffect(() {
      Future.delayed(Durations.long2, () {
        homeLoading.value = false;
      });
      return null;
    }, []);
  }

  void _handleAddNote(BuildContext context, WidgetRef ref) {
    ref
        .read(selectedNoteProvider.notifier)
        .state = null;
    context.push(Routes.addNote);
  }
}
