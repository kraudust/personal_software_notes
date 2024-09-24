# transforms3d
```python
import transforms3d

# Convert euler angles to quaternion
# quat = [w, x, y, z]
quat = transforms3d.euler.euler2quat(roll, pitch, yaw, 'sxyz') # pass in radians

# Convert rotation matrix to quaternion
quat = transforms3d.quaternions.mat2quat(rotation_matrix) # 3x3 numpy 2d array

# Check for rotation equivelancy
orientation_close = transforms3d.quaternions.nearly_equivalent(qtarget, qcurrent, rotational_tolerance, rotational_tolerance)
```

# Rotation
```python
from scipy.spatial.transform import Rotation as rot

# Make a rotation object from a matrix
rotation_obj = rot.from_matrix(rotation_matrix) # 3x3 numpy 2d array

# Identity
rotation_obj = rot.identity()

# Make rotation object from a matrix
rotation_obj = rot.from_quat([quat.x, quat.y, quat.z, quat.w])

# Make rotation object from euler angles passed in in degrees
rotation_quat = rot.from_euler('xyz', [roll, pitch, yaw], degrees=True)

# Quat is form [x, y, z, w]
quat = rotation_object.as_quat()

# Get the 3x3 rotation matrix from the scipy Rotation object
rotation_matrix = rotation_obj.as_matrix()
```

# Create transformation matrix
```python
def create_transformation_matrix(rotation, translation):
    """Combines a scipy Rotation object and a translate vector into a 4x4 transformation matrix.

    Args:
        rotation: A scipy Rotation object representing the rotation.
        translation: A numpy array of shape (3,) representing the translation.

    Returns:
        transformation_matrix: A 4x4 numpy array representing the SE3 transformation matrix.
    """
    # Ensure the translation is a numpy array
    translation = np.asarray(translation)

    # Check the shape of the translation vector
    assert translation.shape == (3,), 'Translation vector must be of shape (3,)'

    # Get the 3x3 rotation matrix from the scipy Rotation object
    rotation_matrix = rotation.as_matrix()

    # Initialize the 4x4 transformation matrix
    transformation_matrix = np.eye(4)

    # Set the top-left 3x3 submatrix to the rotation matrix
    transformation_matrix[:3, :3] = rotation_matrix

    # Set the top-right 3x1 submatrix to the translation vector
    transformation_matrix[:3, 3] = translation

    return transformation_matrix
```

# Find transforms in transformation chain
```python
#TODO Adjust to not use ros2 types for transform storage
def get_transform(from_frame:str, to_frame:str, transforms:dict, logger):
    """ Finds the transform of from_frame relative to to_frame. Will work in either direction.

    Args:
        from_frame: The name of the frame you want to find the transform of
        to_frame: The name of the frame you want the transform relative to
        transforms: Dict of geometry_msgs.msg.TransformStamped with keys (parent, child)
        logger: rclpy logger

    Returns:
        translation: np array with x, y, z translation
        rotation: Spatial transform rotation object
    """
    try:
        # Try in the given direction
        trans, rotation = try_transform(from_frame, to_frame, transforms)
        return trans, rotation
    except:
        try:
            # If not found in the given direction, try in the reverse direction and invert
            trans, rotation = try_transform(to_frame, from_frame, transforms)
            from_frame_relto_to_frame = np.linalg.inv(create_transformation_matrix(
                    rotation, trans))
            return (from_frame_relto_to_frame[:3, 3],
                    rot.from_matrix(from_frame_relto_to_frame[:3, :3]))
        except:
            logger.error('Error finding transform')
            return None


def try_transform(from_frame:str, to_frame:str, transforms:dict):
    """
    Finds the transform of from_frame relative to to_frame. Only works down the robot chain
    (tip to base).

    Args:
        from_frame: The name of the frame you want to find the transform of
        to_frame: The name of the frame you want the transform relative to
        transforms: Dict of geometry_msgs.msg.TransformStamped with keys (parent, child)
        logger: rclpy logger

    Returns:
        translation: np array with x, y z translation
        rotation: Spatial transform rotation object
    """
    try:
        transform_chain = []
        current_frame = from_frame
        # Loop through transforms in tf chain building the chain of transforms in order
        while current_frame != to_frame:
            found = False
            for (parent, child), transform in transforms.items():
                if child == current_frame:
                    transform_chain.append(transform)
                    current_frame = parent
                    found = True
                    break
            if not found:
                raise Exception(f'No transform found from {from_frame} to {to_frame}')
        # Call the method to multiply all the transforms together
        return chain_transforms(transform_chain)
    except:
        return None


def chain_transforms(transforms:list):
    """Does the transformation math to find the resultant transform from a chain of transforms

    Args:
        transforms: List of geometry_msgs.msg.TransformStamped in order
                    (i.e. [link_7 relto link_6, link_6 relto link_5 .....])

    Returns:
        translation: np array with x, y z translation
        rotation: Spatial transform rotation object
    """
    translation = np.array([0.0, 0.0, 0.0])
    rotation = rot.identity()
    for transform in reversed(transforms):
        trans = transform.transform.translation
        rot_so3 = transform.transform.rotation
        translation += rotation.apply([trans.x, trans.y, trans.z])
        rotation = rotation * rot.from_quat([rot_so3.x, rot_so3.y, rot_so3.z, rot_so3.w])
    return translation, rotation
```

# spatialmath SE3 and SO3
```python
from spatialmath import SE3, SO3

# Can specify a transform with an SO3 object and translation
transform = SE3.Rt(SO3(),[0, 0, 0.1])

# Can specify rotation with roll pitch and yaw
rotation = SO3.RPY([math.pi/2, 0, math.pi/2])

# Can find angular distance between two transform or rotation objects
# In angdist note that metric 3 returns half the actual angle, so we multiply by 2
angle = se3_or_so3_obj1.angdist(se3_or_so3_obj2, metric=3) * 2.0

# Check if an SE3 is valid
SE3.isvalid(se3_object.A)
```