--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.1
-- Dumped by pg_dump version 9.2.0
-- Started on 2012-11-29 00:21:26 CLST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 183 (class 3079 OID 11995)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2288 (class 0 OID 0)
-- Dependencies: 183
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 196 (class 1255 OID 16529)
-- Name: trigger_proyecto(); Type: FUNCTION; Schema: public; Owner: warorface
--

CREATE FUNCTION trigger_proyecto() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE	count_etapas int;
BEGIN

IF tg_op="INSERT" THEN
	SELECT count(*) into count_etapas FROM etapas WHERE (fecha_inicio BETWEEN NEW.fecha_inicio AND NEW.fecha_termino) OR (fecha_termino BETWEEN NEW.fecha_inicio AND NEW.fecha_termino);
	IF count_etapas > 0 THEN
		RAISE EXCEPTION 'Usuario esta comprometido en dicho periodo';	
	END IF;
END IF;

END
$$;


ALTER FUNCTION public.trigger_proyecto() OWNER TO warorface;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 168 (class 1259 OID 16391)
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
-- TOC entry 169 (class 1259 OID 16400)
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
-- TOC entry 2289 (class 0 OID 0)
-- Dependencies: 169
-- Name: alumnos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: warorface
--

ALTER SEQUENCE alumnos_id_seq OWNED BY alumnos.id;


--
-- TOC entry 2290 (class 0 OID 0)
-- Dependencies: 169
-- Name: alumnos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: warorface
--

SELECT pg_catalog.setval('alumnos_id_seq', 13, true);


--
-- TOC entry 170 (class 1259 OID 16402)
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
-- TOC entry 171 (class 1259 OID 16406)
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
-- TOC entry 2291 (class 0 OID 0)
-- Dependencies: 171
-- Name: departamentos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: warorface
--

ALTER SEQUENCE departamentos_id_seq OWNED BY departamentos.id;


--
-- TOC entry 2292 (class 0 OID 0)
-- Dependencies: 171
-- Name: departamentos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: warorface
--

SELECT pg_catalog.setval('departamentos_id_seq', 1, false);


--
-- TOC entry 172 (class 1259 OID 16408)
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
-- TOC entry 173 (class 1259 OID 16416)
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
-- TOC entry 174 (class 1259 OID 16420)
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
-- TOC entry 2293 (class 0 OID 0)
-- Dependencies: 174
-- Name: elecciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: warorface
--

ALTER SEQUENCE elecciones_id_seq OWNED BY elecciones.id;


--
-- TOC entry 2294 (class 0 OID 0)
-- Dependencies: 174
-- Name: elecciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: warorface
--

SELECT pg_catalog.setval('elecciones_id_seq', 1, false);


--
-- TOC entry 175 (class 1259 OID 16422)
-- Name: etapas; Type: TABLE; Schema: public; Owner: warorface; Tablespace: 
--

CREATE TABLE etapas (
    id integer NOT NULL,
    descripcion character varying(500) DEFAULT ''::character varying NOT NULL,
    id_proyecto integer NOT NULL,
    id_responsable integer,
    fecha_inicio date,
    fecha_termino date
);


ALTER TABLE public.etapas OWNER TO warorface;

--
-- TOC entry 176 (class 1259 OID 16429)
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
-- TOC entry 2295 (class 0 OID 0)
-- Dependencies: 176
-- Name: etapas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: warorface
--

ALTER SEQUENCE etapas_id_seq OWNED BY etapas.id;


--
-- TOC entry 2296 (class 0 OID 0)
-- Dependencies: 176
-- Name: etapas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: warorface
--

SELECT pg_catalog.setval('etapas_id_seq', 1, false);


--
-- TOC entry 177 (class 1259 OID 16431)
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
-- TOC entry 178 (class 1259 OID 16440)
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
-- TOC entry 2297 (class 0 OID 0)
-- Dependencies: 178
-- Name: listas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: warorface
--

ALTER SEQUENCE listas_id_seq OWNED BY listas.id;


--
-- TOC entry 2298 (class 0 OID 0)
-- Dependencies: 178
-- Name: listas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: warorface
--

SELECT pg_catalog.setval('listas_id_seq', 2, true);


--
-- TOC entry 179 (class 1259 OID 16442)
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
-- TOC entry 180 (class 1259 OID 16450)
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
-- TOC entry 2299 (class 0 OID 0)
-- Dependencies: 180
-- Name: proyectos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: warorface
--

ALTER SEQUENCE proyectos_id_seq OWNED BY proyectos.id;


--
-- TOC entry 2300 (class 0 OID 0)
-- Dependencies: 180
-- Name: proyectos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: warorface
--

SELECT pg_catalog.setval('proyectos_id_seq', 2, true);


--
-- TOC entry 181 (class 1259 OID 16452)
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
-- TOC entry 182 (class 1259 OID 16455)
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
-- TOC entry 2301 (class 0 OID 0)
-- Dependencies: 182
-- Name: votos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: warorface
--

