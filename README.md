# triplet\_energy\_coupling

### Generate parameter file using Amber

```bash
tleap -f leap.src
```

**Software required**: Amber 

**Files needed**: .mol2, gaff.dat, frcmod.mecn

### MD production run

```bash
./sample
```

Runs a minimisation, followed by heating to 300 K for a random number of steps in the range [20000,30000], finally a production run is performed for x steps.

**Files needed**: sample, run\_min, run\_heat, run\_prod, file.prmtop, file.rst7 

### Take snapshots of host:guest 

First generate xyz files which contain the coordinates of the guest with only one host with a tcl script using VMD. This makes N xyz files where N is the number of host molecules,

```bash
vmd -dispdev text -eofexit < select_residues.tcl
```

**Software required**: VMD

**Files needed**: select\_residues.tcl

### Calculate the triplet couplings for (some of) these coordinates

Here the FED method implemented in qchem is used to obtain triplet couplings between the host and the guest. First the coordinates for each nearby host:guest combination are obtained using an octave script,

```matlab
octave:> [dist_,x]=dist_filter(fname,Na,Nb,cutoff)
```

where *fname* is the name of the xyz trajectory file, *Na* is the number of atoms in molecule *a* and *Nb* is the number of atoms in molecule *b*, the *cutoff* radius (Angstrom) tells the script to ignore guest:host combinations that are further away than this. This generates *k* .coords files, where *k* is the number of frames in the xyz file with the distance between the guest and the host (distance between their geometric centres) less than the *cutoff* (Angstrom). 

Then, generate the qchem input files from these coords, 

```bash
./create_fed.sh
```

and *k* qchem .inp files will be created in the fed/ directory.

**Software required**: octave (or matlab), qchem

**Files needed**: dist\_filter.m, create\_fed.sh, fed.template1, fed.tempate2

### Analysis

The reader.sh script reads the qchem FED output file(s),

```bash
./reader.sh frame001.out
```

creating files,

- coords.txt, coordsa.txt, coordsb.txt (contains the coordinates of molecule a and b)
- triplet\_states.txt (contains the amplitudes)
- excitation\_energies.txt (contains the excitation energies in eV)
- fed\_couplings.txt (contains the couplings (eV) between each state)
