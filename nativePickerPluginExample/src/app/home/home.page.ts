import { Component } from '@angular/core';
import { NativePicker } from '@capacitor-community/native-picker';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
})
export class HomePage {
  selectedValue = '';
  values: string[];
  async showPicker(): Promise<void> {
    this.values = [];
    for (let i = 0; i <= Math.floor(Math.random() * 1000); i++) {
      this.values[i] = i + ' AED';
    }
    const result = await NativePicker.showPicker({ values: this.values });
    this.selectedValue = this.values[result.selectedIndex];
  }
}
