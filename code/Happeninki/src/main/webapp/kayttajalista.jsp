<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="fi.tsoha.service.HappeninkiService, java.util.List, fi.tsoha.model.Kayttaja" contentType="text/html; UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta content="text/html"/>
        <meta http-equiv="X-UA-Compatible" content="IE=9" >
        <meta name="viewport" content="width=device-width initial-scale=1.0 maximum-scale=1.0 user-scalable=yes" />

        <title>Happeninki</title>

        <link rel="stylesheet" type="text/css" href="../resources/css/happeninki.css">
    </head>
    <body>
        <div id="page">
            <div class="header">
                Happeninki
            </div>
            <div class="content">
<!--
                <h3>Käyttäjät</h3>
                <form method="GET">
                <table border=0>
                    <tr>
                        <th>Id</th>
                        <th>Nimi</th>
                        <th>Tunnus</th>
                        <th>Sähköposti</th>
                        
                    </tr>
                    <tr>
                        <td><input type="text" name="nimi"/></td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr><td><input type="submit" value="Hae"/></td></tr>
                </table>
                </form> 
-->
                
                <h3>Käyttäjät</h3>
                <table border=1>
                    <tr>
                        <th>Id</th>
                        <th>Nimi</th>
                        <th>Tunnus</th>
                        <th>Sähköposti</th>
                    </tr>
                    <%
                        HappeninkiService s = new HappeninkiService();
                        List<Kayttaja> lista = s.listaaKayttajat();
                        for(Kayttaja k : lista) {
                            out.println("<tr>");
                            
                            out.print("<td>");out.print(k.getID());out.print("</td>");
                            out.print("<td>");out.print(k.getNimi());out.println("</td>");                               
                            out.print("<td>");out.print(k.getTunnus());out.println("</td>"); 
                            out.print("<td>");out.print(k.getSahkoposti());out.println("</td>");  
                           
                            out.println("</tr>");
                        }
                    %>
                </table>
            </div>

        </div>
    </body>
</html>