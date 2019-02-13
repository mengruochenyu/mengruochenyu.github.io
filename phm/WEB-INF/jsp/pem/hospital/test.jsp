<!DOCTYPE html>
<html lang="en">
<head>	
<script type="text/javascript">
//上传-预览逻辑
	$(".newspic").click(function() {	//1.点击默认图片，出发标签<a>的click事件
		$(this).next('input').click();//2.触发input的点击事件，用户选择图片进行上传
	});	
	function showPic(data) {//3.当用户上传图片后，触发input标签的onchange事件，执行showPic()方法
		if (data.files && data.files[0]) {//4.判断input标签的file是否存在
			var reader = new FileReader();//5.实例化一个FileReader()接口
			reader.readAsDataURL(data.files[0]);//6.通过readAsDataURL()方法读取文件，将图片内嵌在网页之中
 			reader.onload = function(evt) {//7.调用FileReader()的onload事件，当文件读取成功时，执行8
 				//8.将reader的result属性值赋值给data.parentNode.childNodes[1].childNodes[1].src，实现图片预览
				data.parentNode.childNodes[1].childNodes[1].src = evt.target.result; 
			}
		}
	}
	
//上传-提交保存逻辑
//用户选择图片,点击提交；将数据通过表单(name-value)提交给后台；注意：需要表单enctype="multipart/form-data"；否则后台无法接受
</script>
</head>
<body>
		<form action="hospital/saveHospital.do" name="editForm"  method="post" enctype="multipart/form-data">
			<a href="javascript:void(0)" class="newspic">
			<!-- static/img/selectimg.png是默认图片，当reader读取完毕后，执行步骤8，即展示上传图片 -->
				<img style="width:200px;height:100px;"  src="static/img/selectimg.png"/>/
			</a>
			<input type="file" id="logoUrl" name="logoUrl" onchange="showPic(this)"  style="display: none"/>	
			<button   type="submit" >提交</button>		
	</form>
</body>
</html>