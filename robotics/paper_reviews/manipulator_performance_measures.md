```toc
title: Table of Contents
```
# Manipulator Workspace as a Performance Index
## Reachable position workspace
Set of points that can be reached by a reference point on a manipulator with at least one orientation and does not include singular points where the manipulator loses DOF
## Dexterous Workspace / Full Orientation Angle Workspace
A point is approachable in all directions. For any point here, end effector can be completed rotated about any axis through that point.
## Orientation Angle Workspace
Set of angle ranges with which the end-effector can reach with a certain orientation for any point in the reachable position workspace.
## Partial Orientation Angle Workspace
Space in which a point can be approached by a range of angles less than 360 degrees
## Operating Volume
Total volume of space occupied by all links when reaching every point int eh workspace
## Workspace Index
Nodes that can be reached divided by nodes in the objective space

# Joint Performance Indices
## Service Angle and Service Sphere
TODO: I don't fully get this one
## Dexterity Index
Volume within which every point can be reached by the manipulator end-effector with any desired orientation.

At a single point, also defined as a measure of a manipulator to achieve varying orientations at that point.
## Joint Range Availability
Measure of how centered a joint stays in it's joint range?

# Manipulability Measures
## Jacobian limitations to be aware of
Performance indices based on jacobian are most accurate when manipulator consists of same type of dof (either prismatic or revolute, not mixed)

Also a note about not mixing the translational and rotational elements of the jacobian, or if you do to use a characteristic length TODO: How often is this done?

## Manipulability Index
Proposed by Yoshikawa and widely used
mu = sqrt(det(J * J^T))

TODO: paper says that the manipulability index does not represent a measure of distance from a singularity. Why?

### Limitations
- Unit dependency
- dimensional dependancey (combining translating and rotating joints)
- Not bounded, so only serves as relative measure of degree of conditioning of manipulator at a given point when compared to other points in workspace




