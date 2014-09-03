/**
 * 
 */
package com.library.hibernate;

import java.io.Serializable;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.SimpleExpression;

/**
 * <p>�Ƚϱ��ʽ</p>
 * @author sunquanzhi
 *
 */
@SuppressWarnings("serial")
public class CompareExpression extends SimpleExpression implements Serializable, HibernateExpression {

	String propertyName;
	Object value;
	CompareType compareType;
	
	/**
	 * <p>����Ƚϱ��ʽ</p>
	 * @param propertyName �������
	 * @param value        �Ƚ�ֵ
	 * @param compareType  �Ƚ�����
	 */
	public CompareExpression(String propertyName,Object value,CompareType compareType)
	{
		super(propertyName, value, compareType.getValue());
		this.propertyName = propertyName;
		this.value = value;
		this.compareType = compareType;
	}
	
	public Criterion createCriteria() {
		if(value == null)
			return null;
		return this;
	}

}
