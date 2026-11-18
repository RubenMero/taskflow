import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TaskDraft {
  final String title;
  final String description;
  final String priority;
  final DateTime? dueDate;

  const TaskDraft({
    required this.title,
    required this.description,
    required this.priority,
    this.dueDate,
  });
}

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({super.key});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedPriority = 'Media';
  DateTime? _selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDueDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 5),
      helpText: 'Selecciona una fecha límite (opcional)',
      cancelText: 'Cancelar',
      confirmText: 'Aceptar',
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final draft = TaskDraft(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      priority: _selectedPriority,
      dueDate: _selectedDate,
    );

    context.pop(draft);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear nueva tarea')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título de la tarea *',
                hintText: 'Ej. Estudiar formularios en Flutter',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
              validator: (value) {
                final text = value?.trim() ?? '';
                if (text.isEmpty) {
                  return 'Por favor, escribe un título para identificar tu tarea.';
                }
                if (text.length < 4) {
                  return 'El título es muy corto (mínimo 4 caracteres).';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Descripción o notas',
                hintText: 'Agrega detalles importantes (opcional)...',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                final text = value?.trim() ?? '';
                if (text.isNotEmpty && text.length < 8) {
                  return 'Si agregas una descripción, escribe al menos 8 caracteres.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedPriority,
              decoration: const InputDecoration(
                labelText: 'Nivel de prioridad',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Baja', child: Text('Baja')),
                DropdownMenuItem(value: 'Media', child: Text('Media')),
                DropdownMenuItem(value: 'Alta', child: Text('Alta')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedPriority = value);
                }
              },
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _pickDueDate,
              icon: const Icon(Icons.calendar_today),
              label: Text(
                _selectedDate == null
                    ? 'Agregar fecha límite (opcional)'
                    : 'Fecha límite: ${_formatDate(_selectedDate!)}',
              ),
            ),
            if (_selectedDate != null)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => setState(() => _selectedDate = null),
                  icon: const Icon(Icons.close, size: 18),
                  label: const Text('Quitar fecha'),
                ),
              ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _submitForm,
              icon: const Icon(Icons.save),
              label: const Text('Guardar tarea'),
            ),
          ],
        ),
      ),
    );
  }
}
