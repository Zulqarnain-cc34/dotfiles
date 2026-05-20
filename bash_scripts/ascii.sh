#!/bin/sh
#
# asciie
#
# print the extended ascii table per the codepage of the current computer
#

# cls
echo -e \\033c

# headings for each column
echo -n "DEC HEX CHR"
printf " | DEC HEX CHR%.0s" {1..7}
printf "\n"

# div
echo -n "- - - - - - "
printf "| - - - - - - %.0s" {1..7}
printf "\n"


# begin character table for ascii 0 to 127 characters
tb=( 'NUL' 'SOH' 'STX' 'ETX' 'EOT' 'ENQ' 'ACK' 'BEL' 'BS ' 'HT ' 'LF ' 'VT ' 'FF ' 'CR ' 'SO ' 'SI ' \
'DLE' 'DC1' 'DC2' 'DC3' 'DC4' 'NAK' 'SYN' 'ETB' 'CAN' 'EM ' 'SUB' 'ESC' 'FS ' 'GS ' 'RS ' 'US ' \
'   ' '!  ' '"  ' '#  ' '$  ' '%  ' '&  '  \'   '(  ' ')  ' '   ' '+  ' ',  ' '-  ' '.  ' '/  ' \
'0  ' '1  ' '2  ' '3  ' '4  ' '5  ' '6  ' '7  ' '8  ' '9  ' ':  ' ';  ' '<  ' '=  ' '>  ' '?  ' \
'@  ' 'A  ' 'B  ' 'C  ' 'D  ' 'E  ' 'F  ' 'G  ' 'H  ' 'I  ' 'J  ' 'K  ' 'L  ' 'M  ' 'N  ' 'O  ' \
'P  ' 'Q  ' 'R  ' 'S  ' 'T  ' 'U  ' 'V  ' 'W  ' 'X  ' 'Y  ' 'Z  ' '[  ' '\  ' ']  ' '^  ' '_  ' \
'`  ' 'a  ' 'b  ' 'c  ' 'd  ' 'e  ' 'f  ' 'g  ' 'h  ' 'i  ' 'j  ' 'k  ' 'l  ' 'm  ' 'n  ' 'o  ' \
'p  ' 'q  ' 'r  ' 's  ' 't  ' 'u  ' 'v  ' 'w  ' 'x  ' 'y  ' 'z  ' '{  ' '|  ' '}  ' '~  ' 'DEL' \
)
# end of character table


# display the regular ascii characters 0 to 127
for a in `seq 0 15`
do

  let "b=$a+16"; let "c=b+16"; let "d=c+16"; let "e=d+16"; let "f=e+16"; let "g=f+16"; let "h=g+16"


  printf "%03d %03X % 3s | %03d %03X % 3s | " $a $a ${tb[$a]} $b $b ${tb[$b]}
  printf "%03d %03X \\$(printf %03o $c)   | %03d %03X \\$(printf %03o $d)   | " $c $c $d $d
  printf "%03d %03X \\$(printf %03o $e)   | %03d %03X \\$(printf %03o $f)   | " $e $e $f $f
  printf "%03d %03X \\$(printf %03o $g)   | " $g $g

  if [[ $a -lt 15 ]];then
    printf "%03d %03X \\$(printf %03o $h) \n" $h $h

  else
    printf "%03d %03X %03s \n" $h $h ${tb[$h]}

  fi

done
# end reg ascii

# begin extended ascii section
echo ' '

# display the extended ascii characters 128 to 255
for a in `seq 128 143`
do

  let "b=$a+16"; let "c=b+16"; let "d=c+16"; let "e=d+16"; let "f=e+16"; let "g=f+16"; let "h=g+16"

  printf "%03d %03X \\$(printf %03o $a)   | %03d %03X \\$(printf %03o $b)   | " $a $a $b $b
  printf "%03d %03X \\$(printf %03o $c)   | %03d %03X \\$(printf %03o $d)   | " $c $c $d $d
  printf "%03d %03X \\$(printf %03o $e)   | %03d %03X \\$(printf %03o $f)   | " $e $e $f $f
  printf "%03d %03X \\$(printf %03o $g)   | %03d %03X \\$(printf %03o $h) \n" $g $g $h $h

done
