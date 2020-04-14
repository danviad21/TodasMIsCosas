--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

-- Started on 2019-09-11 15:27:03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE coinpa1;
--
-- TOC entry 4067 (class 1262 OID 16384)
-- Name: coinpa1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE coinpa1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE coinpa1 OWNER TO postgres;

\connect coinpa1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 213 (class 1259 OID 16869)
-- Name: Area_Personal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Area_Personal" (
    id_area_personal integer NOT NULL,
    cod_interno_area_personal character varying(5) NOT NULL,
    descrip_area_personal character varying(50) NOT NULL,
    status_area_personal integer,
    id_posicion integer,
    CONSTRAINT "Area_Personal_status_area_personal_check" CHECK ((status_area_personal = 0))
);


ALTER TABLE public."Area_Personal" OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16867)
-- Name: Area_Personal_id_area_personal_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Area_Personal_id_area_personal_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Area_Personal_id_area_personal_seq" OWNER TO postgres;

--
-- TOC entry 4068 (class 0 OID 0)
-- Dependencies: 212
-- Name: Area_Personal_id_area_personal_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Area_Personal_id_area_personal_seq" OWNED BY public."Area_Personal".id_area_personal;


--
-- TOC entry 225 (class 1259 OID 17033)
-- Name: Bitacora; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Bitacora" (
    numero_registro_bitacora integer NOT NULL,
    codigo_modulo integer,
    descrip_registro character varying(150) NOT NULL,
    creado timestamp without time zone NOT NULL,
    actualizado timestamp without time zone NOT NULL,
    creado_por character varying(15),
    actualizado_por character varying(15),
    id_usuario_creo integer,
    id_usuario_actualizo integer
);


ALTER TABLE public."Bitacora" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17031)
-- Name: Bitacora_numero_registro_bitacora_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Bitacora_numero_registro_bitacora_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Bitacora_numero_registro_bitacora_seq" OWNER TO postgres;

--
-- TOC entry 4069 (class 0 OID 0)
-- Dependencies: 224
-- Name: Bitacora_numero_registro_bitacora_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Bitacora_numero_registro_bitacora_seq" OWNED BY public."Bitacora".numero_registro_bitacora;


--
-- TOC entry 205 (class 1259 OID 16768)
-- Name: Departamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Departamento" (
    id_departamento integer NOT NULL,
    nombre_departamento character varying(60) NOT NULL,
    status_departamento integer NOT NULL,
    id_pais integer,
    CONSTRAINT "Departamento_status_departamento_check" CHECK (((status_departamento = 1) OR (status_departamento = 0)))
);


ALTER TABLE public."Departamento" OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16766)
-- Name: Departamento_id_departamento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Departamento_id_departamento_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Departamento_id_departamento_seq" OWNER TO postgres;

--
-- TOC entry 4070 (class 0 OID 0)
-- Dependencies: 204
-- Name: Departamento_id_departamento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Departamento_id_departamento_seq" OWNED BY public."Departamento".id_departamento;


--
-- TOC entry 209 (class 1259 OID 16818)
-- Name: Domicilio_Fiscal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Domicilio_Fiscal" (
    id_domicilio_fiscal integer NOT NULL,
    descrip_domicilio_fiscal character varying(100) NOT NULL,
    dir_zona smallint DEFAULT 0 NOT NULL,
    dir_avenida smallint DEFAULT 0 NOT NULL,
    dir_numero_calle smallint DEFAULT 0 NOT NULL,
    numero_edificio character varying(5) DEFAULT ''::character varying NOT NULL,
    status_domicilio_fiscal smallint NOT NULL,
    id_municipio integer,
    CONSTRAINT "Direccion_Empleado_status_direccion_empleado_check" CHECK (((status_domicilio_fiscal = 1) OR (status_domicilio_fiscal = 0)))
);


ALTER TABLE public."Domicilio_Fiscal" OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16816)
-- Name: Direccion_Empleado_id_direccion_empleado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Direccion_Empleado_id_direccion_empleado_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Direccion_Empleado_id_direccion_empleado_seq" OWNER TO postgres;

--
-- TOC entry 4071 (class 0 OID 0)
-- Dependencies: 208
-- Name: Direccion_Empleado_id_direccion_empleado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Direccion_Empleado_id_direccion_empleado_seq" OWNED BY public."Domicilio_Fiscal".id_domicilio_fiscal;


--
-- TOC entry 241 (class 1259 OID 17223)
-- Name: Empleado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Empleado" (
    id_reg_empleado integer NOT NULL,
    cod_empleado_empresa_corporativo character varying(15) NOT NULL,
    fecha_contratacion date NOT NULL,
    fecha_baja_contratacion date,
    id_persona integer,
    id_grupo_empleado integer,
    id_puesto_trabajo integer
);


ALTER TABLE public."Empleado" OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 17221)
-- Name: Empleado_id_reg_empleado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Empleado_id_reg_empleado_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Empleado_id_reg_empleado_seq" OWNER TO postgres;

--
-- TOC entry 4072 (class 0 OID 0)
-- Dependencies: 240
-- Name: Empleado_id_reg_empleado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Empleado_id_reg_empleado_seq" OWNED BY public."Empleado".id_reg_empleado;


--
-- TOC entry 237 (class 1259 OID 17170)
-- Name: Empresa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Empresa" (
    id_empresa integer NOT NULL,
    razon_social_empresa character varying(45) NOT NULL,
    nombre_comercial character varying(45) NOT NULL,
    telefono_empresa character varying(9) NOT NULL,
    email_empresa character varying(50) NOT NULL,
    domicilio_fiscal_empresa integer,
    status_empresa smallint NOT NULL,
    CONSTRAINT "Empresa_status_empresa_check" CHECK (((status_empresa = 0) OR (status_empresa = 1)))
);


ALTER TABLE public."Empresa" OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 17255)
-- Name: Empresa_SubdivisionPersonal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Empresa_SubdivisionPersonal" (
    id_empresa integer NOT NULL,
    id_subdivision_personal integer NOT NULL,
    status_emp_subdiv smallint NOT NULL,
    creado timestamp(0) without time zone NOT NULL,
    actualizado timestamp(0) without time zone,
    creado_por character varying(25) NOT NULL,
    actualizado_por character varying(25),
    CONSTRAINT "Empresa_SubdivisionPersonal_status_rol_check" CHECK (((status_emp_subdiv = 1) OR (status_emp_subdiv = 1)))
);


ALTER TABLE public."Empresa_SubdivisionPersonal" OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 17168)
-- Name: Empresa_id_empresa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Empresa_id_empresa_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Empresa_id_empresa_seq" OWNER TO postgres;

--
-- TOC entry 4073 (class 0 OID 0)
-- Dependencies: 236
-- Name: Empresa_id_empresa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Empresa_id_empresa_seq" OWNED BY public."Empresa".id_empresa;


--
-- TOC entry 247 (class 1259 OID 17370)
-- Name: Grupo_Empleado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Grupo_Empleado" (
    id_grupo_empleado integer NOT NULL,
    descrip_grupo character varying(25) NOT NULL
);


ALTER TABLE public."Grupo_Empleado" OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 17383)
-- Name: Grupo_Empleado_Contrato; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Grupo_Empleado_Contrato" (
    id_grupo_empleado integer,
    id_tipo_contrato integer,
    status_grupo_tipo_contrato smallint,
    creado timestamp without time zone NOT NULL,
    actualizado timestamp without time zone NOT NULL,
    creado_por character varying(25) NOT NULL,
    acutalizado_por character varying(50),
    CONSTRAINT "Grupo_Empleado_Contrato_status_grupo_tipo_contrato_check" CHECK (((status_grupo_tipo_contrato = 0) OR (status_grupo_tipo_contrato = 1)))
);


ALTER TABLE public."Grupo_Empleado_Contrato" OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16784)
-- Name: Municipio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Municipio" (
    id_municipio integer NOT NULL,
    codigo_municipio integer NOT NULL,
    nombre_municipio character varying(35) NOT NULL,
    status_municipio integer NOT NULL,
    id_departamento integer
);


