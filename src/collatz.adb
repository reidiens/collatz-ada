with Ada.Text_IO;       use Ada.Text_IO;

package body Collatz is
    function iterate (I: Integer; print: Boolean := False) return Positive is
        count: Positive := 1;
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
    end iterate;

    function look (target, upper_lim, lower_lim : Positive; upper_tgt: Natural) return Match is
    begin
        if lower_lim >= upper_lim then return (-1, -1);
        end if;

        if upper_tgt = 0 then
            for I in lower_lim..upper_lim loop
                if iterate (I) = target then
                    return (I, target);
                end if;
            end loop; 

            return (-1, -1);
        
        else
            declare
                hold: Positive;
            begin
                for I in lower_lim..upper_lim loop
                    hold := iterate (I);
                    if hold in target..upper_tgt then
                        return (I, hold);
                    end if;
                end loop;

                return (-1, -1);
            end;
        end if;
    end look;

    function search (target, upper_lim, lower_lim : Positive; upper_tgt: Natural) return Match_Arr is
        number_of_matches: Natural := 0;

        temp_match: Match := (Integer(lower_lim - 1), 0);
    begin
        loop
            temp_match := look (target => target,
                                    upper_tgt => upper_tgt,
                                    upper_lim => upper_lim,
                                    lower_lim => temp_match(Num) + 1);
        
            if temp_match = (-1, -1) then exit;
            end if;

            number_of_matches := number_of_matches + 1;
        end loop;

        declare
            matches: Match_Arr (1..number_of_matches);
        begin
            temp_match := (Integer (lower_lim - 1), 0);

            for I in matches'Range loop
                temp_match := look (target => target,
                                    upper_tgt => upper_tgt,
                                    upper_lim => upper_lim,
                                    lower_lim => temp_match (Num) + 1);
            
                if temp_match = (- 1, -1) then exit;
                end if;

                matches (I) := temp_match;
            end loop;
            return matches;
        end;
    end search;

end Collatz;