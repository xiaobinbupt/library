/**
 * 
 */
package com.library.hibernate;

import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.beanutils.PropertyUtils;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.impl.CriteriaImpl;
import org.hibernate.metadata.ClassMetadata;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.SessionFactoryUtils;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.util.Assert;
import org.springframework.util.ReflectionUtils;

import com.library.util.BeanUtils;
import com.library.util.StringUtil;

/**
 * <p>
 * ������
 * </p>
 * 
 * 
 */
@SuppressWarnings("unchecked")
public class HibernateGenericController extends HibernateDaoSupport {

	private boolean cacheQueries = false;

	public void setCacheQueries(boolean cacheQueries) {
		this.cacheQueries = cacheQueries;
	}

	public boolean isCacheQueries() {
		return this.cacheQueries;
	}

	protected Criteria createCriteria(Class clazz) {
		Criteria criteria = getSession().createCriteria(clazz);
		if (isCacheQueries()) {
			criteria.setCacheable(true);
		}
		return criteria;
	}

	/**
	 * <p>
	 * ����ID��ȡ����. ʵ�ʵ���Hibernate��session.load()��������ʵ�����proxy����. ������󲻴��ڣ��׳��쳣.
	 * </p>
	 * 
	 * @param <T>
	 * @param clasz
	 * @param id
	 * @return
	 */
	public <T> T load(Class<T> clasz, Serializable id)
			throws HibernateException {
		return (T) getHibernateTemplate().load(clasz, id);
	}

	public <T> T load(Class<T> clasz, Serializable id, LockMode lockMode)
			throws HibernateException {
		return (T) getHibernateTemplate().load(clasz, id, lockMode);
	}

	/**
	 * <p>
	 * ����ID��ȡ����. ʵ�ʵ���Hibernate��session.get()��������ʵ�����proxy����. ������󲻴��ڣ�����null.
	 * </p>
	 * 
	 * @param <T>
	 * @param clasz
	 * @param id
	 * @return
	 */
	public <T> T get(Class<T> clasz, Serializable id) {
		return (T) getHibernateTemplate().get(clasz, id);
	}

	public Object get(String entityName, Serializable id) {
		return getHibernateTemplate().get(entityName, id);
	}

	public String getEntityName(Object obj) {
		return getSessionFactory().getClassMetadata(obj.getClass())
				.getEntityName();
		// return getSession().getEntityName(obj);
	}

	public <T> T get(Class<T> clasz, Serializable id, LockMode lockMode) {
		return (T) getHibernateTemplate().get(clasz, id, lockMode);
	}

	/**
	 * <p>
	 * ��ȡȫ������.
	 * </p>
	 * 
	 * @param <T>
	 * @param clasz
	 * @return
	 */
	public <T> List<T> getAll(Class<T> clasz) {
		return getHibernateTemplate().loadAll(clasz);
	}

	/**
	 * <p>
	 * ��ȡȫ������,�������ֶ������������.
	 * </p>
	 * 
	 * @param <T>
	 * @param clasz
	 * @param orderBy
	 * @param isAsc
	 * @return
	 */
	public <T> List<T> getAll(Class<T> clasz, String orderBy, boolean isAsc) {
		Assert.hasText(orderBy);
		if (isAsc)
			return getHibernateTemplate().findByCriteria(
					DetachedCriteria.forClass(clasz).addOrder(
							Order.asc(orderBy)));
		else
			return getHibernateTemplate().findByCriteria(
					DetachedCriteria.forClass(clasz).addOrder(
							Order.desc(orderBy)));
	}

	/**
	 * <p>
	 * ɾ������
	 * </p>
	 * 
	 * @param entity
	 */
	public void delete(Object entity) {
		getHibernateTemplate().delete(entity);
	}

	/**
	 * <p>
	 * merge����
	 * </p>
	 * 
	 * @param <T>
	 * @param entity
	 * @return
	 */
	public <T> T merge(T entity) {
		return (T) getHibernateTemplate().merge(entity);
	}

	/**
	 * <p>
	 * ���¶���
	 * </p>
	 * 
	 * @param entity
	 */
	public void update(Object entity) {
		getHibernateTemplate().update(entity);
	}

	/**
	 * <p>
	 * �������
	 * </p>
	 * 
	 * @param entity
	 */
	public void persist(Object entity) {
		getHibernateTemplate().persist(entity);
	}

	/**
	 * <p>
	 * �������
	 * </p>
	 * 
	 * @param entity
	 */
	public void save(Object entity) {
		getHibernateTemplate().save(entity);
	}

