<%--
  Created by IntelliJ IDEA.
  User: LQJ
  Date: 2020/5/20
  Time: 12:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>全国疫情可视化</title>
    <!-- 引入 echarts.js -->
    <script src="https://cdn.staticfile.org/echarts/4.3.0/echarts.min.js"></script>
    <!-- 引入jQuery-->
    <script src="https://libs.baidu.com/jquery/2.0.0/jquery.js"></script>
      <!-- 引入地图-->
      <script src="china.js"></script>
  </head>

  <body>
    &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
    &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
     <button id="diagnoseHistogram">确诊前十柱状图</button>
     <button id="diagnoseRing">确诊前十圆环图</button>
     <button id="diagnoseChange">确诊人数变化曲线</button>
     <button id="diagnoseMap">确诊人数地图</button>
     <button id="diagnoseHubei">湖北省疫情数据</button>
     <p><br/>
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="width: 800px;height:560px;"></div>

    <script type="text/javascript">
      $(function () {
        $("#diagnoseHistogram").on("click", function () {
          // 确诊前十柱状图
          diagnoseHistogram()
        })
        $("#diagnoseRing").on("click", function () {
          // 确诊前十圆环图
          diagnoseRing()
        })
          $("#diagnoseChange").on("click", function () {
              // 确诊人数、治愈人数、死亡人数变化
              diagnoseChange()
          })
          $("#diagnoseMap").on("click", function () {
              // 全国疫情地图
              diagnoseMap()
          })
          $("#diagnoseHubei").on("click", function () {
              // 湖北省疫情数据
              diagnoseHubei()
          })
      })

      // 确诊数前十省份柱状图
      function diagnoseHistogram() {
        var jsondata = {
        }
        $.ajax({
          url: "diagnoseServ",
          data: jsondata,//向后端传的数据
          type: "POST",
          success: function (result) { //result为后端返回数据
            console.log(result)

            var province = [] //省份
            var provinceDiagnose = []  //确诊数
            
            for (var i=0;i<result.length;i++) {
              province[i] = result[i].province
              provinceDiagnose[i] = result[i].provinceDiagnose
            }
            
            // 指定图表的配置项和数据
            var option = {
              title: {
                text: '到3月18日确诊数前十的省份'
              },
              tooltip: {},
              legend: {
                data:['确诊数']
              },
              xAxis: {
                data: province
              },
              yAxis: {},
              series: [{
                name: '确诊数',
                type: 'bar',
                data: provinceDiagnose
              }]
            };

            show(option)
          },
          beforeSend: function () {
            console.log("请求发送之前")
          },
          error: function () {
            console.log("失败时调用")
          }
        })
      }

      // 确诊数前十省份圆环图
      function diagnoseRing() {
        var jsondata = {
        }
        $.ajax({
          url: "diagnoseServ",
          data: jsondata,//向后端传的数据
          type: "POST",
          success: function (result) { //result为后端返回数据
            console.log(result)

            var province = [] //省份
            var provinceDiagnoseList = []  //确诊数

            for (var i=0;i<result.length;i++) {
              province[i] = result[i].province
              provinceDiagnoseList.push({
                "value":result[i].provinceDiagnose,
                "name":result[i].province
              })
            }

            // 指定图表的配置项和数据
            var option = {
              title: {
                text: '到3月18日确诊数前十的省份',
                x:'right',
                y:'top',
              },
              tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b}: {c} ({d}%)'
              },
              legend: {
                orient: 'vertical',
                left: 10,
                data: province
              },
              series: [
                {
                  name: '访问来源',
                  type: 'pie',
                  radius: ['50%', '70%'],
                  avoidLabelOverlap: false,
                  label: {
                    show: false,
                    position: 'center'
                  },
                  emphasis: {
                    label: {
                      show: true,
                      fontSize: '30',
                      fontWeight: 'bold'
                    }
                  },
                  labelLine: {
                    show: false
                  },
                  data: provinceDiagnoseList
                }
              ]
            };

            show(option)
          },
          beforeSend: function () {
            console.log("请求发送之前")
          },
          error: function () {
            console.log("失败时调用")
          }
        })
      }

      // 确诊人数、治愈人数、死亡人数变化
      function diagnoseChange() {
          var jsondata = {
          }
          $.ajax({
              url: "diagnoseSumServ",
              data: jsondata,//向后端传的数据
              type: "POST",
              success: function (result) { //result为后端返回数据
                  console.log(result)

                  var diagnoseSum = [] // 全国确诊人数
                  var cureSum = []  //治愈人数
                  var deadSum = [] // 死亡人数
                  var date = [] //日期

                  for (var i=0;i<result.length;i++) {
                      diagnoseSum[i] = result[i].diagnoseSum
                      cureSum[i] = result[i].cureSum
                      deadSum[i] = result[i].deadSum
                      date[i] = result[i].date
                  }

                  // 指定图表的配置项和数据
                  var option = {
                      title: {
                          text: '全国确诊人数、治愈人数、死亡人数变化图',
                      },
                      tooltip: {
                          trigger: 'axis'
                      },
                      legend: {
                          data: ['确诊人数', '治愈人数', '死亡人数'],
                          x:'right',
                          y:'top'
                      },
                      grid: {
                          left: '3%',
                          right: '4%',
                          bottom: '3%',
                          containLabel: true
                      },
                      xAxis: {
                          type: 'category',
                          boundaryGap: false,
                          data: date
                      },
                      yAxis: {
                          type: 'value'
                      },
                      series: [
                          {
                              name: '确诊人数',
                              type: 'line',
                              data: diagnoseSum
                          },
                          {
                              name: '治愈人数',
                              type: 'line',
                              data: cureSum
                          },
                          {
                              name: '死亡人数',
                              type: 'line',
                              data: deadSum
                          }
                      ]
                  };

                  show(option)
              },
              beforeSend: function () {
                  console.log("请求发送之前")
              },
              error: function () {
                  console.log("失败时调用")
              }
          })
      }

      // 各省份确诊人数地图
      function diagnoseMap() {
          var jsondata = {
          }
          $.ajax({
              url: "diagnoseAllServ",
              data: jsondata,//向后端传的数据
              type: "POST",
              success: function (result) { //result为后端返回数据
                  console.log(result)

                  var provinceDiagnoseList = []  //确诊数

                  for (var i=0;i<result.length;i++) {
                      provinceDiagnoseList.push({
                          "value":result[i].provinceDiagnose,
                          "name":result[i].province
                      })
                  }

                  // 指定图表的配置项和数据
                  var option = {
                      title: {
                          text: '全国确诊人数地图',
                      },
                      tooltip: {
                          formatter:function(params,ticket, callback){
                              return params.seriesName+'<br />'+params.name+'：'+params.value
                          }//数据格式化
                      },
                      visualMap: {
                          min: 0,
                          max: 1500,
                          left: 'left',
                          top: 'bottom',
                          text: ['高','低'],//取值范围的文字
                          inRange: {
                              color: ['#e0ffff', '#006edd']//取值范围的颜色
                          },
                          show:true//图注
                      },
                      geo: {
                          map: 'china',
                          roam: false,//不开启缩放和平移
                          zoom:1.23,//视角缩放比例
                          label: {
                              normal: {
                                  show: true,
                                  fontSize:'10',
                                  color: 'rgba(0,0,0,0.7)'
                              }
                          },
                          itemStyle: {
                              normal:{
                                  borderColor: 'rgba(0, 0, 0, 0.2)'
                              },
                              emphasis:{
                                  areaColor: '#F3B329',//鼠标选择区域颜色
                                  shadowOffsetX: 0,
                                  shadowOffsetY: 0,
                                  shadowBlur: 20,
                                  borderWidth: 0,
                                  shadowColor: 'rgba(0, 0, 0, 0.5)'
                              }
                          }
                      },
                      series : [
                          {
                              name: '确诊人数',
                              type: 'map',
                              geoIndex: 0,
                              data:provinceDiagnoseList
                          }
                      ]
                  };

                  show(option)
              },
              beforeSend: function () {
                  console.log("请求发送之前")
              },
              error: function () {
                  console.log("失败时调用")
              }
          })
      }

      // 湖北省疫情数据
      function diagnoseHubei()  {
          var jsondata = {
          }
          $.ajax({
              url: "diagnoseHubeiServ",
              data: jsondata,//向后端传的数据
              type: "POST",
              success: function (result) { //result为后端返回数据
                  console.log(result)

                  var diagnose = [] //确诊数
                  var cure = []  //治愈人数
                  var dead = [] // 死亡人数
                  var date = [] // 日期
                  var count = 0 // 计数

                  for (var i=0;i<result.length;i++) {
                      if (i==0|i==result.length|i%5==0) {
                          diagnose[count] = result[i].provinceDiagnose
                          cure[count] = result[i].provinceCure
                          dead[count] = result[i].provinceDead
                          date[count] = result[i].date
                          count++
                      }
                  }

                  var posList = [
                      'left', 'right', 'top', 'bottom',
                      'inside',
                      'insideTop', 'insideLeft', 'insideRight', 'insideBottom',
                      'insideTopLeft', 'insideTopRight', 'insideBottomLeft', 'insideBottomRight'
                  ];

                  var app = {}
                  app.configParameters = {
                      rotate: {
                          min: -90,
                          max: 90
                      },
                      align: {
                          options: {
                              left: 'left',
                              center: 'center',
                              right: 'right'
                          }
                      },
                      verticalAlign: {
                          options: {
                              top: 'top',
                              middle: 'middle',
                              bottom: 'bottom'
                          }
                      },
                      position: {
                          options: echarts.util.reduce(posList, function (map, pos) {
                              map[pos] = pos;
                              return map;
                          }, {})
                      },
                      distance: {
                          min: 0,
                          max: 100
                      }
                  };

                  app.config = {
                      rotate: 90,
                      align: 'left',
                      verticalAlign: 'middle',
                      position: 'insideBottom',
                      distance: 15,
                      onChange: function () {
                          var labelOption = {
                              normal: {
                                  rotate: app.config.rotate,
                                  align: app.config.align,
                                  verticalAlign: app.config.verticalAlign,
                                  position: app.config.position,
                                  distance: app.config.distance
                              }
                          };
                          myChart.setOption({
                              series: [{
                                  label: labelOption
                              }, {
                                  label: labelOption
                              }, {
                                  label: labelOption
                              }, {
                                  label: labelOption
                              }]
                          });
                      }
                  };


                  var labelOption = {
                      show: true,
                      position: app.config.position,
                      distance: app.config.distance,
                      align: app.config.align,
                      verticalAlign: app.config.verticalAlign,
                      rotate: app.config.rotate,
                      formatter: '{c}  {name|{a}}',
                      fontSize: 16,
                      rich: {
                          name: {
                              textBorderColor: '#fff'
                          }
                      }
                  };

                  var option = {
                      title: {
                          text: '湖北省疫情数据',
                      },
                      color: ['#003366', '#006699', '#4cabce'],
                      tooltip: {
                          trigger: 'axis',
                          axisPointer: {
                              type: 'shadow'
                          }
                      },
                      legend: {
                          data: ['确诊数', '治愈数', '死亡数']
                      },
                      toolbox: {
                          show: true,
                          orient: 'vertical',
                          left: 'right',
                          top: 'center',
                          feature: {
                              mark: {show: true},
                              dataView: {show: true, readOnly: false},
                              magicType: {show: true, type: ['line', 'bar', 'stack', 'tiled']},
                              restore: {show: true},
                              saveAsImage: {show: true}
                          }
                      },
                      xAxis: [
                          {
                              type: 'category',
                              axisTick: {show: false},
                              data: date
                          }
                      ],
                      yAxis: [
                          {
                              type: 'value'
                          }
                      ],
                      series: [
                          {
                              name: '确诊数',
                              type: 'bar',
                              barGap: 0,
                              data: diagnose
                          },
                          {
                              name: '治愈数',
                              type: 'bar',
                              data: cure
                          },
                          {
                              name: '死亡数',
                              type: 'bar',
                              data: dead
                          }
                      ]
                  };

                  show(option)
              },
              beforeSend: function () {
                  console.log("请求发送之前")
              },
              error: function () {
                  console.log("失败时调用")
              }
          })
      }



      // 用于展示
      function show(option) {
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option,true);// 加上true表示不合并配置
      }
    </script>
  </body>
</html>
