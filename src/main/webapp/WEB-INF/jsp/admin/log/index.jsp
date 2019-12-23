<%@ page contentType="text/html;charset=UTF-8" language="java"   %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<%@include file="../../../../common/header.jsp" %>
<style>
    .table>tbody>tr>td{
        vertical-align: middle;
    }
    .logpath img{
        width:50px;
        height: 50px;

    }
    .rowpage {
        display: flex;
        /*flex-direction: column;*/
        align-items: center;
        /*background: red;*/
    }
    tr>td:nth-child(5) p{
        width:120px;
        overflow: hidden;
        text-overflow:ellipsis;
        white-space: nowrap;
    }
</style>


<div class="sub-header">
    <form class="form-inline" >
        <div class="form-group">
            <div class="input-group">
                <div class="input-group-addon">所属用户</div>
                <select class="form-control" name="article_column_id" id="select_user">
                </select>
            </div>
        </div>
        <div class="form-group">
            <div class="input-group">
                <div class="input-group-addon">日志标题</div>
                <input id="keyword" type="text" class="form-control" name="name" placeholder="请输入关键字">
            </div>
        </div>
        <button type="button" class="btn btn-primary" onclick="ajax_to_page(1)">搜索</button>
    </form>
</div>


<table class="table table-striped">
    <thead>
    <tr>
        <th>ID</th>
        <th>用户名</th>
        <th>日志标题</th>
<%--        <th>添加时间</th>--%>
        <th>图片</th>
        <th>内容</th>
        <th>更新时间</th>
        <th><a href="${ctx}/addlog">新增日志</a></th>
    </tr>
    </thead>
    <tbody id="list">

