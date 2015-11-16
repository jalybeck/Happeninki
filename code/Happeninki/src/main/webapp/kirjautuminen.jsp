<%@ page contentType="text/html; UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta charset="utf-8" />
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

                <h2>Kirjautuminen</h2>
                <form method="GET" action="j_security_check">
                <table border=0>
                <tr><td>K&auml;ytt&auml;j&auml;tunnus:</td><td><input type="text" name="j_username"/></td></tr>
                <tr><td>Salasana:</td><td><input type="password" name="j_password"/></td></tr>
                <tr><td colspan=2 align=right><input type=submit value="Kirjaudu"/></td></tr>
                </table>
                </form>
                <a href="uusikayttaja.jsp">Uusi käyttäjä?</a>
            </div>

        </div>
    </body>
</html>

