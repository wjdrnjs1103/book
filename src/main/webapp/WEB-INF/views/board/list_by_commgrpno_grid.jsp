<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="shrink-to-fit=no initial-scale=1, width=device-width" /> 
<meta name="description" content="" />
<meta name="author" content="" /> 

<title>Team2</title>
 
<!-- /static 기준, Core theme CSS (includes Bootstrap)-->
<link href="../css/style.css" rel="stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />


<script type="text/javascript">
 
  
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />

<div class="py-5">
  
    <DIV class='container'> 
        <DIV class='title_line_none'>
          <a href="./list_by_commgrpno_search_paging.do?commgrpno=${commgrpno }&word=&now_page=1" class='title_link'>　${commgrpVO.name}</a>
        </DIV>
        
        <ASIDE class="aside_right">
          <A href="javascript:location.reload();">새로고침</A>
          <span class='menu_divide' >　</span>
          <A href="./list_by_commgrpno_search_paging.do?commgrpno=${param.commgrpno }&word=${param.word }&now_page=${param.now_page}" title="기본 목록형"><IMG style="width:24px;"src='/css/images/list_gray.png'></A>        
          <span class='menu_divide' >　</span>
          <A href="./list_by_commgrpno_grid.do?commgrpno=${param.commgrpno }"><IMG style="width:24px;"src='/css/images/photo_gray.png'></A>        
        </ASIDE>
        
        <DIV class='menu_line_1_b'></DIV>
        
        <div style='width: 100%; margin-top: 1%;'> <%-- 갤러리 Layout 시작 --%>
            <c:forEach var="boardVO" items="${list }" varStatus="status">
            <c:set var="commgrpno" value="${boardVO.commgrpno }" />
            <c:set var="boardno" value="${boardVO.boardno }" />
            <c:set var="title" value="${boardVO.title }" />
            <c:set var="bcon" value="${boardVO.bcon }" />
            <c:set var="bcnt" value="${boardVO.bcnt }" />
            
            <c:set var="file1" value="${boardVO.file1 }" />
            <c:set var="bsize" value="${boardVO.bsize }" />
            <c:set var="thumb" value="${boardVO.thumb }" />            
            <c:set var="thumb" value="${boardVO.thumb }" />         
               
            <c:set var="budate" value="${boardVO.budate }" />            
      
            <%-- 하나의 행에 이미지를 4개씩 출력후 행 변경 --%>
            <c:if test="${status.index % 5 == 0 && status.index != 0 }"> 
              <HR class=''>
            </c:if>
            
            <!-- 하나의 이미지, 24 * 4 = 96% -->
            <DIV style='width: 19%; height: 270px; float: left; margin-top:5px; margin-bottom:20px; margin-left: 10px;  padding: 0.2%; 
                 background-color: white; text-align: center;'>
              <c:choose>
                <c:when test="${bsize > 0}"> <!-- 파일이 존재하면 -->
                  <c:choose> 
                    <c:when test="${thumb.endsWith('jpg') || thumb.endsWith('png') || thumb.endsWith('gif')}"> <!-- 이미지 인경우 -->
                      <a href="./read.do?boardno=${boardno}">               
                        <IMG src="./storage/${thumb }" style='width: 98%; height: 200px;'>
                      </a><br>
                      <div style="margin-top: 5px; padding-left: 5px; text-align: left; font-weight: bold;">${title}</div>
                      <!-- 게시글 글쓴이 id 입력 -->
                      <div style="margin-top: 7px; padding-left: 5px; text-align: left; font-size: 0.9em; color: #8B8B8B;">user1</div>
                      <div style="padding-left: 5px; text-align: left; font-size: 0.83em; color: #AEADAD;">${boardVO.brdate.substring(0, 10) }　· 조회 ${bcnt }</div>
                      <br>
                    </c:when>
                    <c:otherwise> <!-- 이미지가 아닌 일반 파일 -->
                      <DIV style='width: 98%; height: 200px; display: table; border: solid 1px #CCCCCC;'>
                        <DIV style='display: table-cell; vertical-align: middle; text-align: center;'> <!-- 수직 가운데 정렬 -->
                          <a href="./read.do?boardno=${boardno}">${file1}</a><br>
                        </DIV>
                      </DIV>
                     <div style="margin-top: 5px; padding-left: 5px; text-align: left; font-weight: bold;">${title}</div>     
                     <!-- 게시글 글쓴이 id 입력 -->
                     <div style="margin-top: 7px; padding-left: 5px; text-align: left; font-size: 0.9em; color: #8B8B8B;">user1</div>
                     <div style="padding-left: 5px; text-align: left; font-size: 0.83em; color: #AEADAD;">${boardVO.brdate.substring(0, 10) }　· 조회 ${bcnt }</div>         
                    </c:otherwise>
                  </c:choose>
                </c:when>
                
                <c:otherwise> <%-- 파일이 없는 경우 기본 이미지 출력 --%>
                  <div>
                    <a href="./read.do?boardno=${boardno}">
                      <img src='/board/images/none2.png' style='width: 98%; height: 200px;'>
                    </a><br>
                  </div>
                  <div style="margin-top: 5px; padding-left: 5px; text-align: left; font-weight: bold; font-size: 0.93em;">미리보기 이미지를 등록해주세요.</div>
                  <!-- 게시글 글쓴이 id 입력 -->
                  <div style="margin-top: 7px; padding-left: 5px; text-align: left; font-size: 0.9em; color: #8B8B8B;">user1</div>
                  <div style="padding-left: 5px; text-align: left; font-size: 0.83em; color: #AEADAD;">${boardVO.brdate.substring(0, 10) }　· 조회 ${bcnt }</div>
                </c:otherwise>
                
              </c:choose>         
            </DIV>  
          </c:forEach>
        </DIV><!-- 갤러리 Layout 종료 -->
        
        <div class="menu_line_1_g"></div>
        
        <div class="content_body_bottom ">
          <button type='button' class="btn" style="border: solid 1px;"
                             onclick="location.href='./create.do?commgrpno=${param.commgrpno }&word=${param.word }&now_page=${param.now_page }'">글쓰기</button>  
        </div>
        
        <DIV class='content_body_bottom_c_page'>${paging }</DIV>    
        
        <%-- 검색 --%>
        <div class="content_body_bottom_c_search">
          <form name='frm' id='frm' method='get' action='./list_by_commgrpno_search_paging.do'>
            <input type='hidden' name='commgrpno' value='${param.commgrpno }'>
            
            <select class="input_search_word_" style='width:10%;'>
              <option value='all'${param.search_option == "all" ? "selected='selected'":""}>전체 검색</option>
              <option value='title'${param.search_option == "title" ? "selected='selected'":""}>제목</option>
              <option value='bcon'${param.search_option == "bcon" ? "selected='selected'":""}>내용</option>                    
            </select> 
            
            <c:choose>
              <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
                <input class="input_search_word_" type='text' name='word' id='word' value='${param.word }' style='width: 25%;'>
              </c:when>
              <c:otherwise> <%-- 검색하지 않는 경우 --%>
                <input class="input_search_word_" type='text' name='word' id='word' value='' style='width: 25%;'>
              </c:otherwise>
            </c:choose>
            
            
            <button type='submit' class="btn_yelㅣow margin_l_10">검색</button>
            
            <c:if test="${param.word.length() > 0 }">
              <button type='button' class="btn_gray"
                           onclick="location.href='./list_by_commgrpno_search_paging.do?commgrpno=${commgrpVO.commgrpno}&word=&now_page=1'">검색 취소</button>  
            </c:if>    
          </form>
        </div>
        
        <%-- 추가적으로 광고를 넣을 DIV, css 추가 --%>
        <div class="c_bottom_ad">
          광고
        </div>
        
    </div>
</div>
 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>

