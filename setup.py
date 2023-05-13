from setuptools import setup, Extension
from Cython.Build import cythonize

extensions = [Extension('functions', ["src/functions/functions.pyx"])]

setup(
    name='functions module',
    ext_modules=cythonize(extensions),
    zip_safe=False,
    version="1.0.0"
)