ALTER TABLE public."Municipio" OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16782)
-- Name: Municipio_id_municipio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Municipio_id_municipio_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Municipio_id_municipio_seq" OWNER TO postgres;

--
-- TOC entry 4074 (class 0 OID 0)
-- Dependencies: 206
-- Name: Municipio_id_municipio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Municipio_id_municipio_seq" OWNED BY public."Municipio".id_municipio;


--
-- TOC entry 249 (class 1259 OID 17413)
-- Name: Municipio_id_municipio_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Municipio" ALTER COLUMN id_municipio ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Municipio_id_municipio_seq1"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 211 (class 1259 OID 16838)
-- Name: Nomina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Nomina" (
    id_nomina integer NOT NULL,
    cod_nomina character varying(2) NOT NULL,
    descrip_nomina character varying(40) NOT NULL,
    status_nomina smallint,
    id_tipo_contrato integer,
    CONSTRAINT "Nomina_status_nomina_check" CHECK (((status_nomina = 0) OR (status_nomina = 1)))
);


ALTER TABLE public."Nomina" OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16836)
-- Name: Nomina_id_nomina_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Nomina_id_nomina_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Nomina_id_nomina_seq" OWNER TO postgres;

--
-- TOC entry 4075 (class 0 OID 0)
-- Dependencies: 210
-- Name: Nomina_id_nomina_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Nomina_id_nomina_seq" OWNED BY public."Nomina".id_nomina;


--
-- TOC entry 203 (class 1259 OID 16757)
-- Name: Pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Pais" (
    id_pais integer NOT NULL,
    nombre_pais character varying(56) NOT NULL,
    status_pais integer NOT NULL,
    CONSTRAINT "Pais_status_pais_check" CHECK (((status_pais = 1) OR (status_pais = 0)))
);


ALTER TABLE public."Pais" OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16755)
-- Name: Pais_id_pais_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Pais_id_pais_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Pais_id_pais_seq" OWNER TO postgres;

--
-- TOC entry 4076 (class 0 OID 0)
-- Dependencies: 202
-- Name: Pais_id_pais_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Pais_id_pais_seq" OWNED BY public."Pais".id_pais;


--
-- TOC entry 221 (class 1259 OID 16980)
-- Name: Permiso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Permiso" (
    id_permiso integer NOT NULL,
    cod_interno_permiso character varying(10) NOT NULL,
    descrip_permiso character varying(30) NOT NULL,
    status_permiso smallint,
    creado timestamp without time zone NOT NULL,
    actualizado timestamp without time zone NOT NULL,
    creado_por character varying(25) NOT NULL,
    acutalizado_por character varying(50),
    CONSTRAINT "Permiso_status_permiso_check" CHECK (((status_permiso = 0) OR (status_permiso = 1)))
);


ALTER TABLE public."Permiso" OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17079)
-- Name: Permiso_Usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Permiso_Usuario" (
    numero_registro_permiso_usuario integer NOT NULL,
    descrip_permiso_usuario character varying(50) NOT NULL,
    creado timestamp without time zone NOT NULL,
    actualizado timestamp without time zone,
    status_permiso_usuario integer NOT NULL,
    id_permiso integer,
    id_usuario integer,
    CONSTRAINT "Permiso_Usuario_status_permiso_usuario_check" CHECK (((status_permiso_usuario = 0) OR (status_permiso_usuario = 1)))
);


ALTER TABLE public."Permiso_Usuario" OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17077)
-- Name: Permiso_Usuario_numero_registro_permiso_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Permiso_Usuario_numero_registro_permiso_usuario_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Permiso_Usuario_numero_registro_permiso_usuario_seq" OWNER TO postgres;

--
-- TOC entry 4077 (class 0 OID 0)
-- Dependencies: 230
-- Name: Permiso_Usuario_numero_registro_permiso_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Permiso_Usuario_numero_registro_permiso_usuario_seq" OWNED BY public."Permiso_Usuario".numero_registro_permiso_usuario;


--
-- TOC entry 220 (class 1259 OID 16978)
-- Name: Permiso_id_permiso_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Permiso_id_permiso_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Permiso_id_permiso_seq" OWNER TO postgres;

--
-- TOC entry 4078 (class 0 OID 0)
-- Dependencies: 220
-- Name: Permiso_id_permiso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Permiso_id_permiso_seq" OWNED BY public."Permiso".id_permiso;


--
-- TOC entry 239 (class 1259 OID 17198)
-- Name: Persona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Persona" (
    id_persona integer NOT NULL,
    nombre_1 character varying(25) NOT NULL,
    nombre_2 character varying(25),
    apellido_1 character varying(45) NOT NULL,
    apellido_2 character varying(45),
    apellido_casado character varying(45),
    genero_persona smallint DEFAULT 0 NOT NULL,
    nit_persona character varying(15) NOT NULL,
    telefono_persona character varying(9),
    estado_civil_persona character varying(15) NOT NULL,
    documento_identificacion integer,
    id_direccion_persona integer,
    identificacion character varying(13),
    id_puesto_trabajo integer,
    CONSTRAINT "Persona_genero_check" CHECK (((genero_persona = 0) OR (genero_persona = 1) OR (genero_persona = 2)))
);


ALTER TABLE public."Persona" OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 17196)
-- Name: Persona_id_persona_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Persona_id_persona_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Persona_id_persona_seq" OWNER TO postgres;

--
-- TOC entry 4079 (class 0 OID 0)
-- Dependencies: 238
-- Name: Persona_id_persona_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Persona_id_persona_seq" OWNED BY public."Persona".id_persona;


--
-- TOC entry 235 (class 1259 OID 17120)
-- Name: Posicion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Posicion" (
    id_posicion integer NOT NULL,
    cod_posicion character varying(8) NOT NULL,
    descrip_posicion character varying(50) NOT NULL,
    status_posicion smallint,
    CONSTRAINT "Posicion_status_posicion_check" CHECK (((status_posicion = 0) OR (status_posicion = 1)))
);


ALTER TABLE public."Posicion" OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 17118)
-- Name: Posicion_id_posicion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Posicion_id_posicion_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Posicion_id_posicion_seq" OWNER TO postgres;

--
-- TOC entry 4080 (class 0 OID 0)
-- Dependencies: 234
-- Name: Posicion_id_posicion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Posicion_id_posicion_seq" OWNED BY public."Posicion".id_posicion;


--
-- TOC entry 245 (class 1259 OID 17354)
-- Name: Puesto_Trabajo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Puesto_Trabajo" (
    id_puesto_trabajo integer NOT NULL,
    cod_interno_puesto character varying(10) NOT NULL,
    status_puesto_trabajo smallint NOT NULL,
    id_area_personal integer,
    CONSTRAINT "Puesto_Trabajo_status_puesto_trabajo_check" CHECK (((status_puesto_trabajo = 0) OR (status_puesto_trabajo = 0)))
);


ALTER TABLE public."Puesto_Trabajo" OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 17352)
-- Name: Puesto_Trabajo_id_puesto_trabajo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Puesto_Trabajo_id_puesto_trabajo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Puesto_Trabajo_id_puesto_trabajo_seq" OWNER TO postgres;

--
-- TOC entry 4081 (class 0 OID 0)
-- Dependencies: 244
-- Name: Puesto_Trabajo_id_puesto_trabajo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Puesto_Trabajo_id_puesto_trabajo_seq" OWNED BY public."Puesto_Trabajo".id_puesto_trabajo;


--
-- TOC entry 229 (class 1259 OID 17066)
-- Name: Relacion_Laboral; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Relacion_Laboral" (
    id_relacion_lab integer NOT NULL,
    cod_relacion_lab character varying(3) NOT NULL,
    descrip_relacion_lab character varying(50) NOT NULL,
    status_relacion_lab smallint,
    id_unidad_organizativa integer,
    CONSTRAINT "Relacion_Laboral_status_relacion_lab_check" CHECK (((status_relacion_lab = 0) OR (status_relacion_lab = 1)))
);


