<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<c:import url="../template/header.jsp"></c:import>
<c:import url="../template/header_script.jsp"></c:import>
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous"/>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

</head>
<body>

<div class="container mt-4">
		<div class="row mt-4">
			<div class="alert alert-secondary" role="alert">
				  <h4>${board} WRITE</h4>
			</div>
		</div>
			
			<div id="list" class="row">
			<!-- 상품 리스트 ajax로 num, name, price, count-->
								
			</div>
		
			<div class="row mb-3">
			    <label class="col-sm-2 col-form-label">NAME</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="productName" name="productName">
			    </div>
			</div>
			
			<div class="row mb-3">
			    <label class="col-sm-2 col-form-label">PRICE</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="productPrice" name="productPrice">
			    </div>
			</div>
			
			<div class="row mb-3">
			    <label class="col-sm-2 col-form-label">COUNT</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="productCount" name="productCount">
			    </div>
			</div>
		  
			<div class="row mt-3">
				<label class="col-sm-2 col-form-label">CONTENTS</label>
				<div class="col-sm-10">
					<textarea id="productDetail" class="form-control" name="productDetail"></textarea>
				</div>
			</div>
			
			<div id="fileResult">
			
			</div>
			
			<div class="row mt-3 mb-3 justify-content-between">
				<button id="fileAdd" type="button" class="btn col-2 btn-secondary">FILE ADD</button>
				<button id="add" class="btn col-2 btn-outline-primary">WRITE</button>
			</div>
		
	</div>


<script type="text/javascript">
	
	// textarea id
	$('#productDetail').summernote({
		height : 400
	});

	let count = 0;
	
	$('#fileAdd').click(function() {
		if(count > 4) {
			alert('파일은 최대 5개까지 첨부가능합니다.');
			return;
		}
		
		let result = '<div class="mt-3 input-group">';
		result = result + '<input name="files" type="file" class="form-control files" id="inputGroupFile04" aria-describedby="inputGroupFileAddon04" aria-label="Upload">'
		result = result + '<button class="btn btn-outline-secondary del" type="button" id="inputGroupFileAddon04">X</button>'
		result = result + '</div>';
		$('#fileResult').append(result);
		count++;
	});
	
		// list ajax url : ajaxList, Get
		function getList(pn) {
			$.ajax({
				type:"GET",
				url:"./ajaxList",
				success : function(data){
					// div id="list"에 html 추가
					$("#list").html(data.trim());
				},
				data: {
					pn:pn,
					// 한 페이지에 5개 
					perPage:5
				}
			});
		}
	
	// FileResult 안에 del을 click 했을 때
	$('#fileResult').on('click', ".del", function(){
		$(this).parent().parent().remove();
		count--;
	});
	
	// 상품등록 ajax
	$('#add').click(function() {
		let formData = new FormData();
		let productName = $('#productName').val();
		let productPrice = $('#productPrice').val();
		let productCount = $('#productCount').val();
		let productDetail = $('#productDetail').summernote("code"); //$('#productDetail').val();
		$('.files').each(function(idx, item) {
			if(item.files.length > 0) {				
			console.log("index : " + idx);		// index 번호
			console.log("item : " + item);		// <input type="file">
			console.log(item.files);			// input 태그의 file List
			console.log(item.files[0]);			// files list 중 첫 번째 파일
			console.log("length: " + item.files.length);
			console.log(item.files[0].name);	// files list 중 첫 번째 파일의 이름
			// formData.append("파라미터명", 값);
			formData.append("files", item.files[0]);
			}
		});
		
		formData.append("productName", productName);
		formData.append("productPrice", productPrice);
		formData.append("productCount", productCount);
		formData.append("productDetail", productDetail);
		
		$.ajax({
			type:"POST",
			url:"./add",
			processData:false,
			contentType:false,
			data: formData /* {
				productName: productName,
				productPrice: productPrice,
				productCount: productCount,
				productDetail: productDetail
			} */,
			success: function(data) {
				console.log(data.trim());
				if(data.trim() == '1') {
					alert("상품등록 완료");
					getList();
					$('#productName').val("");
					$('#productPrice').val("");
					$('#productCount').val("");
					$('#productDetail').summernote("code", "");
				} else {
					alert("상품등록 실패");
				}
			},
			error: function() {
				alert("error 발생");
			}
		});
	});
		
	
	// 이벤트 위임
	// let pn = 1;
	$('#list').on('click', '.pager', function() {
		// attr : JS의 getAttribute
		let checkPn = $(this).attr("data-pn");
		if(checkPn > 0) {
			//pn = checkPn;
			getList(checkPn);
		// 이전 또는 다음 Block이 없음
		} else if (checkPn < 0) {
			alert("이전 페이지가 없습니다");
		} else {
			alert("마지막 페이지 입니다.");
		}
	});
	
	getList(1);

</script>
</body>
</html>