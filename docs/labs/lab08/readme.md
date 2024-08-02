Metals, Spin Polarization and Magnetic Systems
==============================================

This week we'll cover two topics: metallic systems and spin. For metals,
there are a couple of complications which mean we have to treat them
differently from systems with a non-zero band gap.

Aluminium
---------

Aluminium forms in a standard fcc structure with one atom per cell, which we
know how to deal with at this point. The thing about Aluminium that makes it
more complicated within DFT is that it is a metal. Metals have a Fermi surface
that can be quite complex in k-space. This means that in contrast to an
insulator or semiconductor where every k-point has the same number of occupied
states, in a metal the number of occupied states can vary from k-point to
k-point. This makes them a little more difficult to converge than other
systems. In short, there are generally two things you need to do:

1. Use a denser k-point grid than you would need for a semiconductor or
   insulator.
2. Use some smearing scheme. This means that a state is no longer simply
   occupied or empty, but has instead some probability of occupation. In a
   semiconductor, if we have a system with 4 electrons, then at every k-point
   the first 2 doubly occupied states will be populated. But in a metal,
   whether or not a state is occupied depends on its energy and the value of
   the Fermi level (which in turn will depend on the energies of all the
   electronic states we calculate). Adding a smearing helps significantly in
   achieving a smooth SCF convergence, as otherwise a small change in a state
   energy from once cycle to the next could lead to a very large change in its
   occupation and to the total energy in turn. We set the smearing scheme and
   width with the `occupations` and `degauss` variables in the input file.

### _Task_

Run the `pw.x` calculation with the supplied input file in
[`01_aluminium/Al.in`](01_aluminium/Al.in) and take a look through the output.

You'll need to look in the `pwscf.xml` file and find the various `ks_energies`
entries towards the end. These give the various k-points used in the
calculation and the energies and occupations of each state for this k-point.
Note, for a metal the default number of bands is at least four more than are
needed for the number of electrons per cell. The pseudopotential we have used
has 3 valence electrons, which could be represented with two potentially
doubly occupied bands, so we have four more bands in the calculation for a
total of 6.

- Try removing the `occupations` and `degauss` variables from the input file
  and see what happens when you try to run the calculation.


Spin Polarization
-----------------

Up till now we have been assuming that we always had some set of bands which
could each fit two identical electrons. Essentially we have been ignoring
the electron spin. If you want to examine, for example, a magnetic system
then the spin of the electrons is important. It can also be important
in modelling atomic or molecular systems. We'll cover different examples
of this in this lab. 


The Oxygen Molecule
-------------------

If a system is not necessarily magnetic we might imagine that representing 
it with some set of fully occupied, doubly degenerate bands will work. However,
in some cases including spin polarization can lead to important differences. One
example of this is the O2 molecule.

In this case, we have a system with two interacting oxygen atoms. Each oxygen
has 8 electrons in total, with the configuration 1s2 2s2 2p4 (the 1s orbital
will be contained within the pseudopotential for the DFT calculations done
here, so you will have 6 electrons from each oxygen atom). For a single
oxygen, from Hund's rule the three p orbitals should be filled singly before
being filled in pairs, so that one of the p-orbitals will have two electrons,
and the other two should have one each. However, if we assume doubly occupied
orbitals, we'll have the two p-orbitals with two electrons and one that is
empty. This means a calculation where we assume a set of doubly occupied bands
will have trouble converging to the ground state of the system. For the
molecule the situation is similar, but the s and p orbitals from each atom
combine to form bonding and anti-bonding sigma and pi orbitals.

The directory [`02_O2`](02_O2) contains an input file to calculate the total
energy of the system at the measured bond length. Here the calculation has
been set up exactly as you've seen in the past.

### _Task_

- Try running the calculation in this directory and see what happens.

While it's possible that the system may randomly meet the convergence
criteria in the self-consistent cycle, this calculation will most likely
not converge. If you look at the estimate accuracy at the end of each
iteration in the output, it will likely vary from step to step, rather than
steadily decreasing as in a well-behaved calculation.

The situation we have is similar to a metal: we have two bands and the ground
state of the system should be when there is one electron in each of them.

### _Task_

