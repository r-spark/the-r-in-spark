FROM jluraschi/multiverse-k8s:version-0.0.2

COPY ./excersises ${HOME}/excersises

USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
