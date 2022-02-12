FROM ubcdsci/jupyterlab
#new package
RUN pip3 install nibabel pydicom matplotlib pillow
