```python
class ChildClass(BaseClass):
	def __init__(self, param1, param2, etc.):
		# Do init stuff
		self.param1 = param1
		# Initialize parent class
		super().__init__(self, base_param=..)
```