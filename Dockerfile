FROM fastcore:latest
ENV FASTAI2_DIR="${FASTAI_DIR}/fastai2"
COPY --chown=fast:fast ./environment.yml ${FASTAI2_DIR}/environment.yml
COPY --chown=fast:fast ./setup.py ${FASTAI2_DIR}/setup.py
COPY --chown=fast:fast ./README.md ${FASTAI2_DIR}/README.md
COPY --chown=fast:fast ./settings.ini ${FASTAI2_DIR}/settings.ini
WORKDIR ${FASTAI2_DIR}
RUN /home/fast/anaconda3/envs/fastai2/bin/python3.6 -m pip install -e ".[dev]" && \
  conda install -n fastai2  pyarrow && \
  /home/fast/anaconda3/envs/fastai2/bin/python3.6 -m pip uninstall -y "Pillow>7" && \
  /home/fast/anaconda3/envs/fastai2/bin/python3.6 -m pip install "Pillow<7" && \
  /home/fast/anaconda3/envs/fastai2/bin/python3.6 -m pip install nbdev pydicom kornia opencv-python scikit-image && \
  /home/fast/anaconda3/envs/fastai2/bin/python3.6 -m ipykernel install --user --name fastai2 --display-name "Python (fastai2)"
COPY --chown=fast:fast . ${FASTAI2_DIR}
RUN conda develop -n fastai2 ${FASTAI2_DIR}/fastai2
RUN conda list -n fastai2
#CMD ["tail","-f","/dev/null"]
#RUN . /home/fast/anaconda3/etc/profile.d/conda.sh && \
#    conda activate fastai2 && \
#  conda install -yc pytorch -c fastai pytorch fastai jupyter && \
#  pip install jupyter_contrib_nbextensions fire sklearn && \
#  pip install typeguard jupyter_nbextensions_configurator && \
#  jupyter contrib nbextension install --user && \
#  conda install -c fastai -c pytorch jupyter "pytorch>=1.2.0" torchvision matplotlib pandas re#quests pyyaml  pillow && \
#  conda install -c conda-forge tensorboard  && \
#  conda install -c anaconda absl-py && \
#  pip install wandb && \
#WORKDIR ${FASTAI2_DIR}
