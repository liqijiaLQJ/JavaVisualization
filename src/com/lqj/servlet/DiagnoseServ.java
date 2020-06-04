package com.lqj.servlet;

import com.alibaba.fastjson.JSON;
import com.lqj.dao.CovidDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

// 确诊数前十的省份
@WebServlet(name = "DiagnoseServ",urlPatterns = {"/diagnoseServ"})
public class DiagnoseServ extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("doGet执行了");
        // 操作数据库
        CovidDao covidDao = new CovidDao();
        List<com.lqj.entity.Diagnose> list = covidDao.diagnose();

        // 将从数据库中查到的数据转成json
        String result = JSON.toJSONString(list);

        response.setCharacterEncoding("utf-8");
        response.setContentType("application/json;charset=utf-8");
        // 返回前端数据
        response.getWriter().write(result);
    }
}
