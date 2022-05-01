import { WebPlugin } from '@capacitor/core';

import type { NativePickerPlugin } from './definitions';

export class NativePickerWeb extends WebPlugin implements NativePickerPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
