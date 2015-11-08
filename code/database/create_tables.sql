create table kayttaja
(
  id serial primary key,
  nimi varchar,
  tunnus varchar,
  salasana varchar,
  sahkoposti varchar,
  varmistettu timestamp,
  muokkaus_pvm timestamp,
  viimeksi_kirjautunut timestamp
);

create table ryhma
(
  id serial primary key,
  nimi varchar,
  kuvaus varchar,
  muokkaus_pvm timestamp,
  kayttaja_id integer references kayttaja
);

create table jasen
(
  id serial primary key,
  nimi varchar,
  kuvaus varchar,
  sahkoposti varchar,
  muokkaus_pvm timestamp,
  ryhma_id integer references ryhma
);

create table tapahtuma
(
  id serial primary key,
  nimi varchar,
  kuvaus varchar,
  pvm timestamp,
  toistuvuus integer,
  voimassa boolean,
  muokkaus_pvm timestamp,
  kayttaja_id integer references kayttaja
);

create table osallistuja
(
  id serial primary key,
  nimi varchar,
  sahkoposti varchar,
  osallistuu boolean,
  muokkaus_pvm timestamp,
  ryhma_id integer references ryhma,
  tapahtuma_id integer references tapahtuma
);