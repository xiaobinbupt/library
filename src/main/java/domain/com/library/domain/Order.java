package com.library.domain;

//订单
import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "toy_order")
public class Order implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	// 新建
	public static int STATUS_NEW = 0;
	// 确认
	public static int STATUS_CONFIRM = 1;
	// 完成
	public static int STATUS_DONE = 2;

	private static Map<Integer, String> status_names = new HashMap<Integer, String>();
	static {
		status_names.put(STATUS_NEW, "新建");
		status_names.put(STATUS_CONFIRM, " 确认");
		status_names.put(STATUS_DONE, "完成");
	}

	private long id;
	private long user_id;
	private User user;
	private long toy_id;
	private Toy toy;
	private Date create_time;
	private int num;
	private int status;
	private String des;

	public String getDes() {
		return des;
	}

	public void setDes(String des) {
		this.des = des;
	}

	@Transient
	public String getStatus_name() {
		return status_names.get(status);
	}

	@Transient
	public Toy getToy() {
		return toy;
	}

	public void setToy(Toy toy) {
		this.toy = toy;
	}

	@Transient
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public long getUser_id() {
		return user_id;
	}

	public void setUser_id(long user_id) {
		this.user_id = user_id;
	}

	public long getToy_id() {
		return toy_id;
	}

	public void setToy_id(long toy_id) {
		this.toy_id = toy_id;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
}
