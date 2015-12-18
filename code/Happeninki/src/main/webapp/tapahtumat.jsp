<%@ page import="fi.tsoha.service.HappeninkiService, java.util.List, fi.tsoha.model.Tapahtuma, fi.tsoha.model.Kayttaja" contentType="text/html; UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/onkoKirjautunut.jsp"/>
<html>
    <head>
        <meta content="text/html"/>
        <meta http-equiv="X-UA-Compatible" content="IE=9" >
        <meta name="viewport" content="width=device-width initial-scale=1.0 maximum-scale=1.0 user-scalable=yes" />
        <meta http-equiv="refresh" content="<%=request.getSession(false).getMaxInactiveInterval()%>;url=<%=request.getContextPath()%>/kirjautuminen.jsp?aikakatkaisu=true" />
        
        <title>Happeninki</title>

        <link type="text/css" rel="stylesheet" href="css/jquery.mmenu.all.css" />
        <link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.4/jquery-ui.css"/>
        <link rel="stylesheet" type="text/css" href="css/jquery-ui-timepicker-addon.css"/>
        <link rel="stylesheet" type="text/css" href="css/happeninki.css"/>
        
        <script type="text/javascript" src="js/jquery-1.11.3.min.js"></script> 
        <script type="text/javascript" src="js/jquery-ui-1.11.4/jquery-ui.js"></script> 
        <script type="text/javascript" src="js/jquery-ui-timepicker-addon.js"></script>        
        <script type="text/javascript" src="js/jquery.validate.js"></script> 
        <script type="text/javascript" src="js/additional-methods.js"></script>
        <script type="text/javascript" src="js/jquery.mmenu.min.all.js"></script>        
        
        <script type="text/javascript"> 
          $(function() {
            $( "#pvm" ).datetimepicker({
                controlType: 'select',
                oneLine: true,
                timeFormat: 'HH:mm',
                dateFormat: 'dd.mm.yy'
            });
          });        
        /*  $(function() {
            $( "a[id=osallistujat]" )
              .button({
               text: false,
               icons: {
                  primary: "ui-icon-circle-triangle-e"
               }});
          });*/
          jQuery(function ($) {
             $("#tapahtumaForm").validate({
                    rules: {
                            nimi: {
                                    required: true
                            },
                            pvm: {
                                    required: true,
                                    dateTimeFIN: true
                            },
                            toistuvuus: {
                                    required: true,
                                    maxlength: 4,
                                    digits: true
                            }
    
                    },
                    messages: {
                            nimi: "Syötä tapahtuman nimi!",
                            pvm: "Syötä päivämäärä muodossa: DD.MM.YYYY HH24:MI",
                            toistuvuus: "Syötä toistuvuus päivissä!"
                    }
            });
          });
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
            
            function poistaTapahtuma() {
                return confirm('Tapahtuman poistaminen poistaa kaikki osallistujat!\nOletko varma, että haluat jatkaa?');
            }
        </script>
    </head>
    <body>
        <div id="page">
            <div class="header">
                <a class="menu" href="#menu"></a>
                Tapahtumat
                <jsp:include page="otsake.jsp"/>
            </div>
            <div class="content">
                <div><%=(request.getParameter("viesti") != null ? request.getParameter("viesti") : "")%></div>
                <h3>Uusi tapahtuma</h3>
                <form id="tapahtumaForm" method="POST" action="kontrolleri.jsp">
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
                        <td><input id="nimi" type="text" name="nimi" value="<%=nimi%>" /></td>
                        <td><input id="kuvaus" type="text" name="kuvaus" value="<%=kuvaus%>" /></td>
                        <td><input id="pvm" type="text" name="pvm" value="<%=pvm%>" /></td>
                        <td><input id="toistuvuus" type="text" name="toistuvuus" value="<%=toistuvuus%>" /></td>
                        <td>                            
                            <select id="aktiivinen" name="aktiivinen">
                                <option value="true">Kyllä</option>
                                <option value="false">Ei</option>
                            </select>
                            <!--<input id="aktiivinen" type="text" name="aktiivinen" value="<%=aktiivinen%>" /> -->
                        </td>
                    </tr>
                    <tr><td><input id="nappi" type="submit" value="Lisää"  /><input id="toiminto" type="hidden" name="toiminto" value="lisaa_tapahtuma"/><input id="id" type="hidden" name="id" /></td></tr>
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
                            <th>&nbsp;</th>
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
                            out.println("<td align=\"center\"><a href=\"kontrolleri.jsp?id="+t.getId()+"&toiminto=poista_tapahtuma"+"\" class=\"delete_icon\" onclick=\"return poistaTapahtuma();\"></a></td>");  
                            out.println("<td align=\"center\"><a id=\"osallistujat\" href=\"osallistujat.jsp?tapahtuma_id="+t.getId()+"&tapahtuma="+t.getNimi()+"\">Osallistujat</a></td>");  
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