ALTER TABLE public."Relacion_Laboral" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17064)
-- Name: Relacion_Laboral_id_relacion_lab_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Relacion_Laboral_id_relacion_lab_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Relacion_Laboral_id_relacion_lab_seq" OWNER TO postgres;

--
-- TOC entry 4082 (class 0 OID 0)
-- Dependencies: 228
-- Name: Relacion_Laboral_id_relacion_lab_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Relacion_Laboral_id_relacion_lab_seq" OWNED BY public."Relacion_Laboral".id_relacion_lab;


--
-- TOC entry 227 (class 1259 OID 17053)
-- Name: Rol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Rol" (
    id_rol integer NOT NULL,
    descrip_rol character varying(50) NOT NULL,
    creado timestamp(0) without time zone NOT NULL,
    actualizado timestamp(0) without time zone,
    creado_por character varying(25) NOT NULL,
    actualizado_por character varying(25),
    status_rol smallint NOT NULL,
    CONSTRAINT "Rol_status_rol_check" CHECK (((status_rol = 1) OR (status_rol = 1)))
);


ALTER TABLE public."Rol" OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17100)
-- Name: Rol_Usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Rol_Usuario" (
    numero_registro integer NOT NULL,
    status_rol_usuario smallint NOT NULL,
    id_rol integer,
    id_usuario integer,
    creado timestamp without time zone NOT NULL,
    actualizado timestamp without time zone[],
    creado_por integer[] NOT NULL,
    actualizado_por integer,
    CONSTRAINT "Rol_Usuario_status_rol_usuario_check" CHECK (((status_rol_usuario = 1) OR (status_rol_usuario = 1)))
);


ALTER TABLE public."Rol_Usuario" OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17098)
-- Name: Rol_Usuario_numero_registro_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Rol_Usuario_numero_registro_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Rol_Usuario_numero_registro_seq" OWNER TO postgres;

--
-- TOC entry 4083 (class 0 OID 0)
-- Dependencies: 232
-- Name: Rol_Usuario_numero_registro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Rol_Usuario_numero_registro_seq" OWNED BY public."Rol_Usuario".numero_registro;


--
-- TOC entry 226 (class 1259 OID 17051)
-- Name: Rol_id_rol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Rol_id_rol_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Rol_id_rol_seq" OWNER TO postgres;

--
-- TOC entry 4084 (class 0 OID 0)
-- Dependencies: 226
-- Name: Rol_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Rol_id_rol_seq" OWNED BY public."Rol".id_rol;


--
-- TOC entry 243 (class 1259 OID 17297)
-- Name: SubdivisionPersonal_Relacion_Laboral; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SubdivisionPersonal_Relacion_Laboral" (
    id_subdivision_personal integer NOT NULL,
    id_relacion_laboral integer NOT NULL,
    status_subdiv_rel_lab smallint NOT NULL,
    creado timestamp(0) without time zone NOT NULL,
    actualizado timestamp(0) without time zone,
    creado_por character varying(25) NOT NULL,
    actualizado_por character varying(25),
    CONSTRAINT "SubdivisionPersonal_Relacion_Labora_status_subdiv_rel_lab_check" CHECK (((status_subdiv_rel_lab = 1) OR (status_subdiv_rel_lab = 1)))
);


ALTER TABLE public."SubdivisionPersonal_Relacion_Laboral" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16899)
-- Name: Subdivision_Personal(Ubicacion); Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Subdivision_Personal(Ubicacion)" (
    id_subdivision_personal integer NOT NULL,
    cod_subdivision_personal character varying(5) NOT NULL,
    descrip_subdivision_personal character varying(50) NOT NULL,
    status_subdivision_personal smallint,
    CONSTRAINT "Subdivision_Personal(Ubicacio_status_subdivision_personal_check" CHECK (((status_subdivision_personal = 0) OR (status_subdivision_personal = 1)))
);


ALTER TABLE public."Subdivision_Personal(Ubicacion)" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16897)
-- Name: Subdivision_Personal(Ubicacion)_id_subdivision_personal_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Subdivision_Personal(Ubicacion)_id_subdivision_personal_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Subdivision_Personal(Ubicacion)_id_subdivision_personal_seq" OWNER TO postgres;

--
-- TOC entry 4085 (class 0 OID 0)
-- Dependencies: 216
-- Name: Subdivision_Personal(Ubicacion)_id_subdivision_personal_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Subdivision_Personal(Ubicacion)_id_subdivision_personal_seq" OWNED BY public."Subdivision_Personal(Ubicacion)".id_subdivision_personal;


--
-- TOC entry 219 (class 1259 OID 16912)
-- Name: Tipo_Contrato; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Tipo_Contrato" (
    id_tipo_contrato_lab integer NOT NULL,
    cod_contrato_lab character varying(8) NOT NULL,
    descrip_contrato_lab character varying(50) NOT NULL,
    status_contrato_lab smallint,
    id_nomina integer,
    CONSTRAINT "Tipo_Contrato_status_contrato_lab_check" CHECK (((status_contrato_lab = 0) OR (status_contrato_lab = 1)))
);


ALTER TABLE public."Tipo_Contrato" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16910)
-- Name: Tipo_Contrato_id_contrato_lab_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Tipo_Contrato_id_contrato_lab_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Tipo_Contrato_id_contrato_lab_seq" OWNER TO postgres;

--
-- TOC entry 4086 (class 0 OID 0)
-- Dependencies: 218
-- Name: Tipo_Contrato_id_contrato_lab_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Tipo_Contrato_id_contrato_lab_seq" OWNED BY public."Tipo_Contrato".id_tipo_contrato_lab;


--
-- TOC entry 215 (class 1259 OID 16884)
-- Name: Unidad_Organizativa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Unidad_Organizativa" (
    id_unidad_organizativa integer NOT NULL,
    cod_unidad_organizativa character varying(5) NOT NULL,
    descrip_unidad_organizativa character varying(50) NOT NULL,
    status_unidad_organizativa smallint,
    id_posicion integer,
    CONSTRAINT "Unidad_Organizativa_status_unidad_organizativa_check" CHECK (((status_unidad_organizativa = 0) OR (status_unidad_organizativa = 1)))
);


ALTER TABLE public."Unidad_Organizativa" OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16882)
-- Name: Unidad_Organizativa_id_unidad_organizativa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Unidad_Organizativa_id_unidad_organizativa_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Unidad_Organizativa_id_unidad_organizativa_seq" OWNER TO postgres;

--
-- TOC entry 4087 (class 0 OID 0)
-- Dependencies: 214
-- Name: Unidad_Organizativa_id_unidad_organizativa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Unidad_Organizativa_id_unidad_organizativa_seq" OWNED BY public."Unidad_Organizativa".id_unidad_organizativa;


--
-- TOC entry 223 (class 1259 OID 17009)
-- Name: Usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Usuario" (
    id_usuario integer NOT NULL,
    nombre_usuario bytea NOT NULL,
    contrasenia_usuario bytea NOT NULL,
    huella_digital bytea,
    email_usuario character varying(50) NOT NULL,
    creado timestamp(0) without time zone NOT NULL,
    actualizado timestamp(0) without time zone,
    creado_por character varying(25) NOT NULL,
    actualizado_por character varying(50),
    id_reg_empleado integer
);


ALTER TABLE public."Usuario" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17007)
-- Name: Usuario_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Usuario_id_usuario_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Usuario_id_usuario_seq" OWNER TO postgres;

--
-- TOC entry 4088 (class 0 OID 0)
-- Dependencies: 222
-- Name: Usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Usuario_id_usuario_seq" OWNED BY public."Usuario".id_usuario;


--
-- TOC entry 246 (class 1259 OID 17368)
-- Name: grupo_empleado_tipo_contrato_numero_registro_grupo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.grupo_empleado_tipo_contrato_numero_registro_grupo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grupo_empleado_tipo_contrato_numero_registro_grupo_seq OWNER TO postgres;