ALTER SEQUENCE votos_id_seq OWNED BY votos.id;


--
-- TOC entry 2302 (class 0 OID 0)
-- Dependencies: 182
-- Name: votos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: warorface
--

SELECT pg_catalog.setval('votos_id_seq', 1, false);


--
-- TOC entry 2231 (class 2604 OID 16457)
-- Name: id; Type: DEFAULT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY alumnos ALTER COLUMN id SET DEFAULT nextval('alumnos_id_seq'::regclass);


--
-- TOC entry 2233 (class 2604 OID 16458)
-- Name: id; Type: DEFAULT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY departamentos ALTER COLUMN id SET DEFAULT nextval('departamentos_id_seq'::regclass);


--
-- TOC entry 2237 (class 2604 OID 16459)
-- Name: id; Type: DEFAULT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY elecciones ALTER COLUMN id SET DEFAULT nextval('elecciones_id_seq'::regclass);


--
-- TOC entry 2239 (class 2604 OID 16460)
-- Name: id; Type: DEFAULT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY etapas ALTER COLUMN id SET DEFAULT nextval('etapas_id_seq'::regclass);


--
-- TOC entry 2243 (class 2604 OID 16461)
-- Name: id; Type: DEFAULT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY listas ALTER COLUMN id SET DEFAULT nextval('listas_id_seq'::regclass);


--
-- TOC entry 2246 (class 2604 OID 16462)
-- Name: id; Type: DEFAULT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY proyectos ALTER COLUMN id SET DEFAULT nextval('proyectos_id_seq'::regclass);


--
-- TOC entry 2247 (class 2604 OID 16463)
-- Name: id; Type: DEFAULT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY votos ALTER COLUMN id SET DEFAULT nextval('votos_id_seq'::regclass);


--
-- TOC entry 2273 (class 0 OID 16391)
-- Dependencies: 168
-- Data for Name: alumnos; Type: TABLE DATA; Schema: public; Owner: warorface
--

COPY alumnos (id, nombre, email, clave) FROM stdin;
7	Tulio	tul@io.com	e10adc3949ba59abbe56e057f20f883e
8	Julio	jul@io.com	e10adc3949ba59abbe56e057f20f883e
9	Mario	mar@io.com	e10adc3949ba59abbe56e057f20f883e
10	Dario	dar@io.com	e10adc3949ba59abbe56e057f20f883e
11	Junio	jun@io.com	e10adc3949ba59abbe56e057f20f883e
12	Remi	rem@io.com	e10adc3949ba59abbe56e057f20f883e
13	Demi	dem@io.com	e10adc3949ba59abbe56e057f20f883e
\.


--
-- TOC entry 2274 (class 0 OID 16402)
-- Dependencies: 170
-- Data for Name: departamentos; Type: TABLE DATA; Schema: public; Owner: warorface
--

COPY departamentos (id, nombre, id_lista, id_alumno_delgado) FROM stdin;
\.


--
-- TOC entry 2275 (class 0 OID 16408)
-- Dependencies: 172
-- Data for Name: directivos; Type: TABLE DATA; Schema: public; Owner: warorface
--

COPY directivos (id_lista, id_alumno, cargo, url_foto) FROM stdin;
2	7	Presidente	tuliofoto
2	10	Tesorero	tesofoto
\.


--
-- TOC entry 2276 (class 0 OID 16416)
-- Dependencies: 173
-- Data for Name: elecciones; Type: TABLE DATA; Schema: public; Owner: warorface
--

COPY elecciones (id, fecha_inicio, fecha_termino, tipo) FROM stdin;
\.


--
-- TOC entry 2277 (class 0 OID 16422)
-- Dependencies: 175
-- Data for Name: etapas; Type: TABLE DATA; Schema: public; Owner: warorface
--

COPY etapas (id, descripcion, id_proyecto, id_responsable, fecha_inicio, fecha_termino) FROM stdin;
\.


--
-- TOC entry 2278 (class 0 OID 16431)
-- Dependencies: 177
-- Data for Name: listas; Type: TABLE DATA; Schema: public; Owner: warorface
--

COPY listas (id, nombre, vision, mision, id_dueno) FROM stdin;
2	Tuliolista	Tuliovision	Tuliomision	7
\.


--
-- TOC entry 2279 (class 0 OID 16442)
-- Dependencies: 179
-- Data for Name: proyectos; Type: TABLE DATA; Schema: public; Owner: warorface
--

COPY proyectos (id, titulo, descripcion, id_alumno_dueno, id_departamento) FROM stdin;
\.


--
-- TOC entry 2280 (class 0 OID 16452)
-- Dependencies: 181
-- Data for Name: votos; Type: TABLE DATA; Schema: public; Owner: warorface
--

COPY votos (id, id_eleccion, id_elegido, id_elector) FROM stdin;
\.


