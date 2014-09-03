/**
 * 
 */
package com.library.util;

import java.lang.Character.UnicodeBlock;
import java.net.URLEncoder;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

import org.apache.commons.lang.StringUtils;

public class StringUtil {

	/**
	 * Judge string whether string is null or empty.
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isEmpty(String str) {
		return str == null || str.trim().length() == 0;
	}

	// emoji表情的Unicode编码范围为[0xE001,0xE05A]&[0xE101,0xE15A]&[0xE201,0xE253]&[0xE401&0xE44C]&[0xE501,0xE537]。
	public static String realname(String name) {
		String realname = name;
		try {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < name.length(); i++) {
				char ch = name.charAt(i);
				UnicodeBlock ub = UnicodeBlock.of(ch);
				if (ub == UnicodeBlock.BASIC_LATIN) {
					// 英文及数字等
					sb.append(ch);
				} else if (ub == UnicodeBlock.HALFWIDTH_AND_FULLWIDTH_FORMS) {
					// 全角半角字符
					sb.append(ch);
				} else {
					// 汉字
					String temp = String.valueOf(ch);
					if (judgeIfSpecial(temp.getBytes("unicode"))) {
						continue;
					} else {
						sb.append(ch);
					}
				}
			}

			realname = sb.toString();
		} catch (Exception e) {
			System.out.println(e);
		}
		return realname;
	}

	public static String txt(String str) {
		if (StringUtils.isBlank(str)) {
			return "";
		}

		str = CharsetUtil.toUnicode(str);
		str = CharsetUtil.toPlainTextString(str);
		System.out.println(str);
		// str.

		// StringBuffer sb = new StringBuffer();
		// for (int i = 0; i < str.length(); i++) {
		// char ch = str.charAt(i);
		// UnicodeBlock ub = UnicodeBlock.of(ch);
		// if (ub == UnicodeBlock.BASIC_LATIN) {
		// // 英文及数字等
		// sb.append(ch);
		// } else if (ub == UnicodeBlock.HALFWIDTH_AND_FULLWIDTH_FORMS) {
		// // 全角半角字符
		// sb.append(ch);
		// } else {
		// // 汉字
		// // String temp = String.valueOf(ch);
		// if (isCnorEn(ch)) {
		// continue;
		// } else {
		// sb.append(ch);
		// }
		// }
		// }
		return str;
	}

	// Emoji表情
	@SuppressWarnings("unused")
	private static boolean isCnorEn(char c) {
		int a = (int) c;
		if ((a >= 0xE001 && a <= 0xE05A) || (a >= 0xE101 && a <= 0xE15A)
				|| (a >= 0xE201 && a <= 0xE253) || (a >= 0xE401 && a <= 0xE44C)
				|| (a >= 0xE501 && a <= 0xE537)) {
			return true;
		}

		if (a == 55356 || a == 55357) {
			return true;
		}

		return false;
	}

	// int emojiRangeArray[10] =
	// {0xE001,0xE05A,0xE101,0xE15A,0xE201,0xE253,0xE401,0xE44C,0xE501,0xE537};

	// [0xE001,0xE05A]&[0xE101,0xE15A]&[0xE201,0xE253]&[0xE401&0xE44C]&[0xE501,0xE537],
	public static boolean judgeIfSpecial(byte[] c) {
		if (c.length != 2 && c.length != 4) {
			return false;
		}
		byte[] b = new byte[2];
		if (c.length == 4) {
			b[0] = c[2];
			b[1] = c[3];
		} else {
			b[0] = c[0];
			b[1] = c[1];
		}
		if (b[0] != -32 && b[0] != -31 && b[0] != -30 && b[0] != -28
				&& b[0] != -27) {
			return false;
		}
		switch (b[0]) {
		case -32: // 0xe0 0xE001,0xE05A
			if (b[1] >= 1 && b[1] <= 90) // 0x01, 0x5A
			{
				return true;
			}
			break;
		case -31: // 0xe1 0xE101,0xE15A
			if (b[1] >= 1 && b[1] <= 90) // 0x01, 0x5A
			{
				return true;
			}
			break;
		case -30: // 0xe2 0xE201,0xE253
			if (b[1] >= 1 && b[1] <= 83) // 0x01, 0x53
			{
				return true;
			}
			break;
		case -28: // 0xe4 0xE401,0xE44C
			if (b[1] >= 1 && b[1] <= 76) // 0x01, 0x4c
			{
				return true;
			}
			break;
		case -27: // 0xe5 0xE501,0xE537
			if (b[1] >= 1 && b[1] <= 55) // 0x01, 0x37
			{
				return true;
			}
			break;
		default:
			break;
		}
		return false;
	}

	/**
	 * Escape special characters with their JSON equivalents.
	 * 
	 * @param str
	 * @return
	 */
	public static String escapeJson(String str) {
		if (isEmpty(str)) {
			return "";
		}
		char b;
		char c = 0;
		int i;
		int len = str.length();
		String t;
		StringBuilder sb = new StringBuilder(len + 4);
		for (i = 0; i < len; i += 1) {
			b = c;
			c = str.charAt(i);
			switch (c) {
			case '\\':
			case '"':
				sb.append('\\');
				sb.append(c);
				break;
			case '/':
				if (b == '<') {
					sb.append('\\');
				}
				sb.append(c);
				break;
			case '\b':
				sb.append("\\b");
				break;
			case '\t':
				sb.append("\\t");
				break;
			case '\n':
				sb.append("\\n");
				break;
			case '\f':
				sb.append("\\f");
				break;
			case '\r':
				sb.append("\\r");
				break;
			default:
				if (c < ' ' || (c >= '\u0080' && c < '\u00a0')
						|| (c >= '\u2000' && c < '\u2100')) {
					t = "000" + Integer.toHexString(c);
					sb.append("\\u" + t.substring(t.length() - 4));
				} else {
					sb.append(c);
				}
			}
		}
		return sb.toString();
	}

