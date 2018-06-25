<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- web的路径问题：
不以“/”开头的相对路径，找资源以当前路径为基准，经常容易出问题
以“/”开始的路径在找资源时，是以服务器的路径为标准，需要加上项目名
 -->
<!-- 引入Jquery -->
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery.min.js"></script>
<!-- Bootstrap -->
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- 引入BootStrap js文件 -->
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

<style type="text/css">
#dep_search {
	margin: 0px;
	border: 0px;
}
</style>
</head>
<body>
	<!-- 搭建显示页面 -->

	<!-- 员工添加模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="empName"
									id="emp_add_input" placeholder="empName"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_add_input" placeholder="email@qq.com"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="inlineRadio1" value="M" checked> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="inlineRadio2" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_add_select">
								</select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">关闭</button>
							<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 员工添加模态框结束 -->


	<!-- 员工修改模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">员工修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="empUpdateModal">
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static"></p>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_update_input" placeholder="email@qq.com"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="M" checked>
									男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_update_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId">
								</select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">关闭</button>
							<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 员工修改模态框结束 -->


	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM_CRUD</h1>
			</div>
		</div>

		<div class="row">
			<div class="col-md-8 col-md-offset-4">
				<input aria-describedby="basic-addon1" type="text" id="input_search"
					placeholder="在此输入要检索的内容。。。">
				<button class="btn btn-primary btn-default" id="dep_search">
					<span class="glyphicon glyphicon-search"></span>
				</button>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary btn-sm" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger btn-sm" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th><input type="checkbox" id="check_all"></th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area"></div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>
	<script type="text/javascript">
		var totalRecord, currentPage; //总记录数和当前页码

		$(function() {
			to_page(1);

		});

		function to_page(pn) {
			$.ajax({
				type : "GET",
				url : "${APP_PATH }/emps",
				data : "pn=" + pn,
				success : function(result) {
					//alert(msg.code);
					//console.log(result);
					//1.解析并显示员工数据
					build_emps_table(result);
					//2.解析并显示分页信息
					build_page_info(result);
					//3.解析并显示分页条
					build_page_nav(result);
				}
			});
		}

		function build_emps_table(result) {
			//每次添加数据之前清空表格
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;//取到所有查询到的封装到list中的员工
			$
					.each(
							emps,
							function(index, item) {
								//alert(item.empName);
								var checkBoxTd = $("<td><input type='checkbox' class='check_item'></td>");
								var empIdTd = $("<td></td>").append(item.empId);
								var empNameTd = $("<td></td>").append(
										item.empName);
								var genderTd = $("<td></td>").append(
										item.gender == 'M' ? "男" : "女");
								var emailTd = $("<td></td>").append(item.email);
								var deptNameTd = $("<td></td>").append(
										item.department.deptName);
								var editBt = $("<button></button>").addClass(
										"btn btn-primary btn-sm edit_btn")
										.append("<span></span>").addClass(
												"glyphicon glyphicon-pencil")
										.append("编辑");
								//为编辑按钮添加一个自定义属性
								editBt.attr("edit-id", item.empId);
								var delBt = $("<button></button>").addClass(
										"btn btn-danger btn-sm delete_btn")
										.append("<span></span>").addClass(
												"glyphicon glyphicon-trash")
										.append("删除");
								//为删除按钮添加一个自定义属性来表示当前要删除员工的id
								delBt.attr("del-id", item.empId);
								var btnTd = $("<td></td>").append(editBt)
										.append(" ").append(delBt);
								//append()方法每次执行完成之后还是返回原来的元素
								$("<tr></tr>").append(checkBoxTd).append(
										empIdTd).append(empNameTd).append(
										genderTd).append(emailTd).append(
										deptNameTd).append(btnTd).appendTo(
										"#emps_table tbody");
							});
		}

		//构构建分页信息
		function build_page_info(result) {
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前第" + result.extend.pageInfo.pageNum + "页,共"
							+ result.extend.pageInfo.pages + "页，共有"
							+ result.extend.pageInfo.total + "条记录");
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}
		//构建分页条,点击分页条要能去下一页等等			
		function build_page_nav(result) {
			//构建分页导航之前将页面清空
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;"));
			//如果没有上一页则给上一页和首页添加不可点击的效果
			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				//为素添加点击翻页事件
				firstPageLi.click(function() {
					to_page(1);
				});
				prePageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}

			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));
			//如果没有下一页则给下一页和末页添加不可点击的效果
			if (result.extend.pageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				nextPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				});
				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				});
			}

			//1.添加首页和前一页
			ul.append(firstPageLi).append(prePageLi);
			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append(
						$("<a></a>").append(item).attr("href", "#"));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				//添加点击事件
				numLi.click(function() {
					to_page(item);//点击以后发送Ajax请求到当前点击的页码
				});
				//2.遍历添加页码
				ul.append(numLi);
			});
			//3.遍历完成后添加下一页和末页
			ul.append(nextPageLi).append(lastPageLi);
			//4.吧ul加入到nav
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}

		//该方法用于重置表单弹出时上一次输入的内容以及校验的状态
		function reset_form(ele) {
			$(ele)[0].reset();//重置表单内容
			//清空样式
			$(ele).find("*").removeClass("has-success has-error");
			$(ele).find(".help-block").text("");
		}
		//点击新增按钮弹出模态框
		$("#emp_add_modal_btn").click(function() {
			//表单完整重置（重置表单的样式和内容）
			reset_form("#empAddModal form");
			//发送Aajx请求查询部门信息，显示在下拉列表中
			getDepts("#empAddModal select");

			//弹出模态框
			$("#empAddModal").modal({
				backdrop : "static"
			});
		});

		//查出所有部门的信息并显示在下拉列表中
		function getDepts(ele) {
			$(ele).empty();
			$.ajax({
				type : "GET",
				url : "${APP_PATH }/depts",
				success : function(result) {
					//alert(msg.code);
					//console.log(result);
					$.each(result.extend.depts, function() {
						var optionEle = $("<option></option>").append(
								this.deptName).attr("value", this.deptId);
						optionEle.appendTo(ele);
					});

				}
			});
		}

		/**
		 *添加员工表单前端校验函数
		 */
		function validate_add_form() {
			//1.首先获取输入框中输入的值
			var empName = $("#emp_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if (!regName.test(empName)) {
				//alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
				show_validate_msg("#emp_add_input", "error",
						"用户名可以是2-5位中文或者6-16位英文和数字的组合");
				return false;
			} else {
				show_validate_msg("#emp_add_input", "success", "");
			}
			;

			//2.邮箱校验
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				//alert("邮箱格式不正确");
				//清空元素之前的样式
				show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
				/* $("#email_add_input").parent().addClass("has-error");
				$("#email_add_input").next("span").text("邮箱格式不正确"); */
				return false;
			} else {
				show_validate_msg("#email_add_input", "success", "");
				/* $("#email_add_input").parent().addClass("has-success");
				$("#email_add_input").next("span").text(""); */
			}

			return true;
		}

		function show_validate_msg(ele, status, msg) {
			//清除当前元素状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if ("success" == status) {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			} else if ("error" == status) {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}

		/**
		 *发送Ajax请求校验用户名是否重复
		 **/
		$("#emp_add_input").change(
				function() {
					//1.模态框中填写的表单数据验证后提交给服务器进行保存
					var empName = this.value;
					$.ajax({
						url : "${APP_PATH}/checkuser",
						type : "POST",
						data : "empName=" + empName,
						success : function(result) {
							if (result.code == 100) {
								show_validate_msg("#emp_add_input", "success",
										"用户名可用");
								$("#emp_save_btn").attr("ajax-va", "success");
							} else {
								show_validate_msg("#emp_add_input", "error",
										result.extend.va_msg);
								$("#emp_save_btn").attr("ajax-va", "error");
							}
						}
					});

				});

		/**
		 *点击保存按钮，保存员工
		 **/
		$("#emp_save_btn").click(function() {
			//1.模态框中填写的表单数据验证后提交给服务器进行保存
			if (!validate_add_form()) {
				return false;
			}
			//判断之前的ajax用户名校验是否成功,如果不成功则直接返回false
			if ($(this).attr("ajax-va") == "error") {
				return false;
			}
			//2.发送AJax请求保存员工
			$.ajax({
				url : "${APP_PATH}/emp",
				type : "POST",
				data : $("#empAddModal form").serialize(),
				success : function(result) {
					if (result.code == 100) {
						//员工保存成功后：
						//1.关闭模态框
						$('#empAddModal').modal('hide');
						//2.来到最后一页，显示插入的数据
						//发送ajax请求显示最后一页数据即可
						to_page(totalRecord);

					} else {
						//显示失败信息
						//有那个字段得错误信息就显示那个字段的
						alert(result.extend.errorFields.email);
						alert(result.extend.errorFields.empName);
					}

				}
			});

		});

		//给编辑按钮绑定事件(新版本得jquery中没有live方法转而替换得是on方法)
		$(document).on("click", ".edit_btn", function() {
			//0.查出部门信息并显示部门列表
			getDepts("#empUpdateModal select");
			//1.查出员工信息并显示员工信息
			getEmp($(this).attr("edit-id"));
			//2.把员工id的值传递给模态框的更新按钮
			$("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
			//显示模态框
			$("#empUpdateModal").modal({
				backdrop : "static"
			});
		});

		function getEmp(id) {
			$.ajax({
				url : "${APP_PATH}/emp/" + id,
				type : "GET",
				success : function(result) {
					var empData = result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val(
							[ empData.gender ]);
					$("#empUpdateModal select").val([ empData.dId ]);
				}
			});
		}

		//为员工更新按钮绑定一个点击事件
		$("#emp_update_btn").click(function() {
			//0.首先校验邮箱
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
				return false;
			} else {
				show_validate_msg("#email_update_input", "success", "");
			}
			//1.发送Ajax请求，保存更新后的员工数据
			$.ajax({
				url : "${APP_PATH}/emp/" + $(this).attr("edit-id"),
				type : "PUT",
				data : $("#empUpdateModal form").serialize(),//+"&_method=PUT" 表单序列话后加上该字符串的意思是，将普通的POST请求转换为PUT请求
				success : function(result) {
					//alert(result.msg);
					//1.关闭模态框
					$("#empUpdateModal").modal("hide");
					//2.回到本页面
					to_page(currentPage);
				}
			});
		});

		//单个删除
		//为删除按钮绑定单击事件(类似于编辑按钮绑定事件)
		$(document).on("click", ".delete_btn", function() {
			//弹出是否删除确认对话框
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("del-id");
			//alert($(this).parents("tr").find("td:eq(1)").text());
			if (confirm("确认删除【" + empName + "】吗?")) {
				//确认，发送ajax请求删除即可
				$.ajax({
					url : "${APP_PATH}/emp/" + empId,
					type : "DELETE",
					success : function(result) {
						alert(result.msg);
						//处理成功后回到本页
						to_page(currentPage);
					}
				});
			}
		});

		//完成全选/全不选功能
		$("#check_all").click(function() {
			//$(".check_item")
			$(".check_item").prop("checked", $(this).prop("checked"));
		});

		//check_item
		$(document)
				.on(
						"click",
						".check_item",
						function() {
							var flag = $(".check_item:checked").length == $(".check_item").length;
							$("#check_all").prop("checked", flag);
						});

		//点击全部删除，批量删除
		$("#emp_delete_all_btn").click(
				function() {
					var empNames = "";
					var empIds = "";
					//遍历选中的checkbox
					$.each($(".check_item:checked"), function() {
						empNames += $(this).parents("tr").find("td:eq(2)")
								.text()
								+ ",";
						empIds += $(this).parents("tr").find("td:eq(1)").text()
								+ "-";
					});
					empNames = empNames.substring(0, empNames.length - 1);
					empIds = empIds.substring(0, empIds.length - 1);
					if (confirm("确认删除【" + empNames + "】吗?")) {
						//发送ajax请求删除
						$.ajax({
							url : "${APP_PATH}/emp/" + empIds,
							type : "DELETE",
							success : function(result) {
								alert(result.msg);
								//回到当前页
								to_page(currentPage);
							}
						});
					}

				});
		//点击全部删除，批量删除
		$("#dep_search").click(function() {
				
				var key=$("#input_search").val();
				
				if(key==null||key==""){
					alert(key);
				
				}else{

					//发送ajax请求删除
					$.ajax({
							url : "${APP_PATH}/emp/" + key,
							type : "GET",
							success : function(result) {
								//1.解析并显示员工数据
								build_emps_table(result);
								//2.解析并显示分页信息
								build_page_info(result);
								//3.解析并显示分页条
								build_page_nav(result);
							}
						});
					}
		});

	
		
		</script>
</body>
</html>