- Create a copy of the `02_O2` directory called `02_O2_metal`. Modify the
  input file in it to use a metallic occupation scheme with a small smearing
  width and run the calculation. The relevant input variables have been used
  in the Al example discussed above.
    - Does the calculation now converge?
    - Take a look at the file `pwscf.xml` in the calculation directory, and
      try to find the occupations of each band at each k-point. Are these as
      expected?

Treating this system as a metal may not get the physics of the system right.
Instead, we can do a spin polarized calculation. There are two new
variables which tell Quantum Espresso to perform a spin-polarized calculation.

- `nspin`: this is 1 by default so no spin polarization is taken into account.
  To perform a spin polarized calculation it should be set to 2.
- `tot_magnetization`: this is difference between the number of spin-up and
  spin-down electrons in the cell. If we want a single spin up electron
  we can set this to `1.0`.

### _Task_

- Create another copy of `02_O2` called `02_O2_spin`. This time modify the
  input file in it to turn on spin polarization, but don't add any smearing.
  Try setting the total magnetization to 0, which would be the case if we don't 
  have any net magnetization in the molecule, as both spins point in opposite
  directions. Then try setting the total magnetization to 2.0, which corresponds
  to both spins pointing in the same direction.
    - How does the total energy compare for each case compare to the metallic
      scheme? Which is the more energetically favourable configuration? How do
      the orbital energies vary?

O2 in its singlet state can be dangerous (see e.g. 
[`this paper`](https://www.sciencedirect.com/science/article/pii/S1383574211001189)),
so treating the spin correctly is important!


Magnetic Systems - Iron
-----------------------

Now that you've seen how including spin polarization can allow us a correctly
describe the ground state of our system in your calculation, the next step
is to use it to describe a magnetic system.

In a magnetic system there is a net spin polarization in the unit cell. This
means that we'll probably have an odd number of electrons, and the energy of
the system when we include a net spin polarization is lower than the energy
when we don't.

One of the most common magnetic systems is iron, so we'll examine this.
The directory [`03_Fe`](03_Fe) contains an input file for iron. Note this is
a BCC structure (as set by `ibrav = 3` in the input file), whereas most of the
crystals structures you have examined previously were FCC. The calculation
has been set up in the usual way for a metallic system.

### _Task_

- Run this calculation and check everything worked as expected.
- Now make a copy of the calculation directory and in this, modify the
  calculation to turn on spin polarization. Try running the calculation
  with `tot_magnetization = 0.0` first, and compare your total energy to that
  obtained using doubly degenerate bands. **Note** while in the case of the
  O2 above, we were able to get our calculations to at least converge by using
  a metallic occupation instead of using spin polarization, in the case of iron,
  it will still be a metal when you use spin polarization, so you should not
  remove the input variables associated with this.
    - The total energies should agree within the accuracy of the calculation.
- Now try setting the total magnetization to 1.0 and see how total energy
  changes.
    - Which is the more energetically favourable configuration?
- Try setting the total magnetization to 2.0.
    - How does this compare to the previous value?

From this we could test many guesses for the total magnetization, and find
the value which gives the lowest overall total energy. However, we can instead
pass an option that tells quantum espresso to automatically find the best
value. This is done by setting the `starting_magnetization` input variable.

- Make another copy of the `03_Fe` directory, and this time set `nspin = 2`,
  and `starting_magnetization = 1.0` (do not include the `tot_magnetization`
  variable as this fixes a value). Run the calculation and see what the final
  total magnetization per cell is. See if you can find a measured value for
  iron to compare to.

- See if you can use what we covered in previous labs to calculate and make a
  plot of the electronic band structure of BCC Fe.
    - Plot the spin-up and spin-down bands in different colours.
    - There are different Fermi energies for the spin-up and spin-down bands:
      indicate these on your plot in some sensible way.
    - As the Brillouin zone is different to the ones you have calculated so
      far you'll need to select a few sensible high-symmetry points yourself
      to plot with.

------------------------------------------------------------------------------

Summary
-------

In this lab you have seen:

- how to treat a metallic system.
- how to do a DFT calculation including spin polarization.
- how some systems need to be done with spin polarization to converge to
  the correct ground state.
- how to use spin polarized calculations to find the correct magnetization of
  a magnetic system by letting the code find the total magnetization that
  produces the lowest overall total energy.


Extra Material
--------------

For another example of a molecular case where spin is important, there is an see
the additional material on [The Hydrogen Atom and Electron
Spin](../extras/labs/hydrogen_atom/readme.md).



