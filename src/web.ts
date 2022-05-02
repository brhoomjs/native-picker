import { WebPlugin } from '@capacitor/core';

import type { NativePickerPlugin } from './definitions';

export class NativePickerWeb extends WebPlugin implements NativePickerPlugin {
  showPicker(): Promise<{ selectedIndex: number }> {
    return new Promise((r, j) => {
      const selectedIndex = parseInt(prompt('Enter amount') || '0');
      if (isNaN(selectedIndex)) j('Wrong number');
      r({ selectedIndex });
    });
  }
}
