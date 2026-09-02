## B-SOS+SONC relaxations for CPOPs

MATLAB implementation of the **B-SOS+SONC** hierarchy for constrained polynomial optimization problems of the form

$$\min f(x) \quad \text{s.t.} \quad a_i \leq g_i(x) \leq b_i.$$

This method combines the Bounded-Sum-of-Squares (B-SOS) hierarchy and Sums of Nonnegative Circuit polynomials (SONC) decompositions yielding tighter relaxations than B-SOS alone, while preserving computational tractability.
The certificate cone used in the new hierarchy is the recently introduced SOS+SONC cone, i.e., the Minkowski sum of the SOS and the SONC cone, and the bounds themselves can be computed via an explicit SDP-REP, a conic optimization problem over the Cartesian product of the semidefinite and the relative entropy cones. 

## Requirements

- MATLAB R2019b or later
- [YALMIP](https://yalmip.github.io/)
- An SDP solver, e.g. [MOSEK](https://www.mosek.com/) or [SeDuMi](https://sedumi.ie.lehigh.edu/)

## Files
| File | Description |
|---|---|
| `boundedSOSpSONC.m` | Main routine constructing and solving the B-SOS+SONC relaxation |
| `constSONC.m` | Builds the SONC (circuit polynomial) constraints |
| `newtonPolytope.m` | Computes the Newton polytope of the input polynomial |
| `partitions.m` | Generates exponent partitions used in the relaxation |

## Examples
The examples in this repository are based on the paper "A Bounded Degree SOS Plus SONC Hierarchy for Polynomial Optimization" by Mareike Dressler and Qi Wang. 
See [Link here] for the full paper.
