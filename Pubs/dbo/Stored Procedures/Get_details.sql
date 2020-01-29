CREATE proc Get_details(@pubname varchar(40))
as
begin
select t.title,sum(s.qty) as total_qty from titles t join sales s
on t.title_id=s.title_id
where pub_id in
(select pub_id from publishers where pub_name=@pubname)
group by t.title
end
