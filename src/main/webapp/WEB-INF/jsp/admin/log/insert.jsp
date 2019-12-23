<%@ page contentType="text/html;charset=UTF-8" language="java"   %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<%@include file="../../../../common/header.jsp" %>
<script type="text/javascript"charset="utf-8" src= "${ctx}/static/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/static/ueditor/ueditor.all.js"></script>


<h3 class="sub-header">新增日志  </h3>
<form class="form-horizontal"  enctype="multipart/form-data" onsubmit="return post()">
    <div class="form-group">
        <label class="col-sm-2 control-label">日志标题</label>
        <input type="text"  hidden="true"  value="${detail.id}" name="id">
        <div class="col-sm-10">
            <input type="text" class="form-control" name="title" placeholder="日志标题" value="${detail.title}">
        </div>
        <div class="col-sm-10  col-sm-offset-2">
            <span id="title"></span>
        </div>
    </div>

    <div class="form-group">
        <label class="col-sm-2 control-label">日志内容</label>
        <div class="col-sm-10">
            <script id="article" name="content" type="text/plain" style="height:300px;"></script>
            <script type="text/javascript">
                var ue = UE.getEditor('article');

            </script>
            <script>
                ue.ready(function() {
                    ue.setContent('${detail.content}');
                });
            </script>
        </div>
        <div class="col-sm-10 col-sm-offset-2">
            <span id="content"></span>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">图片地址</label>
        <div class="col-sm-10 form-inline">
            <input type="text" class="form-control" name="thumbimg" placeholder="图片地址" value="${detail.thumbimg}">
            <input type="file" style="display:none" name="file" onchange="uploader( $(this).prev(), this, '${ctx}/log/uploader')">
            <input type="button" value="上传" onclick="$(this).prev().click()" class="btn btn-default">
            <span id="thumbimg"></span>
        </div>

    </div>
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
            <button  class="btn btn-primary" type="submit">提交</button>
        </div>
    </div>

</form>

<script>
    var tf = false;
    function post() {
        if(validate()){
            var id = "${detail.id}";
            if(id!=""&&id!=null){

               url = "${ctx}/updateLog";
            }else{
                $("input[name=id]").val("-1");
                url = "${ctx}/insertLog"
            }

            $.ajax({
                type:"post",//设置提交方式
                url:url,
                data:$("form").serialize(),//表单数据序列化
                dataType:"json",
                success:function(result){
                    if(result.code == 200){
                        window.location = "${ctx}/tolog"
                    }else{
                        alert(result.msg);
                    }
                }
            });

        }
        return false;
    }
    function validate() {
        var flag = true;
        var content = ue.getContentTxt();
        $("input[type=text]").each(function (i){
            var name = $(this).attr("name");
            var val = $(this).val();
            if(name=="title"){
                if(val.length==0){
                    $("#title").css("color","red").html("标题不能为空");
                    flag = false;
                }else{
                    $("#title").html("");
                }
            }else if(name == "thumbimg"){
                if(val.length==0){
                    $("#thumbimg").css("color","red").html("图片不能为空");
                    flag = false;
                }else {
                    $("#thumbimg").html("");
                }
            }
        });
        if(content.length==""){
            $("#content").css("color","red").html("内容不能为空");
            flag = false;
        }else{
            $("#content").html("");
        }
        if(!tf){
            if($("input[name=thumbimg]").val()!="${detail.thumbimg}"){
                $("#thumbimg").css("color","red").html("请上传图片");
                flag = false;
            }
        }else{
            $("#thumbimg").html("");
        }
        return flag;
    }
    function uploader(inputObj, fileObj, uploaderURL) {
        $(fileObj).next().next().css('color', 'orange');
        $(fileObj).next().next().html("上传中...");
        $(inputObj).val('');
        var formData = new FormData();
        formData.append("file", fileObj.files[0]);
        $.ajax({
            type: 'POST',
            dataType: 'JSON',
            url: uploaderURL,
            data: formData,
            processData: false,
            contentType: false,
            content: 'multipart/form-data',
            error: function(msg) {
                console.dir(msg);
                $(fileObj).next().next().css('color', 'red');
                $(fileObj).next().next().html("系统错误！");
            },
            success: function(msg) {
                re = eval(msg);
                if (re['code'] == 1000) {
                    tf=true;
                    $(inputObj).val(re['msg']);
                    $(fileObj).next().next().html("");
                } else {
                    $(fileObj).next().next().css('color', 'red');
                    $(fileObj).next().next().html(re['msg']);
                }
            }
        });
    }

</script>
<%@include file="../../../../common/footer.jsp" %>