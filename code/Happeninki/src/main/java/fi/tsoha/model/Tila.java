package fi.tsoha.model;

public class Tila {
    private int koodi;
    private String viesti;
    
    public Tila() {
        super();
    }

    public void setKoodi(int tila) {
        this.koodi = tila;
    }

    public int getKoodi() {
        return koodi;
    }

    public void setViesti(String viesti) {
        this.viesti = viesti;
    }

    public String getViesti() {
        return viesti;
    }
}
