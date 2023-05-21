package com.BlogEntities;

public class Category {
	private int cId;
	private String name;
	private String description;
	public Category(int cId, String name, String description) {
		super();
		this.cId = cId;
		this.name = name;
		this.description = description;
	}
	
	public Category() {
		
	}

	public Category(String name, String description) {
		super();
		this.name = name;
		this.description = description;
	}

	public int getcId() {
		return cId;
	}

	public void setcId(int cId) {
		this.cId = cId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	
}
