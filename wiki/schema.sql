  CREATE DATABASE wiki;

  CREATE TABLE authors(
    id serial primary key,
    name varchar(255),
    age integer
  );

  CREATE TABLE documents(
    id serial primary key,
    name varchar(255),
    content text,
    author_id integer
  );

  -- CREATE TABLE subscribers(
  --   id serial primary key,
  --   name varchar(255),
  --   age integer,
  --   email varchar(255),
  --   author_id integer
  -- );