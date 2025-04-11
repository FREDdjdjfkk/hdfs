package com.lpc.pojo;

public class User {
    private int id;
    private String account;
    private String pwd;
    private String name;

    public int getId() {
        return id;
    }

    public String getAccount() {
        return this.account;
    }

    public String getPwd() {
        return pwd;
    }

    public String getName() {
        return name;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public void setName(String name) {
        this.name = name;
    }
}
