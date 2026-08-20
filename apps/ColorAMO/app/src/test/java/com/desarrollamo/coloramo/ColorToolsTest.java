package com.desarrollamo.coloramo;

import org.junit.Test;
import static org.junit.Assert.*;

public class ColorToolsTest {
  @Test public void parsesLongHex(){ assertArrayEquals(new int[]{103,80,164},ColorTools.parseHex("#6750A4")); }
  @Test public void expandsShortHex(){ assertArrayEquals(new int[]{255,170,0},ColorTools.parseHex("#FA0")); }
  @Test public void formatsRgb(){ assertEquals("#00FF7F",ColorTools.toHex(0,255,127)); }
  @Test public void blackWhiteContrastIs21(){ assertEquals(21.0,ColorTools.contrast(new int[]{0,0,0},new int[]{255,255,255}),0.001); }
  @Test(expected=IllegalArgumentException.class) public void rejectsInvalidHex(){ ColorTools.parseHex("#12ZZ00"); }
}
