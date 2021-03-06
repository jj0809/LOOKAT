<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="../template/header.jsp" />
<jsp:include page="../template/qnaTitle.jsp" />
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		test();
	});

	function test() {
		$('button[type="button"][name="updateBtn"]').click(function() {
			var r_no = $(this).parents('td').find('#r_no').val();
			var replyToggle = 'input:checkbox[name=replyToggle' + r_no + ']';
			var content = $('#content' + r_no);
			var edit_content = $('#edit_content' + r_no);
			var editBtn = $('#editBtn' + r_no);
			var checked = $(replyToggle).is(":checked");
			if (checked == true) {
				$(replyToggle).prop('checked', false);
				$(content).css('display', 'block');
				$(edit_content).css('display', 'none');
				$(editBtn).val('수정');
			} else {
				$(replyToggle).prop('checked', true);
				$(content).css('display', 'none');
				$(edit_content).css('display', 'flex');
				$(editBtn).val('취소');
			}
		});
		$('button[type="button"][name="rereplyBtn"]').click(function() {
			var r_no = $(this).parents('td').find('#r_no').val();
			var rereplyToggle = 'input:checkbox[name=rereplyToggle' + r_no + ']';
			var edit2Btn = $('#edit2Btn' + r_no);
			var rereply_content = $('#rereply_content' + r_no);
			var rereply_writer = $('#rereply_writer' + r_no);
			var checked = $(rereplyToggle).is(":checked");
			if (checked == true) {
				$(rereplyToggle).prop('checked', false);
				$(rereply_content).css('display', 'none');
				$(rereply_writer).css('display', 'none');
				$(edit2Btn).val('답글');
			} else {
				$(rereplyToggle).prop('checked', true);
				$(rereply_content).css('display', 'flex');
				$(rereply_writer).css('display', 'block');
				$(edit2Btn).val('취소');
			}
		});
	}
</script>

<style type="text/css">
#viewContainer {
	width: 80%;
	margin: auto;
}

.qnaTable {
	width: 100%;
	border: 1px solid lightgrey;
	margin-left: auto;
	margin-right: auto;
}

.qnaTable>tbody>tr>td, th {
	padding: 10px;
	border: 1px solid lightgrey;
}

.productInfoTable {
	width: 100%;
	border: 1px solid lightgrey;
}

.productInfoTable>tbody>tr>td, th {
	padding: 10px;
}

.qnaContent {
	font-size: 12px;
}

.qnaTitle {
	width: 100px;
}

img {
	width: 800px;
}

.replyTable {
	width: 100%;
}

.replyBtn {
	background-color: #FBFAFA;
	font-size: 12px;
	border: none;
}

.replyBtn:hover {
	font-size: 16px;
	transition-property: all;
	transition-duration: 0.5s;
}

#replyWrite {
	width: 100%;
	background-color: #FBFAFA;
	border: 1px solid lightgrey;
	padding: 5px 5px 5px 25px;
}

.viewPageBtn {
	background-color: black;
	color: white;
	font-weight: 600;
	padding: 5px;
	line-height: -5px;
	font-size: 12px;
}

.viewPageBtn:hover {
	background-color: white;
	font-weight: 700;
	color: black;
}

#replyToggle, #rereplyToggle {
	display: none;
}

#replyTable td {
	padding-left: 5px;
}

#replyWriteBtn {
	width: 100px;
	height: 77px;
	line-height: 100%;
	background-color: white;
}

#replyWriteBtn:hover {
	background: lightgrey;
}
</style>
</head>

