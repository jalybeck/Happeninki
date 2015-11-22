<%@ page language="java" import="fi.tsoha.service.HappeninkiService, fi.tsoha.model.Tila, fi.tsoha.model.Kayttaja" contentType="text/html; UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

    HappeninkiService s = new HappeninkiService();
    String toiminto = request.getParameter("toiminto");

    Tila t = null;
    String returnURL="";
    if("luo_kayttaja".equals(toiminto)) {
        t = s.luoUusiKayttaja(new String(request.getParameter("nimi")), new String(request.getParameter("tunnus")), new String(request.getParameter("salasana")), new String(request.getParameter("sahkoposti")));
        if(t.getKoodi() == 0) {
            request.getRequestDispatcher("kayttajalista.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("uusikayttaja.jsp?viesti="+t.getViesti()).forward(request, response);
        }
    } else if("kirjaudu".equals(toiminto)) {
        s.kirjaudu(new String(request.getParameter("tunnus")), new String(request.getParameter("salasana")), session);
        request.getRequestDispatcher("tapahtumat.jsp").forward(request, response);
    } else if("lisaa_tapahtuma".equals(toiminto)) {
        t = s.luoUusiTapahtuma(new String(request.getParameter("nimi")), new String(request.getParameter("kuvaus")), 
        new String(request.getParameter("pvm")), new Integer(request.getParameter("toistuvuus")).intValue(), 
        new Boolean(request.getParameter("aktiivinen")).booleanValue(), ((Kayttaja)session.getAttribute("kayttaja")).getID());
        
        if(t.getKoodi() == 1)
            returnURL = "tapahtumat.jsp?viesti="+t.getViesti()+"&pida_arvot=1";
        else
            returnURL = "tapahtumat.jsp?viesti="+t.getViesti()+"&pida_arvot=0";
        
        request.getRequestDispatcher(returnURL).forward(request, response);
    } else if("poista_tapahtuma".equals(toiminto)) {
        t = s.poistaTapahtuma(Integer.parseInt(request.getParameter("id")));
        request.getRequestDispatcher("tapahtumat.jsp?viesti="+t.getViesti()).forward(request, response);
    } else if("päivitä_tapahtuma".equals(toiminto)) {
        t = s.päivitäTapahtuma(new Integer(request.getParameter("id")), new String(request.getParameter("nimi")), new String(request.getParameter("kuvaus")), 
        new String(request.getParameter("pvm")), new Integer(request.getParameter("toistuvuus")).intValue(), 
        new Boolean(request.getParameter("aktiivinen")).booleanValue());
        if(t.getKoodi() == 1)
            returnURL = "tapahtumat.jsp?viesti="+t.getViesti()+"&pida_arvot=1";
        else
            returnURL = "tapahtumat.jsp?viesti="+t.getViesti()+"&pida_arvot=0";
            
        request.getRequestDispatcher(returnURL).forward(request, response);
    }
%>
