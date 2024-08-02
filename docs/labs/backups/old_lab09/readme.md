Lab 9: Perovskite Challenge: Band Gap Tuning
============================================

[Back to Course Overview](..)

Perovskites are a class of materials which are promising for use in solar cells, due
to low-cost fabrication processes and band-gap tuneability - see e.g.
[`this recent review`](https://iopscience.iop.org/article/10.1088/1361-6641/ab27f7).
While the large search space of perovskite materials is an advantage in terms
of the likelihood of finding materials with ideal properties for photovoltaic
applications, this also represents a challenge. That is, there are too many 
possibilities to synthesize and characterize them all experimentally.  That's
where DFT can come in very useful - by performing a large number of simulations 
we can narrow down the vast search space to only a small number of candidate materials
which have a desired feature, e.g. the band gap. These candidate materials
can then be explored in more detail via experiment.

In this lab we're going to bring together various different things that you have
learnt in the course and apply them to the problem of band-gap tuning in perovskites.
We will focus on metal halide perovskites, denoted by a formula of AMX3, where A is
monovalent cation, e.g. methylammonium (MA), M is a divalent metal cation, e.g.
lead (Pb) and X is a halide anion, e.g. (I). 

Since we have only a limited time available, we're going to make some assumptions
to restrict our search space. First, we are going to assume each of A, M and X is
a single atom i.e. each perovskite is made up of three atomic species, with e.g.
no organic groups or mixes of halides.

- Structure: example input files for CsPbI3 are provided in the directory
  `01_CsPbI3`. You can use these as a starting point. 
- Cut-off energy: to save computing time, we will use a fixed cut-off energy of 50 Ry 
  for relaxations (in order to allow for variation of the cell size) and a smaller
  cut-off energy of 40 Ry for other calculations in order to save compute time.
- K-points: we will use a fixed k-point grid of 4x4x4.
- We neglect the effects of spin and spin-orbit coupling.
- XC functional: we will use the PBE functional for all calculations. We expect that this
  may cause an error in band gap, e.g. the band gap of CsPbI3 should be 1.72 eV, whereas
  with our combination of parameters, the band gap is calculated to be 1.51 eV. We will
  therefore make (a poorly justified) assumption that:
  - experimental band gap = DFT band gap + 0.2 eV

Depending on the device structure in question, one might be interested in either low
or wide band gap perovskites. In the following we shall define the _ideal_ band gap as
1.9 eV, i.e. the top of the wide band gap range. In other words, we want the
calculated band gap to be 1.7 eV.

### _Task_

- Using the input file for CsPbI3 as a template, vary the atomic species for the
  A, B and/or X sites. 
- You may need to download new pseudopotential files for the different elements you
  choose. You can find a range of pseudopotentials for Quantum Espresso
  [`here`](http://www.quantum-espresso.org/pseudopotentials). Make sure you use
  a pseudopotential which has been generated for PBE.
- Optimize the unit cell - a template has been provided but it may help to refer back to
  [`lab05`](../lab05) if you've forgotten how this works. The various thresholds
  have been set for rough convergence in order to save time, however if it takes a
  long time try increasing the pressure tolerance (`press_conv_thr`). If things are
  really unstable, you may need to further increase the cut-off energy. However, make
  sure you always use 40 Ry for the band structure calculations, so that we can fairly
  compare different calculations.
- Once you have the relaxed structure, check whether you still have a perovskite structure.
  Does it still resemble the perovskite structure if you look at it in e.g. XCrysden?
  If not, you may need to try again with a different combination of elements.
- Calculate the band structure and find the band gap of your perovskite. Again, a template
  has been provided, but it may help to revisit [`lab4`](../lab04). See if you can get
  as close as possible to our `ideal` calculated value of 1.7 eV.