--
-- TOC entry 4089 (class 0 OID 0)
-- Dependencies: 246
-- Name: grupo_empleado_tipo_contrato_numero_registro_grupo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.grupo_empleado_tipo_contrato_numero_registro_grupo_seq OWNED BY public."Grupo_Empleado".id_grupo_empleado;


--
-- TOC entry 3714 (class 2604 OID 16872)
-- Name: Area_Personal id_area_personal; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Area_Personal" ALTER COLUMN id_area_personal SET DEFAULT nextval('public."Area_Personal_id_area_personal_seq"'::regclass);


--
-- TOC entry 3725 (class 2604 OID 17036)
-- Name: Bitacora numero_registro_bitacora; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bitacora" ALTER COLUMN numero_registro_bitacora SET DEFAULT nextval('public."Bitacora_numero_registro_bitacora_seq"'::regclass);


--
-- TOC entry 3704 (class 2604 OID 16771)
-- Name: Departamento id_departamento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Departamento" ALTER COLUMN id_departamento SET DEFAULT nextval('public."Departamento_id_departamento_seq"'::regclass);


--
-- TOC entry 3706 (class 2604 OID 16821)
-- Name: Domicilio_Fiscal id_domicilio_fiscal; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Domicilio_Fiscal" ALTER COLUMN id_domicilio_fiscal SET DEFAULT nextval('public."Direccion_Empleado_id_direccion_empleado_seq"'::regclass);


--
-- TOC entry 3741 (class 2604 OID 17226)
-- Name: Empleado id_reg_empleado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empleado" ALTER COLUMN id_reg_empleado SET DEFAULT nextval('public."Empleado_id_reg_empleado_seq"'::regclass);


--
-- TOC entry 3736 (class 2604 OID 17173)
-- Name: Empresa id_empresa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empresa" ALTER COLUMN id_empresa SET DEFAULT nextval('public."Empresa_id_empresa_seq"'::regclass);


--
-- TOC entry 3746 (class 2604 OID 17373)
-- Name: Grupo_Empleado id_grupo_empleado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Grupo_Empleado" ALTER COLUMN id_grupo_empleado SET DEFAULT nextval('public.grupo_empleado_tipo_contrato_numero_registro_grupo_seq'::regclass);


--
-- TOC entry 3712 (class 2604 OID 16841)
-- Name: Nomina id_nomina; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Nomina" ALTER COLUMN id_nomina SET DEFAULT nextval('public."Nomina_id_nomina_seq"'::regclass);


--
-- TOC entry 3702 (class 2604 OID 16760)
-- Name: Pais id_pais; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Pais" ALTER COLUMN id_pais SET DEFAULT nextval('public."Pais_id_pais_seq"'::regclass);


--
-- TOC entry 3722 (class 2604 OID 16983)
-- Name: Permiso id_permiso; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Permiso" ALTER COLUMN id_permiso SET DEFAULT nextval('public."Permiso_id_permiso_seq"'::regclass);


--
-- TOC entry 3730 (class 2604 OID 17082)
-- Name: Permiso_Usuario numero_registro_permiso_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Permiso_Usuario" ALTER COLUMN numero_registro_permiso_usuario SET DEFAULT nextval('public."Permiso_Usuario_numero_registro_permiso_usuario_seq"'::regclass);


--
-- TOC entry 3739 (class 2604 OID 17201)
-- Name: Persona id_persona; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Persona" ALTER COLUMN id_persona SET DEFAULT nextval('public."Persona_id_persona_seq"'::regclass);


--
-- TOC entry 3734 (class 2604 OID 17123)
-- Name: Posicion id_posicion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Posicion" ALTER COLUMN id_posicion SET DEFAULT nextval('public."Posicion_id_posicion_seq"'::regclass);


--
-- TOC entry 3744 (class 2604 OID 17357)
-- Name: Puesto_Trabajo id_puesto_trabajo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Puesto_Trabajo" ALTER COLUMN id_puesto_trabajo SET DEFAULT nextval('public."Puesto_Trabajo_id_puesto_trabajo_seq"'::regclass);


--
-- TOC entry 3728 (class 2604 OID 17069)
-- Name: Relacion_Laboral id_relacion_lab; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Relacion_Laboral" ALTER COLUMN id_relacion_lab SET DEFAULT nextval('public."Relacion_Laboral_id_relacion_lab_seq"'::regclass);


--
-- TOC entry 3726 (class 2604 OID 17056)
-- Name: Rol id_rol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rol" ALTER COLUMN id_rol SET DEFAULT nextval('public."Rol_id_rol_seq"'::regclass);


--
-- TOC entry 3732 (class 2604 OID 17103)
-- Name: Rol_Usuario numero_registro; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rol_Usuario" ALTER COLUMN numero_registro SET DEFAULT nextval('public."Rol_Usuario_numero_registro_seq"'::regclass);


--
-- TOC entry 3718 (class 2604 OID 16902)
-- Name: Subdivision_Personal(Ubicacion) id_subdivision_personal; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Subdivision_Personal(Ubicacion)" ALTER COLUMN id_subdivision_personal SET DEFAULT nextval('public."Subdivision_Personal(Ubicacion)_id_subdivision_personal_seq"'::regclass);


--
-- TOC entry 3720 (class 2604 OID 16915)
-- Name: Tipo_Contrato id_tipo_contrato_lab; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tipo_Contrato" ALTER COLUMN id_tipo_contrato_lab SET DEFAULT nextval('public."Tipo_Contrato_id_contrato_lab_seq"'::regclass);


--
-- TOC entry 3716 (class 2604 OID 16887)
-- Name: Unidad_Organizativa id_unidad_organizativa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Unidad_Organizativa" ALTER COLUMN id_unidad_organizativa SET DEFAULT nextval('public."Unidad_Organizativa_id_unidad_organizativa_seq"'::regclass);


--
-- TOC entry 3724 (class 2604 OID 17012)
-- Name: Usuario id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuario" ALTER COLUMN id_usuario SET DEFAULT nextval('public."Usuario_id_usuario_seq"'::regclass);


--
-- TOC entry 4025 (class 0 OID 16869)
-- Dependencies: 213
-- Data for Name: Area_Personal; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4037 (class 0 OID 17033)
-- Dependencies: 225
-- Data for Name: Bitacora; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4017 (class 0 OID 16768)
-- Dependencies: 205
-- Data for Name: Departamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Departamento" (id_departamento, nombre_departamento, status_departamento, id_pais) VALUES (1, 'Guatemala', 1, 1);
INSERT INTO public."Departamento" (id_departamento, nombre_departamento, status_departamento, id_pais) VALUES (2, 'El Progreso', 1, 1);
INSERT INTO public."Departamento" (id_departamento, nombre_departamento, status_departamento, id_pais) VALUES (3, 'Sacatepequez', 1, 1);
INSERT INTO public."Departamento" (id_departamento, nombre_departamento, status_departamento, id_pais) VALUES (4, 'Chimaltenango', 1, 1);
INSERT INTO public."Departamento" (id_departamento, nombre_departamento, status_departamento, id_pais) VALUES (5, 'Escuintla', 1, 1);
INSERT INTO public."Departamento" (id_departamento, nombre_departamento, status_departamento, id_pais) VALUES (6, 'Santa Rosa', 1, 1);
INSERT INTO public."Departamento" (id_departamento, nombre_departamento, status_departamento, id_pais) VALUES (7, 'Solola', 1, 1);
INSERT INTO public."Departamento" (id_departamento, nombre_departamento, status_departamento, id_pais) VALUES (8, 'Totonicapan', 1, 1);
INSERT INTO public."Departamento" (id_departamento, nombre_departamento, status_departamento, id_pais) VALUES (9, 'Quetzaltenango', 1, 1);
INSERT INTO public."Departamento" (id_departamento, nombre_departamento, status_departamento, id_pais) VALUES (10, 'Suchitepequez', 1, 1);
INSERT INTO public."Departamento" (id_departamento, nombre_departamento, status_departamento, id_pais) VALUES (11, 'Retalhuleu', 1, 1);
INSERT INTO public."Departamento" (id_departamento, nombre_departamento, status_departamento, id_pais) VALUES (12, 'San Marcos', 1, 1);
INSERT INTO public."Departamento" (id_departamento, nombre_departamento, status_departamento, id_pais) VALUES (13, 'Huehuetenango', 1, 1);
INSERT INTO public."Departamento" (id_departamento, nombre_departamento, status_departamento, id_pais) VALUES (14, 'Quiche', 1, 1);
INSERT INTO public."Departamento" (id_departamento, nombre_departamento, status_departamento, id_pais) VALUES (15, 'Baja Verapaz', 1, 1);
INSERT INTO public."Departamento" (id_departamento, nombre_departamento, status_departamento, id_pais) VALUES (16, 'Alta Verapaz', 1, 1);
INSERT INTO public."Departamento" (id_departamento, nombre_departamento, status_departamento, id_pais) VALUES (17, 'Peten', 1, 1);
INSERT INTO public."Departamento" (id_departamento, nombre_departamento, status_departamento, id_pais) VALUES (18, 'Izabal', 1, 1);
INSERT INTO public."Departamento" (id_departamento, nombre_departamento, status_departamento, id_pais) VALUES (19, 'Zacapa', 1, 1);
INSERT INTO public."Departamento" (id_departamento, nombre_departamento, status_departamento, id_pais) VALUES (20, 'Chiquimula', 1, 1);
INSERT INTO public."Departamento" (id_departamento, nombre_departamento, status_departamento, id_pais) VALUES (21, 'Jalapa', 1, 1);
INSERT INTO public."Departamento" (id_departamento, nombre_departamento, status_departamento, id_pais) VALUES (22, 'Jutiapa', 1, 1);


