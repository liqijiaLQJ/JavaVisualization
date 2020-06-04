package com.lqj.entity;

public class Diagnose {
    private int id;
    private String province;
    private int provinceDiagnose;
    private int provinceCure;
    private int provinceDead;
    private String date;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public int getProvinceDiagnose() {
        return provinceDiagnose;
    }

    public void setProvinceDiagnose(int provinceDiagnose) {
        this.provinceDiagnose = provinceDiagnose;
    }

    public int getProvinceCure() {
        return provinceCure;
    }

    public void setProvinceCure(int provinceCure) {
        this.provinceCure = provinceCure;
    }

    public int getProvinceDead() {
        return provinceDead;
    }

    public void setProvinceDead(int provinceDead) {
        this.provinceDead = provinceDead;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
}
