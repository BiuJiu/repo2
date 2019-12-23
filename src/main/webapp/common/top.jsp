<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/admin"></a>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav navbar-left">
				<li>
					<a href="" target="_blank">HElLLO</a>
				</li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li>
					<a>
						<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
					</a>
				</li>
				<li>
					<a href="${ctx}/toUpdatePwd">
						<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
						修改密码
					</a>
				</li>
				<li>
					<a href="${ctx}/logout">
						<span class="glyphicon glyphicon-log-out" aria-hidden="true"></span>
						退出
					</a>
				</li>
			</ul>
		</div>
	</div>
</nav>
