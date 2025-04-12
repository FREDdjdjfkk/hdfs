package com.lpc.util;

import javax.crypto.Cipher;
import javax.crypto.CipherInputStream;
import javax.crypto.spec.SecretKeySpec;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.security.Key;

public class EncryptionUtil {
    private static final String ALGO = "AES";
    private static final byte[] keyValue = "1234567890123456".getBytes(); // 建议换为安全的方式管理

    private static Key generateKey() throws Exception {
        return new SecretKeySpec(keyValue, ALGO);
    }

    public static InputStream encrypt(InputStream input) throws Exception {
        Cipher cipher = Cipher.getInstance(ALGO);
        cipher.init(Cipher.ENCRYPT_MODE, generateKey());
        return new CipherInputStream(input, cipher);
    }

    public static InputStream decrypt(InputStream input) throws Exception {
        Cipher cipher = Cipher.getInstance(ALGO);
        cipher.init(Cipher.DECRYPT_MODE, generateKey());
        return new CipherInputStream(input, cipher);
    }

    // 读取所有解密后的字节内容
    public static byte[] readAllBytes(InputStream input) throws Exception {
        ByteArrayOutputStream buffer = new ByteArrayOutputStream();
        byte[] data = new byte[4096];
        int nRead;
        while ((nRead = input.read(data, 0, data.length)) != -1) {
            buffer.write(data, 0, nRead);
        }
        return buffer.toByteArray();
    }
}
