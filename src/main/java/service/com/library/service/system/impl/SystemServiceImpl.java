package com.library.service.system.impl;

import java.util.Collection;
import java.util.List;

import com.library.domain.User;
import com.library.hibernate.HibernateExpression;
import com.library.hibernate.HibernateGenericController;
import com.library.service.system.SystemService;

public class SystemServiceImpl implements SystemService {
	private HibernateGenericController controller;

	public void setHibernateGenericController(
			HibernateGenericController controller) {
		this.controller = controller;
	}

	@Override
	public long addUser(User user) {
		return controller.saveBackId(user);
	}

	@Override
	public void updUser(User user) {
		controller.update(user);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<User> getUsers(int page, int page_size, String order_by,
			boolean insc, Collection<HibernateExpression> ex) {
		return controller.findBy(User.class, page, page_size, order_by, insc,
				ex);
	}

	@Override
	public User getUserById(long id) {
		return controller.get(User.class, id);
	}

	@Override
	public User getUserByName(String name) {
		return controller.findUniqueBy(User.class, "name", name);
	}

	@Override
	public long getUsersCount(Collection<HibernateExpression> ex) {
		return controller.getResultCount(User.class, ex);
	}
}
