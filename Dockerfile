FROM ubcdsci/jupyterlab
#new packages
RUN pip3 install nibabel pydicom matplotlib pillow
