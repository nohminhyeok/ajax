<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	const today = new Date();
	const todayYear = today.getFullYear();
	const todayMonth = today.getMonth() + 1;
	const todayDate = today.getDate();
	
	$(function (){
		$('#sn2').blur(function(){
			// sn1.length == 6 && sn2.length == 7 
			// 둘다 isNaN 아니면 
			$.ajax({
				url:'http://localhost:9999/isSn/'+$('#sn1').val()+$('#sn2').val()
				, type: 'get'
				, success: function(data) {
					// 'true' or 'false'
					if(data == true){
						// 성별
						if(Number($('#sn2').val().substr(0,1)) % 2 ==0){
							$('#gender').val('여')
						} else {
							$('#gender').val('남')
						}

						// 변수 처리
						let usN = Number($('#sn1').val().substr(0,2))
						let genderNum = Number($('#sn2').val().substr(0, 1));
						
	                    let birthYear ='';
	                    if (genderNum == 1 || genderNum == 2) {
	                        birthYear = 1900 + usN;
	                    } else if (genderNum == 3 || genderNum == 4) {
	                        birthYear = 2000 + usN;
	                    } else {
	                        alert('잘못된 주민번호 형식입니다.');
	                        return;
	                    }

	                    // 월, 일 계산
	                    let birthMonth = Number($('#sn1').val().substr(2, 2));
	                    let birthDate = Number($('#sn1').val().substr(4, 2));

	                    // 나이 계산
	                    let age = todayYear - birthYear;

	                    // 만 나이 계산 (월과 일 비교)
	                    if (todayMonth < birthMonth || (todayMonth == birthMonth && todayDate < birthDate)) {
	                        age -= 1;
	                    }
	                    $('#age').val(age);
	                    
	                    alert('주민번호 인증 성공');
						} else {
						alert('주민번호 인증 실패')
					}
					
				}
			}) 
		})
		// 내부 API 서버 호출 - 비동기 구현이 필수는 아님
		$('#idckBtn').click(function(){
			$.ajax({
				// $('idck').val() 공백이 아니라면
				url:'/isId/'+$('#idck').val()
				,type: 'get'
				,success: function(data){
					if(data == true){
						alert('이미 사용중인 아이디 입니다.')
					} else {
						alert('사용 가능한 아이디 입니다.')
						$('#id').val($('#idck').val());
					}
				}
			})
		})
		$('#sn1').keyup(function(){
			if($(this).val().length == 6) {
				$('#sn2').focus();
			}
		})

		$('#sn2').keyup(function(){
			if($(this).val().length == 7) {
				$('#idck').focus();
			}
		})
		
		
		
		$('#idckBtn').click(function(){
			if($(this).val() != null){
				$('#pw1').focus();
			}
		})
		
		$('#btn').click(function(){
			let pw1 = $('#pw1').val();
			let pw2 = $('#pw2').val();
			if(pw1 == pw2){
				alert('비밀번호가 일치합니다.')
			} else {
				alert('비밀번호가 일치하지 않습니다.')
			}
			$('#joinForm').submit();
		})
	})
</script>
</head>
<body>
	<h1>회원가입</h1>
	<hr>
	<h2>주민번호 확인</h2>
		<table border="1">
			<tr>
				<th>주민번호</th>
				<td>
					<input type="text" id="sn1" name="sn1"> <!-- keyup, length 6, focus sn2 -->
					-					
					<input type="text" id="sn2" name="sn2"> <!-- blur length == 7, snapi호출, 결과가 true, gender+age, false alert 잘못된 주민번호-->
				</td>			
			</tr>		
		</table>
		
	<hr>
	<h2>ID검색</h2>
		<table border="1">
			<tr>
				<th>ID검색</th>
				<td>
					<input type="text" id="idck">
					<button type="button" id="idckBtn">ID검색</button>
				</td>
			</tr>
		</table>
	<hr>
	
	<form id="joinForm" action="/joinMember" method="post">
		<table border="1">
			<tr>
				<th>주소</th>
				<td>
					<input type="text" name="postcode" id="postcode" placeholder="우편번호">
					<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" name="roadAddress" id="roadAddress" placeholder="도로명주소">
					<input type="text" name="jibunAddress" id="jibunAddress" placeholder="지번주소">
					<span id="guide"  style="color:#999;display:none"></span>
					<input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소">
					<input type="text" name="extraAddress" id="extraAddress" placeholder="참고항목">
				</td>
			</tr>
			<tr>
				<th>성별</th>
				<td><input type="text" id="gender" name="gender" readonly></td>			
			</tr>
			<tr>
				<th>나이</th>
				<td><input type="text" id="age" name="age" readonly value="0"></td>			
			</tr>
			<tr>
				<th>아이디</th>
				<td><input type="text" id="id" name="id" readonly></td>			
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" id="pw1" name="pw1">
					확인 - <input type="password" id="pw2" name="pw2">
				</td>			
			</tr>
		</table>
		<button type="button" id="btn">회원가입</button>
	</form>
	
	<!-- 카카오 주소API 호출을 위한 CDN주소 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<script>
	    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
	    function execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var roadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 참고 항목 변수
	
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('postcode').value = data.zonecode;
	                document.getElementById("roadAddress").value = roadAddr;
	                document.getElementById("jibunAddress").value = data.jibunAddress;
	                
	                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
	                if(roadAddr !== ''){
	                    document.getElementById("extraAddress").value = extraRoadAddr;
	                } else {
	                    document.getElementById("extraAddress").value = '';
	                }
	
	                var guideTextBox = document.getElementById("guide");
	                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	                if(data.autoRoadAddress) {
	                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	                    guideTextBox.style.display = 'block';
	
	                } else if(data.autoJibunAddress) {
	                    var expJibunAddr = data.autoJibunAddress;
	                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	                    guideTextBox.style.display = 'block';
	                } else {
	                    guideTextBox.innerHTML = '';
	                    guideTextBox.style.display = 'none';
                	}
            	}
        	}).open();
   		}
	</script>
</body>
</html>