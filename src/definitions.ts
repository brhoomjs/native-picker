export interface NativePickerPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
