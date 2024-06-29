with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Command_Line;  use Ada.Command_Line;

with Collatz;           use Collatz;
with Collatz.Args;

procedure Main is

    tgt, u_lim, l_lim : Positive;
    u_tgt: Natural;

    first: Boolean;
begin

    if Args.arg_check (target => tgt, 
                        upper_lim => u_lim, 
                        lower_lim => l_lim,
                        upper_tgt => u_tgt,
                        first => first) = -1 then
        return;
    end if;

    if first then
        declare 
            val: Match := look (target => tgt, upper_lim => u_lim, lower_lim => l_lim, upper_tgt => u_tgt);
            temp: Positive;
        begin
            Put (i_img (val(Num)) & "(" & i_img (val(Its)) & " ): ");
            temp := iterate (val(Num), True);
        end;
        New_Line;
        return;
    end if;

    declare
        arr: Match_Arr := search (target => tgt, upper_lim => u_lim, lower_lim => l_lim, upper_tgt => u_tgt);
        temp: Positive;
    begin
        for I in arr'Range loop
            Put (i_img (arr(I)(Num)) & "(" & i_img (arr(I)(Its)) & " ): ");
            temp := iterate (arr(I)(Num), True);
        end loop;
    end;

    return;
end Main;