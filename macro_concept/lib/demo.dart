import 'dart:js_interop';

import 'package:macros/macros.dart';
import 'dart:async';

macro class Log implements ClassDeclarationsMacro {
  const Log();

  @override
  FutureOr<void> buildDeclarationsForClass(ClassDeclaration clazz,
      MemberDeclarationBuilder builder) async {
    final fields = await builder.fieldsOf(clazz);
    final x=await builder.constructorsOf(clazz);

    //for( final y in x){

    // y.positionalParameters.toList().forEach((param){
    //         print('pos:${param.name},${param.}');
    //   });

    //     y.namedParameters.toList().forEach((param){
    //         print('name: ${param.name}');
    //   });
    // }

 
    for (final f in fields) {
      final name = f.identifier.name;
      // FieldDeclaration
      print('name: $name->${f.toExternalReference.toDartObject.metadata.toList().first.}');
       
      final capitalized = name[0].toUpperCase() + name.substring(1);
      builder.declareInType(DeclarationCode.fromString(
        "void log$capitalized() { print('Macro variable $name: \$$name'); }"
      ));
    }
  }
}


macro class AutoConstructor implements ClassDeclarationsMacro {
  const AutoConstructor();

  @override
  FutureOr<void> buildDeclarationsForClass(
    ClassDeclaration clazz, MemberDeclarationBuilder builder) async {

    final fields = await builder.fieldsOf(clazz);
    final className = clazz.identifier.name;

    // Build constructor parameters
    final constructorParameters = _buildConstructorParameters(fields);

    // Generate constructor code
    final constructorCode = _generateConstructorCode(className, constructorParameters);

    // Declare the constructor in the class
    builder.declareInType(constructorCode);

    // Generate getters and setters for private fields using the helper class
    final getterSetterGenerator = GetterSetterGenerator();
    final getterSetterDeclarations = getterSetterGenerator.generateGettersAndSetters(fields);

    // Declare getters and setters in the class
    for (final declaration in getterSetterDeclarations) {
      builder.declareInType(declaration);
    }
  }

  // Helper method to build constructor parameters
  List<String> _buildConstructorParameters(List<FieldDeclaration> fields) {
    final finalFields = fields.where((field) => field.hasFinal).toList();

    return finalFields.map((field) {
      final fieldName = field.identifier.name;
      return 'required this.$fieldName';
    }).toList();
  }

  // Helper method to generate constructor code
  DeclarationCode _generateConstructorCode(String className, List<String> parameters) {
    return DeclarationCode.fromString('''
      $className({
        ${parameters.join(',\n        ')}
      });
    ''');
  }
}


class GetterSetterGenerator {
  // Method to generate getters and setters for private fields
  List<DeclarationCode> generateGettersAndSetters(List<FieldDeclaration> fields) {
    List<DeclarationCode> declarations = [];

    for (final field in fields) {
      final fieldName = field.identifier.name;

      // Check if the field is private (starts with '_')
      if (fieldName.startsWith('_')) {
        final fieldType = field.type.code;
        final publicName = _capitalize(fieldName.substring(1)); // Remove the underscore and capitalize

        // Generate getter
        final getterCode = DeclarationCode.fromString(
          '$fieldType get $publicName => $fieldName;'
        );
        declarations.add(getterCode);

        // Generate setter if the field is not final
        if (!field.hasFinal) {
          final setterCode = DeclarationCode.fromString(
            'set $publicName($fieldType value) { $fieldName = value; }'
          );
          declarations.add(setterCode);
        }
      }
    }

    return declarations;
  }

  // Helper method to capitalize the first letter
  String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
