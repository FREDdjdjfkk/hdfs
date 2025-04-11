package com.lpc.pojo;

import java.util.Date;

public class Downlog {
    private int id;
    private String title;
    private String author;
    private Date downdate;

    private int num;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Date getDowndate() {
        return downdate;
    }

    public void setDowndate(Date downdate) {
        this.downdate = downdate;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }
}
