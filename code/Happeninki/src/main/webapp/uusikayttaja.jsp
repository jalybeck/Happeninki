<%@ page import="fi.tsoha.model.*" contentType="text/html; UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta content="text/html"/>
        <meta http-equiv="X-UA-Compatible" content="IE=9" >
        <meta name="viewport" content="width=device-width initial-scale=1.0 maximum-scale=1.0 user-scalable=yes" />
        <meta http-equiv="refresh" content="<%=request.getSession(false).getMaxInactiveInterval()%>;url=<%=request.getContextPath()%>/kirjautuminen.jsp?aikakatkaisu=true" />
        
        <title>Happeninki</title>

        <link rel="stylesheet" type="text/css" href="css/happeninki.css">
        <script language="Javascript">
            function validate() {
                var nimi       = document.getElementById("nimi").value;
                var sahkoposti = document.getElementById("sahkoposti").value;
                var salasana   = document.getElementById("salasana").value;
                var salasana_uudelleen = document.getElementById("salasana_uudelleen").value;
                if(nimi==null || nimi=="",sahkoposti==null || sahkoposti=="",
                   salasana==null || salasana=="",salasana_uudelleen == null || salasana_uudelleen=="") {
                    alert("Täytä kaikki kentät!");
                    return false;
                }
                
                if(salasana != salasana_uudelleen) {
                    alert("Tarkista, että salasanat täsmäävät!");
                    return false;
                }
            }
        </script>
    </head>
    <body>
        <div id="page">
            <div class="header">
                Happeninki
            </div>
            <div class="content">
                <h3 style="color: red"><%=(request.getParameter("viesti") != null ? request.getParameter("viesti") : "")%></h3>
                <h2>Uusi käyttäjä</h2>
                <form method="POST" action="kontrolleri.jsp" onsubmit="return validate()">
                <table border=0>
                <tr><td>Nimi:</td><td><input id="nimi" type="text" name="nimi"/></td></tr>
                <tr><td>Sähköposti:</td><td><input id="sahkoposti" type="text" name="sahkoposti"/></td></tr>
                <tr><td>Käyttäjätunnus:</td><td><input id="tunnus" type="text" name="tunnus"/></td></tr>
                <tr><td>Salasana:</td><td><input id="salasana" type="password" name="salasana"/></td></tr>
                <tr><td>Salasana uudelleen:</td><td><input id="salasana_uudelleen" type="password" name="salasana_uudelleen"/></td></tr>
                <tr><td colspan=2 align=right><input type=submit value="Rekisteröidy"/><input type="hidden" name="toiminto" value="luo_kayttaja"/></td></tr>
                </table>
                </form>
            </div>

        </div>
    </body>
</html>


