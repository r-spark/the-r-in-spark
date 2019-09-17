FROM mlverse/mlverse-base:version-0.0.1

COPY ./excersises ${HOME}/excersises

USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
