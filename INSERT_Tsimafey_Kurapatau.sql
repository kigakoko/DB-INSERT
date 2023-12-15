insert into film (title, rental_rate, rental_duration, language_id)
select 'The Hangover', 4.99, 14, 1
where not exists (
    select 1
    from film
    where upper(title) = upper('The Hangover')
    limit 1
);

insert into actor (first_name, last_name)
select 'Bradley', 'Cooper' where not exists (
    select 1 from actor where upper(first_name) = 'Bradley' and upper(last_name) = 'Cooper'
);
insert into actor (first_name, last_name)
select 'Ed', 'Helms' where not exists (
    select 1 from actor where upper(first_name) = 'Ed' and upper(last_name) = 'Helms'
);
insert into actor (first_name, last_name)
select 'Zach', 'Galifianakis' where not exists (
    select 1 from actor where upper(first_name) = 'Zach' and upper(last_name) = 'Galifianakis'
);


with FilmCte as (
    select film_id
    from film
    where upper(title) = upper('The Hangover')
)
insert into film_actor (film_id, actor_id)
select (select film_id from FilmCte), a.actor_id
from actor a
where (upper(a.first_name), upper(a.last_name)) in (
        ('Bradley', 'Cooper'),
        ('Ed', 'Helms'),
      ('Zach', 'Galifianakis')
      )
and not exists (
    select 1
    from film_actor fa
    where fa.film_id = (select film_id from filmcte) and fa.actor_id = a.actor_id
);

with FilmCte as (
    select film_id
    from film
    where upper(title) = upper('The Hangover')
)
insert into inventory (film_id, store_id)
select (select film_id from FilmCte), 1
where not exists (
    select 1
    from inventory
    where film_id = (select film_id from FilmCte)
    and store_id = 1
);