<%--    <tr>--%>
<%--        <td>{$v.id}</td>--%>
<%--        <td>{$v.article_column_name}</td>--%>
<%--        <td>{$v.name}</td>--%>
<%--        <td>{$v.add_time|date="Y-m-d H:i",###}</td>--%>
<%--        <td><img src="{$v.img_url}" height="80px"></td>--%>
<%--        <td>--%>
<%--            <a href="/admin/article/edit?id={$v.id}">编辑</a>&#12288;--%>
<%--            <a href="/admin/article/del?id={$v.id}"onclick="return window.confirm('确认要删除这篇文章吗?')">删除</a>--%>
<%--        </td>--%>
<%--    </tr>--%>

    </tbody>
</table>

        <%--第四行 底部导航栏--%>
<div class="rowpage">
    <%--页面信息--%>
    <div class="col-md-7" id="page_info_area"></div>
    <%--页面导航--%>
    <div class="col-md-5" id="nav_info_area"></div>
</div>

    <script>
    var totalPage; // 保存总记录数
    var currentPage; // 保存当前页号
    var bf = false; //option 不重复添加
    <%--页面加载完成后，发起ajax请求，获取json数据--%>
    $(function () {
        var user = $("<option></option>").attr("value","").append("所属用户");
        $("#select_user").append(user)
        ajax_to_page(1);
    });
    function formatDateTime(inputTime) {
        var date = new Date(inputTime);
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        m = m < 10 ? ('0' + m) : m;
        var d = date.getDate();
        d = d < 10 ? ('0' + d) : d;
        var h = date.getHours();
        h = h < 10 ? ('0' + h) : h;
        var minute = date.getMinutes();
        var second = date.getSeconds();
        minute = minute < 10 ? ('0' + minute) : minute;
        second = second < 10 ? ('0' + second) : second;
        return y + '-' + m + '-' + d+' '+h+':'+minute+':'+second;
    };
    /**
     * 发送ajax请求，获取指定页数据
     * @param pageNum
     */
    function ajax_to_page(pageNum) {
        var userid = $("#select_user").val();
        var keyword = $("#keyword").val();

        $.ajax({
            url:"${ctx}/log",
            type:"GET",
            data:{pageNumber:pageNum,userid:userid,keyword:keyword},
            // result是服务器返回结果(InfoDTO对象)
            success:function (result) {
                // console.log(result);
                totalPage = result.dataMap.pageInfo.total;
                currentPage = result.dataMap.pageInfo.pageNum;
                // // 1.解析并显示员工信息
                build_log_table(result);
                // // 2.解析并显示分页信息
                build_page_info(result);
                // // 2.解析并显示导航信息
                build_nav_info(result);

            }

        });
        return false;
    }

    function build_log_table(result){
        // 清空上一页的显示数据
        $("table tbody").empty();
        // 清除th行的全选框选中状态
        $("#checkbox_all").prop("checked", false);
        var logs = result.dataMap.pageInfo.list;


        var userid = [];
        $.each(logs,function(index,item){
            var user = $("<option></option>").attr("value",item.user.id).append(item.user.name);
            var id = $("<td></td>").append(item.id);
            var username = $("<td></td>").append(item.user.name);
            var title = $("<td></td>").append(item.title);
            var thumbimg = $("<td class='logpath'></td>").append("<img src="+item.thumbimg+">");
            var content = $("<td></td>").append(item.content);
            var addtime = $("<td></td>").append(formatDateTime(item.add_time));
            if(userid.indexOf(item.user.id)==-1&&!bf){

                userid.push(item.user.id);
                $("#select_user").append(user)
            }
            var btnEdit = $("<button></button>").addClass("btn btn-info btn-sm btn_edit")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            // 自定义一个属性，用于保存当前记录(员工)的id号,便于之后的修改查询传值
            btnEdit.attr("log_id",item.id);

            /*				<button class="btn btn-danger btn-sm">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    删除
                            </button>*/
            var btnDel = $("<button></button>").addClass("btn btn-danger btn-sm btn_del")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            // 自定义一个属性，用于保存当前记录(员工)的id号,便于之后的删除传值
            btnDel.attr("log_id",item.id);
            // 所有td组成一个tr
            var operateTd = $("<td></td>").append(btnEdit).append(" ").append(btnDel);

            var tritem = $("<tr></tr>").append(id).append(username).append(title).append(thumbimg).append(content).append(addtime).append(operateTd);
            console.dir(item);
            tritem.appendTo("#list");
        });
        bf=true;
    }

    function build_page_info(result) {
        // 清空上一页的显示数据
        $("#page_info_area").empty();
        var pageInfo = result.dataMap.pageInfo;
        var page_info = '当前第 <span class="label label-default">'+pageInfo.pageNum+'</span> 页，\
							共 <span class="label label-default">'+pageInfo.pages+'</span> 页，\
							共 <span class="label label-default">'+pageInfo.total+'</span> 条记录'
        $("#page_info_area").append(page_info);
    }
    function build_nav_info(result) {
        // 清空上一页的显示数据
        $("#nav_info_area").empty();

        var pageInfo = result.dataMap.pageInfo;
        // 每个导航数字 1 2 3都在li标签里面，所有li在一个ul里面，ul在nav里面
        var ul = $("<ul></ul>").addClass("pagination");
        var nav = $("<nav></nav>").attr("aria-label","Page navigation");
        // 首页li
        var firstLi = $("<li></li>").append($("<a></a>").attr("href","#").append("首页"));
        // 上一页li
        var prevLi = $("<li></li>").append($("<a></a>").attr("href","#").append("&laquo;"));
        // 绑定事件（不在第一页时，点击首页和上一页才发送请求）
        if(pageInfo.hasPreviousPage == true){
            firstLi.click(function () {
                ajax_to_page(1);
            });
            prevLi.click(function () {
                ajax_to_page(pageInfo.pageNum-1);
            });
        }
        ul.append(firstLi).append(prevLi);

        // 遍历此次pageInfo中的导航页，并构建li标签，添加到ul
        $.each(pageInfo.navigatepageNums,function (index,item) {
            var navLi = $("<li></li>").append($("<a></a>").attr("href","#").append(item));
            // 遍历到当前显示的页，就高亮，且不能点击
            if(pageInfo.pageNum == item){
                navLi.addClass("active");
            }else {
                // 绑定单击事件
                navLi.click(function () {
                    // 传入页号，获取数据
                    ajax_to_page(item);
                });
            }
            ul.append(navLi);
        })

        // 下一页li
        var nextLi = $("<li></li>").append($("<a></a>").attr("href","#").append("&raquo;"));
        // 尾页li
        var lastLi = $("<li></li>").append($("<a></a>").attr("href","#").append("尾页"));
        // 绑定事件（不在最后页时，点击尾页和下一页才发送请求）
        if(pageInfo.hasNextPage == true){
            nextLi.click(function () {
                ajax_to_page(pageInfo.pageNum+1);
            });
            lastLi.click(function () {
                ajax_to_page(pageInfo.pages);
            });
        }
        ul.append(nextLi).append(lastLi);
        // 将ul添加到nav
        nav.append(ul);
        // 将构造好的nav添加到table tbody
        nav.appendTo($("#nav_info_area"));
    }

    $(document).on("click",".btn_del",function () {
        // 当前要删除的员工姓名
        var logTitle = $(this).parents("tr").find("td:eq(2)").text();
        var log_id = $(this).attr("log_id");
        if(confirm("你是否确定删除日志【"+logTitle+"】?")){
            // 发送删除员工的请求
            $.ajax({
                url:"${ctx}/delLog/"+log_id,
                type:"DELETE",
                success:function (result) {
                    if (result.code == "200"){
                        alert(result.msg);
                        // 跳转到原位置
                        ajax_to_page(currentPage);
                    }
                }
            });
        }
    });

    $(document).on("click",".btn_edit",function () {
        var log_id = $(this).attr("log_id");
        window.location = "${ctx}/toEditLog/"+log_id;

        <%--    // 发送编辑日志的请求--%>
        <%--    $.ajax({--%>
        <%--        url:"${ctx}/toEditLog/"+log_id,--%>
        <%--        type:"post",--%>
        <%--        success:function (result) {--%>
        <%--            if (result.code == "200"){--%>
        <%--                alert(result.msg);--%>
        <%--                // // 跳转到原位置--%>
        <%--                // ajax_to_page(currentPage);--%>
        <%--            }--%>
        <%--        }--%>
        <%--    });--%>

    });

    </script>

<%@include file="../../../../common/footer.jsp" %>

