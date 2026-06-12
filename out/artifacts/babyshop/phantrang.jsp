<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2/1/2026
  Time: 11:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/phantrang.css">
</head>
<body>
<!-- ===== PAGINATION ===== -->
<div class="vc-pagination-wrap">
    <div class="vc-pagination">

        <c:set var="baseUrl" value="/voucher-list"/>

        <!-- PREV -->
        <c:if test="${currentPage > 1}">
            <c:url value="${baseUrl}" var="prevLink">
                <c:param name="page" value="${currentPage - 1}"/>
            </c:url>
            <a href="${prevLink}" class="vc-page prev">&laquo;</a>
        </c:if>

        <!-- PAGE NUMBER -->
        <c:forEach begin="1" end="${totalPage}" var="i">
            <c:url value="${baseUrl}" var="pageLink">
                <c:param name="page" value="${i}"/>
            </c:url>

            <a href="${pageLink}"
               class="vc-page ${currentPage == i ? 'active' : ''}">
                    ${i}
            </a>
        </c:forEach>

        <!-- NEXT -->
        <c:if test="${currentPage < totalPage}">
            <c:url value="${baseUrl}" var="nextLink">
                <c:param name="page" value="${currentPage + 1}"/>
            </c:url>
            <a href="${nextLink}" class="vc-page next">&raquo;</a>
        </c:if>

    </div>
</div>

</body>
</html>
