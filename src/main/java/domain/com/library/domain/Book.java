package com.library.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "book")
public class Book implements Serializable {

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
	private String author;
	private String type;
	private String categorys;
	private String pub;
	private String age;
	private int age_begin;
	private int age_end;
	private String des;
	private int stock;
	private int num;
	
	@Column(name = "age_begin")
	public int getAge_begin() {
		return age_begin;
	}

	public void setAge_begin(int age_begin) {
		this.age_begin = age_begin;
	}

	@Column(name = "age_end")
	public int getAge_end() {
		return age_end;
	}

	public void setAge_end(int age_end) {
		this.age_end = age_end;
	}

	@Column(name = "categorys")
	public String getCategorys() {
		return categorys;
	}

	public void setCategorys(String categorys) {
		this.categorys = categorys;
	}

	@Column(name = "num")
	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
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

	@Column(name = "author")
	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	@Column(name = "type")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Column(name = "public")
	public String getPub() {
		return pub;
	}

	public void setPub(String pub) {
		this.pub = pub;
	}

	@Column(name = "age")
	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
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