	/**
	 * <p>
	 * �������
	 * </p>
	 * 
	 * @param entity
	 */
	public Long saveBackId(Object entity) {
		Long id = (Long) getHibernateTemplate().save(entity);
		return id;
	}

	/**
	 * <p>
	 * ����IDɾ������.
	 * </p>
	 */
	public <T> void deleteById(Class<T> clasz, Serializable id) {
		delete(get(clasz, id));
	}

	protected void flush() {
		getHibernateTemplate().flush();
	}

	protected void clear() {
		getHibernateTemplate().clear();
	}

	protected void refresh(Object entity, LockMode lockMode) {
		getHibernateTemplate().refresh(entity, lockMode);
	}

	protected void refresh(Object entity) {
		getHibernateTemplate().refresh(entity);
	}

	/**
	 * <p>
	 * ����Criteria����.
	 * </p>
	 * 
	 * @param clasz
	 * @param criterions
	 *            �ɱ��Restrictions�����б�,��{@link #createQuery(String,Object...)}
	 */
	protected <T> Criteria createCriteria(Class<T> clasz,
			Criterion... criterions) {
		Criteria criteria = createCriteria(clasz);
		for (Criterion c : criterions) {
			criteria.add(c);
		}
		return criteria;
	}

	/**
	 * <p>
	 * ����Criteria���󣬴������ֶ����������ֶ�.
	 * </p>
	 * 
	 * @param clasz
	 * @see #createCriteria(Class,Criterion[])
	 */
	protected <T> Criteria createCriteria(Class<T> clasz, String orderBy,
			boolean isAsc, Criterion... criterions) {
		// Assert.hasText(orderBy);

		Criteria criteria = createCriteria(clasz, criterions);

		if (!StringUtil.isEmpty(orderBy)) {
			if (isAsc)
				criteria.addOrder(Order.asc(orderBy));
			else
				criteria.addOrder(Order.desc(orderBy));
		}
		return criteria;
	}

	protected <T> Criteria createCriteria(Class<T> clasz,
			Collection<HibernateExpression> expressions) {
		List<Criterion> criterions = new ArrayList<Criterion>();
		for (HibernateExpression expression : expressions) {
			Criterion criterion = expression.createCriteria();
			if (criterion != null) {
				criterions.add(criterion);
			}
		}

		return createCriteria(clasz, criterions.toArray(new Criterion[0]));
	}

	/**
	 * <p>
	 * ����Criteria����,����HibernateExpression
	 * </p>
	 * 
	 * @param <T>
	 * @param clasz
	 * @param orderBy
	 * @param isAsc
	 * @param expressions
	 * @return
	 */
	protected <T> Criteria createCriteria(Class<T> clasz, String orderBy,
			boolean isAsc, Collection<HibernateExpression> expressions) {
		List<Criterion> criterions = new ArrayList<Criterion>();
		for (HibernateExpression expression : expressions) {
			Criterion criterion = expression.createCriteria();
			if (criterion != null) {
				criterions.add(criterion);
			}
		}

		return createCriteria(clasz, orderBy, isAsc,
				criterions.toArray(new Criterion[0]));
	}

	/**
	 * <p>
	 * ����hql��ѯ,ֱ��ʹ��HibernateTemplate��find����.
	 * </p>
	 * 
	 * @param hql
	 * @param values
	 *            �ɱ����,��{@link #createQuery(String,Object...)}
	 */
	public List findBy(String hql, Object... values) {
		Assert.hasText(hql);
		return getHibernateTemplate().find(hql, values);
	}

	/**
	 * <p>
	 * ����������������ֵ��ѯ����.
	 * </p>
	 * 
	 * @param <T>
	 * @param clasz
	 * @param propertyName
	 * @param value
	 * @return
	 */
	public <T> List<T> findBy(Class<T> clasz, String propertyName, Object value) {
		Assert.hasText(propertyName);
		return createCriteria(clasz, Restrictions.eq(propertyName, value))
				.list();
	}

	/**
	 * <p>
	 * ����������������ֵ��ѯ����,���������.
	 * </p>
	 * 
	 * @param <T>
	 * @param clasz
	 * @param propertyName
	 * @param value
	 * @param orderBy
	 * @param isAsc
	 * @return
	 */
	public <T> List<T> findBy(Class<T> clasz, String propertyName,
			Object value, String orderBy, boolean isAsc) {
		Assert.hasText(propertyName);
		Assert.hasText(orderBy);
		return createCriteria(clasz, orderBy, isAsc,
				Restrictions.eq(propertyName, value)).list();
	}

