with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Command_Line;      use Ada.Command_Line;


package body Collatz.Args is

    t_def: Boolean := False;
    l_def: Boolean := False;
    u_def: Boolean := False;
    UT_def: Boolean := False;
    f_def: Boolean := False;

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
                    upper_tgt := Positive (temp);
                    return True;
                
                when others => return False;
            end case;

            exception
                when CONSTRAINT_ERROR =>
                    return False;

        end check_num;

        function check_longarg (arg: String) return Integer is
            
            function find_eq_index return Integer is
                count: Integer := arg'First;
                saw_eq: Boolean := False;
            begin
                for I in arg'Range loop
                    if arg (I) = '=' then 
                        saw_eq := True;
                        exit;
                    end if;
                    count := count + 1;
                end loop;

                if not saw_eq then return 1;
                end if;

                return count;
            end find_eq_index;

            function eval_var_str (var: String) return Character is
            begin
                if var = "target" then 
                    return 't';
                elsif var = "lower_lim" then 
                    return 'l';
                elsif var = "upper_lim" then 
                    return 'u';
                elsif var = "upper_tgt" then    
                    return 'T';
                elsif var = "first" then
                    return 'f';
                elsif var = "help" then
                    return 'h'; 
                else 
                    return '0';
                end if;
            end eval_var_str;

            eq_index: Integer := find_eq_index;

        begin
            if eq_index = 1 then return -2;     -- invalid argument (need eq sign)
            end if;

            declare
                opt: String := arg (arg'First .. eq_index - 1);
                val: String := arg (eq_index + 1 .. arg'Last);
                var: Character := eval_var_str (opt);
            begin
                case var is
                    when 't' =>
                        target := Positive'Value (val);
                        t_def := True;                
                        return 0;
       
                    when 'l' =>
                        lower_lim := Positive'Value (val);
                        l_def := True;
                        return 0;
       
                    when 'u' =>
                        upper_lim := Positive'Value (val);
                        u_def := True;
                        return 0;
                    
                    when 'T' =>
                        upper_tgt := Natural'Value (val);
                        UT_def := True;
                        return 0;

                    when 'f' =>
                        first := True;
                        return 0;
                    
                    when 'h' =>
                        return -3;

                    when others => return -1;
                end case;

                exception
                    when CONSTRAINT_ERROR =>
                        return eq_index;            

            end;
        end check_longarg;

        procedure err_handle (err: Integer; arg: String) is 
        begin
            case err is
                when -1 =>
                    Put_Line ("Unknown argument: '" & arg & "'");

                when -2 =>
                    Put_Line ("Invalid argument: '" & arg & "'");
        
                when -3 =>
                    Put_Line ("Invalid value: '" & arg & "'");

                when others => null;
            end case;

            Put_Line ("Use collatz --help to see the help message");
            New_Line;

        end err_handle;

        skip: Boolean := False;

    begin
        if Argument_Count = 0 then
            print_help;
            return -1;
        end if;

        for I in 1..Argument_Count loop
            declare
                arg: String := Argument (I);
            begin
                if skip = True then
                    skip := False;

                else 
                    if arg (arg'First) /= '-' then
                        if not check_num ('t', I) then
                            err_handle (-1 , arg);
                            return -1;
                        
                        else 
                            t_def := True;
                        end if;

                    else 
                        if arg (arg'First + 1) /= '-' and arg'Length > 2 then
                            err_handle (-1, arg);
                            return -1;
                        end if;

                        case arg (arg'First + 1) is
                            when 't' => 
                                if not check_num('t', I + 1) then
                                    err_handle (-3, Argument (I + 1));
                                    return -1;
                                else
                                    skip := True;
                                    t_def := True;
                                end if;

                            when 'l' =>
                                if not check_num('l', I + 1) then
                                    err_handle (-3, Argument (I + 1));
                                    return -1;
                                else
                                    skip := True;
                                    l_def := True;
                                end if;

                            when 'u' =>
                                if not check_num('u', I + 1) then
                                    err_handle (-3, Argument (I + 1));
                                    return -1;
                                else 
                                    skip := True;
                                    u_def := True;
                                end if;

                            when 'T' =>
                                if not check_num ('T', I + 1) then
                                    err_handle (-3, Argument (I + 1));
                                    return -1;
                                else
                                    skip := True;
                                    UT_def := True;
                                end if;

                            when 'h' =>
                                print_help;
                                return 0;

                            when 'f' =>
                                first := True;
                                f_def := True;

                            when '-' =>
                                declare
                                    temp: Integer := check_longarg (arg (arg'First + 2..arg'Last));
                                begin
                                    case temp is
                                        when -1 =>
                                            err_handle (-1, arg);
                                            return -1;
                                        
                                        when -2 =>
                                            err_handle (-2, arg);
                                            return -1;

                                        when -3 =>
                                            print_help;
                                            return 0;

                                        when 0 => null;

                                        when others => 
                                            Put_Line ("Invalid input: '" & arg (temp + 1..arg'Last) & "' in '" & arg & "'");
                                            Put_Line ("Use collatz --help to see the help message");
                                            New_Line;
                                            return -1;
                                            
                                    end case;
                                end;
                            
                            when others => 
                                err_handle (-1, arg);
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

        if not f_def then
            first := False;
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
        Put_Line ("Usage: collatz [Option] {Value}");
        New_Line;
        Put_Line ("Search for numbers which take [Number] iterations to reach 1 through the Collatz Iterator.");
        Put_Line ("All values must be positive integers");
        New_Line;
        Put_Line ("  Options: ");
        Put_Line ("    -t, --target         The number of iterations you wish to search for. This value is optional if a");
        Put_Line ("                           number is specified immediately after the command. If -T is also used,");
        Put_Line ("                           this value will serve as the lower bound for the range desirable total");
        Put_Line ("                           iterations.");
        New_Line;                        
        Put_Line ("    -l, --lower_lim      What number to start iterating at. Default = 5");
        New_Line;
        Put_Line ("    -u, --upper_lim      What number to stop iterating at. Default = 500");
        New_Line;
        Put_Line ("    -T, --upper_tgt      The upper bound for the range of desirable total iterations. Setting to zero");
        Put_Line ("                           or omitting this value will only search for the numbers which take the ");
        Put_Line ("                           amount of iterations specified by -t. Default = 0");
        New_Line;
        Put_Line ("    -h, --help           Display this text");
        New_Line;
        Put_Line ("    -f, --first          Show only the first number found");
        New_Line;
        Put_Line ("Examples:");
        Put_Line ("$ collatz 5 --upper_lim=1000");
        Put_Line ("   Finds all numbers 5-1000 which take 5 iterations to reach 1");
        New_Line;
        Put_Line ("$ collatz -l 10 -u 650 -t 10");
        Put_Line ("   Finds the numbers 10-650 which take 10 iterations to reach 1");
        New_Line;
        Put_Line ("$ collatz -t 15 --first");
        Put_Line ("   Finds the first number in the default range that takes 15 iterations to reach 1");
        New_Line;
    end print_help;

end Collatz.Args;