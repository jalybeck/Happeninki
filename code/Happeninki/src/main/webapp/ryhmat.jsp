<%@ page contentType="text/html; UTF-8" pageEncoding="UTF-8" import="fi.tsoha.service.HappeninkiService, java.util.List, fi.tsoha.model.Osallistuja, fi.tsoha.model.Kayttaja, fi.tsoha.model.Ryhma"%>
<jsp:include page="/onkoKirjautunut.jsp"/>
<html>
    <head>
        <meta content="text/html"/>
        <meta http-equiv="X-UA-Compatible" content="IE=9" >
        <meta name="viewport" content="width=device-width initial-scale=1.0 maximum-scale=1.0 user-scalable=yes" />
        <meta http-equiv="refresh" content="<%=request.getSession(false).getMaxInactiveInterval()%>;url=<%=request.getContextPath()%>/kirjautuminen.jsp?aikakatkaisu=true" />
        
        <title>Happeninki</title>

        <link type="text/css" rel="stylesheet" href="css/jquery.mmenu.all.css" />
        <link rel="stylesheet" type="text/css" href="css/happeninki.css"/>
        
        <script type="text/javascript" src="js/jquery-1.11.3.min.js"></script> 
        <script type="text/javascript" src="js/jquery.mmenu.min.all.js"></script> 
    </head>
    <body>
        <div id="page">
            <div class="header">
                <a class="menu" href="#menu"></a>
                Ryhmät
                <jsp:include page="otsake.jsp"/>
            </div>
            <div class="content">
                <div><%=(request.getParameter("viesti") != null ? request.getParameter("viesti") : "")%></div>
                <h3>Uusi ryhmä</h3>
                <form method="POST" action="kontrolleri.jsp">
                <table border=0>
                    <tr>
                        <th>Nimi</th>
                        <th>Kuvaus</th>
                        
                    </tr>
                        <%
                            boolean pidaArvot = new Boolean(request.getParameter("pida_arvot"));
                            HappeninkiService s = new HappeninkiService();
                            String nimi = pidaArvot ? s.tarkistaParametri(request.getParameter("nimi")) : "";
                            String kuvaus = pidaArvot ? s.tarkistaParametri(request.getParameter("kuvaus")) : "";
                            
                        %>                            
                    <tr>
                        <td><input type="text" name="nimi"  value="<%=nimi%>"/></td>
                        <td><input type="text" name="kuvaus"  value="<%=kuvaus%>"/></td>
                    </tr>
                    <tr><td><input type="submit" value="Lisää"/><input id="toiminto" type="hidden" name="toiminto" value="lisaa_ryhma"/></td></tr>
                </table>
                </form>
                
                <h3>Omat ryhmät</h3>
                <table class="display">
                    <thead>
                        <tr>
                            <th>Nimi</th>
                            <th>Kuvaus</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        
                        List<Ryhma> ryhmat = s.listaaRyhmat(((Kayttaja)session.getAttribute("kayttaja")).getID());
                        for(Ryhma t : ryhmat) {
                            out.println("<tr>");
                            
                            out.print("<td id=\"nimi_"+t.getId()+"\">");out.print("<a href=\"jasenet.jsp?ryhma_id="+t.getId()+"\">"+t.getNimi());out.print("</a></td>");
                            out.print("<td id=\"kuvaus_"+t.getId()+"\">");out.print(t.getKuvaus());out.println("</td>");
                            out.println("<td align=\"center\"><a href=\"kontrolleri.jsp?id="+t.getId()+"&toiminto=poista_ryhma\" class=\"delete_icon\"></a></td>");  
                            out.println("</tr>");
                        }
                    %>
                    </tbody>                        
                </table>
            </div>

			<nav id="menu" width="100px">
                        
                         <jsp:include page="valikko.jsp"/>
 
   </nav>
        </div>


                
                <script type="text/javascript">
			$(function() {
				
                                
                                $("nav#menu").mmenu({
            extensions: ["theme-dark"]
         });
         
         
                                
			});
		</script>  
    </body>
</html>


