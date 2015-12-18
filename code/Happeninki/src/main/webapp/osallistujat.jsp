<%@ page contentType="text/html; UTF-8" pageEncoding="UTF-8" import="fi.tsoha.service.HappeninkiService, java.util.List, fi.tsoha.model.Osallistuja, fi.tsoha.model.Kayttaja, fi.tsoha.model.Ryhma"%>
<jsp:include page="/onkoKirjautunut.jsp"/>
<html>
    <head>
        <meta content="text/html"/>
        <meta http-equiv="X-UA-Compatible" content="IE=9" >
        <meta name="viewport" content="width=device-width initial-scale=1.0 maximum-scale=1.0 user-scalable=yes" />
        <meta http-equiv="refresh" content="<%=request.getSession(false).getMaxInactiveInterval()%>;url=<%=request.getContextPath()%>/kirjautuminen.jsp?aikakatkaisu=true" />

        <title>Happeninki</title>

        <link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.4/jquery-ui.css"/>
        <link type="text/css" rel="stylesheet" href="css/jquery.mmenu.all.css" />
        <script type="text/javascript" src="js/jquery-1.11.3.min.js"></script> 
        <script type="text/javascript" src="js/jquery-ui-1.11.4/jquery-ui.js"></script> 
        <script type="text/javascript" src="js/jquery.mmenu.min.all.js"></script>         
        <link rel="stylesheet" type="text/css" href="css/happeninki.css"/>  
        <script type="javascript">
            
            function checkDisabled() {

                var elem = document.getElementById("ryhma");
                if(elem.options[elem.selectedIndex].value != -1) {
                    document.getElementById("nimi").disabled = false;
                    document.getElementById("sahkoposti").disabled = false;
                } else {
                    document.getElementById("nimi").disabled = true;
                    document.getElementById("sahkoposti").disabled = true;
                }
            }           
        </script>
    </head>
    <body>
        <div id="page">
            <div class="header">
                <a class="menu" href="#menu"></a>
                Osallistujat tapahtumalle - <%=request.getParameter("tapahtuma")%>
                <jsp:include page="otsake.jsp"/>
            </div>
            <div class="content">
                <div><%=(request.getParameter("viesti") != null ? request.getParameter("viesti") : "")%></div>
                <h3>Uusi Osallistuja</h3>
                <form method="POST" action="kontrolleri.jsp">
                <table border=0>
                    <tr>
                        <th>Nimi</th>
                        <th>Sähköposti</th>
                        <th>Ryhmä</th>
                        
                    </tr>
                    <tr>
                        <%
                            boolean pidaArvot = new Boolean(request.getParameter("pida_arvot"));
                            HappeninkiService s = new HappeninkiService();
                            String nimi = pidaArvot ? s.tarkistaParametri(request.getParameter("nimi")) : "";
                            String sahkoposti = pidaArvot ? s.tarkistaParametri(request.getParameter("sahkoposti")) : "";
                            String ryhma = pidaArvot ? s.tarkistaParametri(request.getParameter("ryhma")) : "";
                            
                        %>                    
                        <td><input id="nimi" type="text" name="nimi" value="<%=nimi%>"/></td>
                        <td><input id="sahkoposti" type="text" name="sahkoposti" value="<%=sahkoposti%>"/></td>
                        <td> 
                            <select id="ryhma" name="ryhma" onchange="checkDisabled();">
                                <option value="-1">-Ei ryhmää-</option>
                                <%
                                    List<Ryhma> ryhmat = s.listaaRyhmat(((Kayttaja)session.getAttribute("kayttaja")).getID());
                                    for(Ryhma r : ryhmat) {
                                        out.println("<option value=\""+r.getId()+"\">"+r.getNimi()+"</option>");
                                    }
                                %>
                            </select> 
                        </td>
                    </tr>
                    <tr><td><input id="nappi" type="submit" value="Lisää"/><input id="toiminto" type="hidden" name="toiminto" value="lisaa_osallistuja"/><input type="hidden" name="tapahtuma_id" value="<%=request.getParameter("tapahtuma_id")%>"/><input id="id" type="hidden" name="id"/><input id="tap" type="hidden" name="tapahtuma" value="<%=request.getParameter("tapahtuma")%>"/></td></tr>
                </table>
                </form>
                
                <h3>Osallistujat</h3>
                <table class="display">
                    <thead>
                        <tr>
                            <th>Nimi</th>
                            <th>Sähköposti</th>
                            <th>Ryhmä</th>
                            <th>Osallistuu?</th>
                            <th>Poista</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        
                        List<Osallistuja> lista = s.listaaOsallistujat(Integer.parseInt(request.getParameter("tapahtuma_id")));
                        for(Osallistuja t : lista) {
                            out.println("<tr>");
                            
                            out.print("<td id=\"nimi_"+t.getId()+"\">");out.print(t.getNimi());out.print("</td>");
                            out.print("<td id=\"sahkoposti_"+t.getId()+"\">");out.print(t.getSahkoposti());out.println("</td>");                               
                            out.print("<td id=\"ryhma_"+t.getId()+"\">");out.print(s.haeRyhma(t.getRyhmaId()).getNimi());out.println("</td>"); 
                            out.print("<td id=\"osallistuu_"+t.getId()+"\">");out.print(t.isOsallistuu());out.println("</td>");  
                            out.println("<td align=\"center\"><a href=\"kontrolleri.jsp?id="+t.getId()+"&toiminto=poista_osallistuja&tapahtuma_id="+request.getParameter("tapahtuma_id")+"&tapahtuma="+request.getParameter("tapahtuma")+"\" class=\"delete_icon\"></a></td>");  
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


