<%@ page contentType="text/html;charset=UTF-8" language="java"   %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../../../../common/header.jsp" %>
<style>
    .form-group span{
        color:red;
    }
</style>
<h3 class="sub-header">修改密码</h3>
<form class="form-horizontal"  onsubmit="return updatePwd()">
    <div class="form-group">
        <label class="col-sm-2 control-label">现用密码</label>
        <div class="col-sm-10">
            <input type="password" class="form-control" name="password" placeholder="现用密码" required>
        </div>
        <span class="col-sm-10 col-sm-offset-2"></span>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">新密码</label>
        <div class="col-sm-10">
            <input type="password" class="form-control" name="password_new" placeholder="新密码" required>
        </div>
        <span class="col-sm-10 col-sm-offset-2"></span>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">确认新密码</label>
        <div class="col-sm-10">
            <input type="password" class="form-control" name="password_new_confirm" placeholder="确认新密码" required>
        </div>
        <span class="col-sm-10 col-sm-offset-2"></span>
    </div>
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
            <button type="submit" class="btn btn-primary">提交</button>
        </div>
        <span class="col-sm-10 col-sm-offset-2"></span>
    </div>
</form>
<script>
    function updatePwd(){
    var flag = true;
    var password = $("input[name=password]").val();
    var new_password = $("input[name=password_new]").val();
    var pwd = "";
    $(".form-group input").each(function (i) {
        var name = $(this).attr("name");

        if(name=="password"){
            var val = $(this).val();
            if(val.length<6){
                $(this).parent().next("span").html("密码至少6位");
                flag =  false;
            }else{
                $(this).parent().next("span").html("");
            }

        }else if(name=="password_new"){
            pwd = $(this).val();
            if(pwd.length<6){
                $(this).parent().next("span").html("密码至少6位");
                flag =  false;
            }else{
                $(this).parent().next("span").html("");
            }
        }else if(name == "password_new_confirm"){
            var repwd = $(this).val();
            if(pwd!=repwd){
                $(this).parent().next("span").html("两次密码不一致");
                flag =  false;
            }else{
                $(this).parent().next("span").html("");
            }
        }
    });
    if(!flag){
        return false;
    }

    $.ajax({
        url:"${ctx}/updatePwd",
        type:"GET",
        data:{password:password,new_password:new_password},
        // result是服务器返回结果(InfoDTO对象)
        success:function (result) {
            if(result.code=="101"){
                alert(result.msg);
            }else if(result.code=="200"){
                alert(result.msg);
                window.location = "logout"
            }else{
                alert(result.msg);
            }
        }

    });
    return false;
    }
</script>
<%@include file="../../../../common/footer.jsp" %>
