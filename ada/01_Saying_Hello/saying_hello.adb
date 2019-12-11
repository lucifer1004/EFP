with Ada.Text_IO; use Ada.Text_IO;

procedure Saying_Hello is
begin
    Put ("What is your name? ");
    declare
    Name : String := Get_Line;
    begin
        Put ("Hello, ");
        Put (Name);
        Put (", nice to meet you!");
    end;
end Saying_Hello;