package fi.tsoha.dao;

import fi.tsoha.model.Kayttaja;

import fi.tsoha.model.Osallistuja;
import fi.tsoha.model.Tapahtuma;

import java.net.URI;
import java.net.URISyntaxException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.sql.Statement;

import java.sql.Timestamp;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

public class HappeninkiDAO {
    public HappeninkiDAO() {
        super();
    }
    
    private Connection getConnection() throws URISyntaxException, SQLException {
       URI dbUri = new URI(System.getenv("DATABASE_URL"));

       String username = dbUri.getUserInfo().split(":")[0];
       String password = dbUri.getUserInfo().split(":")[1];
       String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath();

       return DriverManager.getConnection(dbUrl, username, password);
    }
    
    public void tallennaKayttaja(Kayttaja k) throws SQLException, URISyntaxException {
        String insertTableSQL = "INSERT INTO KAYTTAJA"
                              + "(id, nimi, tunnus, salasana, sahkoposti,muokkaus_pvm) VALUES"
                              + "(nextval('kayttaja_id_seq'),?,?,?,?,now())";
        
                
        try(Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(insertTableSQL)) {
            conn.setAutoCommit(false);

            stmt.setString(1,k.getNimi());
            stmt.setString(2,k.getTunnus());
            stmt.setString(3,k.getSalasana());
            stmt.setString(4,k.getSahkoposti());
            
            stmt.executeUpdate();
            conn.commit();
        } catch (SQLException e) {
            throw new SQLException("Virhe käyttäjän tallenuksessa! Virhe: "+e.getMessage());
        } catch (URISyntaxException e) {
            throw new SQLException("Tietokantaan ei saatu yhteyttä! Virhe: "+e.getMessage());
        }
    }
    
    public List<Kayttaja> kayttajaLista() throws SQLException {
        String kayttajatSQL =   "SELECT id, nimi, tunnus, sahkoposti,muokkaus_pvm " +
                                "FROM   kayttaja " +
                                "ORDER  BY id";
        
        List<Kayttaja> kayttajat = new ArrayList<Kayttaja>();
                
        try(Connection conn = getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(kayttajatSQL)) {
            conn.setAutoCommit(false);
            
            while(rs.next()) {
                Kayttaja k = new Kayttaja();
                k.setID(rs.getInt("id"));
                k.setNimi(rs.getString("nimi"));
                k.setTunnus(rs.getString("tunnus"));
                k.setSahkoposti(rs.getString("sahkoposti"));
                kayttajat.add(k);
            }
        } catch (SQLException e) {
            throw new SQLException("Virhe käyttäjän tallenuksessa! Virhe: "+e.getMessage());
        } catch (URISyntaxException e) {
            throw new SQLException("Tietokantaan ei saatu yhteyttä! Virhe: "+e.getMessage());
        }
        
        return kayttajat;
    }
    
    public Kayttaja haeKayttaja(int id) throws SQLException, URISyntaxException {
        String kayttajaSQL =   "SELECT id, nimi, tunnus, sahkoposti,muokkaus_pvm " +
                                "FROM   kayttaja " +
                                "WHERE  id = ? " +
                                "ORDER  BY id";
        
        Kayttaja kayttaja = new Kayttaja();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try(Connection conn = getConnection()) {
            conn.setAutoCommit(false);
            pstmt = conn.prepareStatement(kayttajaSQL);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                kayttaja.setID(rs.getInt("id"));
                kayttaja.setNimi(rs.getString("nimi"));
                kayttaja.setTunnus(rs.getString("tunnus"));
                kayttaja.setSahkoposti(rs.getString("sahkoposti"));
            }
            
        } catch (SQLException e) {
            throw new SQLException("Virhe käyttäjän tallenuksessa! Virhe: "+e.getMessage());
        } catch (URISyntaxException e) {
            throw new SQLException("Tietokantaan ei saatu yhteyttä! Virhe: "+e.getMessage());
        } finally {
            if(rs != null) rs.close();
            if(pstmt != null) pstmt.close();
        }
        
