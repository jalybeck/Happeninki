package fi.tsoha.model;

public class Ryhma {
    private int id;
    private String nimi;
    private String kuvaus;
    private int kayttajaId;
    
    public Ryhma() {
        super();
    }

    public void setNimi(String nimi) {
        this.nimi = nimi;
    }

    public String getNimi() {
        return nimi;
    }

    public void setKuvaus(String kuvaus) {
        this.kuvaus = kuvaus;
    }

    public String getKuvaus() {
        return kuvaus;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setKayttajaId(int kayttajaId) {
        this.kayttajaId = kayttajaId;
    }

    public int getKayttajaId() {
        return kayttajaId;
    }
}
