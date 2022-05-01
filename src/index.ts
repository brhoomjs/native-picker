import { registerPlugin } from '@capacitor/core';

import type { NativePickerPlugin } from './definitions';

const NativePicker = registerPlugin<NativePickerPlugin>('NativePicker', {
  web: () => import('./web').then(m => new m.NativePickerWeb()),
});

export * from './definitions';
export { NativePicker };
