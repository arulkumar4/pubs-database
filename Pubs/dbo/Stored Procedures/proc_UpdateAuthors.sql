create procedure proc_UpdateAuthors(@lname varchar(40),@fname varchar(20))
  as
  begin
  update authors set au_lname=@lname where au_fname=@fname
  end