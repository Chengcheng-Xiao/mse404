set encoding utf8 # This lets us use the Gamma symbol directly

set xtics ("Γ" 0.0000, "X" 0.5000, "M" 1.0000, "Γ" 1.7071, "R" 2.5731, "X" 3.2802)

set grid xtics lt -1 lw 1.0

unset key

set yrange [-6:]
set ylabel "Energy (eV)"
set title "CsPbIr3 Electronic Band Structure"

plot "bands.out.gnu" w l lt -1 lw 2

pause mouse