--
-- TOC entry 4021 (class 0 OID 16818)
-- Dependencies: 209
-- Data for Name: Domicilio_Fiscal; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4053 (class 0 OID 17223)
-- Dependencies: 241
-- Data for Name: Empleado; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4049 (class 0 OID 17170)
-- Dependencies: 237
-- Data for Name: Empresa; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4054 (class 0 OID 17255)
-- Dependencies: 242
-- Data for Name: Empresa_SubdivisionPersonal; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4059 (class 0 OID 17370)
-- Dependencies: 247
-- Data for Name: Grupo_Empleado; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4060 (class 0 OID 17383)
-- Dependencies: 248
-- Data for Name: Grupo_Empleado_Contrato; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4019 (class 0 OID 16784)
-- Dependencies: 207
-- Data for Name: Municipio; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4023 (class 0 OID 16838)
-- Dependencies: 211
-- Data for Name: Nomina; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4015 (class 0 OID 16757)
-- Dependencies: 203
-- Data for Name: Pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Pais" (id_pais, nombre_pais, status_pais) VALUES (1, 'Guatemala', 1);


--
-- TOC entry 4033 (class 0 OID 16980)
-- Dependencies: 221
-- Data for Name: Permiso; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4043 (class 0 OID 17079)
-- Dependencies: 231
-- Data for Name: Permiso_Usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4051 (class 0 OID 17198)
-- Dependencies: 239
-- Data for Name: Persona; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4047 (class 0 OID 17120)
-- Dependencies: 235
-- Data for Name: Posicion; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4057 (class 0 OID 17354)
-- Dependencies: 245
-- Data for Name: Puesto_Trabajo; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4041 (class 0 OID 17066)
-- Dependencies: 229
-- Data for Name: Relacion_Laboral; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4039 (class 0 OID 17053)
-- Dependencies: 227
-- Data for Name: Rol; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4045 (class 0 OID 17100)
-- Dependencies: 233
-- Data for Name: Rol_Usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4055 (class 0 OID 17297)
-- Dependencies: 243
-- Data for Name: SubdivisionPersonal_Relacion_Laboral; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4029 (class 0 OID 16899)
-- Dependencies: 217
-- Data for Name: Subdivision_Personal(Ubicacion); Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4031 (class 0 OID 16912)
-- Dependencies: 219
-- Data for Name: Tipo_Contrato; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4027 (class 0 OID 16884)
-- Dependencies: 215
-- Data for Name: Unidad_Organizativa; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4035 (class 0 OID 17009)
-- Dependencies: 223
-- Data for Name: Usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4090 (class 0 OID 0)
-- Dependencies: 212
-- Name: Area_Personal_id_area_personal_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Area_Personal_id_area_personal_seq"', 1, false);


--
-- TOC entry 4091 (class 0 OID 0)
-- Dependencies: 224
-- Name: Bitacora_numero_registro_bitacora_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Bitacora_numero_registro_bitacora_seq"', 1, false);


--
-- TOC entry 4092 (class 0 OID 0)
-- Dependencies: 204
-- Name: Departamento_id_departamento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Departamento_id_departamento_seq"', 1, false);


--
-- TOC entry 4093 (class 0 OID 0)
-- Dependencies: 208
-- Name: Direccion_Empleado_id_direccion_empleado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Direccion_Empleado_id_direccion_empleado_seq"', 1, false);


--
-- TOC entry 4094 (class 0 OID 0)
-- Dependencies: 240
-- Name: Empleado_id_reg_empleado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Empleado_id_reg_empleado_seq"', 1, false);


--
-- TOC entry 4095 (class 0 OID 0)
-- Dependencies: 236
-- Name: Empresa_id_empresa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Empresa_id_empresa_seq"', 1, false);


--
-- TOC entry 4096 (class 0 OID 0)
-- Dependencies: 206
-- Name: Municipio_id_municipio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Municipio_id_municipio_seq"', 1, true);


--
-- TOC entry 4097 (class 0 OID 0)
-- Dependencies: 249
-- Name: Municipio_id_municipio_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Municipio_id_municipio_seq1"', 1, false);


--
-- TOC entry 4098 (class 0 OID 0)
-- Dependencies: 210
-- Name: Nomina_id_nomina_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Nomina_id_nomina_seq"', 1, false);


--
-- TOC entry 4099 (class 0 OID 0)
-- Dependencies: 202
-- Name: Pais_id_pais_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Pais_id_pais_seq"', 1, true);


--
-- TOC entry 4100 (class 0 OID 0)
-- Dependencies: 230
-- Name: Permiso_Usuario_numero_registro_permiso_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Permiso_Usuario_numero_registro_permiso_usuario_seq"', 1, false);


--
-- TOC entry 4101 (class 0 OID 0)
-- Dependencies: 220
-- Name: Permiso_id_permiso_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Permiso_id_permiso_seq"', 1, false);


--
-- TOC entry 4102 (class 0 OID 0)
-- Dependencies: 238
-- Name: Persona_id_persona_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Persona_id_persona_seq"', 1, false);


--
-- TOC entry 4103 (class 0 OID 0)
-- Dependencies: 234
-- Name: Posicion_id_posicion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Posicion_id_posicion_seq"', 1, false);


--
-- TOC entry 4104 (class 0 OID 0)
-- Dependencies: 244
-- Name: Puesto_Trabajo_id_puesto_trabajo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Puesto_Trabajo_id_puesto_trabajo_seq"', 1, false);


--
-- TOC entry 4105 (class 0 OID 0)
-- Dependencies: 228
-- Name: Relacion_Laboral_id_relacion_lab_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Relacion_Laboral_id_relacion_lab_seq"', 1, false);


--
-- TOC entry 4106 (class 0 OID 0)
-- Dependencies: 232
-- Name: Rol_Usuario_numero_registro_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Rol_Usuario_numero_registro_seq"', 1, false);


--
-- TOC entry 4107 (class 0 OID 0)
-- Dependencies: 226
-- Name: Rol_id_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Rol_id_rol_seq"', 1, false);


--
-- TOC entry 4108 (class 0 OID 0)
-- Dependencies: 216
-- Name: Subdivision_Personal(Ubicacion)_id_subdivision_personal_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Subdivision_Personal(Ubicacion)_id_subdivision_personal_seq"', 1, false);