	/**
	 * Escape special characters with their HTML equivalents.
	 * 
	 * @param text
	 * @return
	 */
	public static String escapeHtml(String text) {
		if (text == null || text.length() == 0)
			return "";
		StringBuilder result = new StringBuilder(text.length());
		for (int i = 0; i < text.length(); i++) {
			char c = text.charAt(i);
			switch (c) {
			case '<':
				result.append("&lt;");
				break;
			case '>':
				result.append("&gt;");
				break;
			case '&':
				result.append("&amp;");
				break;
			case '\"':
				result.append("&quot;");
				break;
			case '\'':
				result.append("&#039;");
				break;
			case 0x0a: // Follow through...
			case 0x0d:
				result.append(" ");
				break;
			default:
				result.append(c);
				break;
			}
		}
		return result.toString();
	}

	/**
	 * Format email date, if is today return hour and second ,else return date.
	 * 
	 * @param date
	 * @return
	 */
	public static String formatEmailDate(Date date) {
		return DateUtil.formatEmailDate(date);
	}

	/**
	 * Trim a designated string
	 * 
	 * @param str
	 * @param trimStr
	 * @return
	 */
	public static String extendedTrim(String str, String trimStr) {
		if (str == null || str.length() == 0)
			return str;
		for (str = str.trim(); str.startsWith(trimStr); str = str.substring(
				trimStr.length()).trim())
			;
		for (; str.endsWith(trimStr); str = str.substring(0,
				str.length() - trimStr.length()).trim())
			;
		return str;
	}

	public static int getRandom(int start, int end) {
		Double l = Math.random();
		Integer lv = end - start;
		Double k = l * lv;
		return start + k.intValue();
	}

	public static String trimHref(String str) {
		if (str == null) {
			return str;
		}
		StringBuilder builder = new StringBuilder();
		int index = str.indexOf("<a");
		if (index >= 0) {
			builder.append(str.substring(0, index));
			index = str.indexOf(">");
			builder.append((str.substring(index + 1)).replaceAll("</a>", ""));
			return builder.toString();
		} else {
			return str.replaceAll("</a>", "");
		}
	}

	public static boolean isNumber(String target) {
		if (target == null) {
			return false;
		}
		Pattern p = Pattern.compile("^[0-9]+$");
		Matcher m = p.matcher(target);
		return m.matches();
	}

	public static int getPageFromRequest(String pageStr) {
		int page = 1;
		if (StringUtils.isBlank(pageStr) || !isNumber(pageStr)) {
			return page;
		}
		try {
			page = Integer.parseInt(pageStr);
			if (page < 1) {
				page = 1;
			}
		} catch (Exception e) {
			return 1;
		}
		return page;
	}

	public static String encodeUrl(String url) {
		try {
			url = URLEncoder.encode(url, "UTF-8");
			return url.replaceAll("\\+", "%20");

		} catch (Exception e) {
		}
		return "";
	}

