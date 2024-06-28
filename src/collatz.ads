package Collatz is
    type Match_Info is (Num, Its);
    type Match is array (Match_Info) of Integer;

    type Match_Arr is array (Positive range <>) of Match;

    function i_img (I: in Integer) return String renames Integer'Image;
    function iterate (I: Integer; print: Boolean := False) return Positive;
    function look (target, upper_lim, lower_lim : Positive; upper_tgt: Natural) return Match;
    function search (target, upper_lim, lower_lim : Positive; upper_tgt: Natural) return Match_Arr;
end Collatz;
