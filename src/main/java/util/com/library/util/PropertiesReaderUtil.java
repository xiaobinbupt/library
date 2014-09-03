/**
 * 
 */
package com.library.util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

/**
 * @author sunquanzhi
 * 
 */
public class PropertiesReaderUtil {

	private Properties prop = new Properties();
	private static Map<String,PropertiesReaderUtil> commonPropertyReaders = new HashMap<String,PropertiesReaderUtil>();

	private PropertiesReaderUtil(String fileName) {

		try {
			prop.load(this.getClass().getResourceAsStream("/" + fileName));
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public static PropertiesReaderUtil getInstance(String filename) {
		if(commonPropertyReaders.containsKey(filename)){
			return commonPropertyReaders.get(filename);
		}else{
			PropertiesReaderUtil commonPropertyReader = new PropertiesReaderUtil(filename);
			commonPropertyReaders.put(filename, commonPropertyReader);
			return commonPropertyReader;
		}
	}

	public String getProperty(String propertyName) {

		String propertyValue = this.prop.getProperty(propertyName);
		try {
			if (propertyValue != null) {
				propertyValue =  new String(propertyValue.getBytes("ISO-8859-1"), "utf-8");
			} else {
				return "";
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return "";
		} catch (NullPointerException e) {
			e.printStackTrace();
			return "";
		}
		return propertyValue;
	}

}
