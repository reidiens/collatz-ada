with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Command_Line;  use Ada.Command_Line;

package body Collatz.Args is
    function arg_check (target, upper_lim, lower_lim : out Positive; upper_tgt: out Natural; first: out Boolean) return Integer is

        function check_num (option: Character; index: Integer) return Boolean is
            temp: Natural;
        begin
            temp := Natural'Value (Argument (index));

            case option is 
                when 't' =>
                    target := temp;
                    return True;
                
                when 'l' =>
                    lower_lim := temp;
                    return True;
                
                when 'u' =>
                    upper_lim := temp;
                    return True;
                
                when 'T' =>
                    upper_lim := Positive (temp);
                    return True;
                
                when others => return False;
            end case;

            exception
                when CONSTRAINT_ERROR =>
                    return False;

        end check_num;

        skip: Boolean := False;
        t_def: Boolean := False;
        l_def: Boolean := False;
        u_def: Boolean := False;
        UT_def: Boolean := False;

    begin
        for I in 1..Argument_Count loop
            declare
                arg: String := Argument (I);
            begin
                if skip = True then
                    skip := False;

                else 
                    if arg (arg'First) /= '-' then
                        Put_Line ("Unknown argument: '" & arg & "'");
                        Put_Line ("Use collatz --help to see the help message.");
                        New_Line;
                        return -1;

                    else 
                        if arg (arg'First + 1) /= '-' and arg'Length > 2 then
                            Put_Line ("Unknown argument: '" & arg & "'");
                            Put_Line ("Use collatz --help to see the help message."); 
                            New_Line;
                            return -1;
                        end if;

                        case arg (arg'First + 1) is
                            when 't' => 
                                if not check_num('t', I + 1) then
                                    Put_Line ("Error: '" & Argument (I + 1) & "' is unacceptable input. Numbers must be positive non-zero values");
                                    Put_Line ("Use collatz --help to see the help message");
                                    New_Line;
                                    return -1;
                                else
                                    skip := True;
                                    t_def := True;
                                end if;

                            when 'l' =>
                                if not check_num('l', I + 1) then
                                    Put_Line ("Error: '" & Argument (I + 1) & "' is unacceptable input. Numbers must be positive non-zero values");
                                    Put_Line ("Use collatz --help to see the help message");
                                    New_Line;
                                    return -1;
                                else
                                    skip := True;
                                    l_def := True;
                                end if;

                            when 'u' =>
                                if not check_num('u', I + 1) then
                                    Put_Line ("Error: '" & Argument (I + 1) & "' is unacceptable input. Numbers must be positive non-zero values");
                                    Put_Line ("Use collatz --help to see the help message");
                                    New_Line;
                                    return -1;
                                else 
                                    skip := True;
                                    u_def := True;
                                end if;

                            when 'T' =>
                                if not check_num ('T', I + 1) then
                                    Put_Line ("Error: '" & Argument (I + 1) & "' is unacceptable input. Numbers must be positive non-zero values");
                                    Put_Line ("Use collatz --help to see the help message");
                                    New_Line;
                                    return -1;
                                else
                                    skip := True;
                                    UT_def := True;
                                end if;

                            when 'h' =>
                                print_help;
                                return -1;

                            when 'f' =>
                                first := true;

                            when others => 
                                Put_Line ("Unknown argument: '" & arg & "'");
                                Put_Line ("Use collatz --help to see the help message");
                                New_Line;
                                return -1;
                        end case;
                    end if;
                end if;
            end;
        end loop;

        if not t_def then
            Put_Line ("Error: missing argument: -t (--target)");
            Put_Line ("Use collatz --help to see the help mesage");
            New_Line;
            return -1;
        end if;

        if not l_def then
            lower_lim := 5;
        end if;

        if not u_def then
            upper_lim := 500;
        end if;

        if not UT_def then
            upper_tgt := 0;
        end if;

        if upper_lim < lower_lim then
            Put_Line ("Error: Value for -u (--upper_lim) must be greater than value for -l (--lower_lim)");
            Put_Line ("Use collatz --help to see the help message");
            New_Line;
            return -1;
        end if;

        if UT_def and upper_tgt < target then
            Put_Line ("Error: value for -T (--upper_tgt) must be greater than value for -t (--target)");
            Put_Line ("Use collatz --help to see the help message");
            New_Line;
            return -1;
        
        elsif UT_def and upper_tgt = target then
            upper_tgt := 0;
        end if;

        return 0;
    end arg_check;

    procedure print_help is
    begin
        Put_Line ("Usage: collatz [Variable] [Number]... | [Option]");
        New_Line;
        Put_Line ("Search for numbers which take [Number] iterations to reach 1 through the Collatz Iterator.");
        Put_Line ("[Number] is a positive non-zero integer");
        New_Line;
        Put_Line ("  Variables which can be changed are: ");
        Put_Line ("    -t, --target         The number of iterations you wish to search for. This value is not optional");
        Put_Line ("                           If -T is also used, this value will serve as the lower bound for the range");
        Put_Line ("                           desirable total iterations.");
        New_Line;                        
        Put_Line ("    -l, --lower_lim      What number to start iterating at. Default = 5");
        New_Line;
        Put_Line ("    -u, --upper_lim      What number to stop iterating at. Default = 500");
        New_Line;
        Put_Line ("    -T, --upper_tgt      The upper bound for the range of desirable total iterations. Setting to zero");
        Put_Line ("                           or omitting this value will only search for the numbers which take the ");
        Put_Line ("                           amount of iterations specified by -t. Default = 0");
        New_Line;
        Put_Line ("  Options:");
        Put_Line ("    -h, --help           Display this text");
        Put_Line ("    -f, --first          Show only the first number found");
        New_Line;
        Put_Line ("Examples:");
        Put_Line ("$ collatz --target=10 -l 10 -u 650");
        Put_Line ("   Finds the numbers 10-650 which take 10 iterations to reach 1");
        New_Line;
        New_Line;
        Put_Line ("$ collatz -t 15 -f");
        Put_Line ("   Finds the first number in the default range that takes 15 iterations to reach 1");
        New_Line;
    end print_help;

end Collatz.Args;