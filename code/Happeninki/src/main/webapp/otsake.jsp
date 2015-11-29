<%@ page import="fi.tsoha.service.HappeninkiService, fi.tsoha.model.Kayttaja" contentType="text/html; UTF-8" pageEncoding="UTF-8"%>
<span style="float:right">

<%
Kayttaja k = (Kayttaja)session.getAttribute("kayttaja");
if(k!=null){
%>

<a href="<%=request.getContextPath()%>/kontrolleri.jsp?toiminto=kirjaudu_ulos">Kirjaudu ulos</a>


<%
out.println(k.getTunnus());
%>


<%}%>

</span>