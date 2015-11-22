package fi.tsoha.service;

import fi.tsoha.dao.HappeninkiDAO;
import fi.tsoha.model.Kayttaja;

import fi.tsoha.model.Tapahtuma;
import fi.tsoha.model.Tila;

import java.io.UnsupportedEncodingException;

import java.net.URISyntaxException;

import java.security.MessageDigest;

import java.security.NoSuchAlgorithmException;

import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

public class HappeninkiService {
    private HappeninkiDAO dao;
    
    public HappeninkiService() {
        super();
        dao = new HappeninkiDAO();
    }
    
    private String sha256(String str) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(str.getBytes("UTF-8"));
        return toHex(md.digest());
    }
    
    private String toHex(byte[] bytes) {
        StringBuffer result = new StringBuffer();
        for (byte byt : bytes) result.append(Integer.toString((byt & 0xff) + 0x100, 16).substring(1));
        return result.toString();        
    }
    
    public Tila luoUusiKayttaja(String nimi, String tunnus, String salasana, String sahkoposti) throws NoSuchAlgorithmException, UnsupportedEncodingException {

        Tila tila =  new Tila();
        tila.setKoodi(0);
        tila.setViesti("Käyttäjä luotu!");
        
        Kayttaja k = new Kayttaja();
        
        k.setNimi(nimi);
        k.setTunnus(tunnus);
        k.setSalasana(sha256(salasana));
        k.setSahkoposti(sahkoposti);

        try {
            dao.tallennaKayttaja(k);
        } catch (SQLException e) {
            tila.setKoodi(1);
            tila.setViesti(e.getMessage());
        } catch (URISyntaxException e) {
            tila.setKoodi(1);
            tila.setViesti(e.getMessage());            
        }

        return tila;
    }
    
    public List<Kayttaja> listaaKayttajat() {
        List<Kayttaja> lista = new ArrayList<Kayttaja>();
        try {
            lista = dao.kayttajaLista();
        } catch (SQLException e) {
            System.err.println("Virhe käyttäjälistauksessa: "+e.getMessage());
        }
        return lista;
    }

    public Tila luoUusiTapahtuma(String nimi, String kuvaus, String pvm, int toistuvuus, boolean voimassa,int kayttajaId) throws NoSuchAlgorithmException, UnsupportedEncodingException {

        Tila tila =  new Tila();
        tila.setKoodi(0);
        tila.setViesti("Tapahtuma luotu!");
        
        Tapahtuma t = new Tapahtuma();
        
        t.setNimi(nimi);
        t.setKuvaus(kuvaus);
        t.setPvm(pvm);
        t.setToistuvuus(toistuvuus);
        t.setVoimassa(voimassa);        
        t.setKayttajaId(kayttajaId);

        try {
            dao.tallennaTapahtuma(t);
        } catch (SQLException e) {
            tila.setKoodi(1);
            tila.setViesti(e.getMessage());
        } catch (URISyntaxException e) {
            tila.setKoodi(1);
            tila.setViesti(e.getMessage());            
        }

        return tila;
    }
    
    public Tila poistaTapahtuma(int id) {
        Tila tila = new Tila();
        tila.setKoodi(0);
        tila.setViesti("Tapahtuma #"+id+" poistettu!");
        
        try {
            dao.poistaTapahtuma(id);
        } catch (SQLException e) {
            tila.setKoodi(1);
            tila.setViesti(e.getMessage());
        } catch (URISyntaxException e) {
            tila.setKoodi(1);
            tila.setViesti(e.getMessage());            
        }

        return tila;        
    }
    
    public Tila päivitäTapahtuma(int id, String nimi, String kuvaus, String pvm, int toistuvuus, boolean voimassa) {
        Tila tila =  new Tila();
        tila.setKoodi(0);
        tila.setViesti("Tapahtuma päivitetty!");
        
        Tapahtuma t = new Tapahtuma();
        
        t.setId(id);
        t.setNimi(nimi);
        t.setKuvaus(kuvaus);
        t.setPvm(pvm);
        t.setToistuvuus(toistuvuus);
        t.setVoimassa(voimassa);        


        try {
            dao.päivitäTapahtuma(t);
        } catch (SQLException e) {
            tila.setKoodi(1);
            tila.setViesti(e.getMessage());
        } catch (URISyntaxException e) {
            tila.setKoodi(1);
            tila.setViesti(e.getMessage());            
        }

        return tila;      
    }    
    
    public List<Tapahtuma> listaaTapahtumat(int kayttajaId) {
        List<Tapahtuma> lista = new ArrayList<Tapahtuma>();
        try {
            lista = dao.tapahtumaLista(kayttajaId);
        } catch (SQLException e) {
            System.err.println("Virhe tapahtuma listauksessa: "+e.getMessage());
        }
        return lista;
    }
    
    public Tapahtuma haeTapahtuma(int id) throws SQLException, URISyntaxException {
        Tapahtuma t = new Tapahtuma();
        t =  dao.haeTapahtuma(id);
        return t;
    }
    
    
    public String tarkistaParametri(String str) {
        if(str == null)
            return "";
        else
            return str;
    }
    
    public void kirjaudu(String tunnus, String salasana, HttpSession session) throws SQLException,
                                                                                     NoSuchAlgorithmException,
                                                                                     UnsupportedEncodingException {
        Kayttaja k = null;
        try {
            k = dao.haeKayttaja(tunnus,sha256(salasana));
            if(k != null)
                dao.paivitaKirjaantumisAika(k.getID());
            session.setAttribute("kayttaja", k);
        } catch (URISyntaxException e) {
            throw new SQLException("Virhe kirjautumisessa: "+e.getMessage());
        } catch (SQLException e) {
            throw new SQLException("Virhe kirjautumisessa: "+e.getMessage());
        }
    }
}