        return kayttaja;
    }
    
    public Kayttaja haeKayttaja(String tunnus, String salasana) throws SQLException, URISyntaxException {
        String kayttajaSQL =   "SELECT  id, nimi, tunnus, sahkoposti, muokkaus_pvm " +
                                "FROM   kayttaja " +
                                "WHERE  tunnus = ? " +
                                "AND    salasana = ? ";
        
        Kayttaja kayttaja = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try(Connection conn = getConnection()) {
            conn.setAutoCommit(false);
            pstmt = conn.prepareStatement(kayttajaSQL);
            pstmt.setString(1, tunnus);
            pstmt.setString(2, salasana);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                kayttaja = new Kayttaja();
                kayttaja.setID(rs.getInt("id"));
                kayttaja.setNimi(rs.getString("nimi"));
                kayttaja.setTunnus(rs.getString("tunnus"));
                kayttaja.setSahkoposti(rs.getString("sahkoposti"));
            }
            
        } catch (SQLException e) {
            throw new SQLException("Virhe käyttäjän tallenuksessa! Virhe: "+e.getMessage());
        } catch (URISyntaxException e) {
            throw new SQLException("Tietokantaan ei saatu yhteyttä! Virhe: "+e.getMessage());
        } finally {
            if(rs != null) rs.close();
            if(pstmt != null) pstmt.close();
        }
        
        return kayttaja;
    }

    private Timestamp konvertoiPäiväys(String pvm) {
        String []pvmTaulu = pvm.split(Pattern.quote(" "));
        String aika = pvmTaulu[1]+":00";
        pvmTaulu = pvmTaulu[0].split(Pattern.quote("."));
        String pvmTimestamp = pvmTaulu[2]+"-"+pvmTaulu[1]+"-"+pvmTaulu[0]+" "+aika;
        
        return Timestamp.valueOf(pvmTimestamp);
        
    }

    public void tallennaTapahtuma(Tapahtuma t) throws SQLException, URISyntaxException {
        String insertTableSQL = "INSERT INTO TAPAHTUMA"
                              + "(id, nimi, kuvaus, pvm, toistuvuus, voimassa, muokkaus_pvm, kayttaja_id) VALUES"
                              + "(nextval('tapahtuma_id_seq'),?,?,?,?,?,now(),?)";
                    
        try(Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(insertTableSQL)) {
            conn.setAutoCommit(false);
            
            stmt.setString(1,t.getNimi());
            stmt.setString(2,t.getKuvaus());
            stmt.setTimestamp(3,konvertoiPäiväys(t.getPvm()));
            stmt.setInt(4,t.getToistuvuus());            
            stmt.setBoolean(5,t.isVoimassa());
            stmt.setInt(6,t.getKayttajaId());
            
            stmt.executeUpdate();
            conn.commit();
        } catch (SQLException e) {
            throw new SQLException("Virhe tapahtuman tallennuksessa! Virhe: "+e.getMessage());
        } catch (URISyntaxException e) {
            throw new SQLException("Tietokantaan ei saatu yhteyttä! Virhe: "+e.getMessage());
        }
    }
    
    public void päivitäTapahtuma(Tapahtuma t) throws SQLException, URISyntaxException {
        String insertTableSQL = "UPDATE TAPAHTUMA SET nimi = ?, kuvaus = ?, pvm = ?, toistuvuus = ?, voimassa = ? "
                              + "WHERE id = ?";
                    
        try(Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(insertTableSQL)) {
            conn.setAutoCommit(false);
            
            stmt.setString(1,t.getNimi());
            stmt.setString(2,t.getKuvaus());
            stmt.setTimestamp(3,konvertoiPäiväys(t.getPvm()));
            stmt.setInt(4,t.getToistuvuus());            
            stmt.setBoolean(5,t.isVoimassa());
            stmt.setInt(6,t.getId());
            
            stmt.executeUpdate();
            conn.commit();
        } catch (SQLException e) {
            throw new SQLException("Virhe tapahtuman tallennuksessa! Virhe: "+e.getMessage());
        } catch (URISyntaxException e) {
            throw new SQLException("Tietokantaan ei saatu yhteyttä! Virhe: "+e.getMessage());
        }
    }
    
    public void poistaTapahtuma(int id) throws SQLException, URISyntaxException {
        String deleteSQL      = "DELETE FROM TAPAHTUMA "
                              + "WHERE id = ?";

        try(Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(deleteSQL)) {
            conn.setAutoCommit(false);
            
            stmt.setInt(1,id);
            
            stmt.executeUpdate();
            conn.commit();
        } catch (SQLException e) {
            throw new SQLException("Virhe tapahtuman poistossa! Virhe: "+e.getMessage());
        } catch (URISyntaxException e) {
            throw new SQLException("Tietokantaan ei saatu yhteyttä! Virhe: "+e.getMessage());
        }
    }
    
    public List<Tapahtuma> tapahtumaLista(int kayttajaId) throws SQLException {
        String tapahtumatSQL =  "SELECT id, nimi, kuvaus, to_char(pvm,'DD.MM.YYYY HH24:MI') as pvm, toistuvuus, voimassa, muokkaus_pvm, kayttaja_id " +
                                "FROM   TAPAHTUMA " +
                                "WHERE  kayttaja_id = ? "+
                                "ORDER  BY id";
        
        List<Tapahtuma> tapahtumat = new ArrayList<Tapahtuma>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try(Connection conn = getConnection(); ) {
            conn.setAutoCommit(false);
            
            pstmt = conn.prepareStatement(tapahtumatSQL);
            pstmt.setInt(1, kayttajaId);
            rs = pstmt.executeQuery();   
            
            while(rs.next()) {
                Tapahtuma t = new Tapahtuma();
                t.setId(rs.getInt("id"));
                t.setNimi(rs.getString("nimi"));
                t.setKuvaus(rs.getString("kuvaus"));
                t.setPvm(rs.getString("pvm"));
                t.setToistuvuus(rs.getInt("toistuvuus"));
                t.setVoimassa(rs.getBoolean("voimassa"));
                t.setMuokkausPvm(rs.getString("muokkaus_pvm"));
                t.setKayttajaId(rs.getInt("kayttaja_id"));
                tapahtumat.add(t);
            }
        } catch (SQLException e) {
            throw new SQLException("Virhe hakiessa tapahtumia! Virhe: "+e.getMessage());
        } catch (URISyntaxException e) {
            throw new SQLException("Tietokantaan ei saatu yhteyttä! Virhe: "+e.getMessage());
        }
        
        return tapahtumat;
    }
    
    public Tapahtuma haeTapahtuma(int id) throws SQLException, URISyntaxException {
        String tapahtumaSQL =  "SELECT id, nimi, kuvaus, to_char(pvm,'DD.MM.YYYY HH24:MI') as pvm, toistuvuus, voimassa, muokkaus_pvm, kayttaja_id " +
                               "FROM   kayttaja " +
                               "WHERE  id = ? " +
                               "ORDER  BY id";
        
        Tapahtuma t = new Tapahtuma();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try(Connection conn = getConnection()) {
            conn.setAutoCommit(false);
            pstmt = conn.prepareStatement(tapahtumaSQL);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                t.setId(rs.getInt("id"));
                t.setNimi(rs.getString("nimi"));
                t.setKuvaus(rs.getString("kuvaus"));
                t.setPvm(rs.getString("pvm"));
                t.setToistuvuus(rs.getInt("toistuvuus"));
                t.setVoimassa(rs.getBoolean("voimassa"));
                t.setMuokkausPvm(rs.getString("muokkaus_pvm"));
                t.setKayttajaId(rs.getInt("kayttaja_id"));
            }
            
        } catch (SQLException e) {
            throw new SQLException("Virhe tapahtuman haussa ID:lle "+id+"! Virhe: "+e.getMessage());
        } catch (URISyntaxException e) {
            throw new SQLException("Tietokantaan ei saatu yhteyttä! Virhe: "+e.getMessage());
        } finally {
            if(rs != null) rs.close();
            if(pstmt != null) pstmt.close();
        }
        
        return t;
    }
    
    public void tallennaOsallistuja(Osallistuja t) throws SQLException, URISyntaxException {
        String insertTableSQL = "INSERT INTO OSALLISTUJA "
                              + "(id, nimi, sahkoposti, osallistuu, muokkaus_pvm, ryhma_id, tapahtuma_id) VALUES "
                              + "(nextval('osallistuja_id_seq'),?,?,?,now(),?,?)";
                    
        try(Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(insertTableSQL)) {
            conn.setAutoCommit(false);
            
            stmt.setString(1,t.getNimi());
            stmt.setString(2,t.getSahkoposti());
            stmt.setBoolean(3,t.isOsallistuu());
            stmt.setInt(4,t.getRyhmaId());            
            stmt.setInt(5,t.getTapahtumaId());
            
            stmt.executeUpdate();
            conn.commit();
        } catch (SQLException e) {
            throw new SQLException("Virhe osallistujan tallennuksessa! Virhe: "+e.getMessage());
        } catch (URISyntaxException e) {
            throw new SQLException("Tietokantaan ei saatu yhteyttä! Virhe: "+e.getMessage());
        }
    }
    
    public void päivitäOsallistuja(Osallistuja t) throws SQLException, URISyntaxException {
        String insertTableSQL = "UPDATE OSALLISTUJA SET nimi = ?, sahkoposti = ?,  muokkaus_pvm = now(), ryhma_id = ?, tapahtuma_id = ? "
                              + "WHERE id = ?";
                    
        try(Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(insertTableSQL)) {
            conn.setAutoCommit(false);
            
            stmt.setString(1,t.getNimi());
            stmt.setString(2,t.getSahkoposti());
            stmt.setInt(3,t.getRyhmaId());            
            stmt.setInt(4,t.getTapahtumaId());
            stmt.setInt(5,t.getId());
            
            stmt.executeUpdate();
            conn.commit();
        } catch (SQLException e) {
            throw new SQLException("Virhe osallistujan tallennuksessa! Virhe: "+e.getMessage());
        } catch (URISyntaxException e) {
            throw new SQLException("Tietokantaan ei saatu yhteyttä! Virhe: "+e.getMessage());
        }
    }
    
    public void poistaOsallistuja(int id) throws SQLException, URISyntaxException {
        String deleteSQL      = "DELETE FROM OSALLISTUJA "
                              + "WHERE id = ?";

        try(Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(deleteSQL)) {
            conn.setAutoCommit(false);
            
            stmt.setInt(1,id);
            
            stmt.executeUpdate();
            conn.commit();
        } catch (SQLException e) {
            throw new SQLException("Virhe osallistujan poistossa! Virhe: "+e.getMessage());
        } catch (URISyntaxException e) {
            throw new SQLException("Tietokantaan ei saatu yhteyttä! Virhe: "+e.getMessage());
        }
    }
    
    public List<Osallistuja> osallistujaLista(int tapahtumaId) throws SQLException {
        String selectSQL     =  "SELECT id, nimi, sahkoposti, osallistuu, ryhma_id " +
                                "FROM   OSALLISTUJA " +
                                "WHERE  tapahtuma_id = ? "+
                                "ORDER  BY id";
        
        List<Osallistuja> osallistujat = new ArrayList<Osallistuja>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try(Connection conn = getConnection(); ) {
            conn.setAutoCommit(false);
            
            pstmt = conn.prepareStatement(selectSQL);
            pstmt.setInt(1, tapahtumaId);
            rs = pstmt.executeQuery();   
            
            while(rs.next()) {
                Osallistuja t = new Osallistuja();
                t.setId(rs.getInt("id"));
                t.setNimi(rs.getString("nimi"));
                t.setSahkoposti(rs.getString("sahkoposti"));
                t.setOsallistuu(rs.getBoolean("osallistuu"));
                t.setRyhmaId(rs.getInt("ryhma_id"));
                t.setTapahtumaId(tapahtumaId);
                osallistujat.add(t);
            }
        } catch (SQLException e) {
            throw new SQLException("Virhe hakiessa osallistuja! Tapahtumalle id = "+tapahtumaId+" Virhe: "+e.getMessage());
        } catch (URISyntaxException e) {
            throw new SQLException("Tietokantaan ei saatu yhteyttä! Virhe: "+e.getMessage());
        }
        
        return osallistujat;
    }
    
    public Osallistuja haeOsallistuja(int id) throws SQLException, URISyntaxException {
        String selectSQL     =  "SELECT id, nimi, sahkoposti, osallistuu, ryhma_id, tapahtuma_id " +
                                "FROM   OSALLISTUJA " +
                                "WHERE  id = ? "+
                                "ORDER  BY id";
        
        Osallistuja t = new Osallistuja();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try(Connection conn = getConnection()) {
            conn.setAutoCommit(false);
            pstmt = conn.prepareStatement(selectSQL);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                t.setId(rs.getInt("id"));
                t.setNimi(rs.getString("nimi"));
                t.setSahkoposti(rs.getString("sahkoposti"));
                t.setOsallistuu(rs.getBoolean("osallistuu"));
                t.setRyhmaId(rs.getInt("ryhma_id"));
                t.setTapahtumaId(rs.getInt("tapahtuma_id"));
            }
            
        } catch (SQLException e) {
            throw new SQLException("Virhe osallistujan haussa ID:lle "+id+"! Virhe: "+e.getMessage());
        } catch (URISyntaxException e) {
            throw new SQLException("Tietokantaan ei saatu yhteyttä! Virhe: "+e.getMessage());
        } finally {
            if(rs != null) rs.close();
            if(pstmt != null) pstmt.close();
        }
        
        return t;
    }
    
    public void paivitaKirjaantumisAika(int id) throws SQLException {
        String updateSQL    = "UPDATE KAYTTAJA SET viimeksi_kirjautunut = now() "+
                              "WHERE  id = ?";
        
                
        try(Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(updateSQL)) {
            conn.setAutoCommit(false);

            stmt.setInt(1,id);
            
            stmt.executeUpdate();
            conn.commit();
        } catch (SQLException e) {
            throw new SQLException("Virhe käyttäjän tallennuksessa! Virhe: "+e.getMessage());
        } catch (URISyntaxException e) {
            throw new SQLException("Tietokantaan ei saatu yhteyttä! Virhe: "+e.getMessage());
        }        
    }

}