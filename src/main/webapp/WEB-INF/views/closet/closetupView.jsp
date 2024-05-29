<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script src="http://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/inc/top.jsp"></jsp:include>
	<h2
		class="page-section-heading text-center text-uppercase text-secondary mb-0">옷장추가하긩</h2>
	<table>

		<tr>
			<th>대분류</th>
			<td><select id="mainSel">
					<option value="">--선택하세요</option>
					<c:forEach items="${comList}" var="code">
						<option value="${code.pgroupName}">${code.pgroupName}</option>
					</c:forEach>
			</select></td>
			<th>중분류</th>
			<td><select id="subSel">
					<option items="${codList}" value="code1">--선택하세요--</option>
					<option value="${code1.detailName}">${code1.detailName}</option>
			</select></td>
		</tr>
		<tr>
			<th>결과</th>

		</tr>
	</table>

	<div class="row row-cols-1 row-cols-md-3 g-4" id="result"></div>

	<script>
	$(document).ready(function(){
	    $("#mainSel").on('change',function(){
	       
	    	let code =$(this).val();
	    	console.log(code);
	        if(code == ''){
	            $("#subSel").empty().append('<option value="">--선택하세요--</option');
	            return;
	        }
	       
	        $.ajax({
	            url : '<c:url value="/twochoice" />',
	            type : 'GET',
	            data : {pgroupName : code},
	            dataType :'json',
	            success :function(res){
	                $("#subSel").empty().append('<option value="">--선택하세요--</option>');
	                $.each(res, function(idx,item){
	                    $("#subSel").append('<option value="'+ item.ptypeName +'">'
	                                            + item.ptypeName +'</option>');
	                });
	            },
	            error : function(e){
	                console.log(e);
	            }        
	        });
	    });
	    $("#subSel").on('change',function(){
		    	let pgroupName = $("#mainSel").val();
		    	let ptypeName =$(this).val();
		    	console.log(pgroupName, ptypeName);
		    	 $.ajax({
			            url : '<c:url value="/getlist" />',
			            type : 'POST',
			            data : {pgroupName : pgroupName
			            	   ,ptypeName : ptypeName },
			            dataType :'json',
			            success :function(res){
			            	$("#result").empty();
			            	console.log(res);
			                $.each(res, function(idx,item){
			                	
			                	let str ="";
			                	
			                	str +='<span class="card" style="width: 18rem ;">';
			                	str +='<img src="<c:url value="/download?imageFileName='+item.imgPath+'" />" class="card-img-top" alt="...">';
			                	str +='<span class="card-body">';
			                	str +='<h5 class="card-title">'+item.pname+'</h5>';
			                	str +='<p class="card-text">상세정보<br> 코드이름: '+item.pcode+' 패턴: '+item.gappName
			                											+'<br>디테일: '+item.detailDesc+'<br>색상: '+item.cgroupName+'</p>';
			                	str +='<a class="btn btn-primary addadd">추가하기</a>';
			                	str +='<input type="hidden" class="pcode" value="'+item.pcode+'">';
			                	str +='<input type="hidden" class="cgroupCode" value="'+item.cgroupCode+'">';
			                	str +='</div>';    
			                	str +='</span>';    
			                   
			               		
			                	$("#result").append(str);
			                	
			             

			                	 
			                });
			            },
			            error : function(e){
			                console.log(e);
			            }        
		    });
		});
	    $(document).on("click", ".addadd", function(){
	    	console.log($(this));
	    	console.log();
	    	let pcode = $(this).parent().find(".pcode").val();
	    	let cgroupCode = $(this).parent().find(".cgroupCode").val();
	    	console.log(pcode, cgroupCode);
	    	 $.ajax({    		 
		            url : '<c:url value="/plusDo" />',
		            type : 'POST',
		            data : { pcode : pcode
		            	    ,cgroupCode : cgroupCode },
		            dataType :'json',
		            success :function(res){		            
		            	console.log(res);
		            	if (res.message == 'success') {		                    
		                    alert("내옷장에 저장~!!!!!!"); 		                    
		                } else {		                  
		                    alert("저장 안됨 ㅠㅜㅠㅜㅠ");
		                }
		            	
                    },
                    error: function(e){
                        console.log(e);
                    }
                });
            });
	    
	  
        });
	
		</script>
	<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>
</body>
</html>