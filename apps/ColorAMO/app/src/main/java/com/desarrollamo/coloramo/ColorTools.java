package com.desarrollamo.coloramo;

public final class ColorTools {
  private ColorTools() {}
  public static int[] parseHex(String value) {
    if (value == null) throw new IllegalArgumentException("color required");
    String s = value.trim(); if (s.startsWith("#")) s = s.substring(1);
    if (s.length() == 3) s = ""+s.charAt(0)+s.charAt(0)+s.charAt(1)+s.charAt(1)+s.charAt(2)+s.charAt(2);
    if (!s.matches("[0-9a-fA-F]{6}")) throw new IllegalArgumentException("invalid hex");
    return new int[]{Integer.parseInt(s.substring(0,2),16), Integer.parseInt(s.substring(2,4),16), Integer.parseInt(s.substring(4,6),16)};
  }
  public static String toHex(int r,int g,int b) {
    if (r<0||r>255||g<0||g>255||b<0||b>255) throw new IllegalArgumentException("rgb out of range");
    return String.format("#%02X%02X%02X",r,g,b);
  }
  public static double luminance(int r,int g,int b) {
    double[] c={r/255.0,g/255.0,b/255.0};
    for(int i=0;i<3;i++) c[i]=c[i]<=0.04045?c[i]/12.92:Math.pow((c[i]+0.055)/1.055,2.4);
    return 0.2126*c[0]+0.7152*c[1]+0.0722*c[2];
  }
  public static double contrast(int[] a,int[] b) {
    double l1=luminance(a[0],a[1],a[2]), l2=luminance(b[0],b[1],b[2]);
    return (Math.max(l1,l2)+0.05)/(Math.min(l1,l2)+0.05);
  }
}
