# pytest
## .ini files
See docs [here](https://docs.pytest.org/en/stable/). Can have a pytest .ini file in the top level of your workspace. See below for an example:
```python
[pytest]
testpaths = pytest_tests
# ignore deprecation warnings and add code coverage
addopts = -v -W ignore::DeprecationWarning --ignore=pytest_tests/tests_to_ignore --cov --cov-config=.coveragerc
```
Here’s how `.ini` files are typically used with pytest:

### 1. **Creating the `.ini` File**

You can create a file named `pytest.ini` in the root of your project directory. If pytest finds this file, it will automatically read the configurations from it.

### 2. **Basic Structure**

A typical `pytest.ini` file might look something like this:
```
[pytest]
addopts = -v --maxfail=3
testpaths = tests 
python_files = test_*.py 
python_classes = Test* 
python_functions = test_*
```

### 3. **Common Configuration Options**

- **`addopts`**: This option lets you specify additional command-line options that pytest should use by default. For example, `-v` for verbose mode or `--maxfail=3` to stop after three failures.
- **`testpaths`**: This specifies the directories where pytest will look for tests. If you don't specify this, pytest will search in the current directory and subdirectories.
- **`python_files`**: This defines a pattern for the test file names. By default, pytest looks for files that start with `test_`. You can customize this pattern.
- **`python_classes`**: Specifies the pattern for test class names. By default, pytest looks for classes starting with `Test`.
- **`python_functions`**: This specifies the pattern for test function names. By default, pytest looks for functions that start with `test_`.

### 4. **Example Use Case**

If you want to limit the number of tests that are run or make pytest more verbose, the `pytest.ini` file can look like this:
```
[pytest]
addopts = --maxfail=2 -v
```

This will make pytest stop after two test failures and provide verbose output for test results.

### 5. **Plugin Configuration**

You can also configure pytest plugins directly from the `.ini` file. For example, if you are using the `pytest-cov` plugin to measure code coverage:
```
[pytest]
addopts = --cov=my_module --cov-report=term
```

This configures pytest to use coverage reporting for the `my_module` package and output the coverage report to the terminal.

### 6. **Hierarchy of Configuration Files**

Pytest will use the first configuration file it finds in this order:

- `pytest.ini`
- `tox.ini`
- `setup.cfg`

These `.ini` files are a handy way to define and centralize configuration settings for running pytest across your project, avoiding the need to specify command-line options repeatedly.

## Test Examples
Pytest example, these tests would be put in a pytest_tests folder as specified in the .ini file. A good format is to have test_<filename>.py where filename is the name of the file the tests are for.

Can have a helper file with different assertion types. File below is pytest_helpers.py
```python
import numpy as np
import numpy.typing as npt
from spatialmath import SE3, SO3


def assert_poses_equal(pose_a: SE3, pose_b: SE3, lin_tol: float, ang_tol: float):
    """
    Check that pose_a matches pose_b.

    Args:
        pose_a: first pose in comparison
        pose_b: second pose in comparison
        lin_tol: linear tolerance in meters
        ang_tol: angular tolerance in degrees
    """
    # Get linear and angular differences between poses. Metric 3 for angdist provides half the actual
    #   angle so need to multiply by 2 to get the actual angle
    ang_dist = (abs(SO3(pose_a.R).angdist(pose_b.R, metric=3)) * 180.0 / np.pi) * 2.0 # degrees
    lin_dist = np.linalg.norm(pose_a.t - pose_b.t)

    # Verify poses are equal within linear and angular tolerances
    assert lin_dist < lin_tol
    assert ang_dist < ang_tol


def assert_array_equal(test_array: npt.ArrayLike, truth_array: npt.ArrayLike, tol: float):
    """
    Assert each element matches between two arrays.

    Args:
        test_array: array with test data
        truth_array: array with what test data should be
        tol: tolerance in same units as test_array/truth_array
    """
    for test, truth in zip(test_array, truth_array):
        assert abs(test - truth) < tol
```

```python
import pytest
from pytest_helpers import *

class Params:
    """Simple class to hold test parameters."""
    def __init__(self):
        self.default_tol = 1e-6
        self.ang_tol = 0.1 # Degrees
		# could also do more complicated things as needed in Params class like initializing a class you are testing, etc.
		self.test_class = TestClass()

@pytest.fixture
def params():
    """Fixture for passing test parameters to test functions."""
    test_params = Params()
    return test_params

def test_functionname(params):
    """Test that functionname is working as expected"""
    assert_array_equal(params.test_class.array1, params.test_class.array1,
                 params.default_tol)
    assert_poses_equal(params.test_class.pose_a, params.test_class.pose_b, params.default_tol, params.ang_tol)


if __name__ == '__main__':
    # Run pytest on this file
    pytest.main([__file__])
```


