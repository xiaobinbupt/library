package com.library.service.order.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.library.domain.Order;
import com.library.hibernate.CompareExpression;
import com.library.hibernate.CompareType;
import com.library.hibernate.HibernateExpression;
import com.library.hibernate.HibernateGenericController;
import com.library.service.order.OrderService;

public class OrderServiceImpl implements OrderService {
	private HibernateGenericController controller;

	public void setHibernateGenericController(
			HibernateGenericController controller) {
		this.controller = controller;
	}

	@Override
	public void addOrder(Order order) {
		controller.save(order);
	}

	@Override
	public void updOrder(Order order) {
		controller.update(order);
	}

	@Override
	public void delOrder(long id) {
		controller.deleteById(Order.class, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Order> getOrders(int page, int page_size, String order_by,
			boolean insc, Collection<HibernateExpression> ex) {
		return controller.findBy(Order.class, page, page_size, order_by, insc,
				ex);
	}

	@Override
	public long getOrdersCount(Collection<HibernateExpression> ex) {
		return controller.getResultCount(Order.class, ex);
	}

	@Override
	public Order getOrderById(long id) {
		return controller.get(Order.class, id);
	}

	@Override
	public Order getOrderByUserIdToyId(long user_id, long toy_id, int status) {
		Collection<HibernateExpression> ex = new ArrayList<HibernateExpression>();
		ex.add(new CompareExpression("user_id", user_id, CompareType.Equal));
		if (toy_id > 0) {
			ex.add(new CompareExpression("toy_id", toy_id, CompareType.Equal));
		}
		ex.add(new CompareExpression("status", status, CompareType.Equal));
		List<Order> list = getOrders(0, 0, null, true, ex);
		if (list != null && list.size() > 0) {
			return list.get(0);
		}
		return null;
	}

}
