package model;

import java.text.SimpleDateFormat;
import java.sql.Date;

public class Account {

    private String account;
    private String pass;
    private String lastName;
    private String firstName;
    private Date birthday;
    private boolean gender;
    private String phone;
    private boolean isUse;
    private int roleInSystem;

    public Account() {
    }

    public Account(String account, String password, String lastName, String firstName, Date birthday, boolean gender,
            String phone, boolean inUse, int roleInSystem) {
        this.account = account;
        this.lastName = lastName;
        this.firstName = firstName;
        this.birthday = birthday;
        this.gender = gender;
        this.phone = phone;
        this.isUse = inUse;
        this.roleInSystem = roleInSystem;
        this.pass = password;
    }

    public Account(String account, String lastName, String firstName, Date birthday, boolean gender,
            String phone, boolean inUse, int roleInSystem) {
        this.account = account;
        this.lastName = lastName;
        this.firstName = firstName;
        this.birthday = birthday;
        this.gender = gender;
        this.phone = phone;
        this.isUse = inUse;
        this.roleInSystem = roleInSystem;
        this.pass = "";
    }

    public String getRoleString() {
        switch (roleInSystem) {
            case 1:
                return "Administrator";
            case 2:
                return "Manager";
            default:
                throw new IllegalStateException("Invalid role");
        }
    }

    public String getGenderTitle() {
        return gender ? "Male" : "Female";
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getBirthdayString() {
        return (birthday != null) ? new SimpleDateFormat("yyyy-MM-dd").format(birthday) : "N/A";
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public boolean isIsUse() {
        return isUse;
    }

    public void setIsUse(boolean inUse) {
        this.isUse = inUse;
    }

    public int getRoleInSystem() {
        return roleInSystem;
    }

    public void setRoleInSystem(int roleInSystem) {
        this.roleInSystem = roleInSystem;
    }

    protected String getPass() {
        return pass;
    }
}
