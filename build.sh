# Following the instructions found here:
# http://conda.pydata.org/docs/build_tutorials/pkgs2.html

set -e

root_path=~/anaconda3/conda-bld/
python_vers=py35_0
os=linux-64

get_tar_path() {
    package=${1}
    version=${2}

    tar_path=$root_path/$os/$package-$version-$python_vers.tar.bz2
}

build() {
    package=${1}
    version=${2}

    conda build $package

    get_tar_path $package $version

    conda convert --platform all $tar_path -o $root_path

    # force a reinstall to as a validation test
    # only uninstall if it exists - ugly hack as grep returns an error if nothing matched
    set +e
    conda list | grep $package | grep $version
    found=$?
    set -e

    if [ "$found" -eq 0 ]; then
        conda uninstall --yes $package=$version
    fi

    conda install --use-local --yes $package=$version
}

# Build order was determined by resolving the dependency tree prior to need, then in alphabetical order

# alembic dependencies
# build python-editor 0.5

# flask-admin dependencies
# build wtforms 2.1.0

# Needed by airflow
# build alembic 0.8.5
# build babel 1.3
# build chartkick 0.4.2
# build croniter 0.3.12
# build dill 0.2.5
# build flask-admin 1.4.0
# build flask-cache 0.13.1
# build gunicorn 19.3.0
# build setproctitle 1.1.9
# build thrift 0.9.3
build flask-wtf 0.12


# anaconda login
# anaconda upload $root_path/linux-64/*
