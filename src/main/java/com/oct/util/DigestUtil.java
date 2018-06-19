package com.oct.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import sun.misc.BASE64Encoder;

/**
 * 
 * <p>
 * Title: DigestUtil.java
 * </p>
 * Description: MD5加密
 * <p>
 * Modify histoty:
 * 
 */
public class DigestUtil {

	private static final String SALT = "我与死亡同行";
	/**
	 * 获得字符串的加密值
	 * 
	 * @param psw
	 * @return
	 */
	public static String md5(String psw) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			byte[] byts = md.digest((psw+SALT).getBytes());
			BASE64Encoder base64 = new BASE64Encoder();
			return toHex(base64.encode(byts).getBytes());

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 验证密码是否匹配
	 * @param rawPassword 没有加密的密码
	 * @param password  加密过的密码
	 * @return true：相同  false：不相同
	 */
	public static boolean match(String rawPassword,String password){
		if(rawPassword == null || password == null) return false;
		if(md5(rawPassword).equals(password)) return true;
		return false;
	}

	private static String toHex(byte buffer[]) {
		StringBuffer sb = new StringBuffer(buffer.length * 2);
		for (int i = 0; i < buffer.length; i++) {
			sb.append(Character.forDigit((buffer[i] & 240) >> 4, 16));
			sb.append(Character.forDigit(buffer[i] & 15, 16));
		}

		return sb.toString();
	}


}
