package com.library.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "toy")
public class Toy implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private long id;
	private String name;
	private String isdn;
	private String img;
	private String info_img1;
	private String info_img2;
	private String info_img3;
	private String info_img4;
	private String info_img5;
	private String des;
	private float price;
	private int stock;

	@Column(name = "price")
	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
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

	@Column(name = "name")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "isdn")
	public String getIsdn() {
		return isdn;
	}

	public void setIsdn(String isdn) {
		this.isdn = isdn;
	}

	@Column(name = "img")
	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	@Column(name = "info_img1")
	public String getInfo_img1() {
		return info_img1;
	}

	public void setInfo_img1(String info_img1) {
		this.info_img1 = info_img1;
	}

	@Column(name = "info_img2")
	public String getInfo_img2() {
		return info_img2;
	}

	public void setInfo_img2(String info_img2) {
		this.info_img2 = info_img2;
	}

	@Column(name = "info_img3")
	public String getInfo_img3() {
		return info_img3;
	}

	public void setInfo_img3(String info_img3) {
		this.info_img3 = info_img3;
	}

	@Column(name = "info_img4")
	public String getInfo_img4() {
		return info_img4;
	}

	public void setInfo_img4(String info_img4) {
		this.info_img4 = info_img4;
	}

	@Column(name = "info_img5")
	public String getInfo_img5() {
		return info_img5;
	}

	public void setInfo_img5(String info_img5) {
		this.info_img5 = info_img5;
	}

	@Column(name = "des")
	public String getDes() {
		return des;
	}

	public void setDes(String des) {
		this.des = des;
	}

	@Column(name = "stock")
	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}
}
