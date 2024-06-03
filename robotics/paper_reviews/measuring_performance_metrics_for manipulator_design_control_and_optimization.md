```toc
title: Table of Contents
```
# Methodology
Desire to have meaningful and consistent metrics throughout the field, but generic metrics often can't capture everything needed.

## Pose Dependency: Global and Local Metrics
- Global index is independent from robot's motion variables
- Local index is function of robot's current configuration and could result in different value for each point of the workspace
- Global indices are often some sort of statistic run on local indices
	- If reported alone, can miss gradients of behavior

## Task Dependency: Intrinsic and Extrinsic Metrics
- Intrinsic index: function of robot's parameters only (Jacobian, link dimensions, etc.), task invariant
- Extrinsic metrics: depends on task parameters like trajectory

## Physics: Kinematic, Static, and Dynamic Metrics
- Kinematic metrics: just looks at kinematics, Jacobian based kinematics very successful
- Static and Dynamic metrics:
	- Dynamic: Affected by inertial characteristics. Related to payload, power, comsumption, etc.
	- Static: Used when inertial effects can be safely neglected

## Index Anatomy
- Absolute metrics - absolute metric value with units (N, kg, m/s, etc.)
- Relative metrics - usually obtained from an absolute index by dividing by a reference value, so they are unitless
- TODO: I don't quite get their point about absolute metrics being hard to understand. They seem better to me.

# Standard Metrics
Usually, these are on data sheets, and are global and intrinsic. Not as useful for characterizing performance in desired operation.

![[Pasted image 20240528083143.png]]

# Kinematic Performance
Depend on geometric and motion parameters, doesn't consider forces, torques, or inertial properties.

Does include motion limits, collision avoidance, max speeds, accelerations, etc. 

![[Pasted image 20240528083143.png]]

## Precision
- Accuracy
- Repeatability
- Resolution

## Workspace
- Workspace Volume: Reported both directly through shape of robot's workspace and indirectly through joint limits)
	- Alone, doesn't do a great job at representing performance in workspace, sometimes defined as operationsal workspace largest cylinder, sphere, etc. inscribed in reachable workspace
- Workspace Index: Compares robot's workspace to desired operational volume. Workspace is discretized and then index calculated as workspace over desired discretized volume. WSI = n_ws / n_obj
## Jacobian
- Manipulability index
- Condition number
- Global conditioning index

## Statics
performance under load for slow operations, force transmission , stiffness, power consumption, etc.

- Global transmission index: cosine of pressure angle which is defined as the angle between the transmission wrench screw and the output twist screw TODO: I don't quite get this
- Stiffness matrix:
	- Cartesian stiffness matrix Kc evaluated defelction at end effector caused by wrench f as f = Kc * delta_x
	- joint space stiffness matrix Tau = K_th * delta_q
## Dynamics
generalize static formulations by considering inertial effects
- Dynamic manipulability index: expanded manipulability index to include inertia matrix M
	- ![[Pasted image 20240528092311.png]]
- Energy consumption

# Optimization
Any of the performance metrics can be used as an objective function of an optimization problem

For optimizing one metric, it's an easy problem, but with multiple metrics becomes a multi-objective optimization and identifying the pareto front becomes the challenge

# Takeaway
There isn't currently a standard set of benchmarks for this, address metrics with a structured systematic approach, and focus on using existing metrics, rather than creating new ones.

Look into output inertia vs. input inertia

