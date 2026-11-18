import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/app/taskflow_app.dart';

void main() {
  testWidgets('TaskFlow muestra la pantalla inicial',
      (WidgetTester tester) async {

    await tester.pumpWidget(const TaskFlowApp());

    expect(find.text('TaskFlow'), findsOneWidget);

    expect(
      find.text('Tareas pendientes: 3'),
      findsOneWidget,
    );

    expect(
      find.text('Agregar tarea'),
      findsOneWidget,
    );
  });

  testWidgets('Agregar tarea aumenta el contador',
      (WidgetTester tester) async {

    await tester.pumpWidget(const TaskFlowApp());

    await tester.tap(find.text('Agregar tarea'));

    await tester.pump();

    expect(
      find.text('Tareas pendientes: 4'),
      findsOneWidget,
    );
  });

  testWidgets('Completar tarea disminuye el contador',
      (WidgetTester tester) async {

    await tester.pumpWidget(const TaskFlowApp());

    await tester.tap(find.text('Completar una tarea'));

    await tester.pump();

    expect(
      find.text('Tareas pendientes: 2'),
      findsOneWidget,
    );
  });
}
