package fi.tsoha.service;

import fi.tsoha.dao.HappeninkiDAO;
import fi.tsoha.model.Kayttaja;

import fi.tsoha.model.Tila;

import java.io.UnsupportedEncodingException;

import java.net.URISyntaxException;

import java.security.MessageDigest;

import java.security.NoSuchAlgorithmException;

import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

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
    
    public Kayttaja haeKayttaja(int id) {
        Kayttaja k = new Kayttaja();
        try {
             k =  dao.haeKayttaja(id);
        } catch (URISyntaxException e) {
            //TODO: lisää virheviestin lähetys GUIlle
            System.err.println("Virhe käyttjän hakemisessa ID("+id+"): "+e.getMessage());
        } catch (SQLException e) {
            //TODO: lisää virheviestin lähetys GUIlle
            System.err.println("Virhe käyttjän hakemisessa ID("+id+"): "+e.getMessage());
        }
        return k;
    }
}
