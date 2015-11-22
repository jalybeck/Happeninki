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
        <script type="javascript">
            function getReqParamValue(param){
                if(param=(new RegExp('[?&]'+encodeURIComponent(param)+'=([^&]*)')).exec(location.search))
                    return decodeURIComponent(param[1]);
            }
        </script>
    </head>
    <body>
        <div id="page">
            <div class="header">
                Jäsenet ryhmälle - <script>document.write(getReqParamValue('tapahtuma'));</script>
            </div>
            <div class="content">

                <h3>Uusi jäsen</h3>
                <form method="GET">
                <table border=0>
                    <tr>
                        <th>Nimi</th>
                        <th>Kuvaus</th>
                        <th>Sähköposti</th>
                        
                    </tr>
                    <tr>
                        <td><input type="text" name="nimi"/></td>
                        <td><input type="text" name="kuvaus"/></td>
                        <td><input type="text" name="sahkoposti"/></td>
                    </tr>
                    <tr><td><input type="submit" value="Lisää"/></td></tr>
                </table>
                </form>
                
                <h3>Osallistujat</h3>
                <table border=1>
                    <tr>
                        <th>Nimi</th>
                        <th>Sähköposti</th>
                        <th>Osallistuu?</th>
                        
                    </tr>
                    <tr>
                        <td>Janne</td>
                        <td>Frendi</td>
                        <td>janne@test.com</td>

                    </tr>
                    <tr>
                        <td>Kari</td>
                        <td></td>
                        <td>kari@test.com</td>

                    </tr>
                </table>
            </div>

        </div>
    </body>
</html>


