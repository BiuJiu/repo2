
<%@ page contentType="text/html;charset=UTF-8" language="java"   %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<%@include file="../../../../common/header.jsp" %>
<jsp:useBean id="dateValue" class="java.util.Date"/>
<style>
    .rownum{
        display: flex;
        align-items: center;
    }
</style>
<div class="sub-header">
    <form class="form-inline" action="${ctx}/toUser" enctype="multipart/form-data">
        <div class="form-group">
            <div class="input-group">
                <div class="input-group-addon">用户名</div>
                <input type="text" class="form-control" name="username" value="">
            </div>
        </div>
        <button type="submit" class="btn btn-primary">搜索</button>
    </form>
</div>
<table class="table table-striped">
    <thead>
    <tr>
        <th>ID</th>
        <th>用户名</th>
        <th>注册时间</th>
        <th>上次登录时间</th>
        <th>登录错误次数/日期</th>
        <th><a href="${ctx}/toAddUser">新增用户</a></th>
    </tr>
    </thead>
    <tbody>


<c:forEach var="obj" items="${pageinfo.list}">
    <tr>
        <td>${obj.id}</td>
        <td>${obj.name}</td>
        <td>

            <jsp:setProperty name="dateValue" property="time" value="${obj.add_time}"/>
            <fmt:formatDate  value="${dateValue}"  pattern="yyyy-MM-dd HH:mm:ss"/>
        </td>
        <td>

            <jsp:setProperty name="dateValue" property="time" value="${obj.last_login_time}"/>
            <fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd HH:mm:ss"/>
        </td>
        <td>${obj.last_login_error_times}
            /

            <jsp:setProperty name="dateValue" property="time" value="${obj.last_login_error_time}"/>
            <fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd HH:mm:ss"/>
          </td>
        <td>
            <a href="${ctx}/delUser?id=${obj.id}&pageNumber=${pageinfo.pageNum}&&username=" onclick="return window.confirm('确认要删除用户吗?')"  style="display:${obj.id == sessionScope.USER.id?'none':'inline'}">删除</a>
            <a href="${ctx}/cleanError?id=${obj.id}&pageNumber=${pageinfo.pageNum}&&username=" onclick="return window.confirm('确认要清除登录错误次数吗?')" >清零错误</a>
        </td>
    </tr>
</c:forEach>
    </tbody>
</table>

<div class="rownum">
    <%--页面信息--%>
    <div class="col-md-8">
        当前第 <span class="label label-default">${pageinfo.pageNum}</span> 页，
        共 <span class="label label-default">${pageinfo.pages}</span> 页，
        共 <span class="label label-default">${pageinfo.total}</span> 条记录
    </div>
    <%--页面导航--%>
    <div class="col-md-4">
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <%--当前页是第一页--%>
                <c:if test="${pageinfo.isFirstPage == true}">
                    <li><a href="#">首页</a></li>
                </c:if>
                <c:if test="${pageinfo.isFirstPage == false}">
                    <li><a href="${ctx}/toUser?pageNumber=1&&username=">首页</a></li>
                </c:if>
                <%--如果有上一页，则显示下一页符号，并设置跳转参数--%>
                <c:if test="${pageinfo.hasPreviousPage == true}">
                    <li>
                        <a href="${ctx}/toUser?pageNumber=${pageinfo.pageNum-1}&&username=" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:if>
                <%--遍历导航页号--%>
                <c:forEach var="num" items="${pageinfo.navigatepageNums}">
                    <%--遍历到当前页号，则不能点击，且高亮显示--%>
                    <c:if test="${pageinfo.pageNum == num}">
                        <li class="active"><a href="#">${num}</a></li>
                    </c:if>
                    <%--遍历到其他页号，则跳转查询相应页信息--%>
                    <c:if test="${pageinfo.pageNum != num}">
                        <li><a href="${ctx}/toUser?pageNumber=${num}&&username=">${num}</a></li>
                    </c:if>
                </c:forEach>
                <%--如果有下一页，则显示下一页符号，并设置跳转参数--%>
                <c:if test="${pageinfo.hasNextPage == true}">
                    <li>
                        <a href="${ctx}/toUser?pageNumber=${pageinfo.pageNum+1}&&username=" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>
                <%--当前页是第最后一页--%>
                <c:if test="${pageinfo.isLastPage == true}">
                    <li><a href="#">尾页</a></li>
                </c:if>
                <c:if test="${pageinfo.isLastPage == false}">
                    <li><a href="${ctx}/toUser?pageNumber=${pageinfo.pages}&&username=">尾页</a></li>
                </c:if>
            </ul>
        </nav>
    </div>
</div>

<%@include file="../../../../common/footer.jsp" %>
