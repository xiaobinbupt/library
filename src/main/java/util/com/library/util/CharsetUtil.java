/**
 * 
 */
package com.library.util;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import org.apache.oro.text.regex.MatchResult;
import org.apache.oro.text.regex.Pattern;
import org.apache.oro.text.regex.PatternCompiler;
import org.apache.oro.text.regex.PatternMatcher;
import org.apache.oro.text.regex.PatternMatcherInput;
import org.apache.oro.text.regex.Perl5Compiler;
import org.apache.oro.text.regex.Perl5Matcher;

public class CharsetUtil {

	public static final String MESSAGE_UNICODE_PATTERN = "&#\\w{5};";

	public static final String MESSAGE_NOR_UNICODE_PATTERN = "&#(\\d{3,5});";
	
	public static final String MESSAGE_NOR_UNICODE_PATTERN_HEX = "&#x([a-zA-Z0-9]{3,5});";

	public static boolean isUtf8(byte[] bytes) {
		int n1 = 0;
		int n2 = 0;
		int n3 = 0;
		if (bytes.length < 1) {
			return false;
		}
		for (int i = 0; i < bytes.length; ++i) {
			if ((0x80 & bytes[i]) != 0) {
				++n1;
			} else if (n1 % 3 > 0) {
				return false;
			}

			if (n1 % 3 == 1) {
				if ((bytes[i] > -35) && (bytes[i] < -5)) {
					++n2;
				}
				n3 += bytes[i];
			}
		}
		if (n1 < 1) {
			return false;
		}
		if (n1 % 3 == 0) {
			n3 = n3 * 3 / n1;
			if ((n1 / 3 == n2) && (n1 >= 9)) {
				return true;
			}

			if ((n3 >= -28) && (n3 <= -16) && (n2 >= n1 / 4)) {
				return true;
			}
		}
		return false;
	}

	public static boolean isUTF8(byte[] data) {
		int count_good_utf = 0;
		int count_bad_utf = 0;
		byte current_byte = 0;
		byte previous_byte = 0;
		for (int i = 1; i < data.length; ++i) {
			current_byte = data[i];
			previous_byte = data[(i - 1)];
			if ((current_byte & 0xC0) == 128) {
				if ((previous_byte & 0xC0) == 192)
					++count_good_utf;
				else if ((previous_byte & 0x80) == 0)
					++count_bad_utf;
			} else if ((previous_byte & 0xC0) == 192) {
				++count_bad_utf;
			}

		}

		return (count_good_utf > count_bad_utf);
	}

	/**
	 * htmlʵ��ת���Ĺ���,�����ն˻Ὣ����ת����htmlʵ�崫������ ���磺��� ת����htmlʵ��Ϊ &#20320;&#22909;
	 * 
	 * @param str
	 *            Դ�ַ�
	 * @return ת������ַ�
	 */
	public static String toUnicode(String s) {
		StringBuffer sb = new StringBuffer();
		String sGB = null;
		if (s == null || s.equals(""))
			return "";
		for (int i = 0; i < s.length(); i++) {
			char cChar = s.charAt(i);
			// if(isChinese(cChar))
			if (((int) cChar) > 256) {
				if (isChinese2(cChar)) {
					sb.append("&#x");
					sb.append(Integer.toHexString(cChar));
					sb.append(";");
				}
//				else{
//					sb.append("&#x");
//					sb.append(Integer.toHexString(cChar));
//					sb.append(";");
//				}
				continue;
			} else if (((int) cChar) > 127) {
				sb.append("&#x");
				sb.append(Integer.toHexString(cChar));
				sb.append(";");
				continue;
			} else if (((int) cChar) < 32) { // ascii
				continue;
			}
			switch (cChar) {
			case 32: // ' '
				sb.append("&nbsp;");
				break;

			case '$': // '$' 36
				sb.append("��");
				break;

			case '\'': // '\'' 39
				sb.append("&apos;");
				break;

			case 34: // '"'
				sb.append("&quot;");
				break;

			case 38: // '&'
				sb.append("&amp;");
				break;

			case 60: // '<'
				sb.append("&lt;");
				break;

			case 62: // '>'
				sb.append("&gt;");
				break;
			case 0:
				break;
			case 20: // '\14'
				// sb.append("&gt;");
				break;
			default:
				sb.append(cChar);
				break;
			}
		}

		return sb.toString();
	}

	public static boolean isChinese(char c) {
		Character ch = new Character(c);
		String sCh = ch.toString();
		try {
			byte bb[] = sCh.getBytes("gb2312");
			if (bb.length > 1) {
				boolean flag = true;
				return flag;
			}
		} catch (UnsupportedEncodingException ue) {
			ue.printStackTrace();
			boolean flag1 = false;
			return flag1;
		}
		return false;
	}

	static sun.io.CharToByteGBK tool = new sun.io.CharToByteGBK();

	public static boolean isChinese2(char ch) {
		return tool.canConvert(ch);
	}

	public static String toPlainTextString(String in) {
		PatternCompiler compiler = new Perl5Compiler();
		Map<String, String> wordMap = new HashMap<String, String>();
		try {
			Pattern pattern = compiler.compile(MESSAGE_NOR_UNICODE_PATTERN);
			PatternMatcher matcher = new Perl5Matcher();
			PatternMatcherInput input = new PatternMatcherInput(in);
			while (matcher.contains(input, pattern)) {
				MatchResult result = matcher.getMatch();
				wordMap
						.put(result.group(0),
								unicodeToPlain(result.group(1), 1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		for (Map.Entry<String, String> entry : wordMap.entrySet()) {
			in = in.replaceAll(entry.getKey(), entry.getValue());
		}
		wordMap.clear();
		try{
			Pattern pattern = compiler.compile(MESSAGE_NOR_UNICODE_PATTERN_HEX);
			PatternMatcher matcher = new Perl5Matcher();
			PatternMatcherInput input = new PatternMatcherInput(in);
			while (matcher.contains(input, pattern)) {
				MatchResult result = matcher.getMatch();
				wordMap
						.put(result.group(0),
								unicodeToPlain(result.group(1), 2));
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		for (Map.Entry<String, String> entry : wordMap.entrySet()) {
			in = in.replaceAll(entry.getKey(), entry.getValue());
		}
		return in;

	}

	/**
	 * 
	 * @param word
	 * @param numType
	 *            1 Decimal 2 Hex
	 * @return
	 */
	public static String unicodeToPlain(String word, int numType) {
		StringBuilder plain = new StringBuilder();
		if (numType == 1) {
			int w = Integer.parseInt(word);
			plain.append((char) w);
		} else if (numType == 2) {
			int w = Integer.parseInt(word, 16);
			plain.append((char) w);
		}
		return plain.toString();
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		String s = "nih&#x597d;&#x5475;&#x5475;�۸����6100-6300Ԫ/�O���&#20320;&#22909;&#13217;";
		String s2 = "��éO";
		// for(int i=0;i<s2.length();i++){
		// char c = s2.charAt(i);
		// Integer it = (int)c;
		//			
		// System.out.println(it.toString());
		// }
		// System.out.println(toUnicode(s2));
		System.out.println(toPlainTextString(s));
		
		System.out.println(toUnicode("nih�úǺ�"));
	}
}
