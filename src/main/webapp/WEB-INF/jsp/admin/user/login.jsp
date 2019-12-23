<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>日志管理</title>
    <link href="${ctx}/static/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="${ctx}/static/jquery/jquery-3.2.0.min.js"></script>
    <script src="${ctx}/static/bootstrap-3.3.7/js/bootstrap.min.js"></script>
</head>

<body>
<div class="container">
    <form id="form" class="form-signin" onsubmit="return post();">
        <h2 class="form-signin-heading">日志管理</h2>
        <input type="text" name="name" class="form-control" placeholder="用户名" required autofocus>
        <input type="password" name="password" class="form-control" placeholder="密码" required>

        <button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
    </form>
</div>

<script type="text/javascript">
    function post() {
        $.post("${ctx}/tologin", $("#form").serialize(), function(result) {
            console.log(result);
            if (result.code == "101") {
                alert(result.msg);
            } else if(result.code=="102") {
                alert(result.msg);
            }else if(result.code == "200"){
                window.location = "${ctx}/tolog"
            }else{
                alert(result.msg);
            }
        }, "JSON");
        return false;
    }
</script>
<style>
    body {
        padding-top: 40px;
        padding-bottom: 40px;
        background-color: #eee;
    }

    .form-signin {
        max-width: 330px;
        padding: 15px;
        margin: 0 auto;
    }

    .form-signin .form-signin-heading,
    .form-signin .checkbox {
        margin-bottom: 10px;
    }

    .form-signin .checkbox {
        font-weight: normal;
    }

    .form-signin .form-control {
        position: relative;
        height: auto;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
        padding: 10px;
        font-size: 16px;
    }

    .form-signin .form-control:focus {
        z-index: 2;
    }

    .form-signin input[type="text"] {
        margin-bottom: -1px;
        border-bottom-right-radius: 0;
        border-bottom-left-radius: 0;
    }

    .form-signin input[type="password"] {
        margin-bottom: 10px;
        border-top-left-radius: 0;
        border-top-right-radius: 0;
    }
</style>

</body>

</html>