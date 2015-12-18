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
    } else if("kirjaudu_ulos".equals(toiminto)) {
        session.invalidate();
        request.getRequestDispatcher("kirjautuminen.jsp").forward(request, response);
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
    } else if("lisaa_osallistuja".equals(toiminto)) {
        t = s.luoUusiOsallistuja(new String(request.getParameter("nimi")), new String(request.getParameter("sahkoposti")), 
        false, new Integer(request.getParameter("ryhma")).intValue(), new Integer(request.getParameter("tapahtuma_id")).intValue());
        
        if(t.getKoodi() == 1)
            returnURL = "osallistujat.jsp?viesti="+t.getViesti()+"&pida_arvot=1";
        else
            returnURL = "osallistujat.jsp?viesti="+t.getViesti()+"&pida_arvot=0";
        
        request.getRequestDispatcher(returnURL).forward(request, response);
    } else if("poista_osallistuja".equals(toiminto)) {
        t = s.poistaOsallistuja(Integer.parseInt(request.getParameter("id")));
        request.getRequestDispatcher("osallistujat.jsp?viesti="+t.getViesti()).forward(request, response);
    } else if("päivitä_osallistuja".equals(toiminto)) {
        t = s.päivitäOsallistuja(new Integer(request.getParameter("id")).intValue(), new String(request.getParameter("nimi")),
        new String(request.getParameter("sahkoposti")), new Integer(request.getParameter("ryhma")).intValue(), 
        new Integer(request.getParameter("tapahtuma_id")).intValue());
        
        if(t.getKoodi() == 1)
            returnURL = "osallistujat.jsp?viesti="+t.getViesti()+"&pida_arvot=1";
        else
            returnURL = "osallistujat.jsp?viesti="+t.getViesti()+"&pida_arvot=0";
            
        request.getRequestDispatcher(returnURL).forward(request, response);
    } else if("lisaa_ryhma".equals(toiminto)) {
        t = s.luoUusiRyhma(new String(request.getParameter("nimi")), new String(request.getParameter("kuvaus")), 
        ((Kayttaja)session.getAttribute("kayttaja")).getID());
        
        if(t.getKoodi() == 1)
            returnURL = "ryhmat.jsp?viesti="+t.getViesti()+"&pida_arvot=1";
        else
            returnURL = "ryhmat.jsp?viesti="+t.getViesti()+"&pida_arvot=0";
        
        request.getRequestDispatcher(returnURL).forward(request, response);    
    } else if("poista_ryhma".equals(toiminto)) {
        t = s.poistaRyhma(Integer.parseInt(request.getParameter("id")));
        request.getRequestDispatcher("ryhmat.jsp?viesti="+t.getViesti()).forward(request, response);
    }
%>
<jsp:include page="/onkoKirjautunut.jsp"/>