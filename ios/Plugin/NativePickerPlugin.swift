import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(NativePickerPlugin)
public class NativePickerPlugin: CAPPlugin, UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
    }
    
    private var call: CAPPluginCall?
    private var pickerView : UIPickerView!
    private var dummyTextField: UITextField!
    
    private var toolbar: UIToolbar!
    private var toolbarDoneButton: UIBarButtonItem!
    private var toolbarCancelButton: UIBarButtonItem!
    
    private var selectedIndex = -1
    private var values: [String] = []
    
    private func loadPlugin() {
        self.pickerView = UIPickerView()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.dummyTextField = UITextField(frame: .zero)
        
        self.toolbarDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        self.toolbarCancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        
        self.toolbar = UIToolbar()
        self.toolbar.setItems([self.toolbarCancelButton, spacer, self.toolbarDoneButton], animated: true)
        
        
        self.dummyTextField.inputAccessoryView = self.toolbar
        self.dummyTextField.inputView = self.pickerView
        
        self.toolbar.sizeToFit()
        self.bridge?.viewController?.view.addSubview(dummyTextField)
    }
    public override func load() {
        loadPlugin()
    }

    @objc func showPicker(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            self.call = call
            self.values = call.getArray("values", String.self) ?? []
            self.pickerView.reloadComponent(0)
            self.dummyTextField.becomeFirstResponder()
            
        }
    }
    
    @objc func done(sender: UIButton) {
           if (self.call != nil) {
               self.call?.resolve(["selectedIndex": selectedIndex])
           }
           self.dismiss()
    }
    
    @objc func cancel(sender: UIButton) {
           if (self.call != nil) {
               self.call?.reject("Operation Canceled")
           }
           self.dismiss()
    }
    private func dismiss() {
        DispatchQueue.main.async {
            self.dummyTextField.resignFirstResponder()
            self.call = nil
            self.selectedIndex = -1
            self.values.removeAll()
            self.pickerView.reloadComponent(0)
        }
    }
}
