package com.lqj.util;

import java.sql.*;

public class SqlOperation {
    private static String url =  "jdbc:mysql://localhost:3306/visualization?serverTimezone=UTC&characterEncoding=utf8";
    private static String user = "root";
    private static String password = "6666";
    private static String driver = "com.mysql.cj.jdbc.Driver";

    // 连接数据库
    public static Connection getConn () {
        Connection conn = null;

        try {
            Class.forName(driver);//加载驱动
            conn = DriverManager.getConnection(url, user, password);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return conn;
    }

    public static void close (ResultSet rs, PreparedStatement prep, Connection conn) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        if (prep != null) {
            try {
                prep.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static void close (PreparedStatement prep, Connection conn) {
        if (prep != null) {
            try {
                prep.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // 测试
    public static void main(String[] args) throws SQLException {
        Connection conn = getConn();
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        String sql ="select * from covid";
        preparedStatement = conn.prepareStatement(sql);
        rs = preparedStatement.executeQuery();
        while (rs.next()) {
            System.out.println(rs.getString(3));
        }
        close(rs,preparedStatement,conn);
    }
}
