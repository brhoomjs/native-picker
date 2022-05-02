export interface NativePickerPlugin {
  showPicker(options: { values: string[] }): Promise<{ selectedIndex: number }>;
}
