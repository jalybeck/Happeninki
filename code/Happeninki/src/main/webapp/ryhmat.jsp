<%@ page contentType="text/html; UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/onkoKirjautunut.jsp"/>
<html>
    <head>
        <meta content="text/html"/>
        <meta http-equiv="X-UA-Compatible" content="IE=9" >
        <meta name="viewport" content="width=device-width initial-scale=1.0 maximum-scale=1.0 user-scalable=yes" />
        <meta http-equiv="refresh" content="<%=request.getSession(false).getMaxInactiveInterval()%>;url=<%=request.getContextPath()%>/kirjautuminen.jsp?aikakatkaisu=true" />
        
        <title>Happeninki</title>

        <link rel="stylesheet" type="text/css" href="css/happeninki.css">
    </head>
    <body>
        <div id="page">
            <div class="header">
                Ryhmät
            </div>
            <div class="content">

                <h3>Uusi ryhmä</h3>
                <form method="GET">
                <table border=0>
                    <tr>
                        <th>Nimi</th>
                        <th>Kuvaus</th>
                        
                    </tr>
                    <tr>
                        <td><input type="text" name="nimi"/></td>
                        <td><input type="text" name="kuvaus"/></td>
                    </tr>
                    <tr><td><input type="submit" value="Lisää"/></td></tr>
                </table>
                </form>
                
                <h3>Omat ryhmät</h3>
                <table border=1>
                    <tr>
                        <th>Nimi</th>
                        <th>Kuvaus</th>
                        
                    </tr>
                    <tr>
                        <td><a href="jasenet.jsp?ryhma=Sählyporukka">Sählyporukka</a></td>
                        <td>Firman sählyporukka</td>
                    </tr>
                    <tr>
                        <td><a href="jasenet.jsp?ryhma=Kaverit">Kaverit</a></td>
                        <td>Kaverit</td>
                    </tr>
                </table>
            </div>

        </div>
    </body>
</html>


