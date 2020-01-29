create procedure maximun_soldBook
as
begin
  select title from titles where title_id=
  (select top 1 title_id from sales group by title_id
  order by sum(qty) desc)
end