CREATE DATABASE restaurant_db;
\c restaurant_db

CREATE TABLE foods (
id SERIAL PRIMARY KEY,
name varchar(150),
cuisine_type varchar(100),
calories integer,
price money
);

CREATE TABLE parties (
id SERIAL PRIMARY KEY,
table_number integer,
number_guests integer,
pay_status boolean,
order_id integer
);

CREATE TABLE orders (
id SERIAL PRIMARY KEY,
food_id integer,
party_id integer
);

\q
