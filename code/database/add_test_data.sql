insert into kayttaja(id,nimi,tunnus,salasana,sahkoposti,varmistettu,muokkaus_pvm,viimeksi_kirjautunut)
values(1,'Minä','testuser','6afc5d2b0e765a03e97420b94412d024f1a16dbebbcfcd0d6080b3600026b083','test@test.com',current_timestamp,current_timestamp,null);

insert into ryhma(id,nimi,kuvaus,muokkaus_pvm,kayttaja_id)
values(1,'Kaverit','Kaverit',current_timestamp,1);

insert into jasen(id,nimi,kuvaus,sahkoposti,muokkaus_pvm,ryhma_id)
values(1,'Matti','Frendi','matti@test.com',current_timestamp,1);
insert into jasen(id,nimi,kuvaus,sahkoposti,muokkaus_pvm,ryhma_id)
values(2,'Pentti','Työkaveri','pentti@test.com',current_timestamp,1);

insert into tapahtuma(id,nimi,kuvaus,pvm,toistuvuus,voimassa,muokkaus_pvm,kayttaja_id)
values(1,'Sähly','Keskiviikkoinen sähly','2015-11-11 07:30:00',7,true,current_timestamp,1);

insert into osallistuja(id,nimi,sahkoposti,osallistuu,muokkaus_pvm,ryhma_id,tapahtuma_id)
values(1,'Minä','test@test.com',true,current_timestamp,null,1);
insert into osallistuja(id,nimi,sahkoposti,osallistuu,muokkaus_pvm,ryhma_id,tapahtuma_id)
values(2,'Kaverit',null,false,current_timestamp,1,1);
