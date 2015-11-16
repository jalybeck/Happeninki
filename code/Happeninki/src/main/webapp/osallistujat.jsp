<%@ page contentType="text/html; UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=9" >
        <meta name="viewport" content="width=device-width initial-scale=1.0 maximum-scale=1.0 user-scalable=yes" />

        <title>Happeninki</title>

        <link rel="stylesheet" type="text/css" href="../resources/css/happeninki.css">
        <script type="javascript">
            /*function getReqParamValue(param){
                if(param=(new RegExp('[?&]'+encodeURIComponent(param)+'=([^&]*)')).exec(location.search))
                    return decodeURIComponent(param[1]);
            }*/
            
            function checkDisabled() {
                alert('test');
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
                Osallistujat tapahtumalle - <script>document.write(getReqParamValue('tapahtuma'));</script>
            </div>
            <div class="content">

                <h3>Uusi Osallistuja</h3>
                <form method="GET">
                <table border=0>
                    <tr>
                        <th>Nimi</th>
                        <th>Sähköposti</th>
                        <th>Ryhmä</th>
                        
                    </tr>
                    <tr>
                        <td><input id="nimi" type="text" name="nimi"/></td>
                        <td><input id="sahkoposti" type="text" name="sahkoposti"/></td>
                        <td> 
                            <select id="ryhma" onchange="checkDisabled();">
                                <option value="-1">&nbsp;</option>
                                <option value="1">Sählyporukka</option>
                                <option value="2">Kaverit</option>
                            </select> 
                        </td>
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
                        <td>Teemu</td>
                        <td>teemu@test.com</td>
                        <td>Kyllä</td>
                    </tr>
                    <tr>
                        <td>Pentti</td>
                        <td>pentti@test.com</td>
                        <td>Ei</td>
                    </tr>
                </table>
            </div>

        </div>
    </body>
</html>


