--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

-- Started on 2019-10-23 21:06:29

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'LATIN4';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3226 (class 1262 OID 288262)
-- Name: coinpalocal; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE coinpalocal WITH TEMPLATE = template0 ENCODING = 'LATIN4' LC_COLLATE = 'es_ES.UTF-8' LC_CTYPE = 'es_ES.UTF-8';


ALTER DATABASE coinpalocal OWNER TO postgres;

\connect coinpalocal

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'LATIN4';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 265 (class 1255 OID 320347)
-- Name: fn_addp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_addp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$	begin
		if NEW.descrip_permiso is null then
			RAISE EXCEPTION '% not have null descrip_permiso',NEW.descrip_permiso;
		end if;
		
		NEW.cod_interno_permiso = new.id_permiso;
		NEW.creado := now();
		NEW.creado_por := current_user;
		NEW.status_permiso = 1;
	return NEW;
	end;
$$;


ALTER FUNCTION public.fn_addp() OWNER TO postgres;

--
-- TOC entry 264 (class 1255 OID 320341)
-- Name: fn_addr(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_addr() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if NEW.descrip_rol is null then
			RAISE EXCEPTION '% not have null descrip_rol',NEW.descrip_rol;
		end if;
		
		NEW.creado := current_date;
		NEW.creado_por := current_user;
		NEW.status_rol = 1;
	return NEW;
	end;
$$;


ALTER FUNCTION public.fn_addr() OWNER TO postgres;

--
-- TOC entry 262 (class 1255 OID 320279)
-- Name: fn_gen_usr(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_gen_usr(idempl character varying) RETURNS text
    LANGUAGE plpgsql
    AS $$	declare
	usr_name text;
	begin
		if idEmpl is null then
			RAISE EXCEPTION '% cannot have null idEmp', idEmpl;
		end if;
		
		usr_name =  substr(pe.nombre_1,length(pe.nombre_1))|| substr(pe.nombre_2,length(pe.nombre_2))|| pe.apellido_1|| e.id_grupo_empleado||e.id_puesto_trabajo||to_char(current_date,'yyyy')
					from "Empleado" e inner join "Persona" pe on (e.id_persona =  pe.id_persona)
					where e.cod_empleado_empresa_corporativo = idEmpl;
		if usr_name is null then
			RAISE EXCEPTION '';
		end if;
		return usr_name;
	end;
$$;


ALTER FUNCTION public.fn_gen_usr(idempl character varying) OWNER TO postgres;

--
-- TOC entry 263 (class 1255 OID 320334)
-- Name: fn_reg_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_reg_user() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE 
	cod_int "Empleado".cod_empleado_empresa_corporativo%TYPE;
	
BEGIN
		IF OLD.nombre_usuario IS NOT NULL THEN
			RAISE EXCEPTION '% EXISTE',OLD.nombre_usuario;
		END IF;
		
		IF OLD.contrasenia_usuario IS NOT NULL THEN
			RAISE EXCEPTION '% EXISTE',OLD.contrasenia_usuario;
		END IF;
		
		IF NEW.email_usuario IS NULL THEN
            RAISE EXCEPTION '% cannot have null salary', NEW.email_usuario;
		END IF;
		IF NEW.id_empleado IS NULL THEN
            RAISE EXCEPTION '% cannot have null salary', NEW.id_empleado;
        END IF;
		
		cod_int = return_cod_int(NEW.id_empleado);	
		NEW.nombre_usuario = fn_gen_usr(cod_int);
		NEW.contrasenia_usuario = floor(random() * 104500 + 100000)::int;
        NEW.creado := current_timestamp;
        NEW.creado_por := current_user;
		NEW.status_usuario  = 0;
		
		RETURN NEW;
    END;
$$;


ALTER FUNCTION public.fn_reg_user() OWNER TO postgres;

--
-- TOC entry 261 (class 1255 OID 320277)
-- Name: return_cod_int(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.return_cod_int(id_emp integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
	
	DECLARE
		cod_int text;
	begin
		if id_emp is null then
			RAISE EXCEPTION '% cannot have null id_emp', id_emp;
		end if;
		if id_emp <=0 then
			RAISE EXCEPTION '% cannot have < 1 id_emp', id_emp;
		end if;
			
	select cod_empleado_empresa_corporativo into cod_int from "Empleado" where id_reg_empleado = id_emp;
	
	if cod_int is null then
		cod_int = '';
		RAISE EXCEPTION 'is null';
	end if;
	
	return cod_int;
	
	end;
$$;


ALTER FUNCTION public.return_cod_int(id_emp integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 196 (class 1259 OID 288661)
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
-- TOC entry 197 (class 1259 OID 288664)
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
-- TOC entry 3227 (class 0 OID 0)
-- Dependencies: 197
-- Name: Bitacora_numero_registro_bitacora_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Bitacora_numero_registro_bitacora_seq" OWNED BY public."Bitacora".numero_registro_bitacora;


--
-- TOC entry 244 (class 1259 OID 418717)
-- Name: Contrato_Relacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Contrato_Relacion" (
    id_contrato integer NOT NULL,
    fecha_creacion date NOT NULL,
    creado_por integer NOT NULL,
    id_empleado integer
);


ALTER TABLE public."Contrato_Relacion" OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 288666)
-- Name: departamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departamento (
    id_departamento integer NOT NULL,
    nombre_departamento character varying(60) NOT NULL,
    status_departamento integer NOT NULL,
    id_pais integer,
    CONSTRAINT "Departamento_status_departamento_check" CHECK (((status_departamento = 1) OR (status_departamento = 0)))
);


ALTER TABLE public.departamento OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 288670)
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
-- TOC entry 3228 (class 0 OID 0)
-- Dependencies: 199
-- Name: Departamento_id_departamento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Departamento_id_departamento_seq" OWNED BY public.departamento.id_departamento;


--
-- TOC entry 200 (class 1259 OID 288672)
-- Name: domicilio_fiscal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.domicilio_fiscal (
    id_domicilio_fiscal integer NOT NULL,
    descrip_domicilio_fiscal character varying(100) NOT NULL,
    dir_zona smallint DEFAULT 0 NOT NULL,
    dir_avenida smallint DEFAULT 0 NOT NULL,
    dir_numero_calle smallint DEFAULT 0 NOT NULL,
    edificio character varying(15) DEFAULT ''::character varying,
    status_domicilio_fiscal smallint NOT NULL,
    id_municipio integer,
    CONSTRAINT "Direccion_Empleado_status_direccion_empleado_check" CHECK (((status_domicilio_fiscal = 1) OR (status_domicilio_fiscal = 0)))
);


ALTER TABLE public.domicilio_fiscal OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 288680)
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
-- TOC entry 3229 (class 0 OID 0)
-- Dependencies: 201
-- Name: Direccion_Empleado_id_direccion_empleado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Direccion_Empleado_id_direccion_empleado_seq" OWNED BY public.domicilio_fiscal.id_domicilio_fiscal;


--
-- TOC entry 202 (class 1259 OID 288682)
-- Name: empleado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empleado (
    id_empleado integer NOT NULL,
    cod_empleado_corporativo character varying(15) NOT NULL,
    fecha_contratacion date NOT NULL,
    fecha_baja_contratacion date DEFAULT '2000-01-01'::date,
    status_empleado integer NOT NULL,
    id_persona integer,
    id_grupo_empleado integer,
    id_puesto_trabajo integer
);


ALTER TABLE public.empleado OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 288685)
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
-- TOC entry 3230 (class 0 OID 0)
-- Dependencies: 203
-- Name: Empleado_id_reg_empleado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Empleado_id_reg_empleado_seq" OWNED BY public.empleado.id_empleado;


