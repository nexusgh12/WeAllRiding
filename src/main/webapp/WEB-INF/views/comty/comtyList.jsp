<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
main *{
  box-sizing: border-box;
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  -webkit-font-smoothing: antialiased;
  -moz-font-smoothing: antialiased;
  -o-font-smoothing: antialiased;
  font-smoothing: antialiased;
  text-rendering: optimizeLegibility;
}
main {
  font-family: "Roboto", Helvetica, Arial, sans-serif;
  font-weight: 100;
  font-size: 12px;
  line-height: 30px;
  color: #777;
  background: #dddddd;
  width:100%;
}

.container {
  max-width: 1500px;
  width: 100%;
  margin: 0 auto;
  position: relative;
  line-height: 200px;
}
.containerWrap {
  min-height:800px;
  height:auto;
  background: var(--color-lightGray-1);
  padding: 25px;
  margin: 0 auto;
  box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
}
.comtyContainer {
	margin: 0 auto;
	padding: 0 auto;
	width: 80%;
	height: 100%;
}

#cList {
	overflow: auto;
}
#cList>li {
	float: left;
	height: 40px;
	line-height: 40px;
	border-bottom: 1px solid #ddd;
	width: 10%;
	color: black;
}
#cList>li:nth-child(5n+2) {
	width: 50%;
	white-space: nowrap; /*줄 안바꿈*/
	overflow: hidden; /*넘친내용 숨기기*/
	text-overflow: ellipsis; /*넘침시 ...표시*/
}

#cList>li:nth-child(5n) {
	width: 20%;
}

#cListFirst {
	background-color: rgba(234, 234, 234);
}
#writeBtn {
	background-color: rgba(255, 217, 102);
	padding: 10px 50px;
	margin: 0px;
	border-radius: 6px;
	border-color: rgba(204, 204, 204);
	float: right;
}
/*paging*/
.paging {
	display: table;
	margin: 0 auto;
}
.paging > li {
	padding: 0.5vw;
	margin: 0.5vw;
	float: left;
	border-radius: 12px;
	width: 2vw;
	height: 2vh;
	text-align: center;
	vertical-align: middle;
	text-decoration: none;
}
/*search*/
#searchFrm {
	padding: 20px;
	text-align: center;
}
#searchWord {
	height: 24px;
	border-radius: 6px;
}
#searchKey {
	height: 30px;
	border-radius: 6px;
}
#searchBtn {
	height: 30px;
	border-radius: 6px;
}
</style>
<script>
	$(function() {
		$("#searchFrm").submit(function() {
			if ($("#searchWord").val() == "") {
				alert("검색어를 입력하세요");
				return false;
			}
		});
	});
</script>

<!-- parallax START -->
<div class="home">
	<div class="homeBackground parallaxWindow" data-parallax="scroll"
		data-image-src="${url}/images/home/home_background13.png"></div>
	<!-- 배경 이미지 -->
	<div class="homeContent">
		<div class="homeTitle">커뮤니티</div>
		<!-- 페이지 타이틀 -->
	</div>
</div>
<!-- parallax END -->

<main>
	<div class="container">
		<div class="containerWrap">
			<div class="comtyContainer">
				<h1 style="margin: 0 auto; padding: 40px;">커뮤니티</h1>
				<ul id="cList">
					<li id="cListFirst">번호</li>
					<li id="cListFirst">제목</li>
					<li id="cListFirst">글쓴이</li>
					<li id="cListFirst">조회수</li>
					<li id="cListFirst">등록일</li>
					<c:forEach var="vo" items="${lst }">
						<li>${vo.comtyNo }</li>
						<li><a href="/comty/comtyView?comtyNo=${vo.comtyNo}">${vo.comtySubject }</a></li>
						<li>${vo.nickname }</li>
						<li>${vo.comtyHit }</li>
						<li id="comtyWD">${vo.comtyWriteDate }</li>
					</c:forEach>
				</ul>
				<c:if test="${userId != null && userId != ''}">
					<div id="writeBTN">
						<button id="writeBtn" onclick="location.href='/comty/comtyWrite' ">글
							작성하기</button>
					</div>
				</c:if>
				<br />
				<!-- 페이징 -->
				<ul class="paging">
					<!--  이전페이지 -->
					<c:if test="${pVO.pageNum==1}">
						<li>prev</li>
					</c:if>
					<c:if test="${pVO.pageNum>1}">
						<li><a
							href="/comty/comtyList?pageNum=${pVO.pageNum-1}
							<c:if test='${pVO.searchWord != null}'>
								&searchKey=${pVO.searchKey }
								&searchWord=${pVO.searchWord }</c:if>">prev&nbsp;&nbsp;</a></li>
					</c:if>
					<!--  페이지 번호                 1,5      6,10         11,15-->
					<c:forEach var="p" begin="${pVO.startPage}"
						end="${pVO.startPage+pVO.onePageCount-1}">
						<!--  총 페이지수보다 출력할 페이지번호가 작을때 -->
						<c:if test="${p <= pVO.totalPage}">
							<c:if test="${p == pVO.pageNum}">
								<li
									style="background-color: lightgray; height: 25px; border-radius: 6px;">
							</c:if>
							<c:if test="${p != pVO.pageNum}">
								<li>
							</c:if>
							<a
								href="/comty/comtyList?pageNum=${p}
								<c:if test='${pVO.searchWord != null}'>
									&searchKey=${pVO.searchKey }
									&searchWord=${pVO.searchWord }
								</c:if>">
							${p}</a></li>
							</c:if>
					</c:forEach>
					<c:if test="${pVO.pageNum==pVO.totalPage}">
						<li>next</li>
					</c:if>
					<c:if test="${pVO.pageNum<pVO.totalPage}">
						<li><a
							href="/comty/comtyList?pageNum=${pVO.pageNum+1}
							<c:if test='${pVO.searchWord != null}'>
								&searchKey=${pVO.searchKey }
								&searchWord=${pVO.searchWord }</c:if>">&nbsp;&nbsp;next</a></li>
					</c:if>
				</ul>
				<!-- 검색 -->
				<div>
					<form method="get" action="/comty/comtyList" id="searchFrm">
						<select name="searchKey" id="searchKey">
							<option value="comtySubject">제목</option>
							<option value="comtyContent">글내용</option>
							<option value="nickname">글쓴이</option>
						</select> <input type="text" name="searchWord" id="searchWord">
						<button id="searchBtn">검색</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	
</main>