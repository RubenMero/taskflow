import '../domain/task.dart';
import 'task_repository.dart';

class LocalTaskRepository implements TaskRepository {
  final List<Task> _tasks = [
    const Task(
      id: 1,
      title: 'Configurar servidor DNS',
      description: 'Configurar y verificar el servidor DNS.',
      priority: 'Alta',
      isCompleted: true,
      userId: 1,
    ),
    const Task(
      id: 2,
      title: 'Preparar exposición Microsoft 365',
      description: 'Preparar el material para la exposición.',
      priority: 'Alta',
      isCompleted: false,
      userId: 1,
    ),
    const Task(
      id: 3,
      title: 'Revisar informe de auditoría',
      description: 'Verificar los controles y evidencias del informe.',
      priority: 'Media',
      isCompleted: true,
      userId: 1,
    ),
    const Task(
      id: 4,
      title: 'Actualizar aplicación TaskFlow',
      description: 'Realizar mejoras y actualizaciones de TaskFlow.',
      priority: 'Alta',
      isCompleted: false,
      userId: 1,
    ),
    const Task(
      id: 5,
      title: 'Organizar entregas universitarias',
      description: 'Organizar las actividades y entregas universitarias.',
      priority: 'Media',
      isCompleted: false,
      userId: 1,
    ),
  ];

  @override
  List<Task> getTasks() => List.unmodifiable(_tasks);

  @override
  void save(Task task) {
    final index = _tasks.indexWhere((item) => item.id == task.id);

    if (index == -1) return;

    _tasks[index] = task;
  }
}
