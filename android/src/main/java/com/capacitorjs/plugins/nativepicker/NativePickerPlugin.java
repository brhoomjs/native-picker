package com.capacitorjs.plugins.nativepicker;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.util.Log;
import android.view.ViewGroup;
import android.widget.NumberPicker;
import com.getcapacitor.JSArray;
import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;
import java.text.ParseException;
import org.json.JSONException;

@CapacitorPlugin(name = "NativePicker")
public class NativePickerPlugin extends Plugin {

    @PluginMethod
    public void showPicker(PluginCall call) throws JSONException {
        final JSArray values = call.getArray("values");

        final NumberPicker numberPicker = new NumberPicker(this.getActivity());
        numberPicker.setWrapSelectorWheel(false);
        numberPicker.setMinValue(0);
        numberPicker.setMaxValue(values.length() - 1);
        numberPicker.setDisplayedValues(values.toList().toArray(new String[0]));

        final AlertDialog.Builder builder = new AlertDialog.Builder(this.getActivity());

        builder.setPositiveButton(
            "Done",
            new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    final JSObject ret = new JSObject();
                    ret.put("selectedIndex", numberPicker.getValue());
                    call.resolve(ret);
                }
            }
        );
        builder.setNegativeButton(
            "Cancel",
            new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    call.reject("Operation canceled");
                }
            }
        );
        builder.setView(numberPicker);
        builder.create();
        builder.show();
    }
}