--
-- TOC entry 204 (class 1259 OID 288687)
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
-- TOC entry 205 (class 1259 OID 288691)
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
-- TOC entry 206 (class 1259 OID 288695)
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
-- TOC entry 3231 (class 0 OID 0)
-- Dependencies: 206
-- Name: Empresa_id_empresa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Empresa_id_empresa_seq" OWNED BY public."Empresa".id_empresa;


--
-- TOC entry 207 (class 1259 OID 288697)
-- Name: Grupo_Empleado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Grupo_Empleado" (
    id_grupo_empleado integer NOT NULL,
    descrip_grupo character varying(25) NOT NULL
);


ALTER TABLE public."Grupo_Empleado" OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 288700)
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
-- TOC entry 246 (class 1259 OID 418742)
-- Name: Movimiento_Socio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Movimiento_Socio" (
    id_mov_socio integer NOT NULL,
    fecha_movimiento date NOT NULL,
    documento_ref character varying(15) NOT NULL,
    monto_movimiento double precision NOT NULL,
    creado_por integer NOT NULL,
    id_tipo_movimiento integer,
    id_socio integer
);


ALTER TABLE public."Movimiento_Socio" OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 288707)
-- Name: Municipio_id_municipio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Municipio_id_municipio_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public."Municipio_id_municipio_seq" OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 288704)
-- Name: municipio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.municipio (
    id_municipio integer NOT NULL,
    codigo_int_municipal integer NOT NULL,
    nombre_municipio character varying(35) NOT NULL,
    status_municipio integer NOT NULL,
    id_departamento integer
);


ALTER TABLE public.municipio OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 288709)
-- Name: Municipio_id_municipio_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.municipio ALTER COLUMN id_municipio ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Municipio_id_municipio_seq1"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 212 (class 1259 OID 288711)
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
-- TOC entry 213 (class 1259 OID 288715)
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
-- TOC entry 3232 (class 0 OID 0)
-- Dependencies: 213
-- Name: Nomina_id_nomina_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Nomina_id_nomina_seq" OWNED BY public."Nomina".id_nomina;


--
-- TOC entry 214 (class 1259 OID 288717)
-- Name: pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pais (
    id_pais integer NOT NULL,
    nombre_pais character varying(56) NOT NULL,
    status_pais integer NOT NULL,
    CONSTRAINT "Pais_status_pais_check" CHECK (((status_pais = 1) OR (status_pais = 0)))
);


ALTER TABLE public.pais OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 288721)
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
-- TOC entry 3233 (class 0 OID 0)
-- Dependencies: 215
-- Name: Pais_id_pais_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Pais_id_pais_seq" OWNED BY public.pais.id_pais;


--
-- TOC entry 216 (class 1259 OID 288723)
-- Name: Permiso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Permiso" (
    id_permiso integer NOT NULL,
    cod_interno_permiso character varying(10) NOT NULL,
    descrip_permiso character varying(30) NOT NULL,
    status_permiso smallint,
    creado timestamp without time zone NOT NULL,
    actualizado timestamp without time zone,
    creado_por character varying(25) NOT NULL,
    acutalizado_por character varying(50),
    CONSTRAINT "Permiso_status_permiso_check" CHECK (((status_permiso = 0) OR (status_permiso = 1)))
);


ALTER TABLE public."Permiso" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 288727)
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
-- TOC entry 218 (class 1259 OID 288731)
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
-- TOC entry 3234 (class 0 OID 0)
-- Dependencies: 218
-- Name: Permiso_Usuario_numero_registro_permiso_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Permiso_Usuario_numero_registro_permiso_usuario_seq" OWNED BY public."Permiso_Usuario".numero_registro_permiso_usuario;


--
-- TOC entry 219 (class 1259 OID 288733)
-- Name: Permiso_id_permiso_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Permiso_id_permiso_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Permiso_id_permiso_seq" OWNER TO postgres;

--
-- TOC entry 3235 (class 0 OID 0)
-- Dependencies: 219
-- Name: Permiso_id_permiso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Permiso_id_permiso_seq" OWNED BY public."Permiso".id_permiso;


--
-- TOC entry 220 (class 1259 OID 288735)
-- Name: persona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.persona (
    id_persona integer NOT NULL,
    primer_nombre character varying(15) NOT NULL,
    segundo_nombre character varying(15),
    primer_apellido character varying(15) NOT NULL,
    segundo_apellido character varying(15),
    apellido_casado character varying(15),
    nit_persona character varying(12) NOT NULL,
    numero_identificacion_persona character varying(13) NOT NULL,
    genero_persona "char" NOT NULL,
    telefono_persona character varying(8),
    id_direccion_fiscal_fk integer,
    id_estado_civil integer
);


ALTER TABLE public.persona OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 288738)
-- Name: Persona_id_persona_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Persona_id_persona_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Persona_id_persona_seq" OWNER TO postgres;

--
-- TOC entry 3236 (class 0 OID 0)
-- Dependencies: 221
-- Name: Persona_id_persona_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Persona_id_persona_seq" OWNED BY public.persona.id_persona;


--
-- TOC entry 222 (class 1259 OID 288740)
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
-- TOC entry 223 (class 1259 OID 288744)
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
-- TOC entry 3237 (class 0 OID 0)
-- Dependencies: 223
-- Name: Posicion_id_posicion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Posicion_id_posicion_seq" OWNED BY public."Posicion".id_posicion;


--
-- TOC entry 224 (class 1259 OID 288746)
-- Name: puesto_empleado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.puesto_empleado (
    id_puesto_trabajo integer NOT NULL,
    cod_interno_puesto_empleado character varying(10) NOT NULL,
    status_puesto_empleado smallint NOT NULL
);


ALTER TABLE public.puesto_empleado OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 288750)
-- Name: Puesto_Trabajo_id_puesto_trabajo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Puesto_Trabajo_id_puesto_trabajo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Puesto_Trabajo_id_puesto_trabajo_seq" OWNER TO postgres;

--
-- TOC entry 3238 (class 0 OID 0)
-- Dependencies: 225
-- Name: Puesto_Trabajo_id_puesto_trabajo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Puesto_Trabajo_id_puesto_trabajo_seq" OWNED BY public.puesto_empleado.id_puesto_trabajo;


--
-- TOC entry 226 (class 1259 OID 288752)
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
-- TOC entry 227 (class 1259 OID 288756)
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
-- TOC entry 3239 (class 0 OID 0)
-- Dependencies: 227
-- Name: Relacion_Laboral_id_relacion_lab_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Relacion_Laboral_id_relacion_lab_seq" OWNED BY public."Relacion_Laboral".id_relacion_lab;


--
-- TOC entry 228 (class 1259 OID 288758)
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
-- TOC entry 229 (class 1259 OID 288762)
-- Name: Rol_Usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Rol_Usuario" (
    numero_registro integer NOT NULL,
    status_rol_usuario smallint NOT NULL,
    id_rol integer,
    id_usuario integer,
    creado timestamp without time zone NOT NULL,
    actualizado timestamp without time zone[],
    creado_por character varying(10),
    actualizado_por character varying(10),
    CONSTRAINT "Rol_Usuario_status_rol_usuario_check" CHECK (((status_rol_usuario = 1) OR (status_rol_usuario = 1)))
);


ALTER TABLE public."Rol_Usuario" OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 288769)
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
-- TOC entry 3240 (class 0 OID 0)
-- Dependencies: 230
-- Name: Rol_Usuario_numero_registro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Rol_Usuario_numero_registro_seq" OWNED BY public."Rol_Usuario".numero_registro;


--
-- TOC entry 231 (class 1259 OID 288771)
-- Name: Rol_id_rol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Rol_id_rol_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Rol_id_rol_seq" OWNER TO postgres;

--
-- TOC entry 3241 (class 0 OID 0)
-- Dependencies: 231
-- Name: Rol_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Rol_id_rol_seq" OWNED BY public."Rol".id_rol;


--
-- TOC entry 243 (class 1259 OID 410510)
-- Name: Socio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Socio" (
    id_socio integer NOT NULL,
    fecha_alta_socio timestamp(4) with time zone NOT NULL,
    aportacion numeric NOT NULL,
    ahorro numeric NOT NULL,
    status_socio smallint NOT NULL,
    id_contrato integer
);


ALTER TABLE public."Socio" OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 288773)
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
-- TOC entry 233 (class 1259 OID 288777)
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
-- TOC entry 234 (class 1259 OID 288781)
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
-- TOC entry 3242 (class 0 OID 0)
-- Dependencies: 234
-- Name: Subdivision_Personal(Ubicacion)_id_subdivision_personal_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Subdivision_Personal(Ubicacion)_id_subdivision_personal_seq" OWNED BY public."Subdivision_Personal(Ubicacion)".id_subdivision_personal;


--
-- TOC entry 235 (class 1259 OID 288783)
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
-- TOC entry 236 (class 1259 OID 288787)
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
-- TOC entry 3243 (class 0 OID 0)
-- Dependencies: 236
-- Name: Tipo_Contrato_id_contrato_lab_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Tipo_Contrato_id_contrato_lab_seq" OWNED BY public."Tipo_Contrato".id_tipo_contrato_lab;


--
-- TOC entry 245 (class 1259 OID 418735)
-- Name: Tipo_Movimiento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Tipo_Movimiento" (
    id_tipo_movimiento integer NOT NULL,
    descrip_mov character varying(15) NOT NULL,
    status_mov smallint
);


ALTER TABLE public."Tipo_Movimiento" OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 288789)
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
-- TOC entry 238 (class 1259 OID 288793)
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
-- TOC entry 3244 (class 0 OID 0)
-- Dependencies: 238
-- Name: Unidad_Organizativa_id_unidad_organizativa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Unidad_Organizativa_id_unidad_organizativa_seq" OWNED BY public."Unidad_Organizativa".id_unidad_organizativa;


--
-- TOC entry 239 (class 1259 OID 288795)
-- Name: Usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Usuario" (
    id_usuario integer NOT NULL,
    nombre_usuario character varying(15) NOT NULL,
    contrasenia_usuario bytea NOT NULL,
    email_usuario character varying(50) NOT NULL,
    creado timestamp(0) without time zone NOT NULL,
    actualizado timestamp(0) without time zone,
    creado_por character varying(25) NOT NULL,
    actualizado_por character varying(50),
    status_usuario integer,
    id_empleado integer
);


ALTER TABLE public."Usuario" OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 288801)
-- Name: Usuario_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Usuario_id_usuario_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Usuario_id_usuario_seq" OWNER TO postgres;

