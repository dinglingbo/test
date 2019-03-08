<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-21 15:52:43
  - Description:
-->

<head>
    <title>预约新界面</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
    <script src="<%= request.getContextPath() %>/repair/js/RepairBusiness/BookingManagement/jquery-ui.custom.min.js"></script>
    <script src="<%= request.getContextPath() %>/repair/js/RepairBusiness/BookingManagement/icheck.min.js"></script>
    <script src="<%= request.getContextPath() %>/repair/js/RepairBusiness/BookingManagement/fullcalendar.min.js"></script>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/repair/RepairBusiness/BookingManagement/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/repair/RepairBusiness/BookingManagement/fullcalendar.css">
    <script src="<%= request.getContextPath() %>/repair/js/RepairBusiness/BookingManagement/BookingMgrMain.js?v=1.0.0"></script>
    <!-- <link rel="stylesheet" href="<%= request.getContextPath() %>/repair/RepairBusiness/BookingManagement/lightbox.min.css"> -->


    <style type="text/css">
        .fc-border-separate tbody {
            background: #fff;
        }

        .fc-grid .fc-day-number {
            padding: 3px;
            font-size: 2rem;
        }

        .fc-event {
            border: none !important;
            text-align: center;
        }

        .fc-past {
            background-color: #F8F8F8;
        }

        .fc-past .fc-day-number {
            opacity: 0.5;
        }

        .fc th {
            padding: 5px 0;
        }

        .current_day {
            background: #1AB394;
            color: #fff;
        }

        .current_day .fc-day-number,
        .current_day .fc-day-number {
            opacity: 1;
            color: #fff;
        }

        .current_day .fc-event-time,
        .current_day .fc-event-title {
            color: #fff;
        }

        .fc-widget-content {
            cursor: pointer;
        }

        .fc-day-content p {
            margin: 0 0 5px;
            width: 50%;
        }

        .data-p,
        .data-h,
        .data-w,
        .data-l {
            text-align: center;
            font-size: 1.5rem;
            display: inline-block;
            margin: 5px;
        }

        .data-l {
            opacity: 0.5;
        }

        .data-c {
            display: block;
        }

        .data-p label {
            color: blue;
        }

        .data-w label {
            color: red;
        }

        .fc-day-header {
            background-color: #deedf7
        }
    </style>

</head>

