package fi.tsoha.model;

public class Kayttaja {
    
    private String ID;
    private String nimi;
    private String tunnus;
    private String salasana;
    private String sahkoposti;
    
    public Kayttaja() {
        super();
    }
    
    public void setNimi(String nimi) {
        this.nimi = nimi;
    }
    
    public String getNimi() {
        return nimi;
    }
    
    public void setTunnus(String tunnus) {
        this.tunnus = tunnus;
    }
    
    public String getTunnus() {
        return tunnus;
    }

    public void setSalasana(String salasana) {
        this.salasana = salasana;
    }
    
    public String getSalasana() {
        return salasana;
    }
    
    public void setSahkoposti(String sahkoposti) {
        this.sahkoposti = sahkoposti;
    }
    
    public String getSahkoposti() {
        return sahkoposti;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public String getID() {
        return ID;
    }
}
