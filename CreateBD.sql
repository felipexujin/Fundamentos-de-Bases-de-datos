create database if not exists  Evento_uc3m;
use Evento_uc3m;

-- TABLA CATEGORÍA 
create table if not exists Categoria(
	IdC Char(4) primary key,
	NombreC Varchar(100) not null
);

-- TABLA DESCRITA_POR
create table if not exists Descrita_Por(
	Evento int,
	Categoria char(4) not null,
    primary key (Evento,Categoria),
    constraint fk_desrito_categoria Foreign key (Categoria)
		references categoria (Idc)
        on update cascade
        on delete cascade
);


-- TABLA CENTRO
create table if not exists Centro(
	CodC Char(2) primary key,
	NombreCentro Varchar(100) not null,
    Campus ENUM('Getafe', 'Leganés', 'Colmenarejo', 'PT') not null
); 
 

-- TABLA DEPARTAMENTO
create table if not exists Departamento(
	Cod_Dpto Char(2) primary key,
	NombreD Varchar(200) not null
);


-- TABLA TIPO_EVENTO
create table if not exists Tipo_Evento(
	CodT Char(2) primary key,
	NombreT Varchar(100) not null
); 

-- TABLA PERSONA
create table if not exists Persona(
	CodP Char(10) primary key,
	Nombre Varchar(100) not null,
	Apellidos char(5) not null,
    Genero ENUM('H', 'M', 'O', 'N')not null default 'N',
    TipoP ENUM('UC3M', 'Otro') not null 
);

-- TABLA INTERNO
create table if not exists Interno(
	CodP Char(10) primary key,
	NRP Varchar(10) not null,
    CategoríaP ENUM('CU', 'TU', 'AD', 'Otro')  not null default 'Otro',
    
    constraint fk_interno_persona foreign key (CodP) References Persona(CodP)
    on update cascade
    on delete cascade
    
); 

-- TABLA EXTERNO
create table if not exists Externo(
	CodP Char(10) primary key,
	Procedencia ENUM('Empresa', 'Universidad', 'Centro investigación', 'Otro') not null default 'Otro',
	NombreE VARCHAR(100) not null,
    constraint fk_externo_persona foreign key (CodP) References Persona(CodP)
    on update cascade
    on delete cascade
); 


-- TABLA CONVOCATORIA
create table if not exists Convocatoria(
CodConv CHAR(10) primary key, 
NombreConv VARCHAR(200) not null,
Año DATE not null,
TipoC ENUM('Externa', 'Interna') not null
);


-- TABLA ADSCRITO
create table if not exists Adscrito(
Investigador CHAR(10) primary key, 
Departamento CHAR(2) not null,
Fecha_I DATE not null,

constraint fk_adscrito_interno foreign key (Investigador) References Interno(CodP)
    on update restrict
    on delete restrict,
constraint fk_adscrito_depeartamento foreign key (Departamento) References Departamento(Cod_Dpto)
	on update restrict
	on delete restrict

);

-- TABLA GRUPO_INV
create table if not exists Grupo_Inv(
CodG CHAR(3) primary key,
NombreG VARCHAR(200)  not null,
Acrónimo  VARCHAR(10)  not null,
URL VARCHAR(100) not null,
Dirigido_por CHAR(10)  not null,

constraint fk_grupoinv_interno foreign key (Dirigido_Por) References Interno(CodP)
    on update restrict
    on delete restrict
);



-- TABLA PERTENECE
create table if not exists Pertenece(
Grupo CHAR(3),
Investigador CHAR(10),
Fecha_I DATE not null,
primary key (Grupo, Investigador),

constraint fk_pertenece_grupoinv foreign key (Grupo) References Grupo_Inv(CodG)
    on update restrict
    on delete restrict,
    
    constraint fk_pertenece_interno foreign key (Investigador) References  Interno(CodP)
    on update restrict
    on delete restrict
);


-- TABLA EVENTO
create table if not exists Evento(
	Cod_E INT primary key, 
	Título VARCHAR(200) not null,
	FechaH_I DATETIME  not null,
	FechaH_F DATETIME not null,
	Streaming ENUM('si', 'no') not null,
	URL VARCHAR(100) not null,
	Idioma ENUM('español', 'inglés') not null,
	Ayuda CHAR(10),
	Cuantía  DECIMAL,
	Organizado_por CHAR(10) not null,
	Presupuesto DECIMAL not null,
	TipoE CHAR(2) not null,
	Celebrado_en CHAR(2) not null,
	Sala VARCHAR(20) not null,
    
    constraint fk_evento_convocatoria foreign key (Ayuda) References  Convocatoria(CodConv)
		on update set null
		on delete set null,
    constraint fk_evento_interno foreign key (Organizado_por) references Interno(CodP)
		on update restrict
		on delete restrict,
	constraint fk_evento_tipo_evento foreign key (TipoE) references Tipo_Evento(CodT)
		on update restrict
		on delete restrict,
	constraint fk_evento_centro foreign key (Celebrado_en) references Centro(CodC)
		on update restrict
		on delete restrict
);


-- TABLA PARTICIPA
create table if not exists Participa(
	Participante Char(10),
	Evento int,
	Num_horas int not null,
    primary key (Participante, Evento),
    Constraint fk_Praticipa_persona  foreign key(Participante) references Persona(CodP)
	on update restrict
	on delete restrict,
    Constraint fk_Praticipa_evento  foreign key(Evento) references Evento(Cod_E)
	on update restrict
	on delete restrict
); 






