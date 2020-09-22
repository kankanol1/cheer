<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>轮播图管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/htcarousel/htCarousel/">轮播图列表</a></li>
		<shiro:hasPermission name="htcarousel:htCarousel:edit"><li><a href="${ctx}/htcarousel/htCarousel/form">轮播图添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="htCarousel" action="${ctx}/htcarousel/htCarousel/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>是否启用：</label>
				<form:select path="isUse" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>轮播位置：</label>
				<form:select path="location" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>名称</th>
				<th>是否启用</th>
				<th>轮播位置</th>
				<shiro:hasPermission name="htcarousel:htCarousel:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="htCarousel">
			<tr>
				<td><a href="${ctx}/htcarousel/htCarousel/form?id=${htCarousel.id}">
					${htCarousel.name}
				</a></td>
				<td>
					${fns:getDictLabel(htCarousel.isUse, 'yes_no', '')}
				</td>
				<td>
					${fns:getDictLabel(htCarousel.location, 'yes_no', '')}
				</td>
				<shiro:hasPermission name="htcarousel:htCarousel:edit"><td>
    				<a href="${ctx}/htcarousel/htCarousel/form?id=${htCarousel.id}">修改</a>
					<a href="${ctx}/htcarousel/htCarousel/delete?id=${htCarousel.id}" onclick="return confirmx('确认要删除该轮播图吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>