	/**
	 * <p>
	 * ����������������ֵ��ѯΨһ����.
	 * </p>
	 * 
	 * @param <T>
	 * @param clasz
	 * @param propertyName
	 * @param value
	 * @return
	 */
	public <T> T findUniqueBy(Class<T> clasz, String propertyName, Object value) {
		Assert.hasText(propertyName);
		return (T) createCriteria(clasz, Restrictions.eq(propertyName, value))
				.uniqueResult();
	}

	/**
	 * <p>
	 * ��ü�¼����
	 * </p>
	 * 
	 * @param hql
	 * @param values
	 * @return
	 */
	public Long getResultCount(String hql, Object... values) {
		Assert.hasText(hql);
		String countQueryString = " select count(*) "
				+ removeSelect(removeOrders(hql));
		List countlist = getHibernateTemplate().find(countQueryString, values);
		return toLong(countlist.get(0));
	}

	/**
	 * <p>
	 * ִ�����ݿ����
	 * </p>
	 * 
	 * @param hql
	 * @param objects
	 * @return
	 */
	public Integer executeUpdate(final String hql, final Object... objects) {
		return (Integer) getHibernateTemplate().executeWithNativeSession(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException {
						Query query = session.createQuery(hql);
						if (objects != null) {
							for (int i = 0; i < objects.length; i++) {
								query.setParameter(i, objects[i]);
							}
						}
						return query.executeUpdate();
					}
				});
	}

	/**
	 * <p>
	 * ��ü�¼����
	 * </p>
	 * 
	 * @param criteria
	 * @return
	 */
	public Long getResultCount(Criteria criteria) {
		Assert.notNull(criteria);
		CriteriaImpl impl = (CriteriaImpl) criteria;
		Long totalCount = 0L;
		try {
			// �Ȱ�Projection��OrderBy����ȡ����,���������ִ��Count����
			Projection projection = impl.getProjection();
			List<CriteriaImpl.OrderEntry> orderEntries;
			try {
				orderEntries = (List) BeanUtils.forceGetProperty(impl,
						"orderEntries");
				BeanUtils.forceSetProperty(impl, "orderEntries",
						new ArrayList());
			} catch (Exception e) {
				throw new InternalError(
						" Runtime Exception impossibility throw ");
			}

			// ִ�в�ѯ
			totalCount = toLong(criteria.setProjection(Projections.rowCount())
					.uniqueResult());

			// ��֮ǰ��Projection��OrderBy�����������ȥ
			criteria.setProjection(projection);
			if (projection == null) {
				criteria.setResultTransformer(CriteriaSpecification.ROOT_ENTITY);
			}

			try {
				BeanUtils.forceSetProperty(impl, "orderEntries", orderEntries);
			} catch (Exception e) {
				throw new InternalError(
						" Runtime Exception impossibility throw ");
			}
		} finally {
			SessionFactoryUtils.closeSession((Session) impl.getSession());
		}
		return totalCount;
	}

	/**
	 * <p>
	 * ��ü�¼����
	 * </p>
	 * 
	 * @param clasz
	 * @param criterions
	 * @return
	 */
	public Long getResultCount(Class clasz, Criterion... criterions) {
		Criteria criteria = createCriteria(clasz, criterions);
		return getResultCount(criteria);
	}

	/**
	 * <p>
	 * ��ü�¼����
	 * </p>
	 * 
	 * @param clasz
	 * @param expressions
	 * @return
	 */
	public Long getResultCount(Class clasz,
			Collection<HibernateExpression> expressions) {
		Criteria criteria = createCriteria(clasz);
		for (HibernateExpression expression : expressions) {
			Criterion criterion = expression.createCriteria();
			if (criterion != null) {
				criteria.add(criterion);
			}

		}
		return getResultCount(criteria);
	}

	/**
	 * <p>
	 * ��ҳ��ѯ
	 * </p>
	 * 
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return
	 */
	public List findBy(final String hql, int pageNo, final int pageSize,
			final Object... values) {
		Assert.hasText(hql);
		Assert.isTrue(pageNo >= 1, "pageNo should start from 1");
		final int startIndex = getStartOfPage(pageNo, pageSize);
		HibernateCallback action = new HibernateCallback() {
			public Object doInHibernate(final Session session)
					throws SQLException {
				Query query = session.createQuery(hql);
				query.setFirstResult(startIndex);
				query.setMaxResults(pageSize);
				if (values != null && values.length > 0) {
					for (int i = 0; i < values.length; i++) {
						query.setParameter(i, values[i]);
					}
				}

				return query.list();
			}
		};

		return (List) getHibernateTemplate().execute(action);
	}

	/***************************************************************************
	 * <p>
	 * ��ҳ��ѯ
	 * </p>
	 * 
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param params
	 * @return
	 * 
	 * @author penglei
	 */
	public List findBy(final String hql, int pageNo, final int pageSize,
			final Map<String, Object> params) {
		Assert.hasText(hql);
		Assert.isTrue(pageNo >= 1, "pageNo should start from 1");
		final int startIndex = getStartOfPage(pageNo, pageSize);
		HibernateCallback action = new HibernateCallback() {
			public Object doInHibernate(final Session session)
					throws SQLException {
				Query query = session.createQuery(hql);
				query.setFirstResult(startIndex);
				query.setMaxResults(pageSize);

				if (params != null && params.size() > 0) {
					for (String key : params.keySet()) {
						Object param = params.get(key);
						if (param instanceof Object[]) {
							Object[] obj = (Object[]) param;
							query.setParameterList(key, obj);

						} else if (param instanceof Collection) {
							Collection collection = (Collection) param;
							query.setParameterList(key, collection);
						} else {
							query.setParameter(key, param);
						}
					}
				}

				return query.list();
			}
		};

		return (List) getHibernateTemplate().execute(action);
	}

	/**
	 * 
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return
	 */
	public List findByArray(final String hql, int pageNo, final int pageSize,
			final Object[] values) {
		Assert.hasText(hql);
		Assert.isTrue(pageNo >= 1, "pageNo should start from 1");
		// int startIndex = getStartOfPage(pageNo, pageSize);
		// Query query = createQuery(hql, values);
		// return
		// query.setFirstResult(startIndex).setMaxResults(pageSize).list();
		return this.findBy(hql, pageNo, pageSize, values);

	}

	/**
	 * <p>
	 * ��ҳ��ѯ
	 * </p>
	 * 
	 * @param criteria
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public List findBy(Criteria criteria, int pageNo, int pageSize) {
		Assert.notNull(criteria);
		// Assert.isTrue(pageNo >= 1, "pageNo should start from 1");
		if (pageNo > 0 && pageSize > 0) {
			int startIndex = getStartOfPage(pageNo, pageSize);
			return criteria.setFirstResult(startIndex).setMaxResults(pageSize)
					.list();
		} else {
			return criteria.list();
		}
	}

	/**
	 * <p>
	 * ��ҳ��ѯ
	 * </p>
	 * 
	 * @param clasz
	 * @param pageNo
	 * @param pageSize
	 * @param criterions
	 * @return
	 */
	public List findBy(Class clasz, int pageNo, int pageSize,
			Criterion... criterions) {
		Criteria criteria = createCriteria(clasz, criterions);
		return findBy(criteria, pageNo, pageSize);
	}

	/**
	 * <p>
	 * ��ҳ��ѯ,����HibernateExpression
	 * </p>
	 * 
	 * @param clasz
	 * @param pageNo
	 * @param pageSize
	 * @param expressions
	 * @return
	 */
	public List findBy(Class clasz, int pageNo, int pageSize,
			Collection<HibernateExpression> expressions) {
		Criteria criteria = createCriteria(clasz, expressions);
		return findBy(criteria, pageNo, pageSize);
	}

	/**
	 * <p>
	 * ��������,��ҳ��ѯ,����HibernateExpression
	 * </p>
	 * 
	 * @param clasz
	 * @param pageNo
	 * @param pageSize
	 * @param orderBy
	 * @param isAsc
	 * @param expressions
	 * @return
	 */
	public List findBy(Class clasz, int pageNo, int pageSize, String orderBy,
			boolean isAsc, Collection<HibernateExpression> expressions) {
		Criteria criteria = createCriteria(clasz, orderBy, isAsc, expressions);
		return findBy(criteria, pageNo, pageSize);
	}

	/**
	 * <p>
	 * ��ҳ��ѯ
	 * </p>
	 * 
	 * @param clasz
	 * @param pageNo
	 * @param pageSize
	 * @param orderBy
	 * @param isAsc
	 * @param criterions
	 * @return
	 */
	public List findBy(Class clasz, int pageNo, int pageSize, String orderBy,
			boolean isAsc, Criterion... criterions) {
		Criteria criteria = createCriteria(clasz, orderBy, isAsc, criterions);
		return findBy(criteria, pageNo, pageSize);
	}

	/**
	 * �ж϶���ĳЩ���Ե�ֵ�����ݿ����Ƿ�Ψһ.
	 * 
	 * @param uniquePropertyNames
	 *            ��POJO�ﲻ���ظ��������б�,�Զ��ŷָ� ��"name,loginid,password"
	 */
	public <T> boolean isUnique(Class<T> clasz, Object entity,
			String uniquePropertyNames) {
		Assert.hasText(uniquePropertyNames);
		Criteria criteria = createCriteria(clasz).setProjection(
				Projections.rowCount());
		String[] nameList = uniquePropertyNames.split(",");
		try {
			// ѭ������Ψһ��
			for (String name : nameList) {
				criteria.add(Restrictions.eq(name,
						PropertyUtils.getProperty(entity, name)));
			}

			// ���´���Ϊ�������update�����,�ų�entity����.

			// ȡ��entity������ֵ
			Serializable id = getId(clasz, entity);

			// ���id!=null,˵�������Ѵ���,�ò���Ϊupdate,�����ų�������ж�
			if (id != null) {
				String idName = getIdName(clasz);
				criteria.add(Restrictions.not(Restrictions.eq(idName, id)));
			}

		} catch (Exception e) {
			ReflectionUtils.handleReflectionException(e);
		}
		Integer resultCount = (Integer) criteria.uniqueResult();
		return resultCount.intValue() == 0;
	}

	/**
	 * <p>
	 * ȡ�ö��������ֵ,��������.
	 * </p>
	 * 
	 * @param clasz
	 * @param entity
	 * @return
	 * @throws NoSuchMethodException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	public Serializable getId(Class clasz, Object entity)
			throws NoSuchMethodException, IllegalAccessException,
			InvocationTargetException {
		Assert.notNull(entity);
		Assert.notNull(clasz);

		return (Serializable) PropertyUtils.getProperty(entity,
				getIdName(clasz));
	}

	/**
	 * <p>
	 * ȡ�ö��������ֵ,��������.
	 * </p>
	 * 
	 * @param entity
	 * @return
	 */
	public Serializable getId(Object entity) {
		return getSession().getIdentifier(entity);
	}

	/**
	 * <p>
	 * ȡ�ö����������,��������.
	 * </p>
	 * 
	 * @param clazz
	 * @return
	 */
	public String getIdName(Class clazz) {
		Assert.notNull(clazz);
		ClassMetadata meta = getSessionFactory().getClassMetadata(clazz);
		Assert.notNull(meta, "Class " + clazz
				+ " not define in hibernate session factory.");
		String idName = meta.getIdentifierPropertyName();
		Assert.hasText(idName, clazz.getSimpleName()
				+ " has no identifier property define.");
		return idName;
	}

	/**
	 * <p>
	 * ȥ��hql��select �Ӿ䣬δ����union�����,����ҳ��ѯ.
	 * </p>
	 * 
	 * @param hql
	 * @return
	 */
	private static String removeSelect(String hql) {
		Assert.hasText(hql);
		int beginPos = hql.toLowerCase().indexOf("from");
		Assert.isTrue(beginPos != -1, " hql : " + hql
				+ " must has a keyword 'from'");
		return hql.substring(beginPos);
	}

	/**
	 * <p>
	 * ȥ��hql��orderby �Ӿ䣬����ҳ��ѯ.
	 * </p>
	 * 
	 * @param hql
	 * @return
	 */
	private static String removeOrders(String hql) {
		Assert.hasText(hql);
		Pattern p = Pattern.compile("order\\s*by[\\w|\\W|\\s|\\S]*",
				Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(hql);
		StringBuffer sb = new StringBuffer();
		while (m.find()) {
			m.appendReplacement(sb, "");
		}
		m.appendTail(sb);
		return sb.toString();
	}

	/**
	 * <p>
	 * ��ȡ��һҳ��һ�����������ݼ���λ��.
	 * </p>
	 * 
	 * @param pageNo
	 *            ��1��ʼ��ҳ��
	 * @param pageSize
	 *            ÿҳ��¼����
	 * @return ��ҳ��һ������
	 */
	private static int getStartOfPage(int pageNo, int pageSize) {
		return (pageNo - 1) * pageSize;
	}

	/**
	 * <p>
	 * ΪHibernate3.1֮ǰ�汾������
	 * </p>
	 * 
	 * @param obj
	 * @return
	 */
	private static Long toLong(Object obj) {
		if (obj instanceof Long) {
			return (Long) obj;
		} else if (obj instanceof Integer) {
			Integer i = (Integer) obj;
			return i.longValue();
		} else {
			return 0L;
		}
	}
}
