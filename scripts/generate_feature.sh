#!/bin/bash

# Check if feature name is provided
if [ -z "$1" ]; then
    echo "Please provide a feature name"
    echo "Usage: ./generate_feature.sh <feature_name>"
    exit 1
fi

# Convert feature name to snake_case
FEATURE_NAME=$(echo "$1" | sed -r 's/([A-Z])/_\L\1/g' | sed 's/^_//' | tr ' ' '_' | tr '[:upper:]' '[:lower:]')

# Base directory for the feature
FEATURE_DIR="lib/features/$FEATURE_NAME"

# Create the feature directory structure
mkdir -p "$FEATURE_DIR"/{data,logic,domain,ui,widgets}

# Create basic files in each directory
touch "$FEATURE_DIR/data/${FEATURE_NAME}_data.dart"
touch "$FEATURE_DIR/domain/${FEATURE_NAME}_entity.dart"
touch "$FEATURE_DIR/domain/${FEATURE_NAME}_model.dart"
touch "$FEATURE_DIR/logic/${FEATURE_NAME}_cubit.dart"
touch "$FEATURE_DIR/logic/${FEATURE_NAME}_state.dart"
touch "$FEATURE_DIR/ui/${FEATURE_NAME}_page.dart"
touch "$FEATURE_DIR/ui/${FEATURE_NAME}_view.dart"
mkdir -p "$FEATURE_DIR/widgets"

# Function to capitalize first letter
capitalize() {
  printf "%s" "$1" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}'
}

# Get capitalized feature name
FEATURE_NAME_CAPITALIZED=$(capitalize "$FEATURE_NAME")

# Add basic content to the files
cat > "$FEATURE_DIR/data/${FEATURE_NAME}_data.dart" << 'EOL'
class ${FEATURE_NAME_CAPITALIZED}Data {
  // TODO: Implement data methods
}
EOL

cat > "$FEATURE_DIR/domain/${FEATURE_NAME}_entity.dart" << 'EOL'
class ${FEATURE_NAME_CAPITALIZED}Entity {
  // TODO: Implement entity
}
EOL

cat > "$FEATURE_DIR/domain/${FEATURE_NAME}_model.dart" << 'EOL'
class ${FEATURE_NAME_CAPITALIZED}Model {
  // TODO: Implement model
}
EOL

cat > "$FEATURE_DIR/logic/${FEATURE_NAME}_state.dart" << 'EOL'
part of '${FEATURE_NAME}_cubit.dart';

@immutable
abstract class ${FEATURE_NAME_CAPITALIZED}State {}

class ${FEATURE_NAME_CAPITALIZED}Initial extends ${FEATURE_NAME_CAPITALIZED}State {}
EOL

cat > "$FEATURE_DIR/logic/${FEATURE_NAME}_cubit.dart" << 'EOL'
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part '${FEATURE_NAME}_state.dart';

class ${FEATURE_NAME_CAPITALIZED}Cubit extends Cubit<${FEATURE_NAME_CAPITALIZED}State> {
  ${FEATURE_NAME_CAPITALIZED}Cubit() : super(${FEATURE_NAME_CAPITALIZED}Initial());
  
  // TODO: Implement cubit methods
}
EOL

cat > "$FEATURE_DIR/ui/${FEATURE_NAME}_page.dart" << 'EOL'
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/${FEATURE_NAME}_cubit.dart';
import '${FEATURE_NAME}_view.dart';

class ${FEATURE_NAME_CAPITALIZED}Page extends StatelessWidget {
  const ${FEATURE_NAME_CAPITALIZED}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ${FEATURE_NAME_CAPITALIZED}Cubit(),
      child: const ${FEATURE_NAME_CAPITALIZED}View(),
    );
  }
}
EOL

cat > "$FEATURE_DIR/ui/${FEATURE_NAME}_view.dart" << 'EOL'
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/${FEATURE_NAME}_cubit.dart';

class ${FEATURE_NAME_CAPITALIZED}View extends StatelessWidget {
  const ${FEATURE_NAME_CAPITALIZED}View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('${FEATURE_NAME_CAPITALIZED}'),
      ),
      body: BlocBuilder<${FEATURE_NAME_CAPITALIZED}Cubit, ${FEATURE_NAME_CAPITALIZED}State>(
        builder: (context, state) {
          return const Center(
            child: Text('${FEATURE_NAME_CAPITALIZED} View'),
          );
        },
      ),
    );
  }
}
EOL

# Replace the template variables in all files
for file in "$FEATURE_DIR"/**/*.dart; do
  sed -i '' "s/\${FEATURE_NAME}/$FEATURE_NAME/g" "$file"
  sed -i '' "s/\${FEATURE_NAME_CAPITALIZED}/$FEATURE_NAME_CAPITALIZED/g" "$file"
done

echo "✨ Feature '$FEATURE_NAME' has been generated successfully!"
echo "📁 Location: $FEATURE_DIR"
echo "
Generated files:
- data/${FEATURE_NAME}_data.dart
- domain/${FEATURE_NAME}_entity.dart
- domain/${FEATURE_NAME}_model.dart
- logic/${FEATURE_NAME}_cubit.dart
- logic/${FEATURE_NAME}_state.dart
- ui/${FEATURE_NAME}_page.dart
- ui/${FEATURE_NAME}_view.dart
- widgets/ (empty directory)"