<body>
    <div class="nui-toolbar" id="toolbar1" style="padding:2px;">
        <table class="table" id="table1" style="margin: 0;">
            <tr>
                <td style="width:40%;">
                    <input class="nui-combobox" emptyText="请选择公司...">
                    <input format="yyyy-MM" style="width:100px" class="nui-monthpicker" allowInput="false" name="eRecordDate"
                        id="eRecordDate" emptyText="请选择年月" />
                </td>
                <td class="fc-header-right" style="font-size:1.5rem;">
                    可预约：<b id="canReserve" style="color:blue;padding:0 3px;">0</b>，待确认<b id="reserve" style="color:red;padding:0 3px;">0</b>，已确认<b
                        id="confirm" style="color:red;padding:0 3px;">0</b>，已到店<b id="iscome" style="color:red;padding:0 3px;">0</b>，已取消<b
                        style="color:green;padding:0 3px;" id="iscancel">0</b>
                </td>

            </tr>
        </table>
    </div>
    <div class="nui-fit">
        <div id="calendar">

        </div>
    </div>
    <script type="text/javascript">
        nui.parse();
        $(document).ready(function () {
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });
            /* initialize the calendar
             -----------------------------------------------------------------*/
            var date = new Date();
            var d = date.getDate();
            var m = date.getMonth();
            var y = date.getFullYear();
            $('#calendar').fullCalendar({
                header: false,
                firstDay: 1,
                height: 200,
                dayClick: function (date, allDay, jsEvent, view) {
                    console.log(date);
                    console.log(allDay);
                    console.log(jsEvent);
                    console.log(view);
                    $('.current_day').removeClass('current_day');
                    $(this).addClass('current_day');
                    var date = $(this).attr('data-date');
                    console.log(date);
                    list();
                    // parent.layer.open({
                    //     type: 2,
                    //     title: '预约列表',
                    //     shadeClose: false,
                    //     shade: 0.6,
                    //     maxmin: true, //开启最大化最小化按钮
                    //     area: ['100%', '100%'],
                    //     content: '/Admin/ServiceItems/reserveList.html?d=' + date
                    // });
                },
                eventClick: function (event, jsEvent, view) {
                    console.log(event.start);

                    console.log(jsEvent);
                    console.log(view);
                    $('.current_day').removeClass('current_day')
                    $(this).addClass('current_day');
                    console.log(event);
                    var date = event.start
                    var d = new Date(date);
                    var y = d.getFullYear();
                    var m = d.getMonth() + 1;
                    var dd = d.getDate();
                    console.log(date);
                    var dt = y + '-' + m + '-' + dd;
                    list();
                    // parent.layer.open({
                    //     type: 2,
                    //     title: '预约列表',
                    //     shadeClose: false,
                    //     shade: 0.6,
                    //     maxmin: true, //开启最大化最小化按钮
                    //     area: ['100%', '100%'],
                    //     content: '/Admin/ServiceItems/reserveList.html?d=' + dt
                    // });
                },
                events: function (start, end, callback) {
                    var d = new Date($('#calendar').fullCalendar('getDate'));
                    var y = d.getFullYear();
                    var m = d.getMonth() + 1;
                    var td = d.getDate();
                    // $.ajax({
                    //     url: '/Admin/ServiceItems/getMonthCount.html',
                    //     dataType: 'JSON',
                    //     data: {
                    //         time: y + '-' + m,
                    //         store_id: $('#storeId').val()
                    //     },
                    //     success: function (data) {
                    var data = tdata;
                    var totalCan = 0,
                        confirm = 0,
                        iscome = 0,
                        reserve = 0,
                        iscancel = 0;
                    $(data.data).each(function (index, el) {
                        var flag = el.d >= td;
                        var canReserve = el.total - el.reserve - el.confirm -
                            el.over
                        totalCan += canReserve;
                        confirm += Number(el.confirm);
                        iscome += Number(el.over);
                        reserve += Number(el.reserve);
                        iscancel += Number(el.cancel);
                        if (m == el.m && flag) {
                            var str =
                                '<div><p class="data-p">可预约 <label>' +
                                canReserve +
                                '</label></p><p class="data-w">待确认<label>' +
                                el.reserve +
                                '</label></p></div><div><p class="data-w">已确认<label>' +
                                el.confirm +
                                '</label></p><p class="data-w">已到店<label>' +
                                el.over + '</label></p></div>';
                            // var str='';

                        } else {
                            var str =
                                '<div><p class="data-l">可预约<label>' +
                                canReserve +
                                '</label></p><p class="data-l">待确认<label>' +
                                el.reserve +
                                '</label></p></div><div><p class="data-l">已确认<label>' +
                                el.confirm +
                                '</label></p><p class="data-l">已到店<label>' +
                                el.over + '</label></p></div>';
                        }
                        $('td.fc-day[data-date="' + el.key + '"]').find(
                            '.fc-day-content').html(str);
                    });
                    $('#canReserve').text(totalCan);
                    $('#confirm').text(confirm);
                    $('#iscome').text(iscome);
                    $('#iscancel').text(iscancel);
                    $('#reserve').text(reserve);

                    //     }
                    // });
                }
            });

            $('.fc-button-next').on('click', function (event) {
                event.preventDefault();
                $('#calendar').fullCalendar('next');
                var d = new Date($('#calendar').fullCalendar('getDate'));
                var y = d.getFullYear();
                var m = d.getMonth();
                $('.fc-header-title').find('h2').text(y + '年 ' + (m + 1) + '月')
            });
            $('.fc-button-prev').on('click', function (event) {
                event.preventDefault();
                $('#calendar').fullCalendar('prev');
                var d = new Date($('#calendar').fullCalendar('getDate'));
                var y = d.getFullYear();
                var m = d.getMonth();
                $('.fc-header-title').find('h2').text(y + '年 ' + (m + 1) + '月')
            });
            $('#storeId').change(function (event) {
                $('#calendar').fullCalendar('refetchEvents');
            });
        });


        function list() {
            nui.open({
                url: webPath + contextPath +
                    "/repair/RepairBusiness/BookingManagement/BookingManagementList.jsp",
                title: "预约列表",
                width: '100%',
                height: '100%',
                onload: function () {},
                ondestroy: function (action) {}
            });
        }
        
    </script>
</body>

</html>