FROM continuumio/miniconda3

# Install Jupyter, JupterLab, R & the IRkernel
RUN conda install --yes --quiet --channel conda-forge \
    jupyter \
    jupyterlab \
    r-base=4.1.1 \
    r-irkernel

# Install JupyterLab Git Extension
RUN pip install jupyterlab-git

# Create working directory for mounting volumes
RUN mkdir -p /opt/notebooks

# Make port 8888 available for JupyterLab
EXPOSE 8888

# Install Git, the nano-tiny text editor and less (needed for R help)
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    git \
    nano-tiny \
    less

# Copy JupyterLab start-up script into container
COPY start-notebook.sh sn\sn

#new package of xgbboost
RUN git clone --recursive https://github.com/dmlc/xgboost && \
    cd xgboost && \
    make -j4 && \
    cd python-package; python setup.py install

# Change permission of startup script and execute it
RUN chmod +x sn/snstart-notebook.sh
ENTRYPOINT ["sn/snstart-notebook.sh"]

# Switch to staring in directory where volumes will be mounted
WORKDIR "/sn"
