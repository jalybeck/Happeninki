package fi.tsoha.model;

public class Osallistuja {
    private int id;
    private String nimi;
    private String sahkoposti;
    private boolean osallistuu;
    private int ryhmaId;
    private int tapahtumaId;
    
    public Osallistuja() {
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

    public void setSahkoposti(String sahkoposti) {
        this.sahkoposti = sahkoposti;
    }

    public String getSahkoposti() {
        return sahkoposti;
    }

    public void setOsallistuu(boolean osallistuu) {
        this.osallistuu = osallistuu;
    }

    public boolean isOsallistuu() {
        return osallistuu;
    }

    public void setRyhmaId(int ryhmaId) {
        this.ryhmaId = ryhmaId;
    }

    public int getRyhmaId() {
        return ryhmaId;
    }

    public void setTapahtumaId(int tapahtumaId) {
        this.tapahtumaId = tapahtumaId;
    }

    public int getTapahtumaId() {
        return tapahtumaId;
    }
}
