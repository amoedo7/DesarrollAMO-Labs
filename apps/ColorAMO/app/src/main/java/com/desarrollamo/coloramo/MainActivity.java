package com.desarrollamo.coloramo;

import android.app.Activity;
import android.os.Bundle;
import android.graphics.Color;
import android.graphics.Typeface;
import android.view.Gravity;
import android.widget.*;
import java.util.Locale;

public class MainActivity extends Activity {
  @Override public void onCreate(Bundle state) {
    super.onCreate(state);
    LinearLayout root=new LinearLayout(this); root.setOrientation(LinearLayout.VERTICAL); root.setPadding(32,32,32,32);
    TextView title=new TextView(this); title.setText("ColorAMO"); title.setTextSize(30); title.setTypeface(Typeface.DEFAULT_BOLD); root.addView(title);
    TextView sub=new TextView(this); sub.setText("HEX · RGB · contraste WCAG · offline"); root.addView(sub);
    EditText fg=new EditText(this); fg.setHint("Color principal, ej. #6750A4"); fg.setText("#6750A4"); root.addView(fg);
    EditText bg=new EditText(this); bg.setHint("Fondo, ej. #FFFFFF"); bg.setText("#FFFFFF"); root.addView(bg);
    TextView swatch=new TextView(this); swatch.setText("VISTA PREVIA"); swatch.setTextSize(22); swatch.setGravity(Gravity.CENTER); swatch.setPadding(16,60,16,60); root.addView(swatch);
    TextView info=new TextView(this); info.setTextSize(18); info.setPadding(0,20,0,20); root.addView(info);
    Button calc=new Button(this); calc.setText("ANALIZAR COLORES"); root.addView(calc);
    calc.setOnClickListener(v->{ try {
      int[] a=ColorTools.parseHex(fg.getText().toString()), b=ColorTools.parseHex(bg.getText().toString());
      String ah=ColorTools.toHex(a[0],a[1],a[2]), bh=ColorTools.toHex(b[0],b[1],b[2]);
      double ratio=ColorTools.contrast(a,b);
      swatch.setTextColor(Color.rgb(a[0],a[1],a[2])); swatch.setBackgroundColor(Color.rgb(b[0],b[1],b[2]));
      String aa=ratio>=4.5?"AA texto normal ✓":"AA texto normal ✗";
      String aaa=ratio>=7?"AAA ✓":"AAA ✗";
      info.setText(String.format(Locale.US,"Principal %s → RGB(%d, %d, %d)\nFondo %s → RGB(%d, %d, %d)\nContraste %.2f:1 · %s · %s",ah,a[0],a[1],a[2],bh,b[0],b[1],b[2],ratio,aa,aaa));
    } catch(Exception e){ info.setText("Formato inválido. Usa HEX de 3 o 6 dígitos, por ejemplo #FFF o #6750A4."); }});
    calc.performClick(); setContentView(root);
  }
}