	public static void main(String[] args) {
		// // String s = "asd <a href=\"http://asda.sd.com\">asdasd</a>";
		// // System.out.println(trimHref(s));
		// // System.out.println(isNumber(null));
		// String str = "中国人";
		// // int len = str.length();
		// // for (int i = 0; i < len; i++) {
		// // char ch = str.charAt(i);
		// // int ss = (int) ch;
		// // System.out.println(ss);
		// // }
		//
		// try {
		// str = str.getBytes("unicode").toString();
		// } catch (UnsupportedEncodingException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }
		//
		// System.out.println(str);
		String s = "http://tv.tom.com/TomPlayer2.swf?video=http://clip.uhoop.tom.com/a5a7cd/20110413/hd30996.flv";
		System.out.println(isFlushVideo(s));
	}

	/**
	 * 根据视频地址判断视频是否是flush格式
	 * 
	 * @param url
	 * @return
	 */
	public static boolean isFlushVideo(String url) {
		String regex = "\\.(flv|swf|html)$";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(url.trim());
		return m.find();
	}

	/**
	 * 获取汉字串拼音，英文字符不变
	 * 
	 * @param chinese
	 *            汉字串
	 * @return 汉语拼音
	 */
	public static String cn2Spell(String chinese) {
		StringBuffer pybf = new StringBuffer();
		char[] arr = chinese.toCharArray();
		HanyuPinyinOutputFormat defaultFormat = new HanyuPinyinOutputFormat();
		defaultFormat.setCaseType(HanyuPinyinCaseType.LOWERCASE);
		defaultFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
		for (int i = 0; i < arr.length; i++) {
			if (arr[i] > 128) {
				try {
					pybf.append(PinyinHelper.toHanyuPinyinStringArray(arr[i],
							defaultFormat)[0]);
				} catch (BadHanyuPinyinOutputFormatCombination e) {
					e.printStackTrace();
				}
			} else {
				pybf.append(arr[i]);
			}
		}
		return pybf.toString();
	}

	private static final String[] l = { "0", "1", "2", "3", "4", "5", "6", "7",
			"8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
			"l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x",
			"y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K",
			"L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X",
			"Y", "Z" };

	public static String Tento62(long value) {
		if (value < 62) {
			return l[(int) value];
		} else {
			long n = value % (long) 62;
			return (Tento62(value / 62) + l[(int) n]);
		}
	}

	/**
	 * 检测是否有emoji字符
	 * 
	 * @param source
	 * @return 一旦含有就抛出
	 */
	public static boolean containsEmoji(String source) {
		if (StringUtils.isBlank(source)) {
			return false;
		}

		int len = source.length();
		for (int i = 0; i < len; i++) {
			char codePoint = source.charAt(i);
			if (isEmojiCharacter(codePoint)) {
				// do nothing，判断到了这里表明，确认有表情字符
				return true;
			}
		}
		return false;
	}

	private static boolean isEmojiCharacter(char codePoint) {
		return (codePoint == 0x0) || (codePoint == 0x9) || (codePoint == 0xA)
				|| (codePoint == 0xD)
				|| ((codePoint >= 0x20) && (codePoint <= 0xD7FF))
				|| ((codePoint >= 0xE000) && (codePoint <= 0xFFFD))
				|| ((codePoint >= 0x10000) && (codePoint <= 0x10FFFF));
	}

	/**
	 * 过滤emoji 或者 其他非文字类型的字符
	 * 
	 * @param source
	 * @return
	 */
	public static String filterEmoji(String source) {
		if (!containsEmoji(source)) {
			System.out.println("#" + source + "#not containsEmoji");
			return source;// 如果不包含，直接返回
		}
		// 到这里铁定包含
		StringBuilder buf = null;

		int len = source.length();

		for (int i = 0; i < len; i++) {
			char codePoint = source.charAt(i);
			if (isEmojiCharacter(codePoint)) {
				if (buf == null) {
					buf = new StringBuilder(source.length());
				}

				buf.append(codePoint);
			} else {
			}
		}

		if (buf == null) {
			return source;// 如果没有找到 emoji表情，则返回源字符串
		} else {
			if (buf.length() == len) {// 这里的意义在于尽可能少的toString，因为会重新生成字符串
				buf = null;
				return source;
			} else {
				return buf.toString();
			}
		}

	}
}
