--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5
-- Dumped by pg_dump version 14.5

-- Started on 2022-12-23 03:48:15

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

DROP DATABASE "Scorp";
--
-- TOC entry 3336 (class 1262 OID 16477)
-- Name: Scorp; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "Scorp" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Turkish_Turkey.1254';


ALTER DATABASE "Scorp" OWNER TO postgres;

\connect "Scorp"

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

--
-- TOC entry 3337 (class 0 OID 0)
-- Dependencies: 3336
-- Name: DATABASE "Scorp"; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE "Scorp" IS 'Backend Interview Questions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 212 (class 1259 OID 16514)
-- Name: follow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.follow (
    follower_id integer NOT NULL,
    following_id integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.follow OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16497)
-- Name: like; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."like" (
    id integer NOT NULL,
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public."like" OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16485)
-- Name: post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post (
    id integer NOT NULL,
    description text,
    user_id integer NOT NULL,
    image text,
    created_at integer NOT NULL
);


ALTER TABLE public.post OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16478)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username text NOT NULL,
    email text,
    full_name text,
    profile_picture text,
    bio text,
    created_at integer NOT NULL
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- TOC entry 3330 (class 0 OID 16514)
-- Dependencies: 212
-- Data for Name: follow; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.follow (follower_id, following_id, created_at) VALUES (2, 1, 1);
INSERT INTO public.follow (follower_id, following_id, created_at) VALUES (1, 2, 2);


--
-- TOC entry 3329 (class 0 OID 16497)
-- Dependencies: 211
-- Data for Name: like; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."like" (id, user_id, post_id, created_at) VALUES (1, 2, 1, 1);
INSERT INTO public."like" (id, user_id, post_id, created_at) VALUES (2, 2, 2, 2);


--
-- TOC entry 3328 (class 0 OID 16485)
-- Dependencies: 210
-- Data for Name: post; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.post (id, description, user_id, image, created_at) VALUES (1, 'Post One', 1, NULL, 1);
INSERT INTO public.post (id, description, user_id, image, created_at) VALUES (2, 'Post Two', 1, NULL, 2);
INSERT INTO public.post (id, description, user_id, image, created_at) VALUES (3, 'Post Three', 2, NULL, 3);
INSERT INTO public.post (id, description, user_id, image, created_at) VALUES (4, 'Post Four', 2, NULL, 4);
INSERT INTO public.post (id, description, user_id, image, created_at) VALUES (5, 'Post Five', 2, NULL, 5);


--
-- TOC entry 3327 (class 0 OID 16478)
-- Dependencies: 209
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."user" (id, username, email, full_name, profile_picture, bio, created_at) VALUES (1, 'oguz', 'oguzkoroglu@gmail.com', 'Oguz Koroglu', NULL, NULL, 1);
INSERT INTO public."user" (id, username, email, full_name, profile_picture, bio, created_at) VALUES (2, 'user1', 'user1@gmail.com', 'User One', NULL, NULL, 2);
INSERT INTO public."user" (id, username, email, full_name, profile_picture, bio, created_at) VALUES (3, 'user2', 'user2@gmail.com', 'User Two', NULL, NULL, 3);


--
-- TOC entry 3182 (class 2606 OID 16501)
-- Name: like like_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."like"
    ADD CONSTRAINT like_pkey PRIMARY KEY (id);


--
-- TOC entry 3178 (class 2606 OID 16491)
-- Name: post post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (id);


--
-- TOC entry 3176 (class 2606 OID 16484)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 3179 (class 1259 OID 16507)
-- Name: fki_like_post; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_like_post ON public."like" USING btree (post_id);


--
-- TOC entry 3180 (class 1259 OID 16513)
-- Name: fki_p; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_p ON public."like" USING btree (user_id);


--
-- TOC entry 3186 (class 2606 OID 16517)
-- Name: follow follower_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follow
    ADD CONSTRAINT follower_user FOREIGN KEY (follower_id) REFERENCES public."user"(id);


--
-- TOC entry 3187 (class 2606 OID 16522)
-- Name: follow following_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follow
    ADD CONSTRAINT following_user FOREIGN KEY (following_id) REFERENCES public."user"(id);


--
-- TOC entry 3184 (class 2606 OID 16502)
-- Name: like like_post; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."like"
    ADD CONSTRAINT like_post FOREIGN KEY (post_id) REFERENCES public.post(id);


--
-- TOC entry 3185 (class 2606 OID 16508)
-- Name: like like_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."like"
    ADD CONSTRAINT like_user FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- TOC entry 3183 (class 2606 OID 16492)
-- Name: post post_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_user FOREIGN KEY (user_id) REFERENCES public."user"(id);


-- Completed on 2022-12-23 03:48:15

--
-- PostgreSQL database dump complete
--