--
-- TOC entry 3245 (class 0 OID 0)
-- Dependencies: 240
-- Name: Usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Usuario_id_usuario_seq" OWNED BY public."Usuario".id_usuario;


--
-- TOC entry 247 (class 1259 OID 427145)
-- Name: estado_civil_id_estado_civil_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estado_civil_id_estado_civil_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.estado_civil_id_estado_civil_seq OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 303864)
-- Name: estado_civil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estado_civil (
    id_estado_civil integer DEFAULT nextval('public.estado_civil_id_estado_civil_seq'::regclass) NOT NULL,
    descrip_estado_civil character varying(15) NOT NULL,
    status_estado_civil integer NOT NULL,
    CONSTRAINT "Estado_Civil_status_estado_civil_check" CHECK (((status_estado_civil = 1) OR (status_estado_civil = 0)))
);


ALTER TABLE public.estado_civil OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 288803)
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
-- TOC entry 3246 (class 0 OID 0)
-- Dependencies: 241
-- Name: grupo_empleado_tipo_contrato_numero_registro_grupo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.grupo_empleado_tipo_contrato_numero_registro_grupo_seq OWNED BY public."Grupo_Empleado".id_grupo_empleado;


--
-- TOC entry 248 (class 1259 OID 435361)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id_usuario bigint NOT NULL,
    username character varying(255),
    password character varying(255),
    email_usuario character varying(255),
    actualizado date,
    actualizado_por character varying(255),
    creado date,
    creado_por character varying(255),
    status_usuario integer NOT NULL,
    id_empleado integer NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 2854 (class 2604 OID 288806)
-- Name: Bitacora numero_registro_bitacora; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bitacora" ALTER COLUMN numero_registro_bitacora SET DEFAULT nextval('public."Bitacora_numero_registro_bitacora_seq"'::regclass);


--
-- TOC entry 2865 (class 2604 OID 288810)
-- Name: Empresa id_empresa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empresa" ALTER COLUMN id_empresa SET DEFAULT nextval('public."Empresa_id_empresa_seq"'::regclass);


--
-- TOC entry 2868 (class 2604 OID 288811)
-- Name: Grupo_Empleado id_grupo_empleado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Grupo_Empleado" ALTER COLUMN id_grupo_empleado SET DEFAULT nextval('public.grupo_empleado_tipo_contrato_numero_registro_grupo_seq'::regclass);


--
-- TOC entry 2870 (class 2604 OID 288812)
-- Name: Nomina id_nomina; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Nomina" ALTER COLUMN id_nomina SET DEFAULT nextval('public."Nomina_id_nomina_seq"'::regclass);


--
-- TOC entry 2874 (class 2604 OID 288814)
-- Name: Permiso id_permiso; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Permiso" ALTER COLUMN id_permiso SET DEFAULT nextval('public."Permiso_id_permiso_seq"'::regclass);


--
-- TOC entry 2876 (class 2604 OID 288815)
-- Name: Permiso_Usuario numero_registro_permiso_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Permiso_Usuario" ALTER COLUMN numero_registro_permiso_usuario SET DEFAULT nextval('public."Permiso_Usuario_numero_registro_permiso_usuario_seq"'::regclass);


--
-- TOC entry 2879 (class 2604 OID 288817)
-- Name: Posicion id_posicion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Posicion" ALTER COLUMN id_posicion SET DEFAULT nextval('public."Posicion_id_posicion_seq"'::regclass);


--
-- TOC entry 2882 (class 2604 OID 288819)
-- Name: Relacion_Laboral id_relacion_lab; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Relacion_Laboral" ALTER COLUMN id_relacion_lab SET DEFAULT nextval('public."Relacion_Laboral_id_relacion_lab_seq"'::regclass);


--
-- TOC entry 2884 (class 2604 OID 288820)
-- Name: Rol id_rol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rol" ALTER COLUMN id_rol SET DEFAULT nextval('public."Rol_id_rol_seq"'::regclass);


--
-- TOC entry 2886 (class 2604 OID 288821)
-- Name: Rol_Usuario numero_registro; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rol_Usuario" ALTER COLUMN numero_registro SET DEFAULT nextval('public."Rol_Usuario_numero_registro_seq"'::regclass);


--
-- TOC entry 2889 (class 2604 OID 288822)
-- Name: Subdivision_Personal(Ubicacion) id_subdivision_personal; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Subdivision_Personal(Ubicacion)" ALTER COLUMN id_subdivision_personal SET DEFAULT nextval('public."Subdivision_Personal(Ubicacion)_id_subdivision_personal_seq"'::regclass);


--
-- TOC entry 2891 (class 2604 OID 288823)
-- Name: Tipo_Contrato id_tipo_contrato_lab; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tipo_Contrato" ALTER COLUMN id_tipo_contrato_lab SET DEFAULT nextval('public."Tipo_Contrato_id_contrato_lab_seq"'::regclass);


--
-- TOC entry 2893 (class 2604 OID 288824)
-- Name: Unidad_Organizativa id_unidad_organizativa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Unidad_Organizativa" ALTER COLUMN id_unidad_organizativa SET DEFAULT nextval('public."Unidad_Organizativa_id_unidad_organizativa_seq"'::regclass);


--
-- TOC entry 2895 (class 2604 OID 288825)
-- Name: Usuario id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuario" ALTER COLUMN id_usuario SET DEFAULT nextval('public."Usuario_id_usuario_seq"'::regclass);


--
-- TOC entry 2855 (class 2604 OID 288807)
-- Name: departamento id_departamento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamento ALTER COLUMN id_departamento SET DEFAULT nextval('public."Departamento_id_departamento_seq"'::regclass);


--
-- TOC entry 2860 (class 2604 OID 288808)
-- Name: domicilio_fiscal id_domicilio_fiscal; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.domicilio_fiscal ALTER COLUMN id_domicilio_fiscal SET DEFAULT nextval('public."Direccion_Empleado_id_direccion_empleado_seq"'::regclass);


--
-- TOC entry 2863 (class 2604 OID 288809)
-- Name: empleado id_empleado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado ALTER COLUMN id_empleado SET DEFAULT nextval('public."Empleado_id_reg_empleado_seq"'::regclass);


