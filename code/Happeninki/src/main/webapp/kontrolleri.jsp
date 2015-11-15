<%@ page language="java" import="fi.tsoha.service.HappeninkiService, fi.tsoha.model.Tila" contentType="text/html; UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

    HappeninkiService s = new HappeninkiService();
    String toiminto = request.getParameter("toiminto");
    
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    Tila t = null;
    if("luo_kayttaja".equals(toiminto)) {
        t = s.luoUusiKayttaja(new String(request.getParameter("nimi")), new String(request.getParameter("tunnus")), new String(request.getParameter("salasana")), new String(request.getParameter("sahkoposti")));
        if(t.getKoodi() == 0) {
            response.setHeader("Location", "kayttajalista.jsp"); 
        } else {
            response.setHeader("Location", "uusikayttaja.jsp?viesti="+t.getViesti()); 
        }
    }
%>
