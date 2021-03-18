create table if not exists planet
(
	id integer default nextval('"Planet_id_seq"'::regclass) not null
		constraint planet_pk
			primary key,
	name varchar(100),
	rotation_period integer,
	orbital_period integer,
	diameter integer,
	surface_water double precision,
	gravity varchar,
	population bigint
);

alter table planet owner to postgres;

create table if not exists climate
(
	id serial not null
		constraint climat_pk
			primary key,
	type varchar(50)
);

alter table climate owner to postgres;

create table if not exists climate_planet
(
	climat_idx integer not null
		constraint climat__fk
			references climate,
	planet_idx integer not null
		constraint planet___fk
			references planet,
	constraint climat_planet_pk
		primary key (planet_idx, climat_idx)
);

alter table climate_planet owner to postgres;

create table if not exists terrain
(
	id serial not null
		constraint terrain_pk
			primary key,
	name varchar(50)
);

alter table terrain owner to postgres;

create table if not exists terrain_planet
(
	terrain_idx integer not null
		constraint terrain_id_fk
			references terrain,
	planet_idx integer not null
		constraint planet__fk
			references planet,
	constraint terrain_planet_pk
		primary key (terrain_idx, planet_idx)
);

alter table terrain_planet owner to postgres;

create table if not exists transport_typ
(
	id serial not null
		constraint transport_typ_pk
			primary key,
	name varchar
);

alter table transport_typ owner to postgres;

create table if not exists transport
(
	id serial not null
		constraint transport_pk
			primary key,
	name varchar(50),
	model varchar(50),
	manufacturer varchar(50),
	cost_in_credits integer,
	length double precision,
	max_atmosphering_speed integer,
	crew integer,
	passengers integer,
	cargo_capacity integer,
	consumables_typ varchar,
	consumables_duration_day integer,
	class varchar,
	transport_typ_idx integer
		constraint transport_typ_id_fk
			references transport_typ
);

alter table transport owner to postgres;

create table if not exists starship
(
	id serial not null
		constraint starship_pk
			primary key,
	hyperdrive_rating double precision,
	mglt integer,
	transport_idx integer
		constraint starship_transport_id_fk
			references transport
);

alter table starship owner to postgres;

create table if not exists species
(
	id serial not null
		constraint species_pk
			primary key,
	name varchar(50),
	classification varchar(50),
	designation varchar,
	language varchar,
	species_planet_idx integer
		constraint species_planet_id_fk
			references planet
);

alter table species owner to postgres;

create table if not exists characters
(
	id serial not null
		constraint characters_pk
			primary key,
	name varchar,
	height integer,
	mass varchar,
	birth_year varchar,
	gender varchar(50),
	planet_idx integer
		constraint planet___fk
			references planet,
	species_idx integer
);

alter table characters owner to postgres;

create table if not exists colors
(
	id serial not null
		constraint colors_pk
			primary key,
	name varchar
);

alter table colors owner to postgres;

create table if not exists species_appearence
(
	species_idx integer
		constraint species__fk
			references species,
	colors_idx integer
		constraint colors_id_fk
			references colors,
	id serial not null
		constraint species_appearence_pk
			primary key,
	body_part varchar,
	character_idx integer
		constraint appearence___fk
			references characters,
	constraint species_appearence_pk_2
		unique (species_idx, body_part, colors_idx)
);

alter table species_appearence owner to postgres;

