with Ada.Text_IO;       use Ada.Text_IO;

procedure Main is

    type Data is (Num, Its);
    type coll_inf is array (Data) of Integer;

    type coll_arr is array (Positive range <>) of coll_inf;

    function i_img (I: Integer) return String
        renames Integer'Image;

    function collatz (I: Integer; print: Boolean := False) return Natural is
        count: Natural := 1;
        val: Integer := I;
    begin
        loop
            if print then
                Put (i_img (val));
            end if;

            val := (if val mod 2 = 0 then val / 2
                    else (val * 3) + 1);

            if val <= 1 then exit;
            end if;

            count := count + 1; 
        end loop;

        if print then Put_Line (i_img (1));
        end if;

        return count;    
    end collatz;

    function look_for (tgt_lo: Natural; tgt_hi: Natural := 0; upper_lim: Natural := 500; lower_lim: Natural := 5) return coll_arr is

        function look (lower_lim: Natural := 5) return coll_inf is
        begin
            if lower_lim >= upper_lim then return (-1, -1);
            end if;

            if tgt_hi = 0 or tgt_hi < tgt_lo then

                for I in lower_lim..upper_lim loop
                    if collatz (I) = tgt_lo then
                        return (I, tgt_lo);
                    end if;
                end loop;
                
                return (-1, -1);
            
            else
                declare
                    hold: Natural;
                begin
                    for I in lower_lim..upper_lim loop
                        hold := collatz (I);
                        if hold in tgt_lo..tgt_hi then
                            return (I, hold);
                        end if;
                    end loop;

                    return (-1, -1);
                end;
            end if;
        end;

        count: Natural := 0;

    begin
        declare
            temp: coll_inf := (lower_lim - 1, 0);
        begin
            loop
                temp := look (lower_lim => temp(Num) + 1);

                if temp = (-1, -1) then exit;
                end if;

                count := count + 1;
            end loop;

            declare 
                arr: coll_arr (1..count);
            begin
                temp := (lower_lim - 1, 0);
                for I in arr'Range loop
                    temp := look (lower_lim => temp(Num) + 1);

                    if temp = (-1, -1) then exit;
                    end if;

                    arr (I) := temp;
                end loop;
                return arr;
            end;
        end;            
    end;

    arr: coll_arr := look_for (tgt_lo => 10, tgt_hi => 13);
begin

    declare 
        temp: Integer;
    begin
        for I in arr'Range loop
            Put (i_img (arr (I)(Num)) & " (" & i_img (arr (I)(Its)) & " ): ");            
            temp := collatz (arr(I)(Num), True);
        end loop;
    end;

end Main;