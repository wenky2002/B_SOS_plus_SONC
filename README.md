## B-SOS+SONC relaxations for CPOPs

MATLAB implementation of the **B-SOS+SONC** hierarchy for constrained polynomial optimization problems (CPOPs) of the form

$$\min f(x) \quad \text{s.t.} \quad 0 \leq g_i(x) \leq 1.$$

This method combines the Bounded-Sum-of-Squares (B-SOS) and Sums of Nonnegative Circuit polynomials (SONC) decompositions to yield tighter semidefinite programming (SDP) relaxations than B-SOS alone, while preserving computational tractability.

## Requirements

- MATLAB R2019b or later
- [YALMIP](https://yalmip.github.io/)
- An SDP solver, e.g. [MOSEK](https://www.mosek.com/) or [SeDuMi](http://sedumi.ie.lehigh.nl/)

## Files
| File | Description |
|---|---|
| `boundedSOSpSONC.m` | Main routine constructing and solving the B-SOS+SONC relaxation |
| `constSONC.m` | Builds the SONC (circuit polynomial) constraints |
| `newtonPolytope.m` | Computes the Newton polytope of the input polynomial |
| `partitions.m` | Generates exponent partitions used in the relaxation |
