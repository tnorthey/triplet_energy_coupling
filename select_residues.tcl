# VMD for LINUXAMD64, version 1.9.2 (December 29, 2014)
# Log file '1.log', created by user thomas

mol new {../file.prmtop} type {parm7} first 0 last -1 step 1 waitfor 1
mol addfile {03_Prod.mdcrd} type {crdbox} first 0 last -1 step 1 waitfor -1 0
for {set i 1} {$i < 21} {incr i} {
  puts "I inside first loop: $i"
  animate write xyz residue$i.xyz sel [atomselect 0 "residue $i or residue 0"] skip 1 0
}

#animate write xyz out.xyz sel [atomselect 0 "same residue as within 3 of residue 0"] skip 1 0
#animate write xyz out.xyz sel [atomselect 0 "same residue as within 3 of residue 0"] beg 0 end 273 skip 1 0
# VMD for LINUXAMD64, version 1.9.2 (December 29, 2014)
# end of log file.
