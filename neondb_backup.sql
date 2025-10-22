--
-- PostgreSQL database dump
--

\restrict JKQQXNONmfozTjtlUnnWlSxjdQg66jICPY3dm8aZIkTJKMielVT9bPauHRlQU08

-- Dumped from database version 17.5 (6bc9ef8)
-- Dumped by pg_dump version 18.0 (Ubuntu 18.0-1.pgdg24.04+3)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: drizzle; Type: SCHEMA; Schema: -; Owner: neondb_owner
--

CREATE SCHEMA drizzle;


ALTER SCHEMA drizzle OWNER TO neondb_owner;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: __drizzle_migrations; Type: TABLE; Schema: drizzle; Owner: neondb_owner
--

CREATE TABLE drizzle.__drizzle_migrations (
    id integer NOT NULL,
    hash text NOT NULL,
    created_at bigint
);


ALTER TABLE drizzle.__drizzle_migrations OWNER TO neondb_owner;

--
-- Name: __drizzle_migrations_id_seq; Type: SEQUENCE; Schema: drizzle; Owner: neondb_owner
--

CREATE SEQUENCE drizzle.__drizzle_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE drizzle.__drizzle_migrations_id_seq OWNER TO neondb_owner;

--
-- Name: __drizzle_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: drizzle; Owner: neondb_owner
--

ALTER SEQUENCE drizzle.__drizzle_migrations_id_seq OWNED BY drizzle.__drizzle_migrations.id;


--
-- Name: budget_negotiations; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.budget_negotiations (
    id integer NOT NULL,
    project_id integer NOT NULL,
    proposed_by integer NOT NULL,
    original_price numeric(12,2) NOT NULL,
    proposed_price numeric(12,2) NOT NULL,
    message text,
    status character varying(50) DEFAULT 'pending'::text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    responded_at timestamp without time zone
);


ALTER TABLE public.budget_negotiations OWNER TO neondb_owner;

--
-- Name: budget_negotiations_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.budget_negotiations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.budget_negotiations_id_seq OWNER TO neondb_owner;

--
-- Name: budget_negotiations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.budget_negotiations_id_seq OWNED BY public.budget_negotiations.id;


--
-- Name: client_billing_info; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.client_billing_info (
    id integer NOT NULL,
    user_id integer NOT NULL,
    legal_name character varying(255) NOT NULL,
    document_type character varying(50) DEFAULT 'CI'::character varying NOT NULL,
    document_number character varying(50) NOT NULL,
    address text,
    city character varying(100),
    country character varying(100) DEFAULT 'Paraguay'::character varying,
    phone character varying(20),
    is_default boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    client_type character varying(50) DEFAULT 'persona_fisica'::character varying NOT NULL,
    department character varying(100),
    email character varying(255),
    observations text
);


ALTER TABLE public.client_billing_info OWNER TO neondb_owner;

--
-- Name: COLUMN client_billing_info.client_type; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.client_billing_info.client_type IS 'Tipo de cliente: persona_fisica, empresa, consumidor_final, extranjero';


--
-- Name: COLUMN client_billing_info.department; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.client_billing_info.department IS 'Departamento del Paraguay: Itapúa, Central, Alto Paraná, etc.';


--
-- Name: COLUMN client_billing_info.email; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.client_billing_info.email IS 'Email obligatorio para envío de facturas en PDF';


--
-- Name: COLUMN client_billing_info.observations; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.client_billing_info.observations IS 'Observaciones adicionales: Sucursal Central, Proyecto Web, etc.';


--
-- Name: client_billing_info_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.client_billing_info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.client_billing_info_id_seq OWNER TO neondb_owner;

--
-- Name: client_billing_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.client_billing_info_id_seq OWNED BY public.client_billing_info.id;


--
-- Name: company_billing_info; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.company_billing_info (
    id integer NOT NULL,
    company_name character varying(255) NOT NULL,
    ruc character varying(20) NOT NULL,
    address text NOT NULL,
    city character varying(100) NOT NULL,
    country character varying(100) DEFAULT 'Paraguay'::character varying,
    phone character varying(20),
    email character varying(255),
    website character varying(255),
    tax_regime character varying(100),
    economic_activity character varying(255),
    logo_url text,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    timbrado_number character varying(20),
    vigencia_timbrado character varying(20),
    vencimiento_timbrado character varying(20),
    boleta_prefix character varying(20) DEFAULT '001-001'::character varying,
    boleta_sequence integer DEFAULT 1,
    titular_name character varying(255),
    department character varying(100) DEFAULT 'Itapúa'::character varying
);


ALTER TABLE public.company_billing_info OWNER TO neondb_owner;

--
-- Name: COLUMN company_billing_info.titular_name; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.company_billing_info.titular_name IS 'Nombre completo del titular de la empresa (persona física)';


--
-- Name: COLUMN company_billing_info.department; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.company_billing_info.department IS 'Departamento del Paraguay: Itapúa, Central, Alto Paraná, etc.';


--
-- Name: company_billing_info_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.company_billing_info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.company_billing_info_id_seq OWNER TO neondb_owner;

--
-- Name: company_billing_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.company_billing_info_id_seq OWNED BY public.company_billing_info.id;


