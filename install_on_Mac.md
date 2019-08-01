# Install python for NEURON on Mac

## Requirements

1. Xcode

2. XQuartz

Download and install the most recent XQuartz dmg from http://xquartz.org and
run the following from command line:

```bash
defaults write org.macosforge.xquartz.X11 wm_ffm -bool true
```
Verify correct execution by running:
```bash
defaults read | grep ffm
```
You should see this output:
```bash
     "wm_ffm" = 1
```

3. Anaconda Python

Download the latest installer from https://www.anaconda.com/distribution/

_Note:_ It seems that Python must be build with the same C compiler as NEURON


## Install NEURON  from Source

1. Download source

Download the latest code (e.g. `iv-19.tar.gz` and `nrn-7.6.7.tar.gz`) from the [NEURON homepage](https://www.neuron.yale.edu/neuron/getstd).

Make a new sub directory in your home folder, e.g. `neuron_python` and copy the tar files to that location.

2. Install Interviews

In that sub-directory execute the following commands:

```bash
N=`pwd`
tar xzf iv-19.tar.gz 
mv iv-19 iv
cd iv
./configure --prefix=`pwd`
make
make install
```

_Important Note:_ Renaming the extracted directory makes things easier for the installation of NEURON.

3. Install NEURON

```bash
cd ..
tar xzf nrn-7.6.7.tar.gz 
mv nrn-7.6 nrn
cd nrn
./configure --prefix=`pwd` --with-iv=$N/iv --with-nrnpython PYLIB=-lpython PYLIBLINK=-lpython
make
make install
export PATH=$N/nrn/x86_64/bin:$PATH
```

_Note:_ Without the extracted directory, the Finder cannot find `nrniv` when executing `nrndemo` or `nrngui`.

## Make avaible to Python

1. Create a clean python environment:

```bash
# conda create --name p27neuron python=2.7
# conda activate p27neuron 
```

_Note:_ The full anaconda python has some packages installed that lead to a problem
with the version number, and sub-package hoc27 cannot be found.

2. Install additional packages, e.g. Jupyter:

```bash
pip install jupyter
```

3. Install neuron for Python package

Run the installation script:

```bash
cd src/nrnpython/
python setup.py install
```

4. Check

Search for `neuron` in the list of installed packages:
```bash
conda list
```

## Testing

Make sure to activate the conda environment:
```bash
conda activate p27neuron
```

### NEURON

Start NEURON with the build-in Python as shell:

```bash
./nrniv -python
```

Import of the  package using `import neuron` should work.

### Python

Start Python:

```bash
python
```

Import of the package using `import neuron` should work.

### Jupyter notebook

Start Jupyter:

```bash
jupyter notenbook
```

Start a new notebook in the browser interface.
Import of the package using `import neuron` should work.


