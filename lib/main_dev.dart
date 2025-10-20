import 'package:app_agendamento/core/flavor/flavor_config.dart';

import 'app.dart';

void main() {
  bootstrap(
    const FlavorConfig(
      flavor: AppFlavor.dev,
      baseUrl: 'https://parseapi.back4app.com/functions',
      appId: 'IxuB2JD48vMZgd5ZXrTeNvprZXpdU1Ze8gkjepik',
      restKey: 'IC6Z4z7eMOLhB6rMPQWk2BpDHvZjfLUBRG8ddVtI',
    ),
  );
}
