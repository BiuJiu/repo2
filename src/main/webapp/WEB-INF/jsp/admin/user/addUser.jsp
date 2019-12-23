<%@ page contentType="text/html;charset=UTF-8" language="java"   %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<%@include file="../../../../common/header.jsp" %>

<h3 class="sub-header">新增用户</h3>
<form class="form-horizontal" onsubmit="return addUser()">
    <div class="form-group">
        <label class="col-sm-2 control-label">用户名</label>
        <div class="col-sm-10">
            <input id="username" type="text" class="form-control" name="name" placeholder="用户名" required autocomplete="off">
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
            <button type="submit" class="btn btn-primary">提交</button>
        </div>
    </div>
</form>
<script>

    function addUser() {
        var username = document.getElementById("username").value;
        $.ajax({
            url:"${ctx}/addUser",
            type:"GET",
            data:{name:username},
            // result是服务器返回结果(InfoDTO对象)
            success:function (result) {

                if(result.code=="101"){
                    alert(result.msg);
                }else if(result.code=="200"){
                   alert(result.msg);
                   window.location = "${ctx}/toUser?username="
               }else{
                    alert(result.msg);
                }
            }

        });
        return false;
    }
</script>
<%@include file="../../../../common/footer.jsp" %>