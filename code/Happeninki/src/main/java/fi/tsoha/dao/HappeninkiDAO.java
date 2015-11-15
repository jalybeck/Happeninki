package fi.tsoha.dao;

import fi.tsoha.model.Kayttaja;

import java.net.URI;
import java.net.URISyntaxException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.sql.Statement;

import java.util.ArrayList;
import java.util.List;

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
                k.setID(rs.getString("id"));
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
                kayttaja.setID(rs.getString("id"));
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
}