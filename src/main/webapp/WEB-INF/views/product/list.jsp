<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<c:import url="../template/header.jsp"></c:import>
<style type="text/css">
	.detail{
		cursor: pointer;	
	}
</style>

</head>
<body>
	
	<div class="container mt-4">
		<div class="row mt-4">
			<div class="alert alert-primary" role="alert">
			  <h4 style="text-transform: uppercase;">${board} List</h4>
			</div>
		</div>
		
		<div class="row mt-4">
			<c:forEach items="${list}" var="vo">
				<div class="card col-4 detail" data-num="${vo.productNum}">
				  <img src="../resources/upload/product/${vo.productFilesVO[0].fileName}" class="card-img-top" alt="...">
				  <div class="card-body">
				    <p class="card-text">${vo.productName}</p>
				  </div>
				  	<div class="card-footer">
				  		<h5>${vo.productPrice}원</h5>
				  	</div>
				</div>
			</c:forEach>	
		</div>
		
			
		
		<div class="mt-3 row justify-content-between">
		<div class="col-5">
			<form class="d-flex" action="./list" method="get">
				<div class="col-4 me-2">
				<select name="kind" class="form-select " aria-label="Default select example">
				  <option value="col1">Title</option>
				  <option value="col2">Contents</option>
				  <option value="col3">Writer</option>
				</select>
				</div>
				<div class="col-6 me-2">
	        	<input name="search" class="form-control" type="search" placeholder="Search" aria-label="Search">
	        	</div>
	        	<div class="col-2">
	        	<button class="btn btn-outline-success" type="submit">Search</button>
	        	</div>
	      </form>
		</div>
		<div class="col-1">
			<a href="./add" type="button" class="btn btn-outline-primary">WRITE</a>
		</div>
	</div>
		
		<nav aria-label="Page navigation example">
		  <ul class="mt-3 pagination justify-content-center">
		    <li class="page-item">
			    <a class="page-link" href="./list?pn=${pager.pre ? pager.startNum-1 : 1}&kind=${pager.kind}&search=${pager.search}" aria-label="Previous">
	        	<span aria-hidden="true">&laquo;</span>
	      		</a>
      		</li>
      		
		    <c:forEach begin="${pager.startNum}" end="${pager.lastNum}" var="i">
		    	<li class="page-item"><a class="page-link" 
		    	href="./list?pn=${i}&kind=${pager.kind}&search=${pager.search}">${i}</a></li>
		    </c:forEach>
		    
		    <li class="page-item">
			    <a class="page-link" href="./list?pn=${pager.next ? pager.lastNum+1 : pager.lastNum}&kind=${pager.kind}&search=${pager.search}" aria-label="Next">
	        	<span aria-hidden="true">&raquo;</span>
	      		</a>
      		</li>
		  </ul>
		</nav>
	</div>

<c:import url="../template/header_script.jsp"></c:import>
<script type="text/javascript">
	$('.detail').click(function() {
		let num = $(this).attr('data-num');
		location.href="./detail?productNum="+num;
	});
</script>

</body>
</html>