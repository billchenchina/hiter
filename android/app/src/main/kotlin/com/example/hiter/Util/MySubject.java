package com.example.hiter.Util;

import java.util.List;

public class MySubject {

    private String name; //课程名

    private String xnxq;

    private String usrId;

    private String classroom = "暂无"; // 教室

    private String teacher; // 教师

    private List<Integer> weeks; // 第几周至第几周上

    private int start; // 开始上课的节次

    private int step; // 上课节数

    private int weekday; // 周几上

    private String info;


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getXnxq() {
        return xnxq;
    }

    public void setXnxq(String xnxq) {
        this.xnxq = xnxq;
    }

    public String getUsrId() {
        return usrId;
    }

    public void setUsrId(String usrId) {
        this.usrId = usrId;
    }

    public String getClassroom() {
        return classroom;
    }

    public void setClassroom(String classroom) {
        this.classroom = classroom;
    }

    public void setTeacher(String teacher) {
        this.teacher = teacher;
    }

    public List<Integer> getWeeks() {
        return weeks;
    }

    public void setWeeks(List<Integer> weeks) {
        this.weeks = weeks;
    }

    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getStep() {
        return step;
    }

    public void setStep(int step) {
        this.step = step;
    }

    public int getWeekday() {
        return weekday;
    }

    public void setWeekday(int weekday) {
        this.weekday = weekday;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

}