--
-- TOC entry 2249 (class 2606 OID 16465)
-- Name: alumnos_pkey; Type: CONSTRAINT; Schema: public; Owner: warorface; Tablespace: 
--

ALTER TABLE ONLY alumnos
    ADD CONSTRAINT alumnos_pkey PRIMARY KEY (id);


--
-- TOC entry 2251 (class 2606 OID 16467)
-- Name: departamentos_pkey; Type: CONSTRAINT; Schema: public; Owner: warorface; Tablespace: 
--

ALTER TABLE ONLY departamentos
    ADD CONSTRAINT departamentos_pkey PRIMARY KEY (id);


--
-- TOC entry 2253 (class 2606 OID 16469)
-- Name: directivos_pkey; Type: CONSTRAINT; Schema: public; Owner: warorface; Tablespace: 
--

ALTER TABLE ONLY directivos
    ADD CONSTRAINT directivos_pkey PRIMARY KEY (id_lista, id_alumno);


--
-- TOC entry 2255 (class 2606 OID 16471)
-- Name: elecciones_pkey; Type: CONSTRAINT; Schema: public; Owner: warorface; Tablespace: 
--

ALTER TABLE ONLY elecciones
    ADD CONSTRAINT elecciones_pkey PRIMARY KEY (id);


--
-- TOC entry 2257 (class 2606 OID 16473)
-- Name: etapas_pkey; Type: CONSTRAINT; Schema: public; Owner: warorface; Tablespace: 
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etapas_pkey PRIMARY KEY (id);


--
-- TOC entry 2259 (class 2606 OID 16475)
-- Name: listas_pkey; Type: CONSTRAINT; Schema: public; Owner: warorface; Tablespace: 
--

ALTER TABLE ONLY listas
    ADD CONSTRAINT listas_pkey PRIMARY KEY (id);


--
-- TOC entry 2261 (class 2606 OID 16477)
-- Name: proyectos_pkey; Type: CONSTRAINT; Schema: public; Owner: warorface; Tablespace: 
--

ALTER TABLE ONLY proyectos
    ADD CONSTRAINT proyectos_pkey PRIMARY KEY (id);


--
-- TOC entry 2263 (class 2606 OID 16479)
-- Name: votos_pkey; Type: CONSTRAINT; Schema: public; Owner: warorface; Tablespace: 
--

ALTER TABLE ONLY votos
    ADD CONSTRAINT votos_pkey PRIMARY KEY (id);


--
-- TOC entry 2264 (class 2606 OID 16480)
-- Name: departamentos_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY departamentos
    ADD CONSTRAINT departamentos_ibfk_1 FOREIGN KEY (id_lista) REFERENCES listas(id);


--
-- TOC entry 2265 (class 2606 OID 16485)
-- Name: departamentos_ibfk_2; Type: FK CONSTRAINT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY departamentos
    ADD CONSTRAINT departamentos_ibfk_2 FOREIGN KEY (id_alumno_delgado) REFERENCES alumnos(id);


--
-- TOC entry 2266 (class 2606 OID 16490)
-- Name: directivos_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY directivos
    ADD CONSTRAINT directivos_ibfk_1 FOREIGN KEY (id_lista) REFERENCES listas(id);


--
-- TOC entry 2267 (class 2606 OID 16495)
-- Name: directivos_ibfk_2; Type: FK CONSTRAINT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY directivos
    ADD CONSTRAINT directivos_ibfk_2 FOREIGN KEY (id_alumno) REFERENCES alumnos(id);


--
-- TOC entry 2268 (class 2606 OID 16500)
-- Name: etapas_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etapas_ibfk_1 FOREIGN KEY (id_proyecto) REFERENCES proyectos(id);


--
-- TOC entry 2269 (class 2606 OID 16505)
-- Name: proyectos_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY proyectos
    ADD CONSTRAINT proyectos_ibfk_1 FOREIGN KEY (id_alumno_dueno) REFERENCES alumnos(id);


--
-- TOC entry 2270 (class 2606 OID 16510)
-- Name: proyectos_ibfk_2; Type: FK CONSTRAINT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY proyectos
    ADD CONSTRAINT proyectos_ibfk_2 FOREIGN KEY (id_departamento) REFERENCES departamentos(id);


--
-- TOC entry 2271 (class 2606 OID 16515)
-- Name: votos_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY votos
    ADD CONSTRAINT votos_ibfk_1 FOREIGN KEY (id_elector) REFERENCES alumnos(id);


--
-- TOC entry 2272 (class 2606 OID 16520)
-- Name: votos_ibfk_2; Type: FK CONSTRAINT; Schema: public; Owner: warorface
--

ALTER TABLE ONLY votos
    ADD CONSTRAINT votos_ibfk_2 FOREIGN KEY (id_eleccion) REFERENCES elecciones(id);


--
-- TOC entry 2287 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: warorface
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM warorface;
GRANT ALL ON SCHEMA public TO warorface;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-11-29 00:21:26 CLST

--
-- PostgreSQL database dump complete
--

