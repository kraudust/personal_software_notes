```cpp
#include <iostream>
#include <Eigen/Core>
#include <Eigen/Geometry>

Eigen::Vector3d quaternionToEulerZYX(const Eigen::Quaterniond& quat) {
    // Convert quaternion to rotation matrix
    Eigen::Matrix3d rotationMatrix = quat.toRotationMatrix();

    // Extract Euler ZYX angles
    Eigen::Vector3d eulerZYX = rotationMatrix.eulerAngles(2, 1, 0); // ZYX order

    return eulerZYX;
}

int main() {
    // Specify quaternion coefficients
    Eigen::Quaterniond quaternion(0.5, 0.5, 0.5, 0.5); // Replace with your quaternion

    // Convert quaternion to Euler ZYX angles
    Eigen::Vector3d eulerZYX = quaternionToEulerZYX(quaternion);

    // Display the result
    std::cout << "Quaternion: " << quaternion.coeffs().transpose() << std::endl;
    std::cout << "Euler ZYX Angles: " << eulerZYX.transpose() << std::endl;

    return 0;
}
```

```cpp
#include <iostream>
#include <Eigen/Core>
#include <Eigen/Geometry>

Eigen::Quaterniond eulerZYXToQuaternion(double roll, double pitch, double yaw) {
    Eigen::AngleAxisd rollAngle(roll, Eigen::Vector3d::UnitX());
    Eigen::AngleAxisd pitchAngle(pitch, Eigen::Vector3d::UnitY());
    Eigen::AngleAxisd yawAngle(yaw, Eigen::Vector3d::UnitZ());

    Eigen::Quaterniond quaternion = yawAngle * pitchAngle * rollAngle;

    return quaternion;
}

int main() {
    // Specify Euler ZYX angles in radians
    double roll = 0* 90.0 * (M_PI / 180.0);    // Replace with your desired roll angle
    double pitch = 0.0;   // Replace with your desired pitch angle
    double yaw = 0*90.0 * (M_PI / 180.);     // Replace with your desired yaw angle

    // Convert Euler ZYX angles to quaternion
    Eigen::Quaterniond quaternion = eulerZYXToQuaternion(roll, pitch, yaw);

    // Display the result
    std::cout << "Euler ZYX Angles: (" << roll << ", " << pitch << ", " << yaw << ")\n";
    std::cout << "Quaternion: " << quaternion.coeffs()[0] << std::endl;
    std::cout << "Quaternion: " << quaternion.coeffs()[1] << std::endl;
    std::cout << "Quaternion: " << quaternion.coeffs()[2] << std::endl;
    std::cout << "Quaternion: " << quaternion.coeffs()[3] << std::endl;

    return 0;
}
```