本项目为Web项目

# 数据准备
https://github.com/Avens666/COVID-19-2019-nCoV-Infection-Data-cleaning-/tree/master/data   3.18数据更新

本项目进行了数据处理，将其存储到mysql数据库中

# 开发环境
操作系统：windows 10

开发工具：IntelliJ IDEA

JDK：1.8.0_241

服务器：Tomcat 9.0.333

所用外部包：mysql-connector-java-8.0.20.jar     fastjson-1.2.68.jar 

图表展示：百度Echarts可视化库

展示地图：需要china.js 文件

数据库：mysql

# 注意事项
关于IDEA中Web项目创建可参考博客：https://blog.csdn.net/qq_38526573/article/details/89743221

注意：servlet连数据库会找不到驱动类，需要把connector jar包放入tomcat 的common/lib下 ！
