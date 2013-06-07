Calculatinaire
==============
A project by me(Alex Sadler) because I feel that current calculator programs are lacking in functionality, compared to handheld ones.

Why is this?

Surely, a calculator program running on a powerful computer should be much more functional than anything that costs as little as £10.

Calculator companies (Casio, I'm looking at you) must really want your money.

Working on this Project
-----------------------
You can see where this project is going on the wiki (link on github), which is a direct copy of my notes and thoughts - feel free to add anything!

What it will do when Finished
-----------------------------
   1. Expression string input ('6*3+9*2')
   2. String is converted to binary expression tree
   ```
            +
           / \
          *   *
         / \ / \
        6  3 9  2
   ```
   3. The expression is calculated in one of two ways:
      a. Destructively - sqrt(2) for example would be calculated to be 1.41...
      b. Non-destructively - sqrt(2) for example would stay as sqrt(2)
      The program works through recursively, solving each sub tree until it cannot solve anymore
   4. The binary expression tree left after calculation is converted to a string and output.