--
-- TOC entry 2872 (class 2604 OID 288813)
-- Name: pais id_pais; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais ALTER COLUMN id_pais SET DEFAULT nextval('public."Pais_id_pais_seq"'::regclass);


--
-- TOC entry 2878 (class 2604 OID 288816)
-- Name: persona id_persona; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona ALTER COLUMN id_persona SET DEFAULT nextval('public."Persona_id_persona_seq"'::regclass);


--
-- TOC entry 2881 (class 2604 OID 288818)
-- Name: puesto_empleado id_puesto_trabajo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.puesto_empleado ALTER COLUMN id_puesto_trabajo SET DEFAULT nextval('public."Puesto_Trabajo_id_puesto_trabajo_seq"'::regclass);


--
-- TOC entry 2899 (class 2606 OID 288833)
-- Name: Bitacora Bitacora_descrip_registro_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bitacora"
    ADD CONSTRAINT "Bitacora_descrip_registro_key" UNIQUE (descrip_registro);


--
-- TOC entry 2901 (class 2606 OID 288835)
-- Name: Bitacora Bitacora_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bitacora"
    ADD CONSTRAINT "Bitacora_pkey" PRIMARY KEY (numero_registro_bitacora);


--
-- TOC entry 3007 (class 2606 OID 418721)
-- Name: Contrato_Relacion Contrato_Relacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Contrato_Relacion"
    ADD CONSTRAINT "Contrato_Relacion_pkey" PRIMARY KEY (id_contrato);


--
-- TOC entry 2903 (class 2606 OID 288837)
-- Name: departamento Departamento_nombre_departamento_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamento
    ADD CONSTRAINT "Departamento_nombre_departamento_key" UNIQUE (nombre_departamento);


--
-- TOC entry 2905 (class 2606 OID 288839)
-- Name: departamento Departamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamento
    ADD CONSTRAINT "Departamento_pkey" PRIMARY KEY (id_departamento);


--
-- TOC entry 2907 (class 2606 OID 288841)
-- Name: domicilio_fiscal Direccion_Empleado_descrip_direccion_empleado_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.domicilio_fiscal
    ADD CONSTRAINT "Direccion_Empleado_descrip_direccion_empleado_key" UNIQUE (descrip_domicilio_fiscal);


--
-- TOC entry 2909 (class 2606 OID 288843)
-- Name: domicilio_fiscal Direccion_Empleado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.domicilio_fiscal
    ADD CONSTRAINT "Direccion_Empleado_pkey" PRIMARY KEY (id_domicilio_fiscal);


--
-- TOC entry 2911 (class 2606 OID 427161)
-- Name: empleado Empleado_cod_empleado_empresa_corporativo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT "Empleado_cod_empleado_empresa_corporativo_key" UNIQUE (cod_empleado_corporativo);


--
-- TOC entry 2913 (class 2606 OID 288847)
-- Name: empleado Empleado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT "Empleado_pkey" PRIMARY KEY (id_empleado);


--
-- TOC entry 2925 (class 2606 OID 288849)
-- Name: Empresa_SubdivisionPersonal Empresa_SubdivisionPersonal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empresa_SubdivisionPersonal"
    ADD CONSTRAINT "Empresa_SubdivisionPersonal_pkey" PRIMARY KEY (id_empresa, id_subdivision_personal);


--
-- TOC entry 2915 (class 2606 OID 288851)
-- Name: Empresa Empresa_email_empresa_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empresa"
    ADD CONSTRAINT "Empresa_email_empresa_key" UNIQUE (email_empresa);


--
-- TOC entry 2917 (class 2606 OID 288853)
-- Name: Empresa Empresa_nombre_comercial_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empresa"
    ADD CONSTRAINT "Empresa_nombre_comercial_key" UNIQUE (nombre_comercial);


--
-- TOC entry 2919 (class 2606 OID 288855)
-- Name: Empresa Empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empresa"
    ADD CONSTRAINT "Empresa_pkey" PRIMARY KEY (id_empresa);


--
-- TOC entry 2921 (class 2606 OID 288857)
-- Name: Empresa Empresa_razon_social_empresa_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empresa"
    ADD CONSTRAINT "Empresa_razon_social_empresa_key" UNIQUE (razon_social_empresa);


--
-- TOC entry 2923 (class 2606 OID 288859)
-- Name: Empresa Empresa_telefono_empresa_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empresa"
    ADD CONSTRAINT "Empresa_telefono_empresa_key" UNIQUE (telefono_empresa);


--
-- TOC entry 3001 (class 2606 OID 303871)
-- Name: estado_civil Estado_Civil_descrip_estado_civil_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_civil
    ADD CONSTRAINT "Estado_Civil_descrip_estado_civil_key" UNIQUE (descrip_estado_civil);


--
-- TOC entry 3003 (class 2606 OID 303869)
-- Name: estado_civil Estado_Civil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_civil
    ADD CONSTRAINT "Estado_Civil_pkey" PRIMARY KEY (id_estado_civil);


--
-- TOC entry 3013 (class 2606 OID 418748)
-- Name: Movimiento_Socio Movimiento_Socio_documento_ref_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Movimiento_Socio"
    ADD CONSTRAINT "Movimiento_Socio_documento_ref_key" UNIQUE (documento_ref);


--
-- TOC entry 3015 (class 2606 OID 418746)
-- Name: Movimiento_Socio Movimiento_Socio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Movimiento_Socio"
    ADD CONSTRAINT "Movimiento_Socio_pkey" PRIMARY KEY (id_mov_socio);


--
-- TOC entry 2931 (class 2606 OID 288861)
-- Name: municipio Municipio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.municipio
    ADD CONSTRAINT "Municipio_pkey" PRIMARY KEY (id_municipio);


--
-- TOC entry 2933 (class 2606 OID 288863)
-- Name: Nomina Nomina_cod_nomina_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Nomina"
    ADD CONSTRAINT "Nomina_cod_nomina_key" UNIQUE (cod_nomina);


--
-- TOC entry 2935 (class 2606 OID 288865)
-- Name: Nomina Nomina_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Nomina"
    ADD CONSTRAINT "Nomina_pkey" PRIMARY KEY (id_nomina);


