package com.lpc.util;

import java.security.MessageDigest;

public class StringUtil {
    private final static String[] hexDigits = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f" };
    /**
     * 判断输入的字符串参数是否为空。
     * @param args 输入的字串
     * @return true/false
     */
    public static boolean isNullOrEmpty(String args) {
        if (args == null || args.length() == 0) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 判断输入的字符串参数是否为空。
     * @param args 输入的字串
     * @return true/false
     */
    public static boolean isNullOrEmpty(Object args) {
        if (args == null || args.toString().length() == 0) {
            return true;
        } else {
            return false;
        }
    }


    /**
     * 将null的字符串对象转换成空
     *
     * @param value 转换字对象
     * @return 转换后字符串
     */
    public static String null2Empty(Object value) {
        if (value == null) {
            return "";
        } else {
            return value.toString();
        }
    }

    /**
     * md5加密
     *
     * @param origin 待加密字符串
     * @return 加密后字符串
     */
    public static String md5(String origin) {
        String resultString = null;
        try {
            resultString = new String(origin);
            MessageDigest md = MessageDigest.getInstance("MD5");
            resultString = byteArrayToHexString(md.digest(resultString.getBytes()));
        } catch (Exception ex) {
        }
        return resultString;
    }

    private static String byteArrayToHexString(byte[] b) {
        StringBuffer resultSb = new StringBuffer();

        for (int i = 0; i < b.length; i++) {
            resultSb.append(byteToHexString(b[i]));
        }
        return resultSb.toString();
    }

    private static String byteToHexString(byte b) {
        int n = b;
        if (n < 0)
            n = 256 + n;
        int d1 = n / 16;
        int d2 = n % 16;
        return hexDigits[d1] + hexDigits[d2];
    }

    public static void main(String[] args) {
        System.out.println(md5("123456"));
    }

}