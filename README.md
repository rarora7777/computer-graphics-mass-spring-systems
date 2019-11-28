# Computer Graphics – Mass-Spring Systems

> **To get started:** Clone this repository using
> 
>     git clone --recursive http://github.com/alecjacobson/computer-graphics-mass-spring-systems.git
>

![](images/flag.gif)

## Background

### Read Chapter 16.5 of _Fundamentals of Computer Graphics (4th Edition)_.

### Read ["Fast Simulation of Mass-Spring Systems" [Tiantian Liu et al. 2013]](http://graphics.berkeley.edu/papers/Liu-FSM-2013-11/Liu-FSM-2013-11.pdf)

### Mass-Spring Systems

In this assignment we'll consider animating a deformable shape.

We _model_ the shape's physical behavior by treating it as a network of [point
masses](https://en.wikipedia.org/wiki/Point_particle) and
[springs](https://en.wikipedia.org/wiki/Effective_mass_(spring–mass_system)). We
can think of our shape as a
[graph](https://en.wikipedia.org/wiki/Graph_(discrete_mathematics)) where each
vertex is a point mass and each edge is a spring.

Given _initial conditions_ (each point's starting position and starting
velocity, if any) we will create an animation following the laws of physics
forward in time. In the real world, physics is deterministic: if we know the
current state, we can be sure of what the next state will be (at least at the
scales we're considering). This will also be true of our physical simulation.

The law that we start with is Newton's second law, which states that the forces
<img src="/tex/6337ee87446dee40530f55558466bedc.svg?invert_in_darkmode&sanitize=true" align=middle width=48.39011759999999pt height=26.76175259999998pt/> acting on a body must equal its mass <img src="/tex/0e51a2dede42189d77627c4d742822c3.svg?invert_in_darkmode&sanitize=true" align=middle width=14.433101099999991pt height=14.15524440000002pt/> times its acceleration
<img src="/tex/29a223b1732e4aa561aec5a87741a53d.svg?invert_in_darkmode&sanitize=true" align=middle width=50.01112544999999pt height=26.76175259999998pt/>:


<p align="center"><img src="/tex/2f4cd85a2f21158bb638f242fd22b4f8.svg?invert_in_darkmode&sanitize=true" align=middle width=57.67481445pt height=11.4155283pt/></p>

Notice that <img src="/tex/47b0192f8f0819d64bce3612c46d15ea.svg?invert_in_darkmode&sanitize=true" align=middle width=7.56844769999999pt height=22.831056599999986pt/> and <img src="/tex/41f28962986ecdd9c1dc2af8b83fef84.svg?invert_in_darkmode&sanitize=true" align=middle width=9.18943409999999pt height=14.611878600000017pt/> are vectors, each having a magnitude and a direction.
We will build our computational simulation by asking for this equation to be
true for each point mass  in our network. The forces <img src="/tex/a3c2e802fc6ad252375c413a1b6ac2c6.svg?invert_in_darkmode&sanitize=true" align=middle width=10.42712384999999pt height=22.831056599999986pt/> acting on the <img src="/tex/77a3b857d53fb44e33b53e4c8b68351a.svg?invert_in_darkmode&sanitize=true" align=middle width=5.663225699999989pt height=21.68300969999999pt/>-th point
mass are simply the sum of forces coming from any incident spring edge <img src="/tex/e5a8bc7bac1dd7d337c9e609a4ae3f99.svg?invert_in_darkmode&sanitize=true" align=middle width=13.373644349999989pt height=21.68300969999999pt/> and
any external force (such as gravity).

[Personifying](https://en.wikipedia.org/wiki/Personification) physical objects, we say
that they are _at rest_ when their potential energy is zero. When the object is
_not at rest_ then it exerts a force pushing it toward its rest state ([elastic
force](https://en.wikipedia.org/wiki/Elasticity_(physics))), decreasing its
potential energy as fast as possible. The force is the negative gradient of the potential
energy.

A simple spring is defined by its stiffness <img src="/tex/f9bbd08bf846520586581437c960abac.svg?invert_in_darkmode&sanitize=true" align=middle width=39.21220214999999pt height=22.831056599999986pt/> and _rest_ length <img src="/tex/3b2dcd4e3bd8001e045112d599b79c00.svg?invert_in_darkmode&sanitize=true" align=middle width=53.262747449999985pt height=22.55708729999998pt/>.
Its potential energy measures the squared difference of the current length and
the rest length times the stiffness:

<p align="center"><img src="/tex/318e8a5b7d56a623b6be300b71057922.svg?invert_in_darkmode&sanitize=true" align=middle width=243.63856934999998pt height=32.990165999999995pt/></p>

![](images/potential-energy.png)

The force exerted by the spring on each mass is the [partial
derivative](https://en.wikipedia.org/wiki/Partial_derivative) of the potential
energy <img src="/tex/a9a3a4a202d80326bda413b5562d5cd1.svg?invert_in_darkmode&sanitize=true" align=middle width=13.242037049999992pt height=22.465723500000017pt/> with respect to the corresponding mass position. For example, for
<img src="/tex/f13e5bc0860402c82f869bcf883eb8b0.svg?invert_in_darkmode&sanitize=true" align=middle width=15.15312644999999pt height=14.611878600000017pt/> we have

<p align="center"><img src="/tex/419344ec3d3de763aff73f0cd0d1105b.svg?invert_in_darkmode&sanitize=true" align=middle width=127.8270213pt height=37.0084374pt/></p>

For now, we can postpone expanding <img src="/tex/b2006c0d00d8438cf4513b1570d2dc0b.svg?invert_in_darkmode&sanitize=true" align=middle width=54.06866354999998pt height=24.65753399999998pt/>, and just recognize that it is a
3D vector. 

Our problem is to determine _where_ all of the mass will be after a small
duration in time (<img src="/tex/5a63739e01952f6a63389340c037ae29.svg?invert_in_darkmode&sanitize=true" align=middle width=19.634768999999988pt height=22.465723500000017pt/>). 

> **Question:** What is a reasonable choice for the value of <img src="/tex/5a63739e01952f6a63389340c037ae29.svg?invert_in_darkmode&sanitize=true" align=middle width=19.634768999999988pt height=22.465723500000017pt/> ?
>
> **Hint:** 🎞️ or 🖥️
>

We'll assume we know the current positions for each
mass <img src="/tex/e0b9d9299580e2b6a314b1ce43960e1e.svg?invert_in_darkmode&sanitize=true" align=middle width=57.111606749999986pt height=26.76175259999998pt/> at the current time (<img src="/tex/4f4f4e395762a3af4575de74c019ebb5.svg?invert_in_darkmode&sanitize=true" align=middle width=5.936097749999991pt height=20.221802699999984pt/>) and the current velocities
<img src="/tex/fd37fc619ea79b16b7a3654ca0cd9e5d.svg?invert_in_darkmode&sanitize=true" align=middle width=147.16191105pt height=26.76175259999998pt/>. When <img src="/tex/1c899e1c767eb4eac89facb5d1f2cb0d.svg?invert_in_darkmode&sanitize=true" align=middle width=36.07293689999999pt height=21.18721440000001pt/> then we call these the [initial
conditions](https://en.wikipedia.org/wiki/Initial_condition) of the entire
simulation. For <img src="/tex/41163b95295e685e3f25bc73af21a8fb.svg?invert_in_darkmode&sanitize=true" align=middle width=36.07293689999999pt height=21.18721440000001pt/>, we can still think of these values as the initial
conditions for the remaining time.

In the real world, the trajectory of an object follows a continuous curve as a
function of time. In our simulation, we only need to know the position of each
pass at [discrete moments in
time](https://en.wikipedia.org/wiki/Discrete_time_and_continuous_time). We use
this to build discrete approximation of the time derivatives (velocities and
accelerations) that we encounter. Immediately, we can replace the current
velocties <img src="/tex/0b39cd3b1c07dcc4dcbea210f38358ec.svg?invert_in_darkmode&sanitize=true" align=middle width=15.46801904999999pt height=26.085962100000025pt/> with a _backward_ [finite
difference](https://en.wikipedia.org/wiki/Finite_difference) of the positions
over the small time step:

<p align="center"><img src="/tex/245add6aa6b0df39512ea104d7125f08.svg?invert_in_darkmode&sanitize=true" align=middle width=118.89006029999999pt height=37.29153615pt/></p>

where <img src="/tex/612ecaae0105899fb8c4b10424449b4a.svg?invert_in_darkmode&sanitize=true" align=middle width=83.15050919999999pt height=29.789954700000024pt/> is the position at the _previous_ time.

We can also use a _central_ finite difference to define the acceleration at time
<img src="/tex/4f4f4e395762a3af4575de74c019ebb5.svg?invert_in_darkmode&sanitize=true" align=middle width=5.936097749999991pt height=20.221802699999984pt/>:

<p align="center"><img src="/tex/9f0117ddac55126872d30e373e4fa435.svg?invert_in_darkmode&sanitize=true" align=middle width=621.88096245pt height=37.29153615pt/></p>

This expression mentions our _unknown_ variables <img src="/tex/60cd486c9b59db93b3a4fad0605ccebb.svg?invert_in_darkmode&sanitize=true" align=middle width=41.32432424999999pt height=29.789954700000024pt/> for the first
time. We'll soon that based on definition of the potential spring energy above
and the acceleration here we can _solve_ for the values of these unknown
variables.

### Time integration as energy optimization

In the equation <img src="/tex/f428e42f1278299d021e503dfeb2f94f.svg?invert_in_darkmode&sanitize=true" align=middle width=53.10859124999998pt height=22.831056599999986pt/>, the acceleration term <img src="/tex/41f28962986ecdd9c1dc2af8b83fef84.svg?invert_in_darkmode&sanitize=true" align=middle width=9.18943409999999pt height=14.611878600000017pt/> depends _linearly_ on the
unknowns <img src="/tex/61cf41460b5d444b8df90703eb5ef637.svg?invert_in_darkmode&sanitize=true" align=middle width=41.32432424999999pt height=27.6567522pt/>. Unfortunately, even for a simple spring the forces <img src="/tex/e0fce5230e658c0ee1a58d7c155de809.svg?invert_in_darkmode&sanitize=true" align=middle width=109.72591739999997pt height=27.6567522pt/> depend _non-linearly_ on <img src="/tex/61cf41460b5d444b8df90703eb5ef637.svg?invert_in_darkmode&sanitize=true" align=middle width=41.32432424999999pt height=27.6567522pt/>. This means we have a
_non-linear_ system of equations, which can be tricky to satisfy directly.

<!--
If we expanded this as an expression, we
might write:
<p align="center"><img src="/tex/c50231b6047e999b94a458fb5b3282a9.svg?invert_in_darkmode&sanitize=true" align=middle width=293.08068239999994pt height=49.315569599999996pt/></p>
-->

> **Question:** We've _chosen_ to define <img src="/tex/47b0192f8f0819d64bce3612c46d15ea.svg?invert_in_darkmode&sanitize=true" align=middle width=7.56844769999999pt height=22.831056599999986pt/> as the forces that implicitly
> depend on the unknown positions <img src="/tex/61cf41460b5d444b8df90703eb5ef637.svg?invert_in_darkmode&sanitize=true" align=middle width=41.32432424999999pt height=27.6567522pt/> at the end of the
> time step <img src="/tex/f49b1cd442802e4abaee5b7044484875.svg?invert_in_darkmode&sanitize=true" align=middle width=45.662058749999986pt height=22.465723500000017pt/>. What would happen if we defined the forces to explicitly
> depend on the (known) current positions <img src="/tex/be91be346dbdf689f26da562e9b8bc99.svg?invert_in_darkmode&sanitize=true" align=middle width=15.46801904999999pt height=26.085962100000025pt/>?

An alternative is to view physics simulation as an optimization problem. We
will define an energy that will be minimized by the value of <img src="/tex/61cf41460b5d444b8df90703eb5ef637.svg?invert_in_darkmode&sanitize=true" align=middle width=41.32432424999999pt height=27.6567522pt/> that
satisfies <img src="/tex/f428e42f1278299d021e503dfeb2f94f.svg?invert_in_darkmode&sanitize=true" align=middle width=53.10859124999998pt height=22.831056599999986pt/>. The minimizer <img src="/tex/980fcd4213d7b5d2ffcc82ec78c27ead.svg?invert_in_darkmode&sanitize=true" align=middle width=10.502226899999991pt height=14.611878600000017pt/> of some function <img src="/tex/0dc5590ba457f7e2998c0ed49ab7b31f.svg?invert_in_darkmode&sanitize=true" align=middle width=35.262598799999985pt height=24.65753399999998pt/> will satisfy
<img src="/tex/8146e66aa14c7988c2ba77b40286b1cd.svg?invert_in_darkmode&sanitize=true" align=middle width=81.22126484999998pt height=24.65753399999998pt/>. So we construct an energy <img src="/tex/84df98c65d88c6adf15d4645ffa25e47.svg?invert_in_darkmode&sanitize=true" align=middle width=13.08219659999999pt height=22.465723500000017pt/> such that <img src="/tex/7dc060b03cb3a15a83ee204d181c131e.svg?invert_in_darkmode&sanitize=true" align=middle width=124.28420729999998pt height=24.65753399999998pt/>:

<p align="center"><img src="/tex/76195156f5590387ccb31b9616aff758.svg?invert_in_darkmode&sanitize=true" align=middle width=731.3050635pt height=85.26077339999999pt/></p> 

Keen observers will identify that the first term is potential energy and the
second term resembles [kinetic
energy](https://en.wikipedia.org/wiki/Kinetic_energy). Intuitively, we can see
the first term as trying to return the spring to rest length (elasticity) and
the second term as trying to keep masses [moving in the same
direction](https://en.wikipedia.org/wiki/Newton%27s_laws_of_motion#Newton%27s_first_law). 

Because of the <img src="/tex/012ed0635e8ecc5daafe75725d6dea0f.svg?invert_in_darkmode&sanitize=true" align=middle width=108.19618424999999pt height=24.65753399999998pt/> term, minimizing <img src="/tex/84df98c65d88c6adf15d4645ffa25e47.svg?invert_in_darkmode&sanitize=true" align=middle width=13.08219659999999pt height=22.465723500000017pt/> is a non-linear
optimization problem. The standard approach would be to apply [gradient
descent](https://en.wikipedia.org/wiki/Gradient_descent) (slow), [Gauss-Newton
method](https://en.wikipedia.org/wiki/Gauss–Newton_algorithm), or [Newton's
Method](https://en.wikipedia.org/wiki/Newton%27s_method_in_optimization) (too
complicated for this assignment).

In a relatively recent SIGGRAPH paper ["Fast Simulation of Mass-Spring
Systems"](http://graphics.berkeley.edu/papers/Liu-FSM-2013-11/Liu-FSM-2013-11.pdf),
Tiantian Liu et al. made a neat observation that makes designing an algorithm to
minimize <img src="/tex/84df98c65d88c6adf15d4645ffa25e47.svg?invert_in_darkmode&sanitize=true" align=middle width=13.08219659999999pt height=22.465723500000017pt/> quite simple and fast. For each spring <img src="/tex/e5a8bc7bac1dd7d337c9e609a4ae3f99.svg?invert_in_darkmode&sanitize=true" align=middle width=13.373644349999989pt height=21.68300969999999pt/>, they observe that the
non-linear energy can be written as a small optimization problem:

<p align="center"><img src="/tex/b048d7d1d98be7eb5965b404323e0808.svg?invert_in_darkmode&sanitize=true" align=middle width=388.1373309pt height=28.81465785pt/></p>

It may seem like we've just created extra work. We took a closed-form expression 
(left) and replaced it with an optimization problem (right). Yet this
optimization problem is small (<img src="/tex/27ad4bcb9a515705743055d231c7d7c5.svg?invert_in_darkmode&sanitize=true" align=middle width=21.25763639999999pt height=22.831056599999986pt/> is a single 3D vector) and can be
easily solved _independently_ (and even in parallel) for each spring (i.e.,
<img src="/tex/27ad4bcb9a515705743055d231c7d7c5.svg?invert_in_darkmode&sanitize=true" align=middle width=21.25763639999999pt height=22.831056599999986pt/> doesn't depend on <img src="/tex/7ccb533cd16fff60e80c336cf8aeef37.svg?invert_in_darkmode&sanitize=true" align=middle width=23.27060174999999pt height=22.831056599999986pt/> etc.). Reading the right-hand side in
English it says, find the vector of length <img src="/tex/92e0822b1528090efc2435d2ae60c9ee.svg?invert_in_darkmode&sanitize=true" align=middle width=18.17172884999999pt height=14.15524440000002pt/> that is as close as possible
to the current spring vector <img src="/tex/64aaef2d00caf95ec5f213a01b58f662.svg?invert_in_darkmode&sanitize=true" align=middle width=52.67295164999999pt height=19.1781018pt/>. 

![](images/dij-rij-closest-vector.png)


Now, suppose we somehow _knew already_ the vector <img src="/tex/27ad4bcb9a515705743055d231c7d7c5.svg?invert_in_darkmode&sanitize=true" align=middle width=21.25763639999999pt height=22.831056599999986pt/> corresponding to the
_unknown_ optimal solution <img src="/tex/61cf41460b5d444b8df90703eb5ef637.svg?invert_in_darkmode&sanitize=true" align=middle width=41.32432424999999pt height=27.6567522pt/>, then treating <img src="/tex/27ad4bcb9a515705743055d231c7d7c5.svg?invert_in_darkmode&sanitize=true" align=middle width=21.25763639999999pt height=22.831056599999986pt/> as a _constant_ we could
find the optimal solution by solving the _quadratic_ optimization problem:

<p align="center"><img src="/tex/d3dc7494d872489937b2ef87313ca469.svg?invert_in_darkmode&sanitize=true" align=middle width=741.6968262pt height=87.27907155pt/></p> 

The modified energy <img src="/tex/5fc3d1ec40b9a3acc07496c9f0e7f577.svg?invert_in_darkmode&sanitize=true" align=middle width=36.36981974999999pt height=30.267491100000004pt/> is _quadratic_ with respect to the unknowns
<img src="/tex/980fcd4213d7b5d2ffcc82ec78c27ead.svg?invert_in_darkmode&sanitize=true" align=middle width=10.502226899999991pt height=14.611878600000017pt/>, therefore the solution is found when we set the first derivative equal to
zero: 

<p align="center"><img src="/tex/639a82aadbc9a66011d72b222f97bfec.svg?invert_in_darkmode&sanitize=true" align=middle width=58.31376209999999pt height=40.72665465pt/></p>

This leads to a straightforward "local-global" iterative algorithm:

 - Step 1 (local): Given current values of <img src="/tex/980fcd4213d7b5d2ffcc82ec78c27ead.svg?invert_in_darkmode&sanitize=true" align=middle width=10.502226899999991pt height=14.611878600000017pt/> determine <img src="/tex/27ad4bcb9a515705743055d231c7d7c5.svg?invert_in_darkmode&sanitize=true" align=middle width=21.25763639999999pt height=22.831056599999986pt/> for each
   spring.
 - Step 2 (global): Given all <img src="/tex/27ad4bcb9a515705743055d231c7d7c5.svg?invert_in_darkmode&sanitize=true" align=middle width=21.25763639999999pt height=22.831056599999986pt/> vectors, find positions <img src="/tex/980fcd4213d7b5d2ffcc82ec78c27ead.svg?invert_in_darkmode&sanitize=true" align=middle width=10.502226899999991pt height=14.611878600000017pt/> that
   minimize quadratic energy $\tilde{E}$.
 - Step 3: if "not satisfied", go to Step 1.

For the purposes of this assignment we will assume that we're "satisfied" after
a fixed number of iterations (e.g., 50). More advanced _stopping criteria_ could
(should) be employed in general.

### Matrices

The [subtext](https://en.wikipedia.org/wiki/Subtext) of this assignment is
understanding the computational aspects of large matrices. In the algorithm
above, Step 1 is easy and relies on "local" information for each spring.

Step 2 on the otherhand involves all springs simultaneously.
[Matrices](https://en.wikipedia.org/wiki/Matrix_(mathematics)) are our
convenient notation for representing both the [linear
operators](https://en.wikipedia.org/wiki/Linear_operator) (e.g., in the equation
<img src="/tex/4d5f39204df8cdb5837a5bd197c9a57c.svg?invert_in_darkmode&sanitize=true" align=middle width=49.2356436pt height=34.241483099999975pt/>) and the [quadratic
forms](https://en.wikipedia.org/wiki/Quadratic_form) (e.g., in the energy
<img src="/tex/9674605b99e37d0dbca0fc51ec6b1bc7.svg?invert_in_darkmode&sanitize=true" align=middle width=13.08219659999999pt height=30.267491100000004pt/>).

Let's begin by being precise about some notation. We will stack up all of the
<img src="/tex/55a049b8f161ae7cfeb0197d75aff967.svg?invert_in_darkmode&sanitize=true" align=middle width=9.86687624999999pt height=14.15524440000002pt/> unknown mass positions <img src="/tex/4b1d092e4a9a112ea2e69c8b7c2c61c2.svg?invert_in_darkmode&sanitize=true" align=middle width=56.79671579999999pt height=26.76175259999998pt/> as the rows of a matrix <img src="/tex/eedb351c2dc2a62725645049d96e217d.svg?invert_in_darkmode&sanitize=true" align=middle width=69.72396255pt height=26.76175259999998pt/>.
We can do the same for the _known_ previous time steps' positions
<img src="/tex/36b373ed95b016fb214ef52b36dc5010.svg?invert_in_darkmode&sanitize=true" align=middle width=125.14635209999999pt height=27.6567522pt/>.

We can then express the inertial term using matrices:
<p align="center"><img src="/tex/edef44c91a1772228d8d6de8ddeeba32.svg?invert_in_darkmode&sanitize=true" align=middle width=688.7201673pt height=98.7441576pt/></p>

where <img src="/tex/797d20fec02db91e546ce25d31c18bf5.svg?invert_in_darkmode&sanitize=true" align=middle width=42.64833374999999pt height=24.65753399999998pt/> computes the [trace](https://en.wikipedia.org/wiki/Trace_(linear_algebra)) of <img src="/tex/d05b996d2c08252f77613c25205a0f04.svg?invert_in_darkmode&sanitize=true" align=middle width=14.29216634999999pt height=22.55708729999998pt/> (sums up the diagonal entries: <img src="/tex/3d30c855ff8804d9162b1ba648834929.svg?invert_in_darkmode&sanitize=true" align=middle width=115.79870774999999pt height=22.55708729999998pt/>).

and the entries of the square matrix <img src="/tex/35eaa614ad74ef19a4a94c079c27b637.svg?invert_in_darkmode&sanitize=true" align=middle width=78.74033144999999pt height=26.17730939999998pt/> are set to 

<p align="center"><img src="/tex/0c054b82efaa4e2ed9d99fd3ee6221f7.svg?invert_in_darkmode&sanitize=true" align=middle width=189.43734315pt height=69.0417981pt/></p>

The potential energy term can be similarly written with matrices. We'll start by
introducing the _signed incidence_ matrix of our mass-psring network of <img src="/tex/55a049b8f161ae7cfeb0197d75aff967.svg?invert_in_darkmode&sanitize=true" align=middle width=9.86687624999999pt height=14.15524440000002pt/>
vertices and <img src="/tex/0e51a2dede42189d77627c4d742822c3.svg?invert_in_darkmode&sanitize=true" align=middle width=14.433101099999991pt height=14.15524440000002pt/> edges <img src="/tex/35d615023140b8914fbc142ac3bb1336.svg?invert_in_darkmode&sanitize=true" align=middle width=78.62620424999999pt height=26.17730939999998pt/>. The _rows_ of <img src="/tex/96458543dc5abd380904d95cae6aa2bc.svg?invert_in_darkmode&sanitize=true" align=middle width=14.29216634999999pt height=22.55708729999998pt/> correspond to an arbitrary
(but fixed) ordering of the edges in the network. In a mass-spring network, the
edges are un-oriented in the sense that the spring acts symmetrically on its
vertices. For convenience, we'll pick an orientation for edge anyway. For the
<img src="/tex/8cd34385ed61aca950a6b06d09fb50ac.svg?invert_in_darkmode&sanitize=true" align=middle width=7.654137149999991pt height=14.15524440000002pt/>-th edge <img src="/tex/e5a8bc7bac1dd7d337c9e609a4ae3f99.svg?invert_in_darkmode&sanitize=true" align=middle width=13.373644349999989pt height=21.68300969999999pt/>, we should be sure to use the same orientation when computing
<img src="/tex/27ad4bcb9a515705743055d231c7d7c5.svg?invert_in_darkmode&sanitize=true" align=middle width=21.25763639999999pt height=22.831056599999986pt/> and for the following entries of <img src="/tex/96458543dc5abd380904d95cae6aa2bc.svg?invert_in_darkmode&sanitize=true" align=middle width=14.29216634999999pt height=22.55708729999998pt/>. So, for the <img src="/tex/8cd34385ed61aca950a6b06d09fb50ac.svg?invert_in_darkmode&sanitize=true" align=middle width=7.654137149999991pt height=14.15524440000002pt/>-th row of <img src="/tex/96458543dc5abd380904d95cae6aa2bc.svg?invert_in_darkmode&sanitize=true" align=middle width=14.29216634999999pt height=22.55708729999998pt/>
corresponding to edge connecting vertices <img src="/tex/77a3b857d53fb44e33b53e4c8b68351a.svg?invert_in_darkmode&sanitize=true" align=middle width=5.663225699999989pt height=21.68300969999999pt/> and <img src="/tex/36b5afebdba34564d884d347484ac0c7.svg?invert_in_darkmode&sanitize=true" align=middle width=7.710416999999989pt height=21.68300969999999pt/> we'll assign values:

<p align="center"><img src="/tex/7a805f65b1821701404dc10387e0ad77.svg?invert_in_darkmode&sanitize=true" align=middle width=205.767969pt height=118.35736770000001pt/></p>

Using this matrix <img src="/tex/96458543dc5abd380904d95cae6aa2bc.svg?invert_in_darkmode&sanitize=true" align=middle width=14.29216634999999pt height=22.55708729999998pt/> as a linear operator we can compute the spring vectors for
each edge:

<p align="center"><img src="/tex/64c5dab4c6b3f163b0c5537dff55b570.svg?invert_in_darkmode&sanitize=true" align=middle width=184.05540615pt height=15.9817185pt/></p>

We can now write the modified potential energy of <img src="/tex/9674605b99e37d0dbca0fc51ec6b1bc7.svg?invert_in_darkmode&sanitize=true" align=middle width=13.08219659999999pt height=30.267491100000004pt/> in matrix form:

<p align="center"><img src="/tex/d9867749b79e88915bc85196bccc511e.svg?invert_in_darkmode&sanitize=true" align=middle width=429.08050679999997pt height=59.1786591pt/></p>

where we stack the vector <img src="/tex/27ad4bcb9a515705743055d231c7d7c5.svg?invert_in_darkmode&sanitize=true" align=middle width=21.25763639999999pt height=22.831056599999986pt/> for each edge in the corresponding rows of <img src="/tex/39b5c8193ccaa0606e2ad1b2af6c2c65.svg?invert_in_darkmode&sanitize=true" align=middle width=73.26279014999999pt height=26.76175259999998pt/>.


Combining our two matrix expressions together we can write <img src="/tex/9674605b99e37d0dbca0fc51ec6b1bc7.svg?invert_in_darkmode&sanitize=true" align=middle width=13.08219659999999pt height=30.267491100000004pt/> entirely
in matrix form:

<p align="center"><img src="/tex/20b527fb5c733058667e0de48fecf678.svg?invert_in_darkmode&sanitize=true" align=middle width=732.8049102pt height=79.83989145pt/></p>

> **Question:** Why do we not bother to write out the terms that are constant with
> respect to <img src="/tex/980fcd4213d7b5d2ffcc82ec78c27ead.svg?invert_in_darkmode&sanitize=true" align=middle width=10.502226899999991pt height=14.611878600000017pt/>?

We can clean this up by introducing a few auxiliary matrices:

<p align="center"><img src="/tex/bd7e1e8f880815c8a5bee3f04c7cb457.svg?invert_in_darkmode&sanitize=true" align=middle width=294.89027535pt height=97.1055294pt/></p>

Now our optimization problem is neatly written as:

<p align="center"><img src="/tex/a66d510d67403c77f7e051f211662a7b.svg?invert_in_darkmode&sanitize=true" align=middle width=296.3192661pt height=37.011084pt/></p>

> **Recall:** The trace operator behaves very nicely when differentiating.
>
> <p align="center"><img src="/tex/650532e6d415fe94decf282253b94033.svg?invert_in_darkmode&sanitize=true" align=middle width=108.4620075pt height=37.412956349999995pt/></p>
> and 
>
> <p align="center"><img src="/tex/f073e73746c3abad28587eb4a4f5e47a.svg?invert_in_darkmode&sanitize=true" align=middle width=147.0189303pt height=37.412956349999995pt/></p>
>

Taking a derivative with respect to <img src="/tex/980fcd4213d7b5d2ffcc82ec78c27ead.svg?invert_in_darkmode&sanitize=true" align=middle width=10.502226899999991pt height=14.611878600000017pt/> and setting the expression to zero
reveals the minimizer of this quadratic energy:

<p align="center"><img src="/tex/bbb02a616d809294bc90179f34caeabd.svg?invert_in_darkmode&sanitize=true" align=middle width=61.68914234999999pt height=14.611878599999999pt/></p>

Since <img src="/tex/61ccc6d099c3b104d8de703a10b20230.svg?invert_in_darkmode&sanitize=true" align=middle width=14.20083224999999pt height=22.55708729999998pt/> is a square invertible matrix we can _solve_ this system, which we
often write as:

<p align="center"><img src="/tex/eee7831efc046d1f55b39a687aa08b25.svg?invert_in_darkmode&sanitize=true" align=middle width=79.33759845pt height=17.399144399999997pt/></p>

#### Solving as the _action_ of multiplying by a matrix's inverse

From an algorithmic point of view the notation <img src="/tex/50d36af977c46318008201eb650030fd.svg?invert_in_darkmode&sanitize=true" align=middle width=74.77137524999999pt height=26.76175259999998pt/> is misleading. It
might suggest first constructing `Qinv = inverse(Q)` and then conducting matrix
multiply `p = Qinv * b`. This is almost always a bad idea. Constructing `Qinv` 
be very expensive <img src="/tex/b85a093314c0f482cded300a33f790b9.svg?invert_in_darkmode&sanitize=true" align=middle width=43.02219404999999pt height=26.76175259999998pt/> and numerically unstable.

Instead, we should think of the _action_ of multiplying by the inverse of a
matrix as a single "solve" operation: `p = solve(Q,b)`. Some programming
languages (such as MATLAB) indicate using operator overloading "matrix
division": `p = Q \ b`.

All good matrix libraries (including [Eigen](http://eigen.tuxfamily.org)) will
implement this "solve" action. A very common approach is to compute a 
factorization of the matrix into a 
[lower triangular matrix](https://en.wikipedia.org/wiki/Triangular_matrix)
times it's transpose:
<p align="center"><img src="/tex/6da94c7036f7473a9c1bb41e4a88a1fd.svg?invert_in_darkmode&sanitize=true" align=middle width=74.5202007pt height=17.9744895pt/></p>

Finding this <img src="/tex/80637df1ca7533740cc7b3fdd1ab540b.svg?invert_in_darkmode&sanitize=true" align=middle width=11.36979854999999pt height=22.55708729999998pt/> matrix takes <img src="/tex/b85a093314c0f482cded300a33f790b9.svg?invert_in_darkmode&sanitize=true" align=middle width=43.02219404999999pt height=26.76175259999998pt/> time in general.

The action of solving against a triangular matrix is simple
[forward-/back-substitution](https://en.wikipedia.org/wiki/Triangular_matrix#Forward_and_back_substitution)
and takes <img src="/tex/e103cb4afcb639eecf8fda6ff0e12731.svg?invert_in_darkmode&sanitize=true" align=middle width=43.02219404999999pt height=26.76175259999998pt/> time. We can conceptually rewrite our system as 
<img src="/tex/dbe06987bb362e43e1f7bc44d3f4300e.svg?invert_in_darkmode&sanitize=true" align=middle width=57.12291749999999pt height=22.831056599999986pt/> with <img src="/tex/2b85eecc6fff1c1afe338e337cdafad3.svg?invert_in_darkmode&sanitize=true" align=middle width=76.75759904999998pt height=27.91243950000002pt/>.

A key insight of the Liu et al. paper is that our <img src="/tex/61ccc6d099c3b104d8de703a10b20230.svg?invert_in_darkmode&sanitize=true" align=middle width=14.20083224999999pt height=22.55708729999998pt/> matrix is always same
(regardless of the iterations in our algorithm above and even regardless of the
time <img src="/tex/4f4f4e395762a3af4575de74c019ebb5.svg?invert_in_darkmode&sanitize=true" align=middle width=5.936097749999991pt height=20.221802699999984pt/> that we're computing positions for).  We can split our solve routine
into two steps: precomputation done once when the mass-spring system is loaded
in and fast substitution at run-time:

```
// Once Q is known
L = precompute_factorization(Q)
// ... each time step
// ... ... each iteration
p = back_substitution(transpose(L),forward_substitution(L,b))
```

### Sparse Matrices

For small mass spring systems, <img src="/tex/b85a093314c0f482cded300a33f790b9.svg?invert_in_darkmode&sanitize=true" align=middle width=43.02219404999999pt height=26.76175259999998pt/> at loading time and <img src="/tex/e103cb4afcb639eecf8fda6ff0e12731.svg?invert_in_darkmode&sanitize=true" align=middle width=43.02219404999999pt height=26.76175259999998pt/> at runtime
may be acceptable. But for even medium sized systems this will become
intractable <img src="/tex/e2f61a925014fe412a2aa788b37fe3b3.svg?invert_in_darkmode&sanitize=true" align=middle width=250.85231324999998pt height=26.76175259999998pt/>

Fortunately, we can avoid this worst-case behavior by observing a special
structure in our matrices. Let's start with the mass matrix <img src="/tex/46cca5aa23b7d4f0ba986d15ca38e312.svg?invert_in_darkmode&sanitize=true" align=middle width=78.74033144999999pt height=26.17730939999998pt/>. All
of the values of this matrix are zero except the diagonal. Storing this as a
general matrix we would be storing <img src="/tex/8ac8fa012ae9908a95982a20da5b3ffc.svg?invert_in_darkmode&sanitize=true" align=middle width=47.19940334999999pt height=26.76175259999998pt/> zeros. Instead, we can acknowlede that
this matrix is [sparse](https://en.wikipedia.org/wiki/Sparse_matrix) and store
only the non-zeros along the diagonal.

Similarly, the matrix <img src="/tex/3a87475c442cbc1195190e8687bc1d80.svg?invert_in_darkmode&sanitize=true" align=middle width=44.357060549999986pt height=26.17730939999998pt/> has <img src="/tex/64560e95e7c73072649d794700d5fcfc.svg?invert_in_darkmode&sanitize=true" align=middle width=22.652310449999987pt height=21.18721440000001pt/> non-zeros (a <img src="/tex/c11fe0cea175e1b787b3403c763dc9b0.svg?invert_in_darkmode&sanitize=true" align=middle width=21.00464354999999pt height=21.18721440000001pt/> and <img src="/tex/e11a8cfcf953c683196d7a48677b2277.svg?invert_in_darkmode&sanitize=true" align=middle width=21.00464354999999pt height=21.18721440000001pt/> per edge)
and the other <img src="/tex/6a6a244d45a7c52adacfb0b3cfcafb16.svg?invert_in_darkmode&sanitize=true" align=middle width=67.04347815pt height=21.18721440000001pt/> entries are zero. Furthermore, the result of the product <img src="/tex/274cbe00364791ee073c3054b169ec9d.svg?invert_in_darkmode&sanitize=true" align=middle width=39.680247749999985pt height=27.91243950000002pt/> and by
extension <img src="/tex/f27a7bed3895c3f995921598e6b3d130.svg?invert_in_darkmode&sanitize=true" align=middle width=74.99604419999999pt height=26.17730939999998pt/> will mostly contain zeros. The number of non-zeros is
in fact <img src="/tex/4ec673c850255d1482f1ae9f8d97c166.svg?invert_in_darkmode&sanitize=true" align=middle width=70.17202664999998pt height=24.65753399999998pt/>. Large mass-spring systems tend to have <img src="/tex/c3d4945b05e5708192987aee3c345f9d.svg?invert_in_darkmode&sanitize=true" align=middle width=71.99846609999999pt height=24.65753399999998pt/> edges, so we
can happily think of the number of non-zeros as <img src="/tex/1f08ccc9cd7309ba1e756c3d9345ad9f.svg?invert_in_darkmode&sanitize=true" align=middle width=35.64773519999999pt height=24.65753399999998pt/>.

We've reduced the storage required from <img src="/tex/e103cb4afcb639eecf8fda6ff0e12731.svg?invert_in_darkmode&sanitize=true" align=middle width=43.02219404999999pt height=26.76175259999998pt/> to <img src="/tex/1f08ccc9cd7309ba1e756c3d9345ad9f.svg?invert_in_darkmode&sanitize=true" align=middle width=35.64773519999999pt height=24.65753399999998pt/>.  What's the catch?
General (or "dense") matrices can be easily mapped to memory linearly. For a an
arbitrary sparse matrix, we need store additional information to know _where_
each non-zero entry is. The most common general approach is to stored a sorted
list of values in each column (or row) of the matrix. This is a rather awkward
data-structure to manipulate directly. Similar to the pitfalls of [bubble
sort](https://en.wikipedia.org/wiki/Insertion_sort), inserting values one at a
time can be quite slow since we'd have to keep the lists sorted after each
operation. 

Because of this most sparse matrix libraries require (or prefer) to insert all
entries at once and presort non-zeros indices prefer creating the datastructure.
Friendly sparse matrix libraries like Eigen, will let us create a list list of
<img src="/tex/6df5ae9af75cbdd161c06e308727fe6c.svg?invert_in_darkmode&sanitize=true" align=middle width=48.41544014999999pt height=24.65753399999998pt/> triplets for each non-zero and then insert all values. 

So if our dense matrix code looked something like:

```
Afull = zero(m,n)
for each pair i j
  Afull(i,j) += v
end
```

> By convention we use `+=` instead of `=` to allow for repeated <img src="/tex/aa20264597f5a63b51587e0581c48f2c.svg?invert_in_darkmode&sanitize=true" align=middle width=33.46496009999999pt height=24.65753399999998pt/> pairs
> in the list. 

then we can replace this with 

```
triplet_list = []
for each pair i j
  triplet_list.append( i, j, v)
end
Asparse = construct_from_triplets( triplet_list )
```

> **Warning:**
>
> Do not attempt to set values of a sparse matrix directly. That is, **_do
> not_** write:
>
> ```
> A_sparse(i,j) = v
> ```
>

Storing only the non-zero entries means we must rewrite all basic matrix
operations including (matrix-vector product, matrix addition, matrix-matrix
product, transposition, etc.). This is outside the scope of our assignment and
we will use Eigen's `SparseMatrix` class.
 
Most important to our mass spring system is the _solve action_ discussed above.
Similar to the dense case, we can precompute a factorization and use
substitution at runtime. For our sparse matrix, these steps will
be <img src="/tex/e592823f1705f2f2adbee5645981be2e.svg?invert_in_darkmode&sanitize=true" align=middle width=63.75284354999998pt height=26.76175259999998pt/>, with substitution faster and nearly <img src="/tex/1f08ccc9cd7309ba1e756c3d9345ad9f.svg?invert_in_darkmode&sanitize=true" align=middle width=35.64773519999999pt height=24.65753399999998pt/>.

### Pinned Vertices

Subject to the external force of gravity in <img src="/tex/84278aca4a52c2b38bc81753120cdfd4.svg?invert_in_darkmode&sanitize=true" align=middle width=25.45666364999999pt height=26.085962100000025pt/> our spring networks
will just accelerate downward off the screen.

We can pin down vertices (e.g., those listed in `b`) at their intial positions,
by requiring that their corresponding positions values <img src="/tex/f13e5bc0860402c82f869bcf883eb8b0.svg?invert_in_darkmode&sanitize=true" align=middle width=15.15312644999999pt height=14.611878600000017pt/> are always forced
to be equal to their initial values <img src="/tex/2859ff4a8b95aa36e0a448368fdaf224.svg?invert_in_darkmode&sanitize=true" align=middle width=31.828838249999986pt height=26.085962100000025pt/>:

<p align="center"><img src="/tex/9df2286fdacf6e27b7482b5ab860fdc8.svg?invert_in_darkmode&sanitize=true" align=middle width=227.94200879999997pt height=17.9287383pt/></p>

There are various ways we can introduce this simple linear equality constraint
into the energy optimization above. For this assignment, we'll use the
easy-to-implement [penalty
method](https://en.wikipedia.org/wiki/Penalty_method). We will add an additional
quadratic energy term which is minimized when our pinning constraints are
satisfied:

<p align="center"><img src="/tex/23e0fc780c411db5a4bac693ed770ed0.svg?invert_in_darkmode&sanitize=true" align=middle width=227.5768638pt height=40.2074937pt/></p>

where the <img src="/tex/31fae8b8b78ebe01cbfbe2fe53832624.svg?invert_in_darkmode&sanitize=true" align=middle width=12.210846449999991pt height=14.15524440000002pt/> should be set to some large value (e.g., `w=1e10`). We can write this in matrix form as:

<p align="center"><img src="/tex/a8e5540721f67b7ce7add387fd2d4fdb.svg?invert_in_darkmode&sanitize=true" align=middle width=664.79360475pt height=32.990165999999995pt/></p>

where <img src="/tex/499f8b11566a62ae9b0a2f4b918744c0.svg?invert_in_darkmode&sanitize=true" align=middle width=112.73783729999998pt height=29.190975000000005pt/> has one row per pinned vertex with a
<img src="/tex/c11fe0cea175e1b787b3403c763dc9b0.svg?invert_in_darkmode&sanitize=true" align=middle width=21.00464354999999pt height=21.18721440000001pt/> in the corresponding column.

We can add these quadratic and linear coefficients to <img src="/tex/61ccc6d099c3b104d8de703a10b20230.svg?invert_in_darkmode&sanitize=true" align=middle width=14.20083224999999pt height=22.55708729999998pt/> and <img src="/tex/a10ec92d13e76a02b538967f6b90b345.svg?invert_in_darkmode&sanitize=true" align=middle width=10.502226899999991pt height=22.831056599999986pt/> above correspondingly.

## Tasks

### White List

- `Eigen::Triplet`

### Black List

- `igl::edge_lengths`
- `igl::diag`
- `igl::sparse`
- `igl::massmatrix`
- `.sparseView()` on `Eigen::MatrixXd` types

Write your dense code first. This will be simpler to debug.

### `src/signed_incidence_matrix_dense.cpp`

### `src/fast_mass_springs_precomputation_dense.cpp`

### `src/fast_mass_springs_step_dense.cpp`

At this point you should be able to run on small examples.

For example, running `./masssprings_dense ../data/single-spring-horizontal.json`
should produce a swinging, bouncing spring:

![](images/single-spring-horizontal.gif)

If the single spring example is not working, debug immediately before proceeding
to examples with more than one spring.

Running `./masssprings_dense ../data/horizontal-chain.json`
will produce a hanging [catenary chain](https://en.wikipedia.org/wiki/Catenary):

![](images/horizontal-chain.gif)

Running `./masssprings_dense ../data/net.json`
will produce a hanging [catenary chain](https://en.wikipedia.org/wiki/Catenary):

![](images/net.gif)

If you try to run `./masssprings_dense ../data/flag.json` you'll end up waiting
a while. 

Start your sparse implementations by copying-and-pasting your correct dense
code. Remove any dense operations and construct all matrices using triplet lists.

### `src/signed_incidence_matrix_sparse.cpp`

### `src/fast_mass_springs_precomputation_sparse.cpp`

### `src/fast_mass_springs_step_sparse.cpp`

Now you should be able to see more complex examples, such as running
`./masssprings_sparse ../data/flag.json` or `./masssprings_sparse ../data/skirt.json`:

![](images/skirt.gif)