--
-- TOC entry 2937 (class 2606 OID 288867)
-- Name: pais Pais_nombre_pais_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais
    ADD CONSTRAINT "Pais_nombre_pais_key" UNIQUE (nombre_pais);


--
-- TOC entry 2939 (class 2606 OID 288869)
-- Name: pais Pais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais
    ADD CONSTRAINT "Pais_pkey" PRIMARY KEY (id_pais);


--
-- TOC entry 2947 (class 2606 OID 288873)
-- Name: Permiso_Usuario Permiso_Usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Permiso_Usuario"
    ADD CONSTRAINT "Permiso_Usuario_pkey" PRIMARY KEY (numero_registro_permiso_usuario);


--
-- TOC entry 2941 (class 2606 OID 288875)
-- Name: Permiso Permiso_cod_interno_permiso_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Permiso"
    ADD CONSTRAINT "Permiso_cod_interno_permiso_key" UNIQUE (cod_interno_permiso);


--
-- TOC entry 2943 (class 2606 OID 288877)
-- Name: Permiso Permiso_descrip_permiso_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Permiso"
    ADD CONSTRAINT "Permiso_descrip_permiso_key" UNIQUE (descrip_permiso);


--
-- TOC entry 2945 (class 2606 OID 288879)
-- Name: Permiso Permiso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Permiso"
    ADD CONSTRAINT "Permiso_pkey" PRIMARY KEY (id_permiso);


--
-- TOC entry 2949 (class 2606 OID 288881)
-- Name: persona Persona_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT "Persona_pkey" PRIMARY KEY (id_persona);


--
-- TOC entry 2951 (class 2606 OID 288883)
-- Name: Posicion Posicion_cod_posicion_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Posicion"
    ADD CONSTRAINT "Posicion_cod_posicion_key" UNIQUE (cod_posicion);


--
-- TOC entry 2953 (class 2606 OID 288885)
-- Name: Posicion Posicion_descrip_posicion_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Posicion"
    ADD CONSTRAINT "Posicion_descrip_posicion_key" UNIQUE (descrip_posicion);


--
-- TOC entry 2955 (class 2606 OID 288887)
-- Name: Posicion Posicion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Posicion"
    ADD CONSTRAINT "Posicion_pkey" PRIMARY KEY (id_posicion);


--
-- TOC entry 2957 (class 2606 OID 427156)
-- Name: puesto_empleado Puesto_Trabajo_cod_interno_puesto_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.puesto_empleado
    ADD CONSTRAINT "Puesto_Trabajo_cod_interno_puesto_key" UNIQUE (cod_interno_puesto_empleado);


--
-- TOC entry 2959 (class 2606 OID 288891)
-- Name: puesto_empleado Puesto_Trabajo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.puesto_empleado
    ADD CONSTRAINT "Puesto_Trabajo_pkey" PRIMARY KEY (id_puesto_trabajo);


--
-- TOC entry 2961 (class 2606 OID 288893)
-- Name: Relacion_Laboral Relacion_Laboral_cod_relacion_lab_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Relacion_Laboral"
    ADD CONSTRAINT "Relacion_Laboral_cod_relacion_lab_key" UNIQUE (cod_relacion_lab);


--
-- TOC entry 2963 (class 2606 OID 288895)
-- Name: Relacion_Laboral Relacion_Laboral_descrip_relacion_lab_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Relacion_Laboral"
    ADD CONSTRAINT "Relacion_Laboral_descrip_relacion_lab_key" UNIQUE (descrip_relacion_lab);


--
-- TOC entry 2965 (class 2606 OID 288897)
-- Name: Relacion_Laboral Relacion_Laboral_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Relacion_Laboral"
    ADD CONSTRAINT "Relacion_Laboral_pkey" PRIMARY KEY (id_relacion_lab);


--
-- TOC entry 2971 (class 2606 OID 288899)
-- Name: Rol_Usuario Rol_Usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rol_Usuario"
    ADD CONSTRAINT "Rol_Usuario_pkey" PRIMARY KEY (numero_registro);


--
-- TOC entry 2967 (class 2606 OID 288903)
-- Name: Rol Rol_descrip_rol_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rol"
    ADD CONSTRAINT "Rol_descrip_rol_key" UNIQUE (descrip_rol);


--
-- TOC entry 2969 (class 2606 OID 288905)
-- Name: Rol Rol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rol"
    ADD CONSTRAINT "Rol_pkey" PRIMARY KEY (id_rol);


--
-- TOC entry 3005 (class 2606 OID 410514)
-- Name: Socio Socio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Socio"
    ADD CONSTRAINT "Socio_pkey" PRIMARY KEY (id_socio);


--
-- TOC entry 2973 (class 2606 OID 288907)
-- Name: SubdivisionPersonal_Relacion_Laboral SubdivisionPersonal_Relacion_Laboral_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SubdivisionPersonal_Relacion_Laboral"
    ADD CONSTRAINT "SubdivisionPersonal_Relacion_Laboral_pkey" PRIMARY KEY (id_relacion_laboral, id_subdivision_personal);


--
-- TOC entry 2975 (class 2606 OID 288909)
-- Name: Subdivision_Personal(Ubicacion) Subdivision_Personal(Ubicacion)_cod_subdivision_personal_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Subdivision_Personal(Ubicacion)"
    ADD CONSTRAINT "Subdivision_Personal(Ubicacion)_cod_subdivision_personal_key" UNIQUE (cod_subdivision_personal);


--
-- TOC entry 2977 (class 2606 OID 288911)
-- Name: Subdivision_Personal(Ubicacion) Subdivision_Personal(Ubicacion)_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Subdivision_Personal(Ubicacion)"
    ADD CONSTRAINT "Subdivision_Personal(Ubicacion)_pkey" PRIMARY KEY (id_subdivision_personal);


