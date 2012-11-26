--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: alumnos; Type: TABLE; Schema: public; Owner: warorface; Tablespace: 
--

CREATE TABLE alumnos (
    id integer NOT NULL,
    nombre character varying(255) DEFAULT ''::character varying NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    clave character varying(60) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.alumnos OWNER TO warorface;

--
-- Name: alumnos_id_seq; Type: SEQUENCE; Schema: public; Owner: warorface
--

CREATE SEQUENCE alumnos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alumnos_id_seq OWNER TO warorface;

--
-- Name: alumnos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: warorface
--

ALTER SEQUENCE alumnos_id_seq OWNED BY alumnos.id;


--
-- Name: alumnos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: warorface
--

SELECT pg_catalog.setval('alumnos_id_seq', 6, true);


--
-- Name: departamentos; Type: TABLE; Schema: public; Owner: warorface; Tablespace: 
--

CREATE TABLE departamentos (
    id integer NOT NULL,
    nombre character varying(255) DEFAULT ''::character varying NOT NULL,
    id_lista integer NOT NULL,
    id_alumno_delgado integer NOT NULL
);


ALTER TABLE public.departamentos OWNER TO warorface;

--
-- Name: departamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: warorface
--

CREATE SEQUENCE departamentos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.departamentos_id_seq OWNER TO warorface;

--
-- Name: departamentos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: warorface
--

ALTER SEQUENCE departamentos_id_seq OWNED BY departamentos.id;


--
-- Name: departamentos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: warorface
--

SELECT pg_catalog.setval('departamentos_id_seq', 1, false);


--
-- Name: directivos; Type: TABLE; Schema: public; Owner: warorface; Tablespace: 
--

CREATE TABLE directivos (
    id_lista integer NOT NULL,
    id_alumno integer NOT NULL,
    cargo character varying(255) DEFAULT ''::character varying NOT NULL,
    url_foto character varying(500) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.directivos OWNER TO warorface;

--
-- Name: elecciones; Type: TABLE; Schema: public; Owner: warorface; Tablespace: 
--

CREATE TABLE elecciones (
    id integer NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_termino date,
    tipo character varying(50) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.elecciones OWNER TO warorface;

--
-- Name: elecciones_id_seq; Type: SEQUENCE; Schema: public; Owner: warorface
--

CREATE SEQUENCE elecciones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.elecciones_id_seq OWNER TO warorface;

--
-- Name: elecciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: warorface
--

ALTER SEQUENCE elecciones_id_seq OWNED BY elecciones.id;


--
-- Name: elecciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: warorface
--

SELECT pg_catalog.setval('elecciones_id_seq', 1, false);


--
-- Name: etapas; Type: TABLE; Schema: public; Owner: warorface; Tablespace: 
--

CREATE TABLE etapas (
    id integer NOT NULL,
    descripcion character varying(500) DEFAULT ''::character varying NOT NULL,
    id_proyecto integer NOT NULL
);


ALTER TABLE public.etapas OWNER TO warorface;

--
-- Name: etapas_id_seq; Type: SEQUENCE; Schema: public; Owner: warorface
--

CREATE SEQUENCE etapas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.etapas_id_seq OWNER TO warorface;

--
-- Name: etapas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: warorface
--

ALTER SEQUENCE etapas_id_seq OWNED BY etapas.id;


--
-- Name: etapas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: warorface
--

SELECT pg_catalog.setval('etapas_id_seq', 1, false);


--
-- Name: listas; Type: TABLE; Schema: public; Owner: warorface; Tablespace: 
--

CREATE TABLE listas (
    id integer NOT NULL,
    nombre character varying(255) DEFAULT ''::character varying NOT NULL,
    vision character varying(500) DEFAULT ''::character varying NOT NULL,
    mision character varying(500) DEFAULT ''::character varying NOT NULL,
    id_dueno integer NOT NULL
);


ALTER TABLE public.listas OWNER TO warorface;

--
-- Name: listas_id_seq; Type: SEQUENCE; Schema: public; Owner: warorface
--

CREATE SEQUENCE listas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.listas_id_seq OWNER TO warorface;

--
-- Name: listas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: warorface
--

ALTER SEQUENCE listas_id_seq OWNED BY listas.id;


--
-- Name: listas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: warorface
--

SELECT pg_catalog.setval('listas_id_seq', 1, true);


--
-- Name: proyectos; Type: TABLE; Schema: public; Owner: warorface; Tablespace: 
--

CREATE TABLE proyectos (
    id integer NOT NULL,
    titulo character varying(255) DEFAULT ''::character varying NOT NULL,
    descripcion character varying(500) DEFAULT ''::character varying NOT NULL,
    id_alumno_dueno integer NOT NULL,
    id_departamento integer NOT NULL
);


ALTER TABLE public.proyectos OWNER TO warorface;

--
-- Name: proyectos_id_seq; Type: SEQUENCE; Schema: public; Owner: warorface
--

CREATE SEQUENCE proyectos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proyectos_id_seq OWNER TO warorface;

--
-- Name: proyectos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: warorface
--

ALTER SEQUENCE proyectos_id_seq OWNED BY proyectos.id;


--
-- Name: proyectos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: warorface
--

SELECT pg_catalog.setval('proyectos_id_seq', 1, false);


--
-- Name: votos; Type: TABLE; Schema: public; Owner: warorface; Tablespace: 
--

CREATE TABLE votos (
    id integer NOT NULL,
    id_eleccion integer NOT NULL,
    id_elegido integer NOT NULL,
    id_elector integer NOT NULL
);


ALTER TABLE public.votos OWNER TO warorface;

--
-- Name: votos_id_seq; Type: SEQUENCE; Schema: public; Owner: warorface
--

CREATE SEQUENCE votos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.votos_id_seq OWNER TO warorface;

--
-- Name: votos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: warorface
--

ALTER SEQUENCE votos_id_seq OWNED BY votos.id;


--
-- Name: votos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: warorface
--

SELECT pg_catalog.setval('votos_id_seq', 1, false);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY alumnos ALTER COLUMN id SET DEFAULT nextval('alumnos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY departamentos ALTER COLUMN id SET DEFAULT nextval('departamentos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY elecciones ALTER COLUMN id SET DEFAULT nextval('elecciones_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY etapas ALTER COLUMN id SET DEFAULT nextval('etapas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY listas ALTER COLUMN id SET DEFAULT nextval('listas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY proyectos ALTER COLUMN id SET DEFAULT nextval('proyectos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY votos ALTER COLUMN id SET DEFAULT nextval('votos_id_seq'::regclass);


--
-- Data for Name: alumnos; Type: TABLE DATA; Schema: public; Owner: warorface
--

COPY alumnos (id, nombre, email, clave) FROM stdin;
1	jaime	jai@me.com	e10adc3949ba59abbe56e057f20f883e
2	julio	jul@io.com	e10adc3949ba59abbe56e057f20f883e
3	jarro	ja@rro.vh	e10adc3949ba59abbe56e057f20f883e
4	alvaro	alva@ro.com	e10adc3949ba59abbe56e057f20f883e
5	dario	dar@io.com	e10adc3949ba59abbe56e057f20f883e
6	rodrigo	rodri@go.com	e10adc3949ba59abbe56e057f20f883e
\.


--
-- Data for Name: departamentos; Type: TABLE DATA; Schema: public; Owner: warorface
--

COPY departamentos (id, nombre, id_lista, id_alumno_delgado) FROM stdin;
\.


--
-- Data for Name: directivos; Type: TABLE DATA; Schema: public; Owner: warorface
--

COPY directivos (id_lista, id_alumno, cargo, url_foto) FROM stdin;
1	1	Presidente	fdgsd
\.


--
-- Data for Name: elecciones; Type: TABLE DATA; Schema: public; Owner: warorface
--

COPY elecciones (id, fecha_inicio, fecha_termino, tipo) FROM stdin;
\.


--
-- Data for Name: etapas; Type: TABLE DATA; Schema: public; Owner: warorface
--

COPY etapas (id, descripcion, id_proyecto) FROM stdin;
\.


--
-- Data for Name: listas; Type: TABLE DATA; Schema: public; Owner: warorface
--

COPY listas (id, nombre, vision, mision, id_dueno) FROM stdin;
1	sdfdsgf	fdsgfsggf	dsfdsfsda	1
\.


--
-- Data for Name: proyectos; Type: TABLE DATA; Schema: public; Owner: warorface
--

COPY proyectos (id, titulo, descripcion, id_alumno_dueno, id_departamento) FROM stdin;
\.


--
-- Data for Name: votos; Type: TABLE DATA; Schema: public; Owner: warorface
--

COPY votos (id, id_eleccion, id_elegido, id_elector) FROM stdin;
\.


--
-- Name: alumnos_pkey; Type: CONSTRAINT; Schema: public; Owner: warorface; Tablespace: 
--

ALTER TABLE ONLY alumnos
    ADD CONSTRAINT alumnos_pkey PRIMARY KEY (id);


--
-- Name: departamentos_pkey; Type: CONSTRAINT; Schema: public; Owner: warorface; Tablespace: 
--

ALTER TABLE ONLY departamentos
    ADD CONSTRAINT departamentos_pkey PRIMARY KEY (id);


--
-- Name: directivos_pkey; Type: CONSTRAINT; Schema: public; Owner: warorface; Tablespace: 
--

ALTER TABLE ONLY directivos
    ADD CONSTRAINT directivos_pkey PRIMARY KEY (id_lista, id_alumno);


--
-- Name: elecciones_pkey; Type: CONSTRAINT; Schema: public; Owner: warorface; Tablespace: 
--

ALTER TABLE ONLY elecciones
    ADD CONSTRAINT elecciones_pkey PRIMARY KEY (id);


--
-- Name: etapas_pkey; Type: CONSTRAINT; Schema: public; Owner: warorface; Tablespace: 
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etapas_pkey PRIMARY KEY (id);


--
-- Name: listas_pkey; Type: CONSTRAINT; Schema: public; Owner: warorface; Tablespace: 
--

ALTER TABLE ONLY listas
    ADD CONSTRAINT listas_pkey PRIMARY KEY (id);


--
-- Name: proyectos_pkey; Type: CONSTRAINT; Schema: public; Owner: warorface; Tablespace: 
--

ALTER TABLE ONLY proyectos
    ADD CONSTRAINT proyectos_pkey PRIMARY KEY (id);


--
-- Name: votos_pkey; Type: CONSTRAINT; Schema: public; Owner: warorface; Tablespace: 
--

ALTER TABLE ONLY votos
    ADD CONSTRAINT votos_pkey PRIMARY KEY (id);


--
-- Name: departamentos_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY departamentos
    ADD CONSTRAINT departamentos_ibfk_1 FOREIGN KEY (id_lista) REFERENCES listas(id);


--
-- Name: departamentos_ibfk_2; Type: FK CONSTRAINT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY departamentos
    ADD CONSTRAINT departamentos_ibfk_2 FOREIGN KEY (id_alumno_delgado) REFERENCES alumnos(id);


--
-- Name: directivos_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY directivos
    ADD CONSTRAINT directivos_ibfk_1 FOREIGN KEY (id_lista) REFERENCES listas(id);


--
-- Name: directivos_ibfk_2; Type: FK CONSTRAINT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY directivos
    ADD CONSTRAINT directivos_ibfk_2 FOREIGN KEY (id_alumno) REFERENCES alumnos(id);


--
-- Name: etapas_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etapas_ibfk_1 FOREIGN KEY (id_proyecto) REFERENCES proyectos(id);


--
-- Name: proyectos_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY proyectos
    ADD CONSTRAINT proyectos_ibfk_1 FOREIGN KEY (id_alumno_dueno) REFERENCES alumnos(id);


--
-- Name: proyectos_ibfk_2; Type: FK CONSTRAINT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY proyectos
    ADD CONSTRAINT proyectos_ibfk_2 FOREIGN KEY (id_departamento) REFERENCES departamentos(id);


--
-- Name: votos_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY votos
    ADD CONSTRAINT votos_ibfk_1 FOREIGN KEY (id_elector) REFERENCES alumnos(id);


--
-- Name: votos_ibfk_2; Type: FK CONSTRAINT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY votos
    ADD CONSTRAINT votos_ibfk_2 FOREIGN KEY (id_eleccion) REFERENCES elecciones(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: warorface
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM warorface;
GRANT ALL ON SCHEMA public TO warorface;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

