<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="demo.*"%>
<script type="text/javascript" src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
<style>
.title{
	background-color: gray;
	wight:100%;
	height:80px;
}

.t-left{
	float:left;
	width:35%;
	margin-left:3%;
}

.t-text{
	width:auto;
	margin-top:0;
	height:80px;
	line-height:80px;
	color:white;
	font-size:22px;
}

.t-right{
	float:right;
	width:48%;
	margin-right:3%;
}

.w-text{
	float:right;
	width:auto;
	margin-top:0;
	height:80px;
	line-height:80px;
	color:white;
	font-size:14px;
}

.main{
	width:94%;
	margin-left:3%;
	margin-top:25px;
}

ul li{ 
	padding:0;
	list-style:none;
	height:60px;
	margin-left:-5%;
	margin-bottom:10px;
	border:1px solid #000;
}

.li-left{
	width:30%;
	height:60px;
	float:left;
}

.li-left-t{
	margin-left:10%;
	height:60px;
	line-height:60px;
	margin-top:0;
	margin-bottom:0;
	font-size:20px;
}

.li-main{
	width:40%;
	height:60px;
	float:left;
}

.li-main-t{
	margin-left:20%;
	height:30px;
	line-height:30px;
	margin-top:14px;
	margin-bottom:0;
	font-size:20px;
}

.li-right{
	width:10%;
	height:60px;
	float:right;
}

.li-right button{
	height:30px;
	margin-top:14px;
	line-height:30px;
}

.c_img{
	width:120px;
	height:40px;
	float:left;
	border:1px solid #000;
}

.t-code{
	margin-left:25px;
	width:140px;
	height:38px;
}

.count-text{
	margin-left:5%;
	font-size:22px;
}

.res{
	width:94%;
	margin-left:3%;
	margin-top:25px;
}
</style>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>信息查询系统</title>
</head>
<body>
<div class="title">
	<div class="t-left">
		<p class="t-text">信 息 查 询 系 统</p>
	</div>
</div>

<div class="main">
<ul>
	<li>
		<div class="li-left">
			<p class="li-left-t">天气查询</p>
		</div>
		<div class="li-main">
			<input type="text" id="weather" class="li-main-t" />
		</div>
		<div class="li-right">
			<button type="button" onclick="f_weather()">查 询</button>
		</div>
	</li>
	<li>
		<div class="li-left">
			<p class="li-left-t">手机归属地查询</p>
		</div>
		<div class="li-main">
			<input type="text" id="moblie" class="li-main-t" />
		</div>
		<div class="li-right">
			<button type="button" onclick="f_moblie()">查 询</button>
		</div>
	</li>
	<li>
		<div class="li-left">
			<p class="li-left-t">火车时刻表查询</p>
		</div>
		<div class="li-main">
			<input type="text" id="train" class="li-main-t" />
		</div>
		<div class="li-right">
			<button type="button" onclick="f_train()">查 询</button>
		</div>
	</li>
	<li>
		<div class="li-left">
			<p class="li-left-t">邮政编码查询</p>
		</div>
		<div class="li-main">
			<input type="text" id="postal" class="li-main-t" />
		</div>
		<div class="li-right">
			<button type="button" onclick="f_postal()">查 询</button>
		</div>
	</li>
</ul>
</div>

<div class="res">
	<img class="c_img" id="r_img"></img>
	<input type="text" id="t-code" class="t-code" />
	<p class="r-title">查询结果：</p>
	<p id="r-main">无</p>
</div>
</body>
<script type="text/javascript">
	var y_code;
	
	$(function(){
		var one = getRandomName(1);
		var two = randomWord(false, 3);
		y_code = one + two;
		$.ajax({
			url:"<%=application.getContextPath()%>/Tool.do",
			data:{
				"func":"codeimg",
				"str":y_code
			},
			Type:"post",
			success:function(res){
				document.getElementById('r_img').setAttribute('src', 'data:image/png;base64,' + res);
			},
			error:function(err){
				alert(err);
			}
		})
	})

	function f_weather(){
		s_weather = document.getElementById("weather").value;
		t_code = document.getElementById("t-code").value;
		if (y_code == t_code){
			$.ajax({
				url:"<%=application.getContextPath()%>/Tool.do",
				data:{
					"func":"weather",
					"str":s_weather
				},
				Type:"post",
				success:function(res){
					document.getElementById('r-main').innerHTML = res;
				},
				error:function(err){
					alert(err);
				}
			})
		}else{
			alert("验证码不正确");
		}
	}
	
	function f_moblie(){
		s_moblie = document.getElementById("moblie").value;
		t_code = document.getElementById("t-code").value;
		if (y_code == t_code){
			$.ajax({
				url:"<%=application.getContextPath()%>/Tool.do",
				data:{
					"func":"moblie",
					"str":s_moblie
				},
				Type:"post",
				success:function(res){
					document.getElementById('r-main').innerHTML = res;
				},
				error:function(err){
					alert(err);
				}
			})
		}else{
			alert("验证码不正确");
		}
	}
	
	function f_train(){
		s_train = document.getElementById("train").value;
		t_code = document.getElementById("t-code").value;
		if (y_code == t_code){
			$.ajax({
				url:"<%=application.getContextPath()%>/Tool.do",
				data:{
					"func":"train",
					"str":s_train
				},
				Type:"post",
				success:function(res){
					document.getElementById('r-main').innerHTML = res;
				},
				error:function(err){
					alert(err);
				}
			})
		}else{
			alert("验证码不正确");
		}
	}
	
	function f_postal(){
		s_postal = document.getElementById("postal").value;
		t_code = document.getElementById("t-code").value;
		if (y_code == t_code){
			$.ajax({
				url:"<%=application.getContextPath()%>/Tool.do",
				data:{
					"func":"postal",
					"str":s_postal
				},
				Type:"post",
				success:function(res){
					document.getElementById('r-main').innerHTML = res;
				},
				error:function(err){
					alert(err);
				}
			})
		}else{
			alert("验证码不正确");
		}
	}

	function randomAccess(min,max){
		return Math.floor(Math.random() * (min - max) + max)
	}

	// 解码
	function decodeUnicode(str) {
	   str = "\\u"+str
	   str = str.replace(/\\/g, "%");
	   str = unescape(str);
	   str = str.replace(/%/g, "\\");
	   return str;
	}

	function getRandomName(NameLength){
		let name = ""
		for(let i = 0;i<NameLength;i++){
			let unicodeNum  = ""
			unicodeNum = randomAccess(0x4e00,0x5000).toString(16)
			name += decodeUnicode(unicodeNum)
		}
		return name;
	}
	
	function randomWord(randomFlag, min, max){
	  var str = "",
	    range = min,
	    arr = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
	  if(randomFlag){
	    range = Math.round(Math.random() * (max-min)) + min;
	  }
	  for(var i=0; i<range; i++){
	    pos = Math.round(Math.random() * (arr.length-1));
	    str += arr[pos];
	  }
	  return str;
	}
</script>
</html>