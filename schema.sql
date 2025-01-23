--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

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
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: scheduled_tasks; Type: TABLE; Schema: public; Owner: exaado_user
--

CREATE TABLE public.scheduled_tasks (
    id integer NOT NULL,
    task_type character varying(100) NOT NULL,
    execute_at timestamp without time zone NOT NULL,
    status character varying(50),
    channel_id bigint,
    telegram_id bigint
);


ALTER TABLE public.scheduled_tasks OWNER TO exaado_user;

--
-- Name: scheduled_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: exaado_user
--

CREATE SEQUENCE public.scheduled_tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.scheduled_tasks_id_seq OWNER TO exaado_user;

--
-- Name: scheduled_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exaado_user
--

ALTER SEQUENCE public.scheduled_tasks_id_seq OWNED BY public.scheduled_tasks.id;


--
-- Name: subscription_types; Type: TABLE; Schema: public; Owner: exaado_user
--

CREATE TABLE public.subscription_types (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    channel_id bigint NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.subscription_types OWNER TO exaado_user;

--
-- Name: subscription_types_id_seq; Type: SEQUENCE; Schema: public; Owner: exaado_user
--

CREATE SEQUENCE public.subscription_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subscription_types_id_seq OWNER TO exaado_user;

--
-- Name: subscription_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exaado_user
--

ALTER SEQUENCE public.subscription_types_id_seq OWNED BY public.subscription_types.id;


--
-- Name: subscriptions; Type: TABLE; Schema: public; Owner: exaado_user
--

CREATE TABLE public.subscriptions (
    id integer NOT NULL,
    user_id bigint,
    expiry_date timestamp without time zone NOT NULL,
    is_active boolean,
    reminders_sent integer,
    channel_id bigint NOT NULL,
    subscription_type_id integer,
    telegram_id bigint NOT NULL
);


ALTER TABLE public.subscriptions OWNER TO exaado_user;

--
-- Name: subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: exaado_user
--

CREATE SEQUENCE public.subscriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subscriptions_id_seq OWNER TO exaado_user;

--
-- Name: subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exaado_user
--

ALTER SEQUENCE public.subscriptions_id_seq OWNED BY public.subscriptions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: exaado_user
--

CREATE TABLE public.users (
    id integer NOT NULL,
    telegram_id bigint NOT NULL,
    username character varying(255),
    full_name character varying(255),
    wallet_address character varying(64)
);


ALTER TABLE public.users OWNER TO exaado_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: exaado_user
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO exaado_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: exaado_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: scheduled_tasks id; Type: DEFAULT; Schema: public; Owner: exaado_user
--

ALTER TABLE ONLY public.scheduled_tasks ALTER COLUMN id SET DEFAULT nextval('public.scheduled_tasks_id_seq'::regclass);


--
-- Name: subscription_types id; Type: DEFAULT; Schema: public; Owner: exaado_user
--

ALTER TABLE ONLY public.subscription_types ALTER COLUMN id SET DEFAULT nextval('public.subscription_types_id_seq'::regclass);


--
-- Name: subscriptions id; Type: DEFAULT; Schema: public; Owner: exaado_user
--

ALTER TABLE ONLY public.subscriptions ALTER COLUMN id SET DEFAULT nextval('public.subscriptions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: exaado_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: scheduled_tasks scheduled_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: exaado_user
--

ALTER TABLE ONLY public.scheduled_tasks
    ADD CONSTRAINT scheduled_tasks_pkey PRIMARY KEY (id);


--
-- Name: subscription_types subscription_types_pkey; Type: CONSTRAINT; Schema: public; Owner: exaado_user
--

ALTER TABLE ONLY public.subscription_types
    ADD CONSTRAINT subscription_types_pkey PRIMARY KEY (id);


--
-- Name: subscriptions subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: exaado_user
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_pkey PRIMARY KEY (telegram_id, channel_id);


--
-- Name: subscription_types unique_channel_id; Type: CONSTRAINT; Schema: public; Owner: exaado_user
--

ALTER TABLE ONLY public.subscription_types
    ADD CONSTRAINT unique_channel_id UNIQUE (channel_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: exaado_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_telegram_id_key; Type: CONSTRAINT; Schema: public; Owner: exaado_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_telegram_id_key UNIQUE (telegram_id);


--
-- Name: idx_execute_at; Type: INDEX; Schema: public; Owner: exaado_user
--

CREATE INDEX idx_execute_at ON public.scheduled_tasks USING btree (execute_at);


--
-- Name: idx_scheduled_tasks_channel_id; Type: INDEX; Schema: public; Owner: exaado_user
--

CREATE INDEX idx_scheduled_tasks_channel_id ON public.scheduled_tasks USING btree (channel_id);


--
-- Name: idx_scheduled_tasks_execute_at; Type: INDEX; Schema: public; Owner: exaado_user
--

CREATE INDEX idx_scheduled_tasks_execute_at ON public.scheduled_tasks USING btree (execute_at);


--
-- Name: scheduled_tasks fk_scheduled_tasks_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: exaado_user
--

ALTER TABLE ONLY public.scheduled_tasks
    ADD CONSTRAINT fk_scheduled_tasks_channel_id FOREIGN KEY (channel_id) REFERENCES public.subscription_types(channel_id) ON DELETE CASCADE;


--
-- Name: subscriptions subscriptions_subscription_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: exaado_user
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_subscription_type_id_fkey FOREIGN KEY (subscription_type_id) REFERENCES public.subscription_types(id);


--
-- Name: FUNCTION ghstore_in(cstring); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.ghstore_in(cstring) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION ghstore_out(public.ghstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.ghstore_out(public.ghstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore_in(cstring); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_in(cstring) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore_out(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_out(public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore_recv(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_recv(internal) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore_send(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_send(public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore_subscript_handler(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_subscript_handler(internal) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore(text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore(text[]) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore_to_json(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_to_json(public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore_to_jsonb(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_to_jsonb(public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION akeys(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.akeys(public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.armor(bytea) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.armor(bytea, text[], text[]) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION avals(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.avals(public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.crypt(text, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.dearmor(text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.decrypt(bytea, bytea, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.decrypt_iv(bytea, bytea, bytea, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION defined(public.hstore, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.defined(public.hstore, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION delete(public.hstore, text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.delete(public.hstore, text[]) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION delete(public.hstore, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.delete(public.hstore, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION delete(public.hstore, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.delete(public.hstore, public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.digest(bytea, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.digest(text, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION each(hs public.hstore, OUT key text, OUT value text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.each(hs public.hstore, OUT key text, OUT value text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.encrypt(bytea, bytea, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.encrypt_iv(bytea, bytea, bytea, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION exist(public.hstore, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.exist(public.hstore, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION exists_all(public.hstore, text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.exists_all(public.hstore, text[]) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION exists_any(public.hstore, text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.exists_any(public.hstore, text[]) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION fetchval(public.hstore, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.fetchval(public.hstore, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gen_random_bytes(integer) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gen_random_uuid() TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gen_salt(text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gen_salt(text, integer) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION ghstore_compress(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.ghstore_compress(internal) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION ghstore_consistent(internal, public.hstore, smallint, oid, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.ghstore_consistent(internal, public.hstore, smallint, oid, internal) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION ghstore_decompress(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.ghstore_decompress(internal) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION ghstore_options(internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.ghstore_options(internal) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION ghstore_penalty(internal, internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.ghstore_penalty(internal, internal, internal) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION ghstore_picksplit(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.ghstore_picksplit(internal, internal) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION ghstore_same(public.ghstore, public.ghstore, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.ghstore_same(public.ghstore, public.ghstore, internal) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION ghstore_union(internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.ghstore_union(internal, internal) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION gin_consistent_hstore(internal, smallint, public.hstore, integer, internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gin_consistent_hstore(internal, smallint, public.hstore, integer, internal, internal) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION gin_extract_hstore(public.hstore, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gin_extract_hstore(public.hstore, internal) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION gin_extract_hstore_query(public.hstore, internal, smallint, internal, internal); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.gin_extract_hstore_query(public.hstore, internal, smallint, internal, internal) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hmac(bytea, bytea, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hmac(text, text, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hs_concat(public.hstore, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hs_concat(public.hstore, public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hs_contained(public.hstore, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hs_contained(public.hstore, public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hs_contains(public.hstore, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hs_contains(public.hstore, public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore(record); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore(record) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore(text[], text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore(text[], text[]) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore(text, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore_cmp(public.hstore, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_cmp(public.hstore, public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore_eq(public.hstore, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_eq(public.hstore, public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore_ge(public.hstore, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_ge(public.hstore, public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore_gt(public.hstore, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_gt(public.hstore, public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore_hash(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_hash(public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore_hash_extended(public.hstore, bigint); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_hash_extended(public.hstore, bigint) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore_le(public.hstore, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_le(public.hstore, public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore_lt(public.hstore, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_lt(public.hstore, public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore_ne(public.hstore, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_ne(public.hstore, public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore_to_array(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_to_array(public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore_to_json_loose(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_to_json_loose(public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore_to_jsonb_loose(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_to_jsonb_loose(public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore_to_matrix(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_to_matrix(public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION hstore_version_diag(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.hstore_version_diag(public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION isdefined(public.hstore, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.isdefined(public.hstore, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION isexists(public.hstore, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.isexists(public.hstore, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_armor_headers(text, OUT key text, OUT value text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_key_id(bytea) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_pub_decrypt(bytea, bytea) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_pub_decrypt(bytea, bytea, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_pub_decrypt(bytea, bytea, text, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_pub_decrypt_bytea(bytea, bytea) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_pub_decrypt_bytea(bytea, bytea, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_pub_encrypt(text, bytea) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_pub_encrypt(text, bytea, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_pub_encrypt_bytea(bytea, bytea) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_pub_encrypt_bytea(bytea, bytea, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_sym_decrypt(bytea, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_sym_decrypt(bytea, text, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_sym_decrypt_bytea(bytea, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_sym_decrypt_bytea(bytea, text, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_sym_encrypt(text, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_sym_encrypt(text, text, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_sym_encrypt_bytea(bytea, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.pgp_sym_encrypt_bytea(bytea, text, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION populate_record(anyelement, public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.populate_record(anyelement, public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION skeys(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.skeys(public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION slice(public.hstore, text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.slice(public.hstore, text[]) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION slice_array(public.hstore, text[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.slice_array(public.hstore, text[]) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION svals(public.hstore); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.svals(public.hstore) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION tconvert(text, text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.tconvert(text, text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_generate_v1() TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_generate_v1mc() TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_generate_v3(namespace uuid, name text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_generate_v4() TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_generate_v5(namespace uuid, name text) TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_nil() TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_ns_dns() TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_ns_oid() TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_ns_url() TO exaado_user WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_ns_x500() TO exaado_user WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON SEQUENCES TO exaado_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON FUNCTIONS TO exaado_user WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES TO exaado_user WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

