package com.hsun.pojo;

import java.io.Serializable;

public class Student implements Serializable{
    private Long stuId;

    private String name;

    private String gender;

    private String address;

    public Long getStuId() {
        return stuId;
    }

    public void setStuId(Long stuId) {
        this.stuId = stuId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

	@Override
	public String toString() {
		return "Student [stuId=" + stuId + ", name=" + name + ", gender=" + gender + ", address=" + address + "]";
	}
}