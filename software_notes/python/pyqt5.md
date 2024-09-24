```python
from PyQt5.QtWidgets import QApplication, QVBoxLayout, QPushButton, QWidget, QHBoxLayout, QCheckBox

class ExampleWindow(QWidget):
	def __init__(self):
		super().__init__()
		self.set_number = 0
		layout = QVBoxLayout()
		self.button1 = QPushBUtton('Set Number to 1')
		self.button1.clicked.connect(self._button1_function)
		layout.addWidget(self.button1)

		h_layout1 = QHBoxLayout()
		self.button2 = QPushBUtton('Set Number to 2')
		self.button2.clicked.connect(self._button2_function)
		h_layout1.addWidget(self.button2)
		self.button3 = QPushBUtton('Set Number to 3')
		self.button3.clicked.connect(self._button3_function)
		h_layout1.addWidget(self.button3)
		self.checkbox1 = QCheckBox("Check Me")
		hlayout_1.addWidget(self.checkbox1)
		layout.addLayout(hlayout_1)

	def _button1_function(self):
		# do whatever you want the button to do
		self.set_number = 1

	def _button2_function(self):
		# do whatever you want the button to do
		self.set_number = 2
	
	def _button3_function(self):
		# do whatever you want the button to do
		self.set_number = 3

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = ExampleWindow()
    app.exec()
```