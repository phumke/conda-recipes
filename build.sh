# Following the instructions found here:
# http://conda.pydata.org/docs/build_tutorials/pkgs2.html

Root_Path=~/anaconda3/conda-bld/

build_chartkick() {
    conda build chartkick

    conda convert --platform all $Root_Path/linux-64/chartkick-0.4.2-py35_0.tar.bz2 -o $Root_Path

    # force a reinstall to as a validation test
    conda uninstall chartkick --yes
    conda install --use-local --yes chartkick
}

build_chartkick

# anaconda login
# anaconda upload $Root_Path/linux-64/*
