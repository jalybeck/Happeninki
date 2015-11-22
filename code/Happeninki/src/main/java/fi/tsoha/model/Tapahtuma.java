package fi.tsoha.model;

public class Tapahtuma {
    private int id;
    private String nimi;
    private String kuvaus;
    private String pvm;
    private int toistuvuus;
    private boolean voimassa;
    private String muokkausPvm;
    private int kayttajaId;
    
    public Tapahtuma() {
        super();
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setNimi(String nimi) {
        this.nimi = nimi;
    }

    public String getNimi() {
        return nimi;
    }

    public void setPvm(String pvm) {
        this.pvm = pvm;
    }

    public String getPvm() {
        return pvm;
    }

    public void setToistuvuus(int toistuvuus) {
        this.toistuvuus = toistuvuus;
    }

    public int getToistuvuus() {
        return toistuvuus;
    }

    public void setVoimassa(boolean voimassa) {
        this.voimassa = voimassa;
    }

    public boolean isVoimassa() {
        return voimassa;
    }

    public void setMuokkausPvm(String muokkausPvm) {
        this.muokkausPvm = muokkausPvm;
    }

    public String getMuokkausPvm() {
        return muokkausPvm;
    }

    public void setKayttajaId(int kayttajaId) {
        this.kayttajaId = kayttajaId;
    }

    public int getKayttajaId() {
        return kayttajaId;
    }

    public void setKuvaus(String kuvaus) {
        this.kuvaus = kuvaus;
    }

    public String getKuvaus() {
        return kuvaus;
    }
}