--
-- TOC entry 2979 (class 2606 OID 288913)
-- Name: Subdivision_Personal(Ubicacion) Subdivision_Personal(Ubicacion_descrip_subdivision_personal_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Subdivision_Personal(Ubicacion)"
    ADD CONSTRAINT "Subdivision_Personal(Ubicacion_descrip_subdivision_personal_key" UNIQUE (descrip_subdivision_personal);


--
-- TOC entry 2981 (class 2606 OID 288915)
-- Name: Tipo_Contrato Tipo_Contrato_cod_contrato_lab_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tipo_Contrato"
    ADD CONSTRAINT "Tipo_Contrato_cod_contrato_lab_key" UNIQUE (cod_contrato_lab);


--
-- TOC entry 2983 (class 2606 OID 288917)
-- Name: Tipo_Contrato Tipo_Contrato_descrip_contrato_lab_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tipo_Contrato"
    ADD CONSTRAINT "Tipo_Contrato_descrip_contrato_lab_key" UNIQUE (descrip_contrato_lab);


--
-- TOC entry 2985 (class 2606 OID 288919)
-- Name: Tipo_Contrato Tipo_Contrato_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tipo_Contrato"
    ADD CONSTRAINT "Tipo_Contrato_pkey" PRIMARY KEY (id_tipo_contrato_lab);


--
-- TOC entry 3009 (class 2606 OID 418741)
-- Name: Tipo_Movimiento Tipo_Movimiento_descrip_mov_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tipo_Movimiento"
    ADD CONSTRAINT "Tipo_Movimiento_descrip_mov_key" UNIQUE (descrip_mov);


--
-- TOC entry 3011 (class 2606 OID 418739)
-- Name: Tipo_Movimiento Tipo_Movimiento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tipo_Movimiento"
    ADD CONSTRAINT "Tipo_Movimiento_pkey" PRIMARY KEY (id_tipo_movimiento);


--
-- TOC entry 2987 (class 2606 OID 288921)
-- Name: Unidad_Organizativa Unidad_Organizativa_cod_unidad_organizativa_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Unidad_Organizativa"
    ADD CONSTRAINT "Unidad_Organizativa_cod_unidad_organizativa_key" UNIQUE (cod_unidad_organizativa);


--
-- TOC entry 2989 (class 2606 OID 288923)
-- Name: Unidad_Organizativa Unidad_Organizativa_descrip_unidad_organizativa_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Unidad_Organizativa"
    ADD CONSTRAINT "Unidad_Organizativa_descrip_unidad_organizativa_key" UNIQUE (descrip_unidad_organizativa);


--
-- TOC entry 2991 (class 2606 OID 288925)
-- Name: Unidad_Organizativa Unidad_Organizativa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Unidad_Organizativa"
    ADD CONSTRAINT "Unidad_Organizativa_pkey" PRIMARY KEY (id_unidad_organizativa);


--
-- TOC entry 2993 (class 2606 OID 288927)
-- Name: Usuario Usuario_contrasenia_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Usuario_contrasenia_usuario_key" UNIQUE (contrasenia_usuario);


--
-- TOC entry 2995 (class 2606 OID 288929)
-- Name: Usuario Usuario_email_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Usuario_email_usuario_key" UNIQUE (email_usuario);


--
-- TOC entry 2997 (class 2606 OID 320322)
-- Name: Usuario Usuario_nombre_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Usuario_nombre_usuario_key" UNIQUE (nombre_usuario);


--
-- TOC entry 2999 (class 2606 OID 288935)
-- Name: Usuario Usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Usuario_pkey" PRIMARY KEY (id_usuario);


--
-- TOC entry 2927 (class 2606 OID 288937)
-- Name: Grupo_Empleado grupo_empleado_tipo_contrato_descrip_grupo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Grupo_Empleado"
    ADD CONSTRAINT grupo_empleado_tipo_contrato_descrip_grupo_key UNIQUE (descrip_grupo);


--
-- TOC entry 2929 (class 2606 OID 288939)
-- Name: Grupo_Empleado grupo_empleado_tipo_contrato_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Grupo_Empleado"
    ADD CONSTRAINT grupo_empleado_tipo_contrato_pkey PRIMARY KEY (id_grupo_empleado);


--
-- TOC entry 3017 (class 2606 OID 435365)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 3046 (class 2620 OID 320335)
-- Name: Usuario add_usr; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER add_usr BEFORE INSERT ON public."Usuario" FOR EACH ROW EXECUTE PROCEDURE public.fn_reg_user();


--
-- TOC entry 3045 (class 2620 OID 320342)
-- Name: Rol tr_add_r; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr_add_r BEFORE INSERT ON public."Rol" FOR EACH ROW EXECUTE PROCEDURE public.fn_addr();


--
-- TOC entry 3044 (class 2620 OID 320348)
-- Name: Permiso tr_add_r; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr_add_r BEFORE INSERT ON public."Permiso" FOR EACH ROW EXECUTE PROCEDURE public.fn_addp();


--
-- TOC entry 3018 (class 2606 OID 288940)
-- Name: Bitacora actualizado_por_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bitacora"
    ADD CONSTRAINT actualizado_por_fk FOREIGN KEY (id_usuario_actualizo) REFERENCES public."Usuario"(id_usuario) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3019 (class 2606 OID 288945)
-- Name: Bitacora creado_por_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bitacora"
    ADD CONSTRAINT creado_por_fk FOREIGN KEY (id_usuario_creo) REFERENCES public."Usuario"(id_usuario) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3040 (class 2606 OID 418730)
-- Name: Socio id_contrato_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Socio"
    ADD CONSTRAINT id_contrato_fk FOREIGN KEY (id_contrato) REFERENCES public."Contrato_Relacion"(id_contrato);


--
-- TOC entry 3028 (class 2606 OID 418829)
-- Name: municipio id_departamento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.municipio
    ADD CONSTRAINT id_departamento_fk FOREIGN KEY (id_departamento) REFERENCES public.departamento(id_departamento);


--
-- TOC entry 3031 (class 2606 OID 418837)
-- Name: persona id_direccion_fiscal_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT id_direccion_fiscal_fk FOREIGN KEY (id_direccion_fiscal_fk) REFERENCES public.domicilio_fiscal(id_domicilio_fiscal);


--
-- TOC entry 3041 (class 2606 OID 418759)
-- Name: Contrato_Relacion id_empleado_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Contrato_Relacion"
    ADD CONSTRAINT id_empleado_fk FOREIGN KEY (id_empleado) REFERENCES public.empleado(id_empleado);


--
-- TOC entry 3023 (class 2606 OID 288955)
-- Name: Empresa_SubdivisionPersonal id_empresa_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empresa_SubdivisionPersonal"
    ADD CONSTRAINT id_empresa_fk1 FOREIGN KEY (id_empresa) REFERENCES public."Empresa"(id_empresa) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3032 (class 2606 OID 418847)
-- Name: persona id_estado_civil_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT id_estado_civil_fk FOREIGN KEY (id_estado_civil) REFERENCES public.estado_civil(id_estado_civil);


--
-- TOC entry 3026 (class 2606 OID 288960)
-- Name: Grupo_Empleado_Contrato id_grupo_empleado_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Grupo_Empleado_Contrato"
    ADD CONSTRAINT id_grupo_empleado_fk1 FOREIGN KEY (id_grupo_empleado) REFERENCES public."Grupo_Empleado"(id_grupo_empleado) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3021 (class 2606 OID 288965)
-- Name: domicilio_fiscal id_municipio_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.domicilio_fiscal
    ADD CONSTRAINT id_municipio_fk FOREIGN KEY (id_municipio) REFERENCES public.municipio(id_municipio) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3038 (class 2606 OID 288970)
-- Name: Tipo_Contrato id_nomina_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tipo_Contrato"
    ADD CONSTRAINT id_nomina_fk FOREIGN KEY (id_nomina) REFERENCES public."Nomina"(id_nomina) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3020 (class 2606 OID 288975)
-- Name: departamento id_pais_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamento
    ADD CONSTRAINT id_pais_fk FOREIGN KEY (id_pais) REFERENCES public.pais(id_pais) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3029 (class 2606 OID 288980)
-- Name: Permiso_Usuario id_permiso_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Permiso_Usuario"
    ADD CONSTRAINT id_permiso_fk FOREIGN KEY (id_permiso) REFERENCES public."Permiso"(id_permiso) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3039 (class 2606 OID 288985)
-- Name: Unidad_Organizativa id_posicion_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Unidad_Organizativa"
    ADD CONSTRAINT id_posicion_fk FOREIGN KEY (id_posicion) REFERENCES public."Posicion"(id_posicion) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3022 (class 2606 OID 418857)
-- Name: empleado id_puesto_empleado_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT id_puesto_empleado_fk FOREIGN KEY (id_puesto_trabajo) REFERENCES public.puesto_empleado(id_puesto_trabajo);


--
-- TOC entry 3036 (class 2606 OID 289000)
-- Name: SubdivisionPersonal_Relacion_Laboral id_relacion_laboral_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SubdivisionPersonal_Relacion_Laboral"
    ADD CONSTRAINT id_relacion_laboral_fk1 FOREIGN KEY (id_relacion_laboral) REFERENCES public."Relacion_Laboral"(id_relacion_lab) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3034 (class 2606 OID 418809)
-- Name: Rol_Usuario id_rol_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rol_Usuario"
    ADD CONSTRAINT id_rol_fk FOREIGN KEY (id_rol) REFERENCES public."Rol"(id_rol);


--
-- TOC entry 3043 (class 2606 OID 418754)
-- Name: Movimiento_Socio id_socio_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Movimiento_Socio"
    ADD CONSTRAINT id_socio_fk FOREIGN KEY (id_socio) REFERENCES public."Socio"(id_socio);


--
-- TOC entry 3024 (class 2606 OID 289010)
-- Name: Empresa_SubdivisionPersonal id_subdivision_personal_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empresa_SubdivisionPersonal"
    ADD CONSTRAINT id_subdivision_personal_fk1 FOREIGN KEY (id_subdivision_personal) REFERENCES public."Subdivision_Personal(Ubicacion)"(id_subdivision_personal) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3025 (class 2606 OID 289015)
-- Name: Empresa_SubdivisionPersonal id_subdivision_personal_fk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Empresa_SubdivisionPersonal"
    ADD CONSTRAINT id_subdivision_personal_fk2 FOREIGN KEY (id_subdivision_personal) REFERENCES public."Subdivision_Personal(Ubicacion)"(id_subdivision_personal) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3037 (class 2606 OID 289020)
-- Name: SubdivisionPersonal_Relacion_Laboral id_subdivision_personal_fk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SubdivisionPersonal_Relacion_Laboral"
    ADD CONSTRAINT id_subdivision_personal_fk2 FOREIGN KEY (id_subdivision_personal) REFERENCES public."Subdivision_Personal(Ubicacion)"(id_subdivision_personal) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3027 (class 2606 OID 289025)
-- Name: Grupo_Empleado_Contrato id_tipo_contrato_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Grupo_Empleado_Contrato"
    ADD CONSTRAINT id_tipo_contrato_fk1 FOREIGN KEY (id_tipo_contrato) REFERENCES public."Tipo_Contrato"(id_tipo_contrato_lab) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3042 (class 2606 OID 418749)
-- Name: Movimiento_Socio id_tipo_mov_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Movimiento_Socio"
    ADD CONSTRAINT id_tipo_mov_fk FOREIGN KEY (id_tipo_movimiento) REFERENCES public."Tipo_Movimiento"(id_tipo_movimiento);


--
-- TOC entry 3033 (class 2606 OID 289030)
-- Name: Relacion_Laboral id_unidad_organizativa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Relacion_Laboral"
    ADD CONSTRAINT id_unidad_organizativa_fk FOREIGN KEY (id_unidad_organizativa) REFERENCES public."Unidad_Organizativa"(id_unidad_organizativa) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3030 (class 2606 OID 289035)
-- Name: Permiso_Usuario id_usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Permiso_Usuario"
    ADD CONSTRAINT id_usuario_fk FOREIGN KEY (id_usuario) REFERENCES public."Usuario"(id_usuario) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3035 (class 2606 OID 418814)
-- Name: Rol_Usuario id_usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rol_Usuario"
    ADD CONSTRAINT id_usuario_fk FOREIGN KEY (id_usuario) REFERENCES public."Usuario"(id_usuario);


-- Completed on 2019-10-23 21:06:30

--
-- PostgreSQL database dump complete
--

