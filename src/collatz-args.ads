package Collatz.Args is
    function arg_check(target, upper_lim, lower_lim : out Positive; upper_tgt: out Natural; first: out Boolean) return Integer;
    private
    procedure print_help;
end Collatz.Args;