package com.meetup.memcached.gumball;

public class Gumball {

	// 0: value; 1: miss timestamp.
	private String flag;
	
	private String value;
	
	public Result(String flag, String value) {
		this.flag  = flag;
		this.value = value;
	}
	
	public String getFlag() {
		return flag;
	}
	
	public String getValue() {
		return value;
	}
	
}