--
-- TOC entry 4109 (class 0 OID 0)
-- Dependencies: 218
-- Name: Tipo_Contrato_id_contrato_lab_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Tipo_Contrato_id_contrato_lab_seq"', 1, false);


--
-- TOC entry 4110 (class 0 OID 0)
-- Dependencies: 214
-- Name: Unidad_Organizativa_id_unidad_organizativa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Unidad_Organizativa_id_unidad_organizativa_seq"', 1, false);


--
-- TOC entry 4111 (class 0 OID 0)
-- Dependencies: 222
-- Name: Usuario_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Usuario_id_usuario_seq"', 1, false);


--
-- TOC entry 4112 (class 0 OID 0)
-- Dependencies: 246
-- Name: grupo_empleado_tipo_contrato_numero_registro_grupo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grupo_empleado_tipo_contrato_numero_registro_grupo_seq', 1, false);


--
-- TOC entry 3767 (class 2606 OID 16877)
-- Name: Area_Personal Area_Personal_cod_interno_area_personal_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Area_Personal"
    ADD CONSTRAINT "Area_Personal_cod_interno_area_personal_key" UNIQUE (cod_interno_area_personal);


--
-- TOC entry 3769 (class 2606 OID 16879)
-- Name: Area_Personal Area_Personal_descrip_area_personal_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Area_Personal"
    ADD CONSTRAINT "Area_Personal_descrip_area_personal_key" UNIQUE (descrip_area_personal);


--
-- TOC entry 3771 (class 2606 OID 16875)
-- Name: Area_Personal Area_Personal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Area_Personal"
    ADD CONSTRAINT "Area_Personal_pkey" PRIMARY KEY (id_area_personal);


--
-- TOC entry 3807 (class 2606 OID 17040)
-- Name: Bitacora Bitacora_descrip_registro_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bitacora"
    ADD CONSTRAINT "Bitacora_descrip_registro_key" UNIQUE (descrip_registro);


--
-- TOC entry 3809 (class 2606 OID 17038)
-- Name: Bitacora Bitacora_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bitacora"
    ADD CONSTRAINT "Bitacora_pkey" PRIMARY KEY (numero_registro_bitacora);


--
-- TOC entry 3753 (class 2606 OID 16776)
-- Name: Departamento Departamento_nombre_departamento_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Departamento"
    ADD CONSTRAINT "Departamento_nombre_departamento_key" UNIQUE (nombre_departamento);


--
-- TOC entry 3755 (class 2606 OID 16774)
-- Name: Departamento Departamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Departamento"
    ADD CONSTRAINT "Departamento_pkey" PRIMARY KEY (id_departamento);


--
-- TOC entry 3759 (class 2606 OID 17329)
-- Name: Domicilio_Fiscal Direccion_Empleado_descrip_direccion_empleado_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Domicilio_Fiscal"
    ADD CONSTRAINT "Direccion_Empleado_descrip_direccion_empleado_key" UNIQUE (descrip_domicilio_fiscal);


--
-- TOC entry 3761 (class 2606 OID 16828)
-- Name: Domicilio_Fiscal Direccion_Empleado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Domicilio_Fiscal"
    ADD CONSTRAINT "Direccion_Empleado_pkey" PRIMARY KEY (id_domicilio_fiscal);


--
-- TOC entry 3845 (class 2606 OID 17207)
-- Name: Persona Documento_Identificacion_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Persona"
    ADD CONSTRAINT "Documento_Identificacion_key" UNIQUE (documento_identificacion);


--
-- TOC entry 3853 (class 2606 OID 17230)
-- Name: Empleado Empleado_cod_empleado_empresa_corporativo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empleado"
    ADD CONSTRAINT "Empleado_cod_empleado_empresa_corporativo_key" UNIQUE (cod_empleado_empresa_corporativo);


--
-- TOC entry 3855 (class 2606 OID 17228)
-- Name: Empleado Empleado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empleado"
    ADD CONSTRAINT "Empleado_pkey" PRIMARY KEY (id_reg_empleado);


--
-- TOC entry 3857 (class 2606 OID 17260)
-- Name: Empresa_SubdivisionPersonal Empresa_SubdivisionPersonal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empresa_SubdivisionPersonal"
    ADD CONSTRAINT "Empresa_SubdivisionPersonal_pkey" PRIMARY KEY (id_empresa, id_subdivision_personal);


--
-- TOC entry 3835 (class 2606 OID 17184)
-- Name: Empresa Empresa_email_empresa_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empresa"
    ADD CONSTRAINT "Empresa_email_empresa_key" UNIQUE (email_empresa);


--
-- TOC entry 3837 (class 2606 OID 17180)
-- Name: Empresa Empresa_nombre_comercial_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empresa"
    ADD CONSTRAINT "Empresa_nombre_comercial_key" UNIQUE (nombre_comercial);


--
-- TOC entry 3839 (class 2606 OID 17176)
-- Name: Empresa Empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empresa"
    ADD CONSTRAINT "Empresa_pkey" PRIMARY KEY (id_empresa);


--
-- TOC entry 3841 (class 2606 OID 17178)
-- Name: Empresa Empresa_razon_social_empresa_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empresa"
    ADD CONSTRAINT "Empresa_razon_social_empresa_key" UNIQUE (razon_social_empresa);


--
-- TOC entry 3843 (class 2606 OID 17182)
-- Name: Empresa Empresa_telefono_empresa_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empresa"
    ADD CONSTRAINT "Empresa_telefono_empresa_key" UNIQUE (telefono_empresa);


--
-- TOC entry 3757 (class 2606 OID 16790)
-- Name: Municipio Municipio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Municipio"
    ADD CONSTRAINT "Municipio_pkey" PRIMARY KEY (id_municipio);


--
-- TOC entry 3763 (class 2606 OID 16846)
-- Name: Nomina Nomina_cod_nomina_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Nomina"
    ADD CONSTRAINT "Nomina_cod_nomina_key" UNIQUE (cod_nomina);


--
-- TOC entry 3765 (class 2606 OID 16844)
-- Name: Nomina Nomina_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Nomina"
    ADD CONSTRAINT "Nomina_pkey" PRIMARY KEY (id_nomina);


--
-- TOC entry 3749 (class 2606 OID 16765)
-- Name: Pais Pais_nombre_pais_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Pais"
    ADD CONSTRAINT "Pais_nombre_pais_key" UNIQUE (nombre_pais);


--
-- TOC entry 3751 (class 2606 OID 16763)
-- Name: Pais Pais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Pais"
    ADD CONSTRAINT "Pais_pkey" PRIMARY KEY (id_pais);


--
-- TOC entry 3823 (class 2606 OID 17087)
-- Name: Permiso_Usuario Permiso_Usuario_descrip_permiso_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Permiso_Usuario"
    ADD CONSTRAINT "Permiso_Usuario_descrip_permiso_usuario_key" UNIQUE (descrip_permiso_usuario);


--
-- TOC entry 3825 (class 2606 OID 17085)
-- Name: Permiso_Usuario Permiso_Usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Permiso_Usuario"
    ADD CONSTRAINT "Permiso_Usuario_pkey" PRIMARY KEY (numero_registro_permiso_usuario);


--
-- TOC entry 3791 (class 2606 OID 16988)
-- Name: Permiso Permiso_cod_interno_permiso_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Permiso"
    ADD CONSTRAINT "Permiso_cod_interno_permiso_key" UNIQUE (cod_interno_permiso);


--
-- TOC entry 3793 (class 2606 OID 16990)
-- Name: Permiso Permiso_descrip_permiso_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Permiso"
    ADD CONSTRAINT "Permiso_descrip_permiso_key" UNIQUE (descrip_permiso);


--
-- TOC entry 3795 (class 2606 OID 16986)
-- Name: Permiso Permiso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Permiso"
    ADD CONSTRAINT "Permiso_pkey" PRIMARY KEY (id_permiso);


