<%@ page contentType="text/html; UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=9" >
        <meta name="viewport" content="width=device-width initial-scale=1.0 maximum-scale=1.0 user-scalable=yes" />

        <title>Happeninki</title>

        <link rel="stylesheet" type="text/css" href="../resources/css/happeninki.css">
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