--
-- Name: exchange_rate_config; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.exchange_rate_config (
    id integer NOT NULL,
    usd_to_guarani numeric(10,2) NOT NULL,
    updated_by integer NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.exchange_rate_config OWNER TO neondb_owner;

--
-- Name: exchange_rate_config_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.exchange_rate_config_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.exchange_rate_config_id_seq OWNER TO neondb_owner;

--
-- Name: exchange_rate_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.exchange_rate_config_id_seq OWNED BY public.exchange_rate_config.id;


--
-- Name: invoices; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.invoices (
    id integer NOT NULL,
    invoice_number character varying(100) NOT NULL,
    project_id integer NOT NULL,
    client_id integer NOT NULL,
    amount numeric(12,2) NOT NULL,
    status character varying(50) DEFAULT 'pending'::character varying NOT NULL,
    due_date timestamp without time zone NOT NULL,
    paid_date timestamp without time zone,
    description text,
    tax_amount numeric(12,2) DEFAULT 0.00,
    discount_amount numeric(12,2) DEFAULT 0.00,
    total_amount numeric(12,2) NOT NULL,
    payment_method_id integer,
    notes text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    currency character varying(3) DEFAULT 'PYG'::character varying NOT NULL,
    payment_stage_id integer,
    exchange_rate_used numeric(10,2),
    sifen_cdc character varying(44),
    sifen_protocolo character varying(50),
    sifen_estado character varying(20),
    sifen_xml text,
    sifen_fecha_envio timestamp without time zone,
    sifen_mensaje_error text,
    sifen_qr character varying(1000),
    client_snapshot_type character varying(50),
    client_snapshot_legal_name character varying(255),
    client_snapshot_document_type character varying(50),
    client_snapshot_document_number character varying(50),
    client_snapshot_address text,
    client_snapshot_city character varying(100),
    client_snapshot_department character varying(100),
    client_snapshot_country character varying(100),
    client_snapshot_email character varying(255),
    client_snapshot_phone character varying(20),
    issue_date_snapshot character varying(50),
    issue_date_time_snapshot character varying(50)
);


ALTER TABLE public.invoices OWNER TO neondb_owner;

--
-- Name: COLUMN invoices.exchange_rate_used; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.invoices.exchange_rate_used IS 'Tipo de cambio USD a PYG usado al momento de generar la factura. Este valor queda fijo y no cambia aunque el tipo de cambio se actualice después.';


--
-- Name: COLUMN invoices.sifen_cdc; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.invoices.sifen_cdc IS 'Código de Control SIFEN de 44 dígitos';


--
-- Name: COLUMN invoices.sifen_protocolo; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.invoices.sifen_protocolo IS 'Protocolo de autorización devuelto por SIFEN';


--
-- Name: COLUMN invoices.sifen_estado; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.invoices.sifen_estado IS 'Estado de la factura en SIFEN: aceptado, rechazado, pendiente';


--
-- Name: COLUMN invoices.sifen_xml; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.invoices.sifen_xml IS 'XML completo enviado a SIFEN';


--
-- Name: COLUMN invoices.sifen_fecha_envio; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.invoices.sifen_fecha_envio IS 'Fecha y hora de envío a SIFEN';


--
-- Name: COLUMN invoices.sifen_mensaje_error; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.invoices.sifen_mensaje_error IS 'Mensaje de error si la factura fue rechazada por SIFEN';


--
-- Name: COLUMN invoices.sifen_qr; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.invoices.sifen_qr IS 'URL del código QR para verificación en e-Kuatia SET';


--
-- Name: invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.invoices_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invoices_id_seq OWNER TO neondb_owner;

--
-- Name: invoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.invoices_id_seq OWNED BY public.invoices.id;


--
-- Name: legal_pages; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.legal_pages (
    id integer NOT NULL,
    page_type character varying(50) NOT NULL,
    title character varying(255) NOT NULL,
    content text NOT NULL,
    last_updated_by integer,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.legal_pages OWNER TO neondb_owner;

--
-- Name: legal_pages_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.legal_pages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.legal_pages_id_seq OWNER TO neondb_owner;

--
-- Name: legal_pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.legal_pages_id_seq OWNED BY public.legal_pages.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    title character varying(255) NOT NULL,
    message text NOT NULL,
    type character varying(50) DEFAULT 'info'::character varying NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.notifications OWNER TO neondb_owner;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_id_seq OWNER TO neondb_owner;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: partners; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.partners (
    id integer NOT NULL,
    user_id integer NOT NULL,
    referral_code character varying(50) NOT NULL,
    commission_rate numeric(5,2) DEFAULT 25.00 NOT NULL,
    total_earnings numeric(12,2) DEFAULT 0.00 NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.partners OWNER TO neondb_owner;

--
-- Name: partners_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.partners_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.partners_id_seq OWNER TO neondb_owner;

--
-- Name: partners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.partners_id_seq OWNED BY public.partners.id;


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.password_reset_tokens (
    id integer NOT NULL,
    user_id integer NOT NULL,
    token character varying(255) NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    used boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.password_reset_tokens OWNER TO neondb_owner;

--
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.password_reset_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.password_reset_tokens_id_seq OWNER TO neondb_owner;

--
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.password_reset_tokens_id_seq OWNED BY public.password_reset_tokens.id;


--
-- Name: payment_methods; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.payment_methods (
    id integer NOT NULL,
    user_id integer NOT NULL,
    type character varying(50) NOT NULL,
    is_default boolean DEFAULT false,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    details jsonb NOT NULL
);


ALTER TABLE public.payment_methods OWNER TO neondb_owner;

--
-- Name: payment_methods_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.payment_methods_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_methods_id_seq OWNER TO neondb_owner;

--
-- Name: payment_methods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.payment_methods_id_seq OWNED BY public.payment_methods.id;


--
-- Name: payment_stages; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.payment_stages (
    id integer NOT NULL,
    project_id integer NOT NULL,
    stage_name text NOT NULL,
    stage_percentage integer NOT NULL,
    amount numeric(10,2) NOT NULL,
    required_progress integer DEFAULT 0 NOT NULL,
    status text DEFAULT 'pending'::character varying NOT NULL,
    payment_link text,
    paid_date timestamp without time zone,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    payment_method character varying(50),
    payment_data jsonb,
    proof_file_url text,
    exchange_rate_used numeric(10,2)
);


ALTER TABLE public.payment_stages OWNER TO neondb_owner;

--
-- Name: COLUMN payment_stages.exchange_rate_used; Type: COMMENT; Schema: public; Owner: neondb_owner
--

COMMENT ON COLUMN public.payment_stages.exchange_rate_used IS 'Tipo de cambio USD a PYG usado al momento del pago. Este valor queda fijo y no cambia aunque el tipo de cambio se actualice después.';


--
-- Name: payment_stages_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.payment_stages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_stages_id_seq OWNER TO neondb_owner;

--
-- Name: payment_stages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.payment_stages_id_seq OWNED BY public.payment_stages.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    project_id integer NOT NULL,
    amount numeric(12,2) NOT NULL,
    status character varying(50) DEFAULT 'pending'::character varying NOT NULL,
    payment_data jsonb,
    created_at timestamp without time zone DEFAULT now(),
    stage character varying(50) DEFAULT 'full'::character varying,
    stage_percentage numeric(5,2) DEFAULT 100.00,
    payment_method character varying(100),
    transaction_id character varying(255)
);


ALTER TABLE public.payments OWNER TO neondb_owner;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_id_seq OWNER TO neondb_owner;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: portfolio; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.portfolio (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    category character varying(100) NOT NULL,
    technologies text NOT NULL,
    image_url text NOT NULL,
    demo_url text,
    completed_at timestamp without time zone NOT NULL,
    featured boolean DEFAULT false NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.portfolio OWNER TO neondb_owner;

--
-- Name: portfolio_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.portfolio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.portfolio_id_seq OWNER TO neondb_owner;

--
-- Name: portfolio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.portfolio_id_seq OWNED BY public.portfolio.id;


--
-- Name: project_files; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.project_files (
    id integer NOT NULL,
    project_id integer NOT NULL,
    file_name character varying(255) NOT NULL,
    file_url text NOT NULL,
    file_type character varying(100),
    uploaded_by integer NOT NULL,
    file_size integer,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.project_files OWNER TO neondb_owner;

--
-- Name: project_files_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.project_files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_files_id_seq OWNER TO neondb_owner;

--
-- Name: project_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.project_files_id_seq OWNED BY public.project_files.id;


--
-- Name: project_messages; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.project_messages (
    id integer NOT NULL,
    project_id integer NOT NULL,
    user_id integer NOT NULL,
    message text NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.project_messages OWNER TO neondb_owner;

--
-- Name: project_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.project_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_messages_id_seq OWNER TO neondb_owner;

--
-- Name: project_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.project_messages_id_seq OWNED BY public.project_messages.id;


--
-- Name: project_timeline; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.project_timeline (
    id integer NOT NULL,
    project_id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    status character varying(50) DEFAULT 'pending'::character varying,
    estimated_date timestamp without time zone,
    completed_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.project_timeline OWNER TO neondb_owner;

--
-- Name: project_timeline_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.project_timeline_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_timeline_id_seq OWNER TO neondb_owner;

--
-- Name: project_timeline_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.project_timeline_id_seq OWNED BY public.project_timeline.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    price numeric(12,2) NOT NULL,
    status character varying(50) DEFAULT 'pending'::character varying NOT NULL,
    progress integer DEFAULT 0 NOT NULL,
    client_id integer NOT NULL,
    partner_id integer,
    delivery_date timestamp without time zone,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    start_date timestamp without time zone
);


ALTER TABLE public.projects OWNER TO neondb_owner;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.projects_id_seq OWNER TO neondb_owner;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: referrals; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.referrals (
    id integer NOT NULL,
    partner_id integer NOT NULL,
    client_id integer NOT NULL,
    project_id integer,
    status character varying(50) DEFAULT 'pending'::character varying NOT NULL,
    commission_amount numeric(12,2) DEFAULT 0.00 NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.referrals OWNER TO neondb_owner;

--
-- Name: referrals_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.referrals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.referrals_id_seq OWNER TO neondb_owner;

--
-- Name: referrals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.referrals_id_seq OWNED BY public.referrals.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.sessions (
    sid character varying NOT NULL,
    sess jsonb NOT NULL,
    expire timestamp without time zone NOT NULL
);


ALTER TABLE public.sessions OWNER TO neondb_owner;

--
-- Name: ticket_responses; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.ticket_responses (
    id integer NOT NULL,
    ticket_id integer NOT NULL,
    user_id integer NOT NULL,
    message text NOT NULL,
    is_from_support boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.ticket_responses OWNER TO neondb_owner;

--
-- Name: ticket_responses_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.ticket_responses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ticket_responses_id_seq OWNER TO neondb_owner;

--
-- Name: ticket_responses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.ticket_responses_id_seq OWNED BY public.ticket_responses.id;


--
-- Name: tickets; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.tickets (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    status character varying(50) DEFAULT 'open'::character varying NOT NULL,
    priority character varying(50) DEFAULT 'medium'::character varying NOT NULL,
    user_id integer NOT NULL,
    project_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.tickets OWNER TO neondb_owner;

--
-- Name: tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.tickets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tickets_id_seq OWNER TO neondb_owner;

--
-- Name: tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.tickets_id_seq OWNED BY public.tickets.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    invoice_id integer NOT NULL,
    payment_method_id integer NOT NULL,
    user_id integer NOT NULL,
    amount numeric(12,2) NOT NULL,
    currency character varying(3) DEFAULT 'USD'::character varying NOT NULL,
    status character varying(50) DEFAULT 'pending'::character varying NOT NULL,
    transaction_id character varying(255),
    payment_data jsonb,
    created_at timestamp without time zone DEFAULT now(),
    completed_at timestamp without time zone
);


ALTER TABLE public.transactions OWNER TO neondb_owner;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_id_seq OWNER TO neondb_owner;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    full_name character varying(255) NOT NULL,
    role character varying(50) DEFAULT 'client'::character varying NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    whatsapp_number character varying(50)
);


ALTER TABLE public.users OWNER TO neondb_owner;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO neondb_owner;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: work_modalities; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.work_modalities (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    subtitle character varying(255),
    badge_text character varying(100),
    badge_variant character varying(50) DEFAULT 'secondary'::character varying,
    description text NOT NULL,
    price_text character varying(255) NOT NULL,
    price_subtitle character varying(255),
    features jsonb NOT NULL,
    button_text character varying(255) DEFAULT 'Solicitar Cotización'::character varying NOT NULL,
    button_variant character varying(50) DEFAULT 'default'::character varying,
    is_popular boolean DEFAULT false,
    is_active boolean DEFAULT true,
    display_order integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.work_modalities OWNER TO neondb_owner;

--
-- Name: work_modalities_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.work_modalities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.work_modalities_id_seq OWNER TO neondb_owner;

--
-- Name: work_modalities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.work_modalities_id_seq OWNED BY public.work_modalities.id;


--
-- Name: __drizzle_migrations id; Type: DEFAULT; Schema: drizzle; Owner: neondb_owner
--

ALTER TABLE ONLY drizzle.__drizzle_migrations ALTER COLUMN id SET DEFAULT nextval('drizzle.__drizzle_migrations_id_seq'::regclass);


--
-- Name: budget_negotiations id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.budget_negotiations ALTER COLUMN id SET DEFAULT nextval('public.budget_negotiations_id_seq'::regclass);


--
-- Name: client_billing_info id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.client_billing_info ALTER COLUMN id SET DEFAULT nextval('public.client_billing_info_id_seq'::regclass);


--
-- Name: company_billing_info id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.company_billing_info ALTER COLUMN id SET DEFAULT nextval('public.company_billing_info_id_seq'::regclass);


--
-- Name: exchange_rate_config id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.exchange_rate_config ALTER COLUMN id SET DEFAULT nextval('public.exchange_rate_config_id_seq'::regclass);


--
-- Name: invoices id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.invoices ALTER COLUMN id SET DEFAULT nextval('public.invoices_id_seq'::regclass);


--
-- Name: legal_pages id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.legal_pages ALTER COLUMN id SET DEFAULT nextval('public.legal_pages_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: partners id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.partners ALTER COLUMN id SET DEFAULT nextval('public.partners_id_seq'::regclass);


--
-- Name: password_reset_tokens id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.password_reset_tokens ALTER COLUMN id SET DEFAULT nextval('public.password_reset_tokens_id_seq'::regclass);


--
-- Name: payment_methods id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payment_methods ALTER COLUMN id SET DEFAULT nextval('public.payment_methods_id_seq'::regclass);


--
-- Name: payment_stages id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payment_stages ALTER COLUMN id SET DEFAULT nextval('public.payment_stages_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: portfolio id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.portfolio ALTER COLUMN id SET DEFAULT nextval('public.portfolio_id_seq'::regclass);


--
-- Name: project_files id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_files ALTER COLUMN id SET DEFAULT nextval('public.project_files_id_seq'::regclass);


--
-- Name: project_messages id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_messages ALTER COLUMN id SET DEFAULT nextval('public.project_messages_id_seq'::regclass);


--
-- Name: project_timeline id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_timeline ALTER COLUMN id SET DEFAULT nextval('public.project_timeline_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: referrals id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.referrals ALTER COLUMN id SET DEFAULT nextval('public.referrals_id_seq'::regclass);


--
-- Name: ticket_responses id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.ticket_responses ALTER COLUMN id SET DEFAULT nextval('public.ticket_responses_id_seq'::regclass);


--
-- Name: tickets id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.tickets ALTER COLUMN id SET DEFAULT nextval('public.tickets_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: work_modalities id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.work_modalities ALTER COLUMN id SET DEFAULT nextval('public.work_modalities_id_seq'::regclass);


--
-- Data for Name: __drizzle_migrations; Type: TABLE DATA; Schema: drizzle; Owner: neondb_owner
--

COPY drizzle.__drizzle_migrations (id, hash, created_at) FROM stdin;
\.


--
-- Data for Name: budget_negotiations; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.budget_negotiations (id, project_id, proposed_by, original_price, proposed_price, message, status, created_at, responded_at) FROM stdin;
\.


--
-- Data for Name: client_billing_info; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.client_billing_info (id, user_id, legal_name, document_type, document_number, address, city, country, phone, is_default, created_at, updated_at, client_type, department, email, observations) FROM stdin;
1	2	Jorjelink	CI	123456789	Barrio Residencial – Carlos A. López – Itapúa	Carlos Antonio López	Paraguay	+595985990044	t	2025-09-30 03:19:11.00619	2025-10-17 16:11:18.893	consumidor_final	Itapúa	alfagroupstoreok@gmail.com	
\.


--
-- Data for Name: company_billing_info; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.company_billing_info (id, company_name, ruc, address, city, country, phone, email, website, tax_regime, economic_activity, logo_url, is_active, created_at, updated_at, timbrado_number, vigencia_timbrado, vencimiento_timbrado, boleta_prefix, boleta_sequence, titular_name, department) FROM stdin;
3	SoftwarePar S.R.L.	80001234-5	Barrio Residencial	Carlos Antonio López	Paraguay	+595 985 990 046	softwarepar.lat@gmail.com	https://softwarepar.lat	Pequeño Contribuyente - RESIMPLE	Desarrollo de software y servicios informáticos		f	2025-09-30 02:58:46.531403	2025-10-17 15:48:08.147	15378596	01/10/2025	30/09/2027	001-001	1	Jhoni Fabián Benítez De La Cruz	Itapúa
2	SoftwarePar	4220058-0	Barrio Residencial	Carlos Antonio López	Paraguay	+595 985 990 046	softwarepar.lat@gmail.com	https://softwarepar.lat	Pequeño Contribuyente - RESIMPLE	Desarrollo de software y servicios informáticos		f	2025-09-30 02:58:37.188036	2025-10-17 15:48:08.147	7777777	01/10/2025	30/09/2027	001-001	1	Jhoni Fabián Benítez De La Cruz	Itapúa
1	SoftwarePar	4220058-0	Barrio Residencial – Carlos A. López – Itapúa – Paraguay 	Carlos Antonio López	Paraguay	+595 985 990 046	softwarepar.lat@gmail.com	https://softwarepar.lat	Pequeño Contribuyente - RESIMPLE	Desarrollo de software y servicios informáticos		t	2025-09-30 02:51:18.953684	2025-10-17 15:48:08.704	151515151	01/10/2025	30/09/2027	001-001	2	Jhoni Fabián Benítez De La Cruz	Itapúa
\.


--
-- Data for Name: exchange_rate_config; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.exchange_rate_config (id, usd_to_guarani, updated_by, is_active, created_at, updated_at) FROM stdin;
1	7300.00	1	f	2025-09-30 15:52:54.875118	2025-10-16 23:28:08.192
2	7200.00	1	f	2025-09-30 15:53:34.668394	2025-10-16 23:28:08.192
3	7300.00	1	f	2025-10-01 00:51:06.648818	2025-10-16 23:28:08.192
4	7.06	1	f	2025-10-11 22:40:02.85167	2025-10-16 23:28:08.192
5	7.06	1	f	2025-10-11 22:41:08.5435	2025-10-16 23:28:08.192
6	7.06	1	f	2025-10-11 22:41:25.8804	2025-10-16 23:28:08.192
7	7.06	1	f	2025-10-11 22:41:38.616533	2025-10-16 23:28:08.192
8	7060.00	1	f	2025-10-11 22:41:46.744348	2025-10-16 23:28:08.192
9	7300.00	1	f	2025-10-11 22:52:06.802565	2025-10-16 23:28:08.192
10	7060.00	1	f	2025-10-11 22:56:29.278781	2025-10-16 23:28:08.192
11	7300.00	1	f	2025-10-11 23:20:17.365582	2025-10-16 23:28:08.192
12	7100.00	1	t	2025-10-16 23:28:08.713638	2025-10-16 23:28:08.713638
\.


--
-- Data for Name: invoices; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.invoices (id, invoice_number, project_id, client_id, amount, status, due_date, paid_date, description, tax_amount, discount_amount, total_amount, payment_method_id, notes, created_at, updated_at, currency, payment_stage_id, exchange_rate_used, sifen_cdc, sifen_protocolo, sifen_estado, sifen_xml, sifen_fecha_envio, sifen_mensaje_error, sifen_qr, client_snapshot_type, client_snapshot_legal_name, client_snapshot_document_type, client_snapshot_document_number, client_snapshot_address, client_snapshot_city, client_snapshot_department, client_snapshot_country, client_snapshot_email, client_snapshot_phone, issue_date_snapshot, issue_date_time_snapshot) FROM stdin;
\.


--
-- Data for Name: legal_pages; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.legal_pages (id, page_type, title, content, last_updated_by, is_active, created_at, updated_at) FROM stdin;
2	privacy	Política de Privacidad	<h1>Política de Privacidad</h1>\n<p><strong>Última actualización:</strong> Octubre 2025</p>\n\n<h2>1. Información que recopilamos</h2>\n<h3>1.1 Información personal</h3>\n<ul>\n  <li>Nombre completo y datos de contacto</li>\n  <li>Dirección de correo electrónico</li>\n  <li>Número de teléfono</li>\n  <li>Información de facturación (RUC, dirección)</li>\n  <li>Datos de empresa o negocio (si aplica)</li>\n</ul>\n\n<h3>1.2 Información técnica</h3>\n<ul>\n  <li>Dirección IP, tipo de dispositivo y navegador</li>\n  <li>Datos de uso y navegación en la plataforma</li>\n  <li>Cookies y tecnologías similares</li>\n  <li>Registros de actividad y seguridad del sistema</li>\n</ul>\n\n<h2>2. Cómo utilizamos la información</h2>\n<ul>\n  <li>Prestar y mejorar nuestros servicios digitales</li>\n  <li>Procesar pagos y emitir facturación electrónica conforme a la SET (Paraguay)</li>\n  <li>Comunicarnos contigo sobre proyectos, soporte o actualizaciones</li>\n  <li>Cumplir con obligaciones legales, fiscales y de seguridad informática</li>\n  <li>Personalizar tu experiencia en el sitio y panel del cliente</li>\n</ul>\n\n<h2>3. Compartir información</h2>\n<p>No vendemos ni transferimos tu información personal. Podemos compartir datos solo en los siguientes casos:</p>\n<ul>\n  <li>Con proveedores de servicios tecnológicos confiables (hosting, pasarelas de pago, facturación electrónica)</li>\n  <li>Cuando lo requiera la ley o una autoridad competente</li>\n  <li>Para proteger los derechos o seguridad de SoftwarePar y sus usuarios</li>\n  <li>Con tu consentimiento expreso</li>\n</ul>\n\n<h2>4. Seguridad de datos</h2>\n<ul>\n  <li>Cifrado SSL/TLS en todas las transmisiones</li>\n  <li>Servidores seguros con acceso restringido</li>\n  <li>Copias de seguridad y monitoreo continuo</li>\n  <li>Autenticación segura en el panel del cliente</li>\n</ul>\n\n<h2>5. Cookies y tecnologías similares</h2>\n<p>Usamos cookies para optimizar tu experiencia:</p>\n<ul>\n  <li><strong>Esenciales:</strong> necesarias para el funcionamiento del sitio</li>\n  <li><strong>Preferencias:</strong> guardan configuraciones del usuario</li>\n  <li><strong>Analíticas:</strong> ayudan a mejorar el rendimiento del sitio</li>\n  <li><strong>Marketing:</strong> permiten mostrar contenido relevante (no obligatorio)</li>\n</ul>\n\n<h2>6. Tus derechos</h2>\n<p>Podés solicitar en cualquier momento:</p>\n<ul>\n  <li>Acceso a tus datos personales</li>\n  <li>Corrección o actualización de la información</li>\n  <li>Eliminación de tu cuenta o datos personales</li>\n  <li>Restricción o retiro del consentimiento para tratamiento de datos</li>\n</ul>\n\n<h2>7. Retención de datos</h2>\n<p>Conservamos los datos únicamente durante el tiempo necesario para los fines descritos o según las normas fiscales paraguayas.</p>\n\n<h2>8. Transferencias internacionales</h2>\n<p>Algunos servicios pueden utilizar servidores ubicados fuera de Paraguay. Nos aseguramos de que cumplan con estándares adecuados de protección de datos.</p>\n\n<h2>9. Usuarios menores de edad</h2>\n<p>Nuestros servicios están dirigidos a mayores de 18 años. No recopilamos intencionalmente información de menores sin consentimiento verificable de los padres o tutores.</p>\n\n<h2>10. Cambios en la política</h2>\n<p>Podemos modificar esta política para reflejar cambios legales o técnicos. Las actualizaciones se publicarán en este mismo apartado con la nueva fecha de vigencia.</p>\n\n<h2>11. Contacto</h2>\n<p>Para consultas o solicitudes relacionadas con privacidad:</p>\n<p>\n📧 <strong>Email:</strong> softwarepar.lat@gmail.com<br>\n📞 <strong>Teléfono:</strong> +595 985 990 046<br>\n📍 <strong>Dirección:</strong> Barrio Residencial – Carlos Antonio López – Itapúa – Paraguay\n</p>\n\n<p><em>Esta política cumple con la normativa vigente de protección de datos personales y obligaciones fiscales según las leyes de la República del Paraguay.</em></p>\n	1	t	2025-10-17 02:38:39.302516	2025-10-17 03:17:14.547
1	terms	Términos y Condiciones de Servicio	<h1>Términos y Condiciones de Servicio</h1>\n<p><strong>Última actualización:</strong> Octubre 2025</p>\n\n<h2>1. Aceptación de los Términos</h2>\n<p>Al contratar o utilizar los servicios de <strong>SoftwarePar</strong>, el usuario acepta estos Términos y Condiciones, así como las políticas complementarias publicadas en el sitio web.</p>\n\n<h2>2. Descripción del Servicio</h2>\n<p>SoftwarePar ofrece soluciones tecnológicas y de desarrollo digital, incluyendo:</p>\n<ul>\n  <li>Desarrollo de sitios web y sistemas administrativos</li>\n  <li>Diseño y mantenimiento de plataformas online</li>\n  <li>Servicios de hosting, dominios y soporte técnico</li>\n  <li>Facturación electrónica y automatización de procesos</li>\n</ul>\n\n<h2>3. Modalidades de Trabajo</h2>\n<h3>3.1 Desarrollo Personalizado</h3>\n<p>El cliente contrata el desarrollo de un sistema, aplicación o sitio web adaptado a sus necesidades. Incluye entrega de código, acceso al panel de administración y soporte según plan.</p>\n\n<h3>3.2 Mantenimiento y Soporte</h3>\n<p>SoftwarePar ofrece planes de mantenimiento técnico, actualizaciones de seguridad y asistencia remota para proyectos ya implementados.</p>\n\n<h2>4. Pagos y Facturación</h2>\n<ul>\n  <li>Los pagos se realizan en guaraníes (PYG) o dólares estadounidenses (USD) según el tipo de cambio vigente.</li>\n  <li>Métodos aceptados: Mango, Ueno, Banco Solar, transferencia o efectivo.</li>\n  <li>Se emite <strong>Boleta RESIMPLE o Factura Electrónica</strong> conforme a la normativa de la <strong>SET Paraguay</strong>.</li>\n  <li>Los precios publicados no incluyen servicios de terceros (hosting, dominio, etc.) salvo que se indique lo contrario.</li>\n  <li>Los pagos deben completarse antes de la entrega final del proyecto o activación del servicio.</li>\n</ul>\n\n<h2>5. Propiedad Intelectual</h2>\n<ul>\n  <li>En proyectos personalizados, el cliente obtiene los derechos de uso del sistema entregado.</li>\n  <li>SoftwarePar mantiene la titularidad del código fuente y componentes reutilizables del sistema base.</li>\n  <li>El cliente no podrá revender ni redistribuir el software sin autorización escrita.</li>\n</ul>\n\n<h2>6. Garantías y Soporte</h2>\n<ul>\n  <li>Todos los proyectos incluyen <strong>6 meses de garantía técnica</strong> por errores o fallas atribuibles al desarrollo.</li>\n  <li>Incluye actualizaciones de seguridad menores y soporte remoto.</li>\n  <li>Cambios funcionales o rediseños no forman parte de la garantía.</li>\n</ul>\n\n<h2>7. Limitación de Responsabilidad</h2>\n<p>SoftwarePar no será responsable por:</p>\n<ul>\n  <li>Daños indirectos, pérdida de datos o interrupciones causadas por terceros (hosting, DNS, proveedores externos).</li>\n  <li>Fallos derivados de configuraciones modificadas por el cliente.</li>\n  <li>Retrasos debidos a causas de fuerza mayor.</li>\n</ul>\n\n<h2>8. Modificaciones del Servicio</h2>\n<p>SoftwarePar puede actualizar, mejorar o interrumpir temporalmente servicios por mantenimiento o razones técnicas. Los cambios sustanciales serán notificados al cliente con anticipación razonable.</p>\n\n<h2>9. Privacidad y Protección de Datos</h2>\n<p>El tratamiento de los datos personales del cliente se realiza conforme a nuestra <a href="/privacidad">Política de Privacidad vigente</a>.</p>\n\n<h2>10. Contacto</h2>\n<p>\n📧 <strong>Email:</strong> softwarepar.lat@gmail.com<br>\n📞 <strong>Teléfono:</strong> +595 985 990 046<br>\n📍 <strong>Dirección:</strong> Barrio Residencial – Carlos Antonio López – Itapúa – Paraguay\n</p>\n\n<p><em>Estos términos se ajustan a la normativa comercial y tributaria vigente de la República del Paraguay.</em></p>\n	1	t	2025-10-17 02:38:39.302516	2025-10-17 03:17:24.728
3	cookies	Política de Cookies	<h1>Política de Cookies</h1>\n<p><strong>Última actualización:</strong> Octubre 2025</p>\n\n<h2>1. ¿Qué son las cookies?</h2>\n<p>Las cookies son pequeños archivos de texto que se almacenan en tu dispositivo cuando visitás un sitio web. Sirven para recordar tus preferencias, mejorar tu experiencia de navegación y recopilar información anónima sobre cómo se usa el sitio.</p>\n\n<h2>2. ¿Qué tipos de cookies utilizamos?</h2>\n\n<h3>a) Cookies esenciales</h3>\n<p>Necesarias para el funcionamiento básico del sitio y el acceso a funciones seguras (por ejemplo, inicio de sesión en el panel de clientes o procesamiento de pagos).</p>\n\n<h3>b) Cookies de preferencias</h3>\n<p>Permiten recordar configuraciones, idioma y personalizaciones del usuario.</p>\n\n<h3>c) Cookies analíticas</h3>\n<p>Nos ayudan a entender cómo los visitantes usan el sitio (por ejemplo, páginas más vistas, duración de la visita). Estas cookies son anónimas y se usan para mejorar el rendimiento general del sitio.</p>\n\n<h3>d) Cookies de marketing</h3>\n<p>Podrían emplearse para mostrar anuncios o promociones relevantes en función de tus intereses (solo si aceptás su uso).</p>\n\n<h2>3. ¿Por qué usamos cookies?</h2>\n<ul>\n  <li>Garantizar el funcionamiento técnico del sitio web</li>\n  <li>Recordar tus preferencias de usuario</li>\n  <li>Analizar el tráfico y rendimiento del sitio</li>\n  <li>Mejorar la seguridad y la experiencia del usuario</li>\n</ul>\n<p>No usamos cookies para almacenar información sensible como contraseñas, datos financieros o personales.</p>\n\n<h2>4. Gestión y control de cookies</h2>\n<p>Podés configurar tu navegador para aceptar, rechazar o eliminar cookies en cualquier momento. Tené en cuenta que desactivar las cookies esenciales puede afectar el funcionamiento de algunas partes del sitio.</p>\n\n<p><strong>Guías útiles:</strong></p>\n<ul>\n  <li><a href="https://support.google.com/chrome/answer/95647" target="_blank">Google Chrome</a></li>\n  <li><a href="https://support.mozilla.org/es/kb/Deshabilitar%20cookies%20de%20sitios%20web" target="_blank">Mozilla Firefox</a></li>\n  <li><a href="https://support.microsoft.com/es-es/microsoft-edge/eliminar-cookies-en-microsoft-edge-63947406-40ac-c3b8-57b9-2a946a29ae09" target="_blank">Microsoft Edge</a></li>\n  <li><a href="https://support.apple.com/es-es/guide/safari/sfri11471/mac" target="_blank">Safari</a></li>\n</ul>\n\n<h2>5. Consentimiento</h2>\n<p>Al continuar navegando en nuestro sitio, se asume que aceptás el uso de cookies según los términos de esta política. Si preferís no aceptar ciertas cookies, podés configurarlas a través del banner de consentimiento o desde la configuración de tu navegador.</p>\n\n<h2>6. Cambios en esta política</h2>\n<p>Podemos actualizar esta Política de Cookies ocasionalmente para reflejar cambios técnicos o normativos. La fecha de actualización se indicará siempre al inicio del documento.</p>\n\n<h2>7. Contacto</h2>\n<p>Si tenés dudas sobre esta política o el uso de cookies en nuestro sitio, podés contactarnos en:</p>\n<p>\n📧 <strong>Email:</strong> softwarepar.lat@gmail.com<br>\n📞 <strong>Teléfono:</strong> +595 985 990 046<br>\n📍 <strong>Dirección:</strong> Barrio Residencial – Carlos Antonio López – Itapúa – Paraguay\n</p>\n\n<p><em>Esta política se aplica conforme a las normas de protección de datos y privacidad vigentes en la República del Paraguay.</em></p>\n	\N	t	2025-10-17 02:38:39.302516	2025-10-17 02:38:39.302516
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.notifications (id, user_id, title, message, type, is_read, created_at) FROM stdin;
1	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-09-29 15:22:27.801728
2	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-09-29 15:22:29.29057
3	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-09-29 16:04:59.1094
4	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-09-29 16:05:01.06248
5	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-09-29 16:14:07.278636
6	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-09-29 16:14:08.456755
7	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "Proyecto de Prueba - Notificaciones"	info	f	2025-09-29 16:22:56.985883
8	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Proyecto de Prueba - Notificaciones" ha sido creado y está siendo revisado	success	f	2025-09-29 16:22:58.619185
9	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "Proyecto de Prueba - Notificaciones"	info	f	2025-09-29 16:24:24.385947
10	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Proyecto de Prueba - Notificaciones" ha sido creado y está siendo revisado	success	f	2025-09-29 16:24:26.024409
11	2	💵 Contraoferta Recibida	Proyecto "FrigoMgrande": Precio propuesto $250	warning	f	2025-09-29 16:28:03.27255
12	1	💬 Nuevo Mensaje	Cliente te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-09-29 16:29:04.202682
13	2	💬 Nuevo Mensaje	Administrador SoftwarePar te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-09-29 16:29:19.050779
14	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango. Comprobante adjunto: photo-1621607512214-68297480165e.jpg. Requiere verificación.	warning	f	2025-09-29 16:33:02.920794
15	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-09-29 16:34:28.86734
16	1	🚀 Nuevo Proyecto Creado	Cliente de Prueba ha creado el proyecto "Proyecto de Prueba Email - 2025-09-29T17:04:14.890Z"	info	f	2025-09-29 17:04:15.495878
17	3	✅ Proyecto Creado Exitosamente	Tu proyecto "Proyecto de Prueba Email - 2025-09-29T17:04:14.890Z" ha sido creado y está siendo revisado	success	f	2025-09-29 17:04:19.761361
18	3	📋 Proyecto Actualizado	Tu proyecto "Proyecto de Prueba Email - 2025-09-29T17:04:14.890Z" ha sido actualizado: Estado cambiado a: En Progreso - Progreso actualizado a 25%	info	f	2025-09-29 17:04:21.666928
19	1	📋 Proyecto Actualizado por Admin	Proyecto "Proyecto de Prueba Email - 2025-09-29T17:04:14.890Z" actualizado: Estado cambiado a: En Progreso - Progreso actualizado a 25%	info	f	2025-09-29 17:04:22.801791
20	1	🎫 Nuevo Ticket de Soporte	Cliente de Prueba ha creado el ticket: "Ticket de Prueba - Consulta sobre el proyecto"	warning	f	2025-09-29 17:04:28.837308
21	1	💬 Nuevo Mensaje	Cliente de Prueba te ha enviado un mensaje en "Proyecto de Prueba Email - 2025-09-29T17:04:14.890Z"	info	f	2025-09-29 17:04:30.854736
22	3	📋 Proyecto Actualizado	Tu proyecto "Proyecto de Prueba Email - 2025-09-29T17:04:14.890Z" ha sido actualizado: Estado cambiado a: Completado - Progreso actualizado a 100%	info	f	2025-09-29 17:04:30.973519
23	1	📋 Proyecto Actualizado por Admin	Proyecto "Proyecto de Prueba Email - 2025-09-29T17:04:14.890Z" actualizado: Estado cambiado a: Completado - Progreso actualizado a 100%	info	f	2025-09-29 17:04:32.768153
24	1	🚀 Nuevo Proyecto Creado	Cliente de Prueba ha creado el proyecto "Proyecto de Prueba Email - 2025-09-29T20:59:55.385Z"	info	f	2025-09-29 20:59:56.078026
25	3	✅ Proyecto Creado Exitosamente	Tu proyecto "Proyecto de Prueba Email - 2025-09-29T20:59:55.385Z" ha sido creado y está siendo revisado	success	f	2025-09-29 20:59:59.360426
26	3	📋 Proyecto Actualizado	Tu proyecto "Proyecto de Prueba Email - 2025-09-29T20:59:55.385Z" ha sido actualizado: Estado cambiado a: En Progreso - Progreso actualizado a 25%	info	f	2025-09-29 21:00:01.328731
27	1	📋 Proyecto Actualizado por Admin	Proyecto "Proyecto de Prueba Email - 2025-09-29T20:59:55.385Z" actualizado: Estado cambiado a: En Progreso - Progreso actualizado a 25%	info	f	2025-09-29 21:00:02.64845
28	1	🎫 Nuevo Ticket de Soporte	Cliente de Prueba ha creado el ticket: "Ticket de Prueba - Consulta sobre el proyecto"	warning	f	2025-09-29 21:00:06.457302
29	1	💬 Nuevo Mensaje	Cliente de Prueba te ha enviado un mensaje en "Proyecto de Prueba Email - 2025-09-29T20:59:55.385Z"	info	f	2025-09-29 21:00:07.901123
30	3	📋 Proyecto Actualizado	Tu proyecto "Proyecto de Prueba Email - 2025-09-29T20:59:55.385Z" ha sido actualizado: Estado cambiado a: Completado - Progreso actualizado a 100%	info	f	2025-09-29 21:00:08.598154
31	1	📋 Proyecto Actualizado por Admin	Proyecto "Proyecto de Prueba Email - 2025-09-29T20:59:55.385Z" actualizado: Estado cambiado a: Completado - Progreso actualizado a 100%	info	f	2025-09-29 21:00:09.697936
32	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "test"	info	f	2025-09-29 21:23:40.922568
33	2	✅ Proyecto Creado Exitosamente	Tu proyecto "test" ha sido creado y está siendo revisado	success	f	2025-09-29 21:23:45.226111
34	2	💵 Contraoferta Recibida	Proyecto "test": Precio propuesto $275	warning	f	2025-09-29 21:25:29.630751
35	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-09-29 21:34:03.102939
36	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-09-29 21:34:07.469534
37	2	💵 Contraoferta Recibida	Proyecto "FrigoMgrande": Precio propuesto $350	warning	f	2025-09-29 21:35:52.647467
38	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-09-29 21:43:09.483022
39	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-09-29 21:43:11.43281
40	2	💵 Contraoferta Recibida	Proyecto "FrigoMgrande": Precio propuesto $425	warning	f	2025-09-29 21:44:44.354683
41	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango. Comprobante adjunto: photo-1621607512214-68297480165e.jpg. Requiere verificación.	warning	f	2025-09-29 21:48:39.830617
42	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-09-29 21:51:05.529997
43	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-09-29 22:15:36.111101
44	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-09-29 22:15:38.218791
45	2	💵 Contraoferta Recibida	Proyecto "FrigoMgrande": Precio propuesto $300	warning	f	2025-09-29 22:16:16.453416
46	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-09-29 22:19:55.443582
47	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-09-29 22:19:58.822728
48	2	💵 Contraoferta Recibida	Proyecto "FrigoMgrande": Precio propuesto $175	warning	f	2025-09-29 22:20:41.491543
49	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango. Comprobante adjunto: solar.png. Requiere verificación.	warning	f	2025-09-29 22:23:25.064449
50	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-09-29 22:24:37.558769
51	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-09-30 00:48:24.046749
52	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-09-30 00:48:27.403274
53	2	💵 Contraoferta Recibida	Proyecto "FrigoMgrande": Precio propuesto $350	warning	f	2025-09-30 00:49:41.279789
54	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-09-30 01:17:59.337382
55	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-09-30 01:30:01.574974
56	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-09-30 15:27:12.173577
57	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-09-30 15:27:14.82863
58	2	💵 Contraoferta Recibida	Proyecto "FrigoMgrande": Precio propuesto $300	warning	f	2025-09-30 15:28:35.512127
59	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Comprobante adjunto: web.png. Requiere verificación.	warning	f	2025-09-30 16:06:23.188881
60	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-09-30 16:07:58.839348
61	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Avance 50% - Desarrollo" mediante Mango (TU FINANCIERA). Comprobante adjunto: SoftwarePar_Boleta_RESIMPLE_INV-STAGE-11-21.pdf. Requiere verificación.	warning	f	2025-10-01 00:13:01.768413
62	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-01 00:15:33.059709
63	2	💬 Nuevo Mensaje	Administrador SoftwarePar te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-10-01 00:29:04.839846
64	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-10-11 22:15:24.853925
65	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-10-11 22:15:29.904124
66	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Comprobante adjunto: mango.png. Requiere verificación.	warning	f	2025-10-11 22:17:58.148412
67	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-11 22:19:23.045109
68	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-10-11 23:05:38.496069
69	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-10-11 23:05:43.270383
70	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Comprobante adjunto: vaquita.png. Requiere verificación.	warning	f	2025-10-11 23:08:03.911822
71	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-11 23:09:13.746072
72	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-10-11 23:15:06.06969
73	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-10-11 23:15:10.911339
74	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-11 23:15:55.242363
75	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-11 23:16:33.097658
76	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "Barbershop"	info	f	2025-10-13 13:18:33.17086
77	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Barbershop" ha sido creado y está siendo revisado	success	f	2025-10-13 13:18:35.681804
78	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Ueno Bank. Comprobante adjunto: test.pdf. Requiere verificación.	warning	f	2025-10-13 13:21:03.728985
79	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 13:21:50.284589
80	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Avance 50% - Desarrollo" mediante Mango (TU FINANCIERA). Comprobante adjunto: SoftwarePar_Boleta_RESIMPLE_INV-STAGE-13-29.pdf. Requiere verificación.	warning	f	2025-10-13 13:32:25.751135
81	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 13:34:11.315857
82	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Mango (TU FINANCIERA). Comprobante adjunto: SoftwarePar_Boleta_RESIMPLE_INV-STAGE-13-29 (5).pdf. Requiere verificación.	warning	f	2025-10-13 13:38:26.616232
83	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 13:39:42.471936
84	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Entrega Final" mediante Mango (TU FINANCIERA). Comprobante adjunto: SoftwarePar_Boleta_STAGE-37.pdf. Requiere verificación.	warning	f	2025-10-13 13:45:44.036969
85	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 13:46:47.27615
86	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "Barbershop"	info	f	2025-10-13 13:51:58.592275
87	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Barbershop" ha sido creado y está siendo revisado	success	f	2025-10-13 13:52:02.393137
88	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Comprobante adjunto: SoftwarePar_Boleta_RESIMPLE_INV-STAGE-12-26.pdf. Requiere verificación.	warning	f	2025-10-13 13:53:17.853019
89	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 13:53:48.471558
169	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-10-16 22:12:21.652321
90	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Avance 50% - Desarrollo" mediante Mango (TU FINANCIERA). Comprobante adjunto: test.pdf. Requiere verificación.	warning	f	2025-10-13 14:04:37.526987
91	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 14:04:58.61289
92	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-13 14:11:40.573681
93	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 14:12:03.657864
94	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Entrega Final" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-13 14:21:56.228171
95	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 14:22:15.22891
96	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-10-13 18:44:13.136684
97	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-10-13 18:44:15.335464
98	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-13 18:45:22.640981
99	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 18:45:36.825278
100	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Avance 50% - Desarrollo" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-13 18:53:45.920305
101	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 18:54:09.997894
102	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-13 21:01:20.212056
103	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 21:01:40.806027
104	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Entrega Final" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-13 21:10:01.525454
105	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 21:10:39.626911
106	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgranded"	info	f	2025-10-13 21:14:23.407293
107	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgranded" ha sido creado y está siendo revisado	success	f	2025-10-13 21:14:26.069294
108	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-13 21:15:23.790188
109	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 21:23:54.035635
110	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Avance 50% - Desarrollo" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-13 22:37:38.239067
111	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 22:38:17.166068
112	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-13 22:41:50.8051
113	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-13 22:41:56.191719
114	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 22:42:20.807783
115	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Entrega Final" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-13 22:49:06.627952
116	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-13 22:49:34.518232
117	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-10-14 09:07:00.593906
118	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-10-14 09:07:04.343869
119	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 09:07:47.377102
120	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 09:08:13.046894
121	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Avance 50% - Desarrollo" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 09:11:42.117195
122	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 09:12:03.469593
123	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 09:19:25.206562
124	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 09:19:54.599331
125	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Entrega Final" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 09:26:12.806799
126	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 09:26:34.848457
127	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-10-14 09:33:55.082564
128	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-10-14 09:33:57.948028
170	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-10-16 22:12:24.593247
129	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 09:34:39.165296
130	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 09:34:57.818171
131	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Avance 50% - Desarrollo" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 09:40:36.797084
132	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 09:40:56.518825
133	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 10:48:36.181802
134	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 10:49:03.528791
135	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Entrega Final" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 10:53:03.195423
136	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 10:53:26.113745
137	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "Barbershop"	info	f	2025-10-14 11:06:14.867751
138	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Barbershop" ha sido creado y está siendo revisado	success	f	2025-10-14 11:06:17.302926
139	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 11:06:52.686205
140	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 11:07:24.509935
141	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "Barbershop"	info	f	2025-10-14 11:19:07.088084
142	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Barbershop" ha sido creado y está siendo revisado	success	f	2025-10-14 11:19:09.54806
143	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 11:20:10.606717
144	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 11:20:28.441181
145	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Avance 50% - Desarrollo" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 11:43:53.708622
146	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 11:44:21.97128
147	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 11:55:50.091502
148	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 11:56:14.119634
149	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Entrega Final" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 12:09:01.301016
150	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 12:09:18.209609
151	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "Barbershop"	info	f	2025-10-14 12:21:10.844266
152	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Barbershop" ha sido creado y está siendo revisado	success	f	2025-10-14 12:21:13.238308
153	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 12:22:30.130968
154	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 12:22:43.440597
155	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Avance 50% - Desarrollo" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 12:57:38.263555
156	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 12:58:00.880166
157	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-14 13:05:18.542601
158	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-14 13:05:51.25104
159	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Entrega Final" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-15 12:00:53.369798
160	2	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-15 12:01:42.894931
161	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "Barbershop"	info	f	2025-10-15 12:10:19.113086
162	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Barbershop" ha sido creado y está siendo revisado	success	f	2025-10-15 12:10:21.279803
163	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-15 12:13:55.158073
164	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-15 12:14:27.372555
165	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Avance 50% - Desarrollo" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-15 14:18:58.394766
166	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-15 14:19:31.974644
167	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-15 14:23:13.807737
168	2	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-15 14:48:19.218459
171	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-10-16 22:27:33.797048
172	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-10-16 22:27:37.180992
173	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-16 22:28:52.637902
174	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-10-16 22:31:54.19637
175	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-10-16 22:31:56.718905
176	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-16 22:33:26.400542
177	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-16 22:34:01.098872
178	1	💬 Nuevo Mensaje	Cliente te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-10-16 22:46:10.876792
179	2	💬 Nuevo Mensaje	Administrador SoftwarePar te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-10-16 22:46:21.595433
180	2	💬 Nuevo Mensaje	Administrador SoftwarePar te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-10-16 22:46:47.330548
181	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Avance 50% - Desarrollo" mediante Ueno Bank. Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-16 23:29:51.174725
182	2	✅ Pago Aprobado	Tu pago para la etapa "Avance 50% - Desarrollo" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-16 23:30:48.886559
183	1	🚀 Nuevo Proyecto Creado	Cliente de Prueba ha creado el proyecto "Proyecto de Prueba Email - 2025-10-17T03:00:53.810Z"	info	f	2025-10-17 03:00:54.472916
184	3	✅ Proyecto Creado Exitosamente	Tu proyecto "Proyecto de Prueba Email - 2025-10-17T03:00:53.810Z" ha sido creado y está siendo revisado	success	f	2025-10-17 03:00:56.296055
185	3	📋 Proyecto Actualizado	Tu proyecto "Proyecto de Prueba Email - 2025-10-17T03:00:53.810Z" ha sido actualizado: Estado cambiado a: En Progreso - Progreso actualizado a 25%	info	f	2025-10-17 03:00:57.53232
186	1	📋 Proyecto Actualizado por Admin	Proyecto "Proyecto de Prueba Email - 2025-10-17T03:00:53.810Z" actualizado: Estado cambiado a: En Progreso - Progreso actualizado a 25%	info	f	2025-10-17 03:00:58.588019
187	1	🎫 Nuevo Ticket de Soporte	Cliente de Prueba ha creado el ticket: "Ticket de Prueba - Consulta sobre el proyecto"	warning	f	2025-10-17 03:01:00.950191
188	1	💬 Nuevo Mensaje	Cliente de Prueba te ha enviado un mensaje en "Proyecto de Prueba Email - 2025-10-17T03:00:53.810Z"	info	f	2025-10-17 03:01:02.26791
189	3	📋 Proyecto Actualizado	Tu proyecto "Proyecto de Prueba Email - 2025-10-17T03:00:53.810Z" ha sido actualizado: Estado cambiado a: Completado - Progreso actualizado a 100%	info	f	2025-10-17 03:01:03.387143
190	1	📋 Proyecto Actualizado por Admin	Proyecto "Proyecto de Prueba Email - 2025-10-17T03:00:53.810Z" actualizado: Estado cambiado a: Completado - Progreso actualizado a 100%	info	f	2025-10-17 03:01:04.266813
191	1	📋 Payment Proof Received	Client Cliente submitted payment proof for "Pre-entrega - 90% Completado" via Ueno Bank. No attachment. Requires verification.	warning	f	2025-10-17 05:01:39.218358
192	2	✅ Payment Approved	Your payment for the stage "Pre-entrega - 90% Completado" has been verified and approved. We are continuing with development!	success	f	2025-10-17 05:02:05.468301
193	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "Barbershop"	info	f	2025-10-17 12:58:12.508806
194	2	✅ Proyecto Creado Exitosamente	Tu proyecto "Barbershop" ha sido creado y está siendo revisado	success	f	2025-10-17 12:58:14.026887
195	2	💵 Contraoferta Recibida	Proyecto "Barbershop": Precio propuesto $200	warning	f	2025-10-17 13:03:07.721253
196	1	📋 Payment Proof Received	Client Cliente submitted payment proof for "Anticipo - Inicio del Proyecto" via Ueno Bank. No attachment. Requires verification.	warning	f	2025-10-17 13:05:23.275704
197	2	✅ Payment Approved	Your payment for the stage "Anticipo - Inicio del Proyecto" has been verified and approved. We are continuing with development!	success	f	2025-10-17 13:05:54.710813
198	1	📋 Payment Proof Received	Client Cliente submitted payment proof for "Avance 50% - Desarrollo" via Ueno Bank. No attachment. Requires verification.	warning	f	2025-10-17 14:30:09.785083
199	2	✅ Payment Approved	Your payment for the stage "Avance 50% - Desarrollo" has been verified and approved. We are continuing with development!	success	f	2025-10-17 14:31:05.093631
200	1	📋 Payment Proof Received	Client Cliente submitted payment proof for "Pre-entrega - 90% Completado" via Ueno Bank. No attachment. Requires verification.	warning	f	2025-10-17 14:38:07.872808
201	2	✅ Payment Approved	Your payment for the stage "Pre-entrega - 90% Completado" has been verified and approved. We are continuing with development!	success	f	2025-10-17 14:38:43.677333
202	1	📋 Payment Proof Received	Client Cliente submitted payment proof for "Entrega Final" via Mango (TU FINANCIERA). No attachment. Requires verification.	warning	f	2025-10-17 15:00:46.736088
203	2	✅ Payment Approved	Your payment for the stage "Entrega Final" has been verified and approved. We are continuing with development!	success	f	2025-10-17 15:01:33.991686
204	1	🚀 Nuevo Proyecto Creado	Cliente ha creado el proyecto "FrigoMgrande"	info	f	2025-10-17 16:18:28.453639
205	2	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-10-17 16:18:30.532049
206	2	💵 Contraoferta Recibida	Proyecto "FrigoMgrande": Precio propuesto $175	warning	f	2025-10-17 16:20:30.856278
207	1	📋 Comprobante de Pago Recibido	El cliente Cliente envió comprobante de pago para "Anticipo - Inicio del Proyecto" mediante Mango (TU FINANCIERA). Sin comprobante adjunto. Requiere verificación.	warning	f	2025-10-18 15:29:29.20048
208	2	✅ Pago Aprobado	Tu pago para la etapa "Anticipo - Inicio del Proyecto" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-10-18 15:33:58.779144
\.


--
-- Data for Name: partners; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.partners (id, user_id, referral_code, commission_rate, total_earnings, created_at) FROM stdin;
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.password_reset_tokens (id, user_id, token, expires_at, used, created_at) FROM stdin;
1	2	6ec92e042b5ebb6f264c3654752b01656001307db21dc030929befc3cf42acc6	2025-10-17 01:47:57.784	t	2025-10-17 00:47:57.85948
2	2	$2b$10$c6yUqnYxLCkuMnoVT4iIVOtByvGkMxLWLvbLIY5PhSwro0jnu2V/y	2025-10-18 03:30:22.299	f	2025-10-17 03:30:22.375134
3	2	$2b$10$Sgv3gmV4dQ1pfvtolznK8.6oQwSJQ1ODBSqVSow9QJcNAFHfj.X7y	2025-10-18 03:35:30.778	f	2025-10-17 03:35:30.855229
4	2	dfc4115ed78a347b4154b81c8cd342656e22cfbffb8edf87728f227fe82bb1e5	2025-10-18 03:46:10.465	t	2025-10-17 03:46:10.540924
\.


--
-- Data for Name: payment_methods; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.payment_methods (id, user_id, type, is_default, is_active, created_at, details) FROM stdin;
\.


--
-- Data for Name: payment_stages; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.payment_stages (id, project_id, stage_name, stage_percentage, amount, required_progress, status, payment_link, paid_date, created_at, updated_at, payment_method, payment_data, proof_file_url, exchange_rate_used) FROM stdin;
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.payments (id, project_id, amount, status, payment_data, created_at, stage, stage_percentage, payment_method, transaction_id) FROM stdin;
\.


--
-- Data for Name: portfolio; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.portfolio (id, title, description, category, technologies, image_url, demo_url, completed_at, featured, is_active, created_at, updated_at) FROM stdin;
7	BaberShop	Aplicación web completa para gestión de barbería con sistema de reservas online, panel administrativo y soporte multiidioma (Español/Portugués). Incluye catálogo de servicios con precios en múltiples monedas (USD, BRL, PYG), galería de trabajos, gestión de personal y configuración de horarios. Sistema responsive con diseño moderno y funcionalidades avanzadas de administración.	Web App	[]	https://i.ibb.co/8DwC9CCg/web.png	https://barbershop.softwarepar.lat	2025-09-23 00:00:00	f	t	2025-09-24 23:27:36.539547	2025-10-06 14:53:42.559
2	Dashboard Analytics	Dashboard interactivo para analisis de datos con graficos en tiempo real y reportes personalizables.	Dashboard	[]	https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800	https://demo-dashboard.softwarepar.lat	2024-02-10 00:00:00	t	t	2025-08-27 14:44:09.899342	2025-10-06 14:53:53.928
3	App Movil Delivery1	Aplicacion movil para delivery de comida con seguimiento en tiempo real y multiples metodos de pago.	Mobile App	[]	https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=800		2024-03-05 00:00:00	f	t	2025-08-27 14:44:09.899342	2025-10-06 14:54:01.97
4	Sistema CRM	Sistema de gestion de relaciones con clientes con automatizacion de marketing y seguimiento de ventas.	Web App	[]	https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800	https://demo-crm.softwarepar.lat	2024-01-28 00:00:00	f	t	2025-08-27 14:44:09.899342	2025-10-06 14:54:09.764
1	E-commerce Moderno	Plataforma de comercio electronico con carrito de compras, pagos integrados y panel de administracion completo.	E-commerce	[]	https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=800	https://demo-ecommerce.softwarepar.lat	2024-01-15 00:00:00	t	t	2025-08-27 14:44:09.899342	2025-10-06 14:54:21.675
\.


--
-- Data for Name: project_files; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.project_files (id, project_id, file_name, file_url, file_type, uploaded_by, file_size, created_at) FROM stdin;
\.


--
-- Data for Name: project_messages; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.project_messages (id, project_id, user_id, message, created_at) FROM stdin;
\.


--
-- Data for Name: project_timeline; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.project_timeline (id, project_id, title, description, status, estimated_date, completed_at, created_at) FROM stdin;
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.projects (id, name, description, price, status, progress, client_id, partner_id, delivery_date, created_at, updated_at, start_date) FROM stdin;
\.


--
-- Data for Name: referrals; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.referrals (id, partner_id, client_id, project_id, status, commission_amount, created_at) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.sessions (sid, sess, expire) FROM stdin;
\.


--
-- Data for Name: ticket_responses; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.ticket_responses (id, ticket_id, user_id, message, is_from_support, created_at) FROM stdin;
\.


--
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.tickets (id, title, description, status, priority, user_id, project_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.transactions (id, invoice_id, payment_method_id, user_id, amount, currency, status, transaction_id, payment_data, created_at, completed_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.users (id, email, password, full_name, role, is_active, created_at, updated_at, whatsapp_number) FROM stdin;
3	cliente.prueba@test.com	$2b$10$6nMuk.lGIr1.p4G2wV.giO2yNpOx55rL9wWBeAxKgHbVGBVLbToZ2	Cliente de Prueba	client	t	2025-09-29 17:04:14.806663	2025-09-29 17:04:14.806663	\N
1	softwarepar.lat@gmail.com	$2b$10$FuHFhTc0ctLQqAfTWnUk9e5fbbha/vx2AhragKYn6MRT5R4SM4336	Administrador SoftwarePar	admin	t	2025-08-26 22:32:54.933839	2025-10-16 23:55:25.087	\N
2	alfagroupstoreok@gmail.com	$2b$10$YWLG9p67FrC4Zvk1QecXkO9CVy9Nj2a2eo2mgWT56BEKJUkjEzHWS	Cliente	client	t	2025-09-29 15:15:32.71422	2025-10-17 04:01:52.492	+59512121212
\.


--
-- Data for Name: work_modalities; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.work_modalities (id, title, subtitle, badge_text, badge_variant, description, price_text, price_subtitle, features, button_text, button_variant, is_popular, is_active, display_order, created_at, updated_at) FROM stdin;
4	Compra Completa	Tradicional	Tradicional	secondary	Recibe el código fuente completo y propiedad total del proyecto	$2,500 - $15,000	Precio según complejidad	"[\\"Código fuente completo incluido\\",\\"Propiedad intelectual total\\",\\"Documentación técnica completa\\",\\"3 meses de soporte incluido\\",\\"Capacitación del equipo\\",\\"Deployment en tu servidor\\"]"	Solicitar Cotización	default	f	f	1	2025-09-23 12:20:20.459498	2025-10-06 15:02:52.189
3	Modelo SaaS	Más Popular	Más Popular	secondary	Accede al software como servicio con pagos mensuales flexibles	$50 - $200	por mes	["Sin inversión inicial alta", "Actualizaciones automáticas", "Soporte técnico incluido", "Escalabilidad garantizada", "Copias de seguridad automáticas", "Acceso 24/7 desde cualquier lugar"]	Comenzar Ahora	default	t	f	2	2025-09-23 12:07:05.836181	2025-09-23 12:15:18.484
1	Compra Completa	Tradicional	Tradicional	default	Recibe el código fuente completo y propiedad total del proyecto	$2,500 - $15,000	Precio según complejidad	"[\\"Código fuente completo incluido\\",\\"Propiedad intelectual total\\",\\"Documentación técnica completa\\",\\"3 meses de soporte incluido\\",\\"Capacitación del equipo\\",\\"Deployment en tu servidor\\"]"	Solicitar Cotización	default	f	f	1	2025-09-23 12:01:27.883544	2025-09-23 12:19:00.669
5	Partnership	Innovador	Más Popular	default	Paga menos, conviértete en partner y genera ingresos revendendolo	40% - 60%	+ comisiones por ventas	["Precio reducido inicial", "Código de referido único", "20-40% comisión por venta", "Dashboard de ganancias", "Sistema de licencias", "Soporte y marketing incluido"]	Convertirse en Partner	default	t	f	2	2025-09-23 12:20:20.459498	2025-09-23 12:21:44.001
6	Lanzamiento Web	Tu sitio profesional listo en pocos días	Ideal para Emprendedores	default	Ideal para negocios y emprendedores que desean una página web moderna, rápida y optimizada. Incluye dominio, hosting, y soporte técnico por 30 días.	Gs 1.500.000	Entrega en 7 a 15 días	"[\\"Diseño web profesional (hasta 5 secciones)\\",\\"Dominio .com o .com.py incluido\\",\\"Hosting y certificado SSL\\",\\"Diseño responsive (PC, tablet, móvil)\\",\\"Formulario de contacto y WhatsApp directo\\",\\"Optimización SEO básica\\",\\"Soporte técnico 30 días\\"]"	Cotizar mi web profesional	default	f	t	1	2025-10-06 15:00:30.907659	2025-10-06 15:00:30.907659
2	Partnership	Innovador	Más Popular	default	Paga menos, conviértete en partner y genera ingresos revendendolo	40% - 70%	+ comisiones por ventas	"[\\"Precio reducido inicial\\",\\"Código de referido único\\",\\"20-40% comisión por venta\\",\\"Dashboard de ganancias\\",\\"Sistema de licencias\\",\\"Soporte y marketing incluido\\"]"	Convertirse en Partner	default	t	f	2	2025-09-23 12:01:27.883544	2025-10-06 15:02:46.881
7	Desarrollo Avanzado	Soluciones web y apps a medida para tu empresa	Más Popular	secondary	Perfecto para empresas que necesitan sistemas personalizados, paneles administrativos y aplicaciones con integraciones avanzadas.	Gs. 3.500.000	Precio según complejidad	"[\\"Sistema web o app personalizada\\",\\"Panel administrativo completo\\",\\"Integración con pagos y facturación\\",\\"Usuarios y roles personalizados\\",\\"Reportes y dashboard\\",\\"Diseño exclusivo adaptado a tu marca\\",\\"Garantía técnica 6 meses\\",\\"Implementación en servidor\\"]"	Solicitar Cotización	default	t	t	2	2025-10-06 15:02:26.43384	2025-10-06 15:03:17.764
\.


--
-- Name: __drizzle_migrations_id_seq; Type: SEQUENCE SET; Schema: drizzle; Owner: neondb_owner
--

SELECT pg_catalog.setval('drizzle.__drizzle_migrations_id_seq', 1, false);


--
-- Name: budget_negotiations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.budget_negotiations_id_seq', 10, true);


--
-- Name: client_billing_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.client_billing_info_id_seq', 1, true);


--
-- Name: company_billing_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.company_billing_info_id_seq', 3, true);


--
-- Name: exchange_rate_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.exchange_rate_config_id_seq', 12, true);


--
-- Name: invoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.invoices_id_seq', 59, true);


--
-- Name: legal_pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.legal_pages_id_seq', 9, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.notifications_id_seq', 208, true);


--
-- Name: partners_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.partners_id_seq', 1, false);


--
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.password_reset_tokens_id_seq', 4, true);


--
-- Name: payment_methods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.payment_methods_id_seq', 1, false);


--
-- Name: payment_stages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.payment_stages_id_seq', 97, true);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.payments_id_seq', 1, false);


--
-- Name: portfolio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.portfolio_id_seq', 7, true);


--
-- Name: project_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.project_files_id_seq', 1, false);


--
-- Name: project_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.project_messages_id_seq', 9, true);


--
-- Name: project_timeline_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.project_timeline_id_seq', 144, true);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.projects_id_seq', 31, true);


--
-- Name: referrals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.referrals_id_seq', 1, false);


--
-- Name: ticket_responses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.ticket_responses_id_seq', 1, false);


--
-- Name: tickets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.tickets_id_seq', 3, true);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.transactions_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: work_modalities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.work_modalities_id_seq', 7, true);


--
-- Name: __drizzle_migrations __drizzle_migrations_pkey; Type: CONSTRAINT; Schema: drizzle; Owner: neondb_owner
--

ALTER TABLE ONLY drizzle.__drizzle_migrations
    ADD CONSTRAINT __drizzle_migrations_pkey PRIMARY KEY (id);


--
-- Name: budget_negotiations budget_negotiations_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.budget_negotiations
    ADD CONSTRAINT budget_negotiations_pkey PRIMARY KEY (id);


--
-- Name: client_billing_info client_billing_info_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.client_billing_info
    ADD CONSTRAINT client_billing_info_pkey PRIMARY KEY (id);


--
-- Name: company_billing_info company_billing_info_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.company_billing_info
    ADD CONSTRAINT company_billing_info_pkey PRIMARY KEY (id);


--
-- Name: exchange_rate_config exchange_rate_config_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.exchange_rate_config
    ADD CONSTRAINT exchange_rate_config_pkey PRIMARY KEY (id);


--
-- Name: invoices invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_pkey PRIMARY KEY (id);


--
-- Name: legal_pages legal_pages_page_type_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.legal_pages
    ADD CONSTRAINT legal_pages_page_type_key UNIQUE (page_type);


--
-- Name: legal_pages legal_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.legal_pages
    ADD CONSTRAINT legal_pages_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: partners partners_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.partners
    ADD CONSTRAINT partners_pkey PRIMARY KEY (id);


--
-- Name: partners partners_referral_code_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.partners
    ADD CONSTRAINT partners_referral_code_unique UNIQUE (referral_code);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_token_unique UNIQUE (token);


--
-- Name: payment_methods payment_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payment_methods
    ADD CONSTRAINT payment_methods_pkey PRIMARY KEY (id);


--
-- Name: payment_stages payment_stages_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payment_stages
    ADD CONSTRAINT payment_stages_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: portfolio portfolio_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.portfolio
    ADD CONSTRAINT portfolio_pkey PRIMARY KEY (id);


--
-- Name: project_files project_files_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_files
    ADD CONSTRAINT project_files_pkey PRIMARY KEY (id);


--
-- Name: project_messages project_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_messages
    ADD CONSTRAINT project_messages_pkey PRIMARY KEY (id);


--
-- Name: project_timeline project_timeline_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_timeline
    ADD CONSTRAINT project_timeline_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: referrals referrals_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (sid);


--
-- Name: ticket_responses ticket_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.ticket_responses
    ADD CONSTRAINT ticket_responses_pkey PRIMARY KEY (id);


--
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: work_modalities work_modalities_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.work_modalities
    ADD CONSTRAINT work_modalities_pkey PRIMARY KEY (id);


--
-- Name: IDX_session_expire; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX "IDX_session_expire" ON public.sessions USING btree (expire);


--
-- Name: budget_negotiations budget_negotiations_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.budget_negotiations
    ADD CONSTRAINT budget_negotiations_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: budget_negotiations budget_negotiations_proposed_by_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.budget_negotiations
    ADD CONSTRAINT budget_negotiations_proposed_by_users_id_fk FOREIGN KEY (proposed_by) REFERENCES public.users(id);


--
-- Name: client_billing_info client_billing_info_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.client_billing_info
    ADD CONSTRAINT client_billing_info_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: exchange_rate_config exchange_rate_config_updated_by_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.exchange_rate_config
    ADD CONSTRAINT exchange_rate_config_updated_by_users_id_fk FOREIGN KEY (updated_by) REFERENCES public.users(id);


--
-- Name: invoices invoices_client_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_client_id_users_id_fk FOREIGN KEY (client_id) REFERENCES public.users(id);


--
-- Name: invoices invoices_payment_method_id_payment_methods_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_payment_method_id_payment_methods_id_fk FOREIGN KEY (payment_method_id) REFERENCES public.payment_methods(id);


--
-- Name: invoices invoices_payment_stage_id_payment_stages_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_payment_stage_id_payment_stages_id_fk FOREIGN KEY (payment_stage_id) REFERENCES public.payment_stages(id);


--
-- Name: invoices invoices_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: legal_pages legal_pages_last_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.legal_pages
    ADD CONSTRAINT legal_pages_last_updated_by_fkey FOREIGN KEY (last_updated_by) REFERENCES public.users(id);


--
-- Name: notifications notifications_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: partners partners_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.partners
    ADD CONSTRAINT partners_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: password_reset_tokens password_reset_tokens_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: payment_methods payment_methods_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payment_methods
    ADD CONSTRAINT payment_methods_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: payment_stages payment_stages_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payment_stages
    ADD CONSTRAINT payment_stages_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: payments payments_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: project_files project_files_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_files
    ADD CONSTRAINT project_files_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: project_files project_files_uploaded_by_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_files
    ADD CONSTRAINT project_files_uploaded_by_users_id_fk FOREIGN KEY (uploaded_by) REFERENCES public.users(id);


--
-- Name: project_messages project_messages_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_messages
    ADD CONSTRAINT project_messages_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: project_messages project_messages_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_messages
    ADD CONSTRAINT project_messages_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: project_timeline project_timeline_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_timeline
    ADD CONSTRAINT project_timeline_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: projects projects_client_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_client_id_users_id_fk FOREIGN KEY (client_id) REFERENCES public.users(id);


--
-- Name: projects projects_partner_id_partners_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_partner_id_partners_id_fk FOREIGN KEY (partner_id) REFERENCES public.partners(id);


--
-- Name: referrals referrals_client_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_client_id_users_id_fk FOREIGN KEY (client_id) REFERENCES public.users(id);


--
-- Name: referrals referrals_partner_id_partners_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_partner_id_partners_id_fk FOREIGN KEY (partner_id) REFERENCES public.partners(id);


--
-- Name: referrals referrals_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: ticket_responses ticket_responses_ticket_id_tickets_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.ticket_responses
    ADD CONSTRAINT ticket_responses_ticket_id_tickets_id_fk FOREIGN KEY (ticket_id) REFERENCES public.tickets(id);


--
-- Name: ticket_responses ticket_responses_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.ticket_responses
    ADD CONSTRAINT ticket_responses_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: tickets tickets_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: tickets tickets_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: transactions transactions_invoice_id_invoices_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_invoice_id_invoices_id_fk FOREIGN KEY (invoice_id) REFERENCES public.invoices(id);


--
-- Name: transactions transactions_payment_method_id_payment_methods_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_payment_method_id_payment_methods_id_fk FOREIGN KEY (payment_method_id) REFERENCES public.payment_methods(id);


--
-- Name: transactions transactions_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

\unrestrict JKQQXNONmfozTjtlUnnWlSxjdQg66jICPY3dm8aZIkTJKMielVT9bPauHRlQU08