--
-- TOC entry 3847 (class 2606 OID 17209)
-- Name: Persona Persona_estado_civil_persona_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Persona"
    ADD CONSTRAINT "Persona_estado_civil_persona_key" UNIQUE (estado_civil_persona);


--
-- TOC entry 3849 (class 2606 OID 17205)
-- Name: Persona Persona_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Persona"
    ADD CONSTRAINT "Persona_pkey" PRIMARY KEY (id_persona);


--
-- TOC entry 3851 (class 2606 OID 17213)
-- Name: Persona Persona_telefono_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Persona"
    ADD CONSTRAINT "Persona_telefono_key" UNIQUE (telefono_persona);


--
-- TOC entry 3829 (class 2606 OID 17128)
-- Name: Posicion Posicion_cod_posicion_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Posicion"
    ADD CONSTRAINT "Posicion_cod_posicion_key" UNIQUE (cod_posicion);


--
-- TOC entry 3831 (class 2606 OID 17130)
-- Name: Posicion Posicion_descrip_posicion_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Posicion"
    ADD CONSTRAINT "Posicion_descrip_posicion_key" UNIQUE (descrip_posicion);


--
-- TOC entry 3833 (class 2606 OID 17126)
-- Name: Posicion Posicion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Posicion"
    ADD CONSTRAINT "Posicion_pkey" PRIMARY KEY (id_posicion);


--
-- TOC entry 3861 (class 2606 OID 17362)
-- Name: Puesto_Trabajo Puesto_Trabajo_cod_interno_puesto_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Puesto_Trabajo"
    ADD CONSTRAINT "Puesto_Trabajo_cod_interno_puesto_key" UNIQUE (cod_interno_puesto);


--
-- TOC entry 3863 (class 2606 OID 17360)
-- Name: Puesto_Trabajo Puesto_Trabajo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Puesto_Trabajo"
    ADD CONSTRAINT "Puesto_Trabajo_pkey" PRIMARY KEY (id_puesto_trabajo);


--
-- TOC entry 3817 (class 2606 OID 17074)
-- Name: Relacion_Laboral Relacion_Laboral_cod_relacion_lab_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Relacion_Laboral"
    ADD CONSTRAINT "Relacion_Laboral_cod_relacion_lab_key" UNIQUE (cod_relacion_lab);


--
-- TOC entry 3819 (class 2606 OID 17076)
-- Name: Relacion_Laboral Relacion_Laboral_descrip_relacion_lab_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Relacion_Laboral"
    ADD CONSTRAINT "Relacion_Laboral_descrip_relacion_lab_key" UNIQUE (descrip_relacion_lab);


--
-- TOC entry 3821 (class 2606 OID 17072)
-- Name: Relacion_Laboral Relacion_Laboral_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Relacion_Laboral"
    ADD CONSTRAINT "Relacion_Laboral_pkey" PRIMARY KEY (id_relacion_lab);


--
-- TOC entry 3827 (class 2606 OID 17106)
-- Name: Rol_Usuario Rol_Usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rol_Usuario"
    ADD CONSTRAINT "Rol_Usuario_pkey" PRIMARY KEY (numero_registro);


--
-- TOC entry 3811 (class 2606 OID 17063)
-- Name: Rol Rol_creado_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rol"
    ADD CONSTRAINT "Rol_creado_key" UNIQUE (creado);


--
-- TOC entry 3813 (class 2606 OID 17061)
-- Name: Rol Rol_descrip_rol_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rol"
    ADD CONSTRAINT "Rol_descrip_rol_key" UNIQUE (descrip_rol);


--
-- TOC entry 3815 (class 2606 OID 17059)
-- Name: Rol Rol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rol"
    ADD CONSTRAINT "Rol_pkey" PRIMARY KEY (id_rol);


--
-- TOC entry 3859 (class 2606 OID 17302)
-- Name: SubdivisionPersonal_Relacion_Laboral SubdivisionPersonal_Relacion_Laboral_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SubdivisionPersonal_Relacion_Laboral"
    ADD CONSTRAINT "SubdivisionPersonal_Relacion_Laboral_pkey" PRIMARY KEY (id_relacion_laboral, id_subdivision_personal);


--
-- TOC entry 3779 (class 2606 OID 16907)
-- Name: Subdivision_Personal(Ubicacion) Subdivision_Personal(Ubicacion)_cod_subdivision_personal_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Subdivision_Personal(Ubicacion)"
    ADD CONSTRAINT "Subdivision_Personal(Ubicacion)_cod_subdivision_personal_key" UNIQUE (cod_subdivision_personal);


--
-- TOC entry 3781 (class 2606 OID 16905)
-- Name: Subdivision_Personal(Ubicacion) Subdivision_Personal(Ubicacion)_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Subdivision_Personal(Ubicacion)"
    ADD CONSTRAINT "Subdivision_Personal(Ubicacion)_pkey" PRIMARY KEY (id_subdivision_personal);