<div id="viewContainer">
	<form method="post">
		<c:if test="${qnaDto.q_p_no ne 0}">
			<table class="productInfoTable">
				<tbody>
					<tr>
						<td style="width: 5%" rowspan="2"><img style="width: 80px;" src="${qnaDto.p_Image}"></td>
						<td style="height: 80%; border-bottom: 1px solid lightgrey;">
							${qnaDto.p_Name}[${qnaDto.p_Color}]<br />
							&#8361;<fmt:formatNumber pattern="#,##0">${qnaDto.p_Price}</fmt:formatNumber>
						</td>
						<td style="width: 2%"></td>
					</tr>
					<tr>
						<td>
							<input type="button" class="viewPageBtn" value="상품 상세보기" onclick="location.href='productViewPage.do?p_No=${qnaDto.q_p_no}'" />
						</td>
						<td></td>
					</tr>
				</tbody>
			</table>
			<br />
		</c:if>
		<table class="qnaTable">
			<tbody>
				<tr>
					<th class="qnaTitle">제목</th>
					<td>${qnaDto.q_title}</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${qnaDto.m_name}</td>
				</tr>
				<tr>
					<td colspan="2">
					<!-- 작성일 안나옴 -->
						<pre><span style="font-weight:700;">작성일</span> ${qnaDto.q_date}      <span style="font-weight:700;">조회수</span> ${qnaDto.q_hit}</pre>
					</td>
				</tr>
				<tr>
					<td class="qnaContent" colspan="2">${qnaDto.q_content}</td>
				</tr>
				<c:set var="uploadFileNames" value="${fn:split(qnaDto.q_filename,'^')}" />
				<tr>
					<td colspan="2">
						<c:forEach var="uploadFileName" items="${uploadFileNames}">
							<img alt="${uploadFileName}" src="resources/storage/${uploadFileName}"><br /><br />
						</c:forEach>
					</td>
				</tr>
			</tbody>
		</table>

		<div style="line-height: 70%">
			<br />
		</div>
		<!-- 줄간격을위한 div -->

		<table align="right">
			<tbody>
				<tr>
					<td>
						<c:if test="${loginDto.m_no ==  qnaDto.q_m_no}">
							<input class="viewPageBtn" type="button" value="수정하기" onclick="qnaUpdatePage(this.form)" />
							<input class="viewPageBtn" type="button" value="삭제하기" onclick="fq_qnaDelete(this.form)" />
						</c:if>
						<input class="viewPageBtn" type="button" value="목록보기" onclick="location.href='qnaListPage.do?page=${page}'" />
					</td>
				</tr>
			</tbody>
		</table>
		<br /><br />
		<%-- hidden	 --%>
		<input type="hidden" name="q_no" value="${qnaDto.q_no}" />
		<input type="hidden" name="q_title" value="${qnaDto.q_title}">
		<input type="hidden" name="q_content" value="${qnaDto.q_content}">
		<input type="hidden" name="q_filename" value="${qnaDto.q_filename}" />
		<input type="hidden" name="page" value="${page}" />
	</form>

	<%-- 댓글 목록 --%>
	<%-- session에 replyList가 저장되어 있다. --%>
	<div id="replyContainer" style="border: 1px solid lightgrey; background-color: #FBFAFA; padding: 15px;">
		<table class="replyTable">
			<tbody>
				<c:if test="${empty replyList}">
					<tr>
						<td colspan="2">코맨트가 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty replyList}">
					<c:forEach var="replyDto" items="${replyList}">
						<form method="post">
							<tr>
								<c:if test="${replyDto.r_delete eq -1}">
									<td id="1" colspan="2">삭제된 댓글입니다</td>
								</c:if>
								<c:if test="${replyDto.r_delete eq 0}">
									<td colspan="2">
										<c:forEach begin="1" end="${replyDto.r_depth}" step="1"> 
											&nbsp;&nbsp;&nbsp;&nbsp;
										</c:forEach>
										<c:if test="${replyDto.r_depth > 0}">
											<img style="width: 10px;" src="https://i.esdrop.com/d/JkZ39Felsl.png" />&nbsp;
										</c:if>
										<span style="font-weight: 700; font-size: 16px;">${replyDto.r_writer}</span>&nbsp;&nbsp;&nbsp;<span style="color: grey; font-size: 10px;">${replyDto.r_date}</span>
										<input type="checkbox" id="replyToggle" name="replyToggle${replyDto.r_no}" value="${replyDto.r_no}">
										<input type="checkbox" id="rereplyToggle" name="rereplyToggle${replyDto.r_no}" value="${replyDto.r_no}">
										<c:if test="${loginDto ne null}">
											<button type="button" class="replyBtn" name="rereplyBtn" id="edit2Btn${replyDto.r_no}" value="답글">
												<i class="far fa-comment-dots"></i>
											</button>
										</c:if>
										<c:if test="${loginDto.m_no eq replyDto.r_m_no}">
											<button type="button" class="replyBtn" name="updateBtn" id="editBtn${replyDto.r_no}" value="수정">
												<i class="fas fa-wrench"></i>
											</button>
											<button value="삭제" class="replyBtn" onclick="fq_replyDelete(this.form)">
												<i class="far fa-trash-alt"></i>
											</button>
										</c:if>
										<!-- hidden -->
										<input type="hidden" id="r_no" name="r_no" value="${replyDto.r_no}" />
										<input type="hidden" name="r_q_no" value="${qnaDto.q_no}" />
										<input type="hidden" name="r_m_no" value="${loginDto.m_no}" />
										<input type="hidden" name="r_writer" value="${loginDto.m_name}" />
										<input type="hidden" name="r_delete" value="${replyDto.r_delete}" />
										<input type="hidden" name="r_group" value="${replyDto.r_group}" />
										<input type="hidden" name="r_groupOrd" value="${replyDto.r_groupOrd}" />
										<input type="hidden" name="r_depth" value="${replyDto.r_depth}" />
										<input type="hidden" name="page" value="${param.page}" />
									</td>
								</c:if>
							</tr>
							<tr>
								<td colspan="2">
									<div id="content${replyDto.r_no}">
										<c:forEach begin="1" end="${replyDto.r_depth}" step="1"> 
											&nbsp;&nbsp;&nbsp;&nbsp;
										</c:forEach>
										${replyDto.r_content}
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div style="display: none;" id="edit_content${replyDto.r_no}">
										<div style="display: flex;">
											<textarea style="resize: none; width: 80%; height: 30px;" rows="3" cols="100" name="edit_content" placeholder="댓글은 마음의 창입니다. 고운말을 씁시다.">${replyDto.r_content}</textarea>
											&nbsp;&nbsp;
											<button class="replyBtn" style="width: 100px; height: 30px; line-height: 100%" onclick="fq_replyUpdate(this.form)">수정</button>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div style="display: none;" id="rereply_writer${replyDto.r_no}">
										<span style="font-weight: 700; font-size: 16px;">${loginDto.m_name}</span>&nbsp;&nbsp;&nbsp;<span style="color: grey; font-size: 10px;">${replyDto.r_date}</span>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div style="display: none;"
										id="rereply_content${replyDto.r_no}">
										<div style="display: flex;">
											<textarea style="resize: none; width: 80%; height: 30px;" rows="3" cols="100" name="rereply_content" placeholder="댓글은 마음의 창입니다. 고운말을 씁시다."></textarea>
											&nbsp;&nbsp;
											<button class="replyBtn" style="width: 100px; height: 30px; line-height: 100%" onclick="fq_rereplyInsert(this.form)">
												<i class="far fa-comment-dots"></i>
											</button>
										</div>
									</div>
								</td>
							</tr>
						</form>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
	</div>
	<br /><br />

	<div style="line-height: 70%">
		<br />
	</div>
	<!-- 줄간격을위한 div -->

	<form id="replyWrite" action="q_replyInsert.do" method="post">
		<c:if test="${not empty loginDto}">
			<span style="font-weight: 600">댓글달기</span>
			<table style="width: 100%; border-spacing: 20px;">
				<tbody>
					<tr>
						<td style="width: 15%;">작성자&nbsp;&nbsp;&nbsp;${loginDto.m_name }</td>
					</tr>
					<tr>
						<td style="display: flex;">
							<textarea style="resize: none; width: 80%" rows="3" cols="100" name="r_content" placeholder="댓글은 마음의 창입니다. 고운말을 씁시다."></textarea>
							&nbsp;&nbsp;
							<button id="replyWriteBtn">확인</button>
						</td>
					</tr>
				</tbody>
			</table>
		</c:if>
		<c:if test="${empty loginDto}">
			<span style="font-weight: 600; text-align: center;">로그인이 필요합니다</span>
			<input type="button" id="loginBtn" value="로그인 하기" onclick="location.href='loginPage.do'" />
		</c:if>
		<%-- hidden --%>
		<input type="hidden" name="r_q_no" value="${qnaDto.q_no}" />
		<input type="hidden" name="r_m_no" value="${loginDto.m_no}" />
		<input type="hidden" name="r_writer" value="${loginDto.m_name}" />
		<input type="hidden" name="page" value="${param.page}" />
	</form>
	<br />
</div>
<script>
	function qnaUpdatePage(f) {
		f.action = 'qnaUpdatePage.do';
		f.submit();
	}
	function fq_qnaDelete(f) {
		var result = confirm('삭제하시겠습니까?');
		if (result) {
			f.action = 'qnaDelete.do';
			f.submit();
		}
	}
	function fq_replyDelete(f) {
		f.action = 'q_replyDelete.do';
		f.submit();
	}
	function fq_replyUpdate(f) {
		f.action = 'q_replyUpdate.do';
		f.submit();
	}
	function fq_rereplyInsert(f) {
		f.action = 'q_rereplyInsert.do';
		f.submit();
	}
</script>

<%@ include file="../template/footer.jsp"%>