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
                Tapahtumat
            </div>
            <div class="content">

                <h3>Uusi tapahtuma</h3>
                <form method="GET">
                <table border=0>
                    <tr>
                        <th>Nimi</th>
                        <th>Kuvaus</th>
                        <th>Ajankohta</th>
                        <th>Toistuvuus päivissä</th>
                        <th>Aktiivinen</th>
                        
                    </tr>
                    <tr>
                        <td><input type="text" name="nimi"/></td>
                        <td><input type="text" name="kuvaus"/></td>
                        <td><input type="text" name="pvm"/></td>
                        <td><input type="text" name="toistuvuus"/></td>
                        <td><input type="text" name="aktiivinen"/></td>
                    </tr>
                    <tr><td><input type="submit" value="Lisää"/></td></tr>
                </table>
                </form>
                
                <h3>Omat tapahtumat</h3>
                <table border=1>
                    <tr>
                        <th>Nimi</th>
                        <th>Kuvaus</th>
                        <th>Ajankohta</th>
                        <th>Toistuvuus päivissä</th>
                        <th>Aktiivinen</th>
                        
                    </tr>
                    <tr>
                        <td><a href="osallistujat.jsp?tapahtuma=Sähly">Sähly</a></td>
                        <td>Firma porukan sähly joka keskiviikko</td>
                        <td>11.11.2015 klo 07:30</td>
                        <td>7</td>
                        <td>Kyllä</td>
                    </tr>
                    <tr>
                        <td><a href="osallistujat.jsp?tapahtuma=Konsertti">Konsertti</a></td>
                        <td>Bändi hartwall areenalla</td>
                        <td>28.11.2015 klo 19:30</td>
                        <td>0</td>
                        <td>Kyllä</td>
                    </tr>
                </table>
            </div>

        </div>
    </body>
</html>


