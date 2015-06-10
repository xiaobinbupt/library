package com.library.service.order;

import java.util.Collection;
import java.util.List;

import com.library.domain.Order;
import com.library.hibernate.HibernateExpression;

public interface OrderService {

	public void addOrder(Order order);

	public void updOrder(Order order);

	public void delOrder(long id);

	public List<Order> getOrders(int page, int page_size, String order_by,
			boolean insc, Collection<HibernateExpression> ex);

	public long getOrdersCount(Collection<HibernateExpression> ex);

	public Order getOrderById(long id);
	
	public Order getOrderByUserIdToyId(long user_id, long toy_id, int status);
}
