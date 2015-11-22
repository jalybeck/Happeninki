<%@ page import="fi.tsoha.service.HappeninkiService, java.util.List, fi.tsoha.model.Tapahtuma, fi.tsoha.model.Kayttaja" contentType="text/html; UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/onkoKirjautunut.jsp"/>
<html>
    <head>
        <meta content="text/html"/>
        <meta http-equiv="X-UA-Compatible" content="IE=9" >
        <meta name="viewport" content="width=device-width initial-scale=1.0 maximum-scale=1.0 user-scalable=yes" />
        <meta http-equiv="refresh" content="<%=request.getSession(false).getMaxInactiveInterval()%>;url=<%=request.getContextPath()%>/kirjautuminen.jsp?aikakatkaisu=true" />
        
        <title>Happeninki</title>

        <link rel="stylesheet" type="text/css" href="css/happeninki.css"/>
        <link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.4/jquery-ui.css"/>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/s/dt/jqc-1.11.3,dt-1.10.10,b-1.1.0,b-colvis-1.1.0/datatables.min.css"/>
        <script type="text/javascript" src="js/jquery-1.11.3.min.js"></script> 
        <script type="text/javascript" src="js/jquery-ui-1.11.4/jquery-ui.js"></script> 
        <script type="text/javascript" src="https://cdn.datatables.net/s/dt/jqc-1.11.3,dt-1.10.10,b-1.1.0,b-colvis-1.1.0/datatables.min.js"></script>
        <script type="text/javascript">
            var toggle = 0;
            var old;
            function getId(idf) {
                var e = document.getElementById(idf);
                return e;
            }
            
            function updateFields(idf, row) {
                if(typeof old === 'undefined') {
                    old = row;
                }
                if(old != row) {
                    old.style.backgroundColor = '';
                    toggle = 0;
                }
                toggle = !toggle;
                old = row;
                if(toggle) {
                    row.style.backgroundColor  = 'LimeGreen';
                    getId('toiminto').value = 'päivitä_tapahtuma';
                    getId('nappi').value = 'Tallenna';
                    getId('id').value = idf;
                    getId('nimi').value = getId('nimi_'.concat(idf)).textContent;
                    getId('kuvaus').value = getId('kuvaus_'.concat(idf)).textContent;
                    getId('pvm').value = getId('pvm_'.concat(idf)).textContent;
                    getId('toistuvuus').value = getId('toistuvuus_'.concat(idf)).textContent;
                    getId('aktiivinen').value = getId('aktiivinen_'.concat(idf)).textContent;
                } else {
                    row.style.backgroundColor  = '';
                    getId('toiminto').value = 'lisaa_tapahtuma';
                    getId('nappi').value = 'Lisää';
                    getId('id').value = '';
                    getId('nimi').value = '';
                    getId('kuvaus').value = '';
                    getId('pvm').value = '';
                    getId('toistuvuus').value = '';
                    getId('aktiivinen').value = '';                    
                }
            }
        </script>
    </head>
    <body>
        <div id="page">
            <div class="header">
                Tapahtumat
            </div>
            <div class="content">
                <div><%=(request.getParameter("viesti") != null ? request.getParameter("viesti") : "")%></div>
                <h3>Uusi tapahtuma</h3>
                <form method="POST" action="kontrolleri.jsp">
                <table border=0>
                    <tr>
                        <th>Nimi</th>
                        <th>Kuvaus</th>
                        <th>Ajankohta</th>
                        <th>Toistuvuus päivissä</th>
                        <th>Aktiivinen</th>
                    </tr>
                    <tr>
                        <%
                            boolean pidaArvot = new Boolean(request.getParameter("pida_arvot"));
                            HappeninkiService s = new HappeninkiService();
                            String nimi = pidaArvot ? s.tarkistaParametri(request.getParameter("nimi")) : "";
                            String kuvaus = pidaArvot ? s.tarkistaParametri(request.getParameter("kuvaus")) : "";
                            String pvm = pidaArvot ? s.tarkistaParametri(request.getParameter("pvm")) : "";
                            String toistuvuus = pidaArvot ? s.tarkistaParametri(request.getParameter("toistuvuus")) : "";   
                            String aktiivinen = pidaArvot ? s.tarkistaParametri(request.getParameter("aktiivinen")) : "";
                        %>
                        <td><input id="nimi" type="text" name="nimi" value="<%=nimi%>"/></td>
                        <td><input id="kuvaus" type="text" name="kuvaus" value="<%=kuvaus%>"/></td>
                        <td><input id="pvm" type="text" name="pvm" value="<%=pvm%>"/></td>
                        <td><input id="toistuvuus" type="text" name="toistuvuus" value="<%=toistuvuus%>"/></td>
                        <td><input id="aktiivinen" type="text" name="aktiivinen" value="<%=aktiivinen%>"/></td>
                    </tr>
                    <tr><td><input id="nappi" type="submit" value="Lisää"/><input id="toiminto" type="hidden" name="toiminto" value="lisaa_tapahtuma"/><input id="id" type="hidden" name="id" /></td></tr>
                </table>
                </form>
                
                <h3>Omat tapahtumat</h3>
                <table class="display">
                    <thead>
                        <tr>
                            <th>Nimi</th>
                            <th>Kuvaus</th>
                            <th>Ajankohta</th>
                            <th>Toistuvuus päivissä</th>
                            <th>Aktiivinen</th>
                            <th>Poista</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        
                        List<Tapahtuma> lista = s.listaaTapahtumat(((Kayttaja)session.getAttribute("kayttaja")).getID());
                        for(Tapahtuma t : lista) {
                            out.println("<tr onclick=\"updateFields('"+t.getId()+"',this);\">");
                            
                            out.print("<td id=\"nimi_"+t.getId()+"\">");out.print(t.getNimi());out.print("</td>");
                            out.print("<td id=\"kuvaus_"+t.getId()+"\">");out.print(t.getKuvaus());out.println("</td>");                               
                            out.print("<td id=\"pvm_"+t.getId()+"\">");out.print(t.getPvm());out.println("</td>"); 
                            out.print("<td id=\"toistuvuus_"+t.getId()+"\">");out.print(t.getToistuvuus());out.println("</td>");  
                            out.print("<td id=\"aktiivinen_"+t.getId()+"\">");out.print(t.isVoimassa());out.println("</td>");  
                            out.println("<td align=\"center\"><a href=\"kontrolleri.jsp?id="+t.getId()+"&toiminto=poista_tapahtuma"+"\" class=\"delete_icon\"></a></td>");  
                            out.println("</tr>");
                        }
                    %>
                    </tbody>
                </table>

            </div>

        </div>
    </body>
</html>


