/**
 * 
 */
package com.library.hibernate;

import com.library.util.BeanUtils;

public class HibernateEqualsBuilder {

	public static boolean reflectionEquals(Object obj, Object target,
			String keyfield) {
		if (target == null || obj == null)
			return false;
		if (target.getClass().equals(obj.getClass())) {
			try {
				Object objId = BeanUtils.forceGetProperty(obj, keyfield);
				Object targetId = BeanUtils.forceGetProperty(target, keyfield);
				if (objId.equals(targetId))
					return true;
			} catch (Exception e) {
			}
		}
		return false;
	}
}
