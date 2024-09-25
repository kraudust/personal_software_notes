There are several good libraries in C++ for SE(3) (Special Euclidean group) and SO(3) (Special Orthogonal group) transformations. Here are some popular ones:

1. Eigen
Website: [Eigen](https://eigen.tuxfamily.org)
Description: Eigen is a high-performance linear algebra library that includes support for transformations in SE(3) and SO(3). You can represent rotations using Eigen::Quaternion or Eigen::AngleAxis and perform rigid body transformations using Eigen::Affine3d or Eigen::Isometry3d.
Pros: Well-documented, fast, and widely used in the robotics and computer vision communities.
Cons: May require some manual coding for specialized transformation needs.
2. Sophus
GitHub: [Sophus](https://github.com/strasdat/Sophus)
Description: Sophus provides lightweight C++ implementations for SE(3) and SO(3) Lie groups. It's frequently used in robotics and computer vision applications. It supports exponential and logarithmic maps between Lie groups and their corresponding Lie algebras, which is especially useful in optimization problems.
Pros: Simple API for SE(3) and SO(3) transformations, with Lie group support.
Cons: Minimalistic library focused on Lie groups, so you might need to complement it with other libraries for more general linear algebra tasks.
3. g2o
GitHub: [g2o](https://github.com/RainerKuemmerle/g2o)
Description: g2o (General Graph Optimization) is widely used in SLAM (Simultaneous Localization and Mapping) and includes Lie algebra implementations for SE(3) and SO(3). It also supports optimization over these groups.
Pros: Optimized for graph-based problems (e.g., SLAM), supports SE(2), SE(3), and SO(3) transformations, integrates well with other libraries like Eigen.
Cons: More complex to use if you're just looking for basic transformation support.
4. ceres-solver
Website: [ceres-solver](http://ceres-solver.org/)
Description: Ceres is a large-scale, open-source optimization library. While its primary focus is on non-linear optimization, it also includes native support for SO(3) and SE(3) transformations through its ceres::Quaternion and ceres::Pose3 classes.
Pros: Great if you need optimization over SE(3) or SO(3) transforms. Works well for problems involving bundle adjustment, SLAM, and sensor fusion.
Cons: More complex and optimized for solving non-linear problems; not purely a transformation library.
5. Pinocchio
Website: [Pinocchio](https://gepettoweb.laas.fr/doc/stack-of-tasks/pinocchio/master/doxygen-html/)
Description: Pinocchio is a library for robotics and rigid body dynamics that includes tools for working with SE(3) and SO(3). It provides fast algorithms for forward and inverse kinematics and dynamics, built on top of Eigen.
Pros: Specialized in robotics applications, fast and efficient.
Cons: Heavier than some other options if you only need basic transformation operations.

Recommendations:
For general use: Eigen is often the go-to solution due to its broad feature set and performance.
For robotics and vision: Sophus or Pinocchio are great choices.
For SLAM and optimization: g2o or ceres-solver would be more appropriate.
These libraries are well-maintained and frequently used in the robotics, computer vision, and SLAM communities. Depending on your project needs, you can choose one that best fits your requirements.