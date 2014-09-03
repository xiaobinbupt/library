package com.library.service.system;

import java.util.Collection;
import java.util.List;

import com.library.domain.User;
import com.library.hibernate.HibernateExpression;

public interface SystemService {
	
	public long addUser(User user);

	public void updUser(User user);

	public List<User> getUsers(int page, int page_size, String order_by,
			boolean insc, Collection<HibernateExpression> ex);
	
	public long getUsersCount(Collection<HibernateExpression> ex);
	
	public User getUserByName(String name);
	
	public User getUserById(long id);
}