--
-- TOC entry 3783 (class 2606 OID 16909)
-- Name: Subdivision_Personal(Ubicacion) Subdivision_Personal(Ubicacion_descrip_subdivision_personal_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Subdivision_Personal(Ubicacion)"
    ADD CONSTRAINT "Subdivision_Personal(Ubicacion_descrip_subdivision_personal_key" UNIQUE (descrip_subdivision_personal);


--
-- TOC entry 3785 (class 2606 OID 16920)
-- Name: Tipo_Contrato Tipo_Contrato_cod_contrato_lab_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tipo_Contrato"
    ADD CONSTRAINT "Tipo_Contrato_cod_contrato_lab_key" UNIQUE (cod_contrato_lab);


--
-- TOC entry 3787 (class 2606 OID 16922)
-- Name: Tipo_Contrato Tipo_Contrato_descrip_contrato_lab_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tipo_Contrato"
    ADD CONSTRAINT "Tipo_Contrato_descrip_contrato_lab_key" UNIQUE (descrip_contrato_lab);


--
-- TOC entry 3789 (class 2606 OID 16918)
-- Name: Tipo_Contrato Tipo_Contrato_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tipo_Contrato"
    ADD CONSTRAINT "Tipo_Contrato_pkey" PRIMARY KEY (id_tipo_contrato_lab);


--
-- TOC entry 3773 (class 2606 OID 16892)
-- Name: Unidad_Organizativa Unidad_Organizativa_cod_unidad_organizativa_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Unidad_Organizativa"
    ADD CONSTRAINT "Unidad_Organizativa_cod_unidad_organizativa_key" UNIQUE (cod_unidad_organizativa);


--
-- TOC entry 3775 (class 2606 OID 16894)
-- Name: Unidad_Organizativa Unidad_Organizativa_descrip_unidad_organizativa_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Unidad_Organizativa"
    ADD CONSTRAINT "Unidad_Organizativa_descrip_unidad_organizativa_key" UNIQUE (descrip_unidad_organizativa);


--
-- TOC entry 3777 (class 2606 OID 16890)
-- Name: Unidad_Organizativa Unidad_Organizativa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Unidad_Organizativa"
    ADD CONSTRAINT "Unidad_Organizativa_pkey" PRIMARY KEY (id_unidad_organizativa);


--
-- TOC entry 3797 (class 2606 OID 17021)
-- Name: Usuario Usuario_contrasenia_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Usuario_contrasenia_usuario_key" UNIQUE (contrasenia_usuario);


--
-- TOC entry 3799 (class 2606 OID 17025)
-- Name: Usuario Usuario_email_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Usuario_email_usuario_key" UNIQUE (email_usuario);


--
-- TOC entry 3801 (class 2606 OID 17023)
-- Name: Usuario Usuario_huella_digital_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Usuario_huella_digital_key" UNIQUE (huella_digital);


--
-- TOC entry 3803 (class 2606 OID 17019)
-- Name: Usuario Usuario_nombre_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Usuario_nombre_usuario_key" UNIQUE (nombre_usuario);


--
-- TOC entry 3805 (class 2606 OID 17017)
-- Name: Usuario Usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Usuario_pkey" PRIMARY KEY (id_usuario);


--
-- TOC entry 3865 (class 2606 OID 17377)
-- Name: Grupo_Empleado grupo_empleado_tipo_contrato_descrip_grupo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Grupo_Empleado"
    ADD CONSTRAINT grupo_empleado_tipo_contrato_descrip_grupo_key UNIQUE (descrip_grupo);


--
-- TOC entry 3867 (class 2606 OID 17375)
-- Name: Grupo_Empleado grupo_empleado_tipo_contrato_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Grupo_Empleado"
    ADD CONSTRAINT grupo_empleado_tipo_contrato_pkey PRIMARY KEY (id_grupo_empleado);


--
-- TOC entry 3875 (class 2606 OID 17046)
-- Name: Bitacora actualizado_por_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bitacora"
    ADD CONSTRAINT actualizado_por_fk FOREIGN KEY (id_usuario_actualizo) REFERENCES public."Usuario"(id_usuario) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3874 (class 2606 OID 17041)
-- Name: Bitacora creado_por_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bitacora"
    ADD CONSTRAINT creado_por_fk FOREIGN KEY (id_usuario_creo) REFERENCES public."Usuario"(id_usuario) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3881 (class 2606 OID 17331)
-- Name: Persona direccion_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Persona"
    ADD CONSTRAINT direccion_persona_fk FOREIGN KEY (id_direccion_persona) REFERENCES public."Domicilio_Fiscal"(id_domicilio_fiscal);


--
-- TOC entry 3890 (class 2606 OID 17363)
-- Name: Puesto_Trabajo id_area_personal_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Puesto_Trabajo"
    ADD CONSTRAINT id_area_personal_fk FOREIGN KEY (id_area_personal) REFERENCES public."Area_Personal"(id_area_personal) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3885 (class 2606 OID 17261)
-- Name: Empresa_SubdivisionPersonal id_empresa_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empresa_SubdivisionPersonal"
    ADD CONSTRAINT id_empresa_fk1 FOREIGN KEY (id_empresa) REFERENCES public."Empresa"(id_empresa) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3882 (class 2606 OID 17378)
-- Name: Empleado id_grupo_empleado_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empleado"
    ADD CONSTRAINT id_grupo_empleado_fk FOREIGN KEY (id_grupo_empleado) REFERENCES public."Grupo_Empleado"(id_grupo_empleado) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3891 (class 2606 OID 17387)
-- Name: Grupo_Empleado_Contrato id_grupo_empleado_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Grupo_Empleado_Contrato"
    ADD CONSTRAINT id_grupo_empleado_fk1 FOREIGN KEY (id_grupo_empleado) REFERENCES public."Grupo_Empleado"(id_grupo_empleado) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3869 (class 2606 OID 16831)
-- Name: Domicilio_Fiscal id_municipio_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Domicilio_Fiscal"
    ADD CONSTRAINT id_municipio_fk FOREIGN KEY (id_municipio) REFERENCES public."Municipio"(id_municipio) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3872 (class 2606 OID 17342)
-- Name: Tipo_Contrato id_nomina_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tipo_Contrato"
    ADD CONSTRAINT id_nomina_fk FOREIGN KEY (id_nomina) REFERENCES public."Nomina"(id_nomina) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3868 (class 2606 OID 16777)
-- Name: Departamento id_pais_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Departamento"
    ADD CONSTRAINT id_pais_fk FOREIGN KEY (id_pais) REFERENCES public."Pais"(id_pais) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3877 (class 2606 OID 17088)
-- Name: Permiso_Usuario id_permiso_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Permiso_Usuario"
    ADD CONSTRAINT id_permiso_fk FOREIGN KEY (id_permiso) REFERENCES public."Permiso"(id_permiso) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3884 (class 2606 OID 17323)
-- Name: Empleado id_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empleado"
    ADD CONSTRAINT id_persona_fk FOREIGN KEY (id_persona) REFERENCES public."Persona"(id_persona) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3871 (class 2606 OID 17318)
-- Name: Unidad_Organizativa id_posicion_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Unidad_Organizativa"
    ADD CONSTRAINT id_posicion_fk FOREIGN KEY (id_posicion) REFERENCES public."Posicion"(id_posicion) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3870 (class 2606 OID 17347)
-- Name: Area_Personal id_posicion_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Area_Personal"
    ADD CONSTRAINT id_posicion_fk FOREIGN KEY (id_posicion) REFERENCES public."Posicion"(id_posicion) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3883 (class 2606 OID 17397)
-- Name: Empleado id_puesto_trabajo_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empleado"
    ADD CONSTRAINT id_puesto_trabajo_fk FOREIGN KEY (id_puesto_trabajo) REFERENCES public."Puesto_Trabajo"(id_puesto_trabajo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3873 (class 2606 OID 17231)
-- Name: Usuario id_reg_empleado_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT id_reg_empleado_fk FOREIGN KEY (id_reg_empleado) REFERENCES public."Empleado"(id_reg_empleado) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3888 (class 2606 OID 17303)
-- Name: SubdivisionPersonal_Relacion_Laboral id_relacion_laboral_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SubdivisionPersonal_Relacion_Laboral"
    ADD CONSTRAINT id_relacion_laboral_fk1 FOREIGN KEY (id_relacion_laboral) REFERENCES public."Relacion_Laboral"(id_relacion_lab) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3879 (class 2606 OID 17107)
-- Name: Rol_Usuario id_rol_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rol_Usuario"
    ADD CONSTRAINT id_rol_fk FOREIGN KEY (id_rol) REFERENCES public."Rol"(id_rol) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3886 (class 2606 OID 17266)
-- Name: Empresa_SubdivisionPersonal id_subdivision_personal_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empresa_SubdivisionPersonal"
    ADD CONSTRAINT id_subdivision_personal_fk1 FOREIGN KEY (id_subdivision_personal) REFERENCES public."Subdivision_Personal(Ubicacion)"(id_subdivision_personal) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3887 (class 2606 OID 17292)
-- Name: Empresa_SubdivisionPersonal id_subdivision_personal_fk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empresa_SubdivisionPersonal"
    ADD CONSTRAINT id_subdivision_personal_fk2 FOREIGN KEY (id_subdivision_personal) REFERENCES public."Subdivision_Personal(Ubicacion)"(id_subdivision_personal) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3889 (class 2606 OID 17308)
-- Name: SubdivisionPersonal_Relacion_Laboral id_subdivision_personal_fk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SubdivisionPersonal_Relacion_Laboral"
    ADD CONSTRAINT id_subdivision_personal_fk2 FOREIGN KEY (id_subdivision_personal) REFERENCES public."Subdivision_Personal(Ubicacion)"(id_subdivision_personal) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3892 (class 2606 OID 17392)
-- Name: Grupo_Empleado_Contrato id_tipo_contrato_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Grupo_Empleado_Contrato"
    ADD CONSTRAINT id_tipo_contrato_fk1 FOREIGN KEY (id_tipo_contrato) REFERENCES public."Tipo_Contrato"(id_tipo_contrato_lab) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3876 (class 2606 OID 17313)
-- Name: Relacion_Laboral id_unidad_organizativa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Relacion_Laboral"
    ADD CONSTRAINT id_unidad_organizativa_fk FOREIGN KEY (id_unidad_organizativa) REFERENCES public."Unidad_Organizativa"(id_unidad_organizativa) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3878 (class 2606 OID 17093)
-- Name: Permiso_Usuario id_usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Permiso_Usuario"
    ADD CONSTRAINT id_usuario_fk FOREIGN KEY (id_usuario) REFERENCES public."Usuario"(id_usuario) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3880 (class 2606 OID 17112)
-- Name: Rol_Usuario id_usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rol_Usuario"
    ADD CONSTRAINT id_usuario_fk FOREIGN KEY (id_usuario) REFERENCES public."Usuario"(id_usuario) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2019-09-11 15:28:09

--
-- PostgreSQL database dump complete
--

