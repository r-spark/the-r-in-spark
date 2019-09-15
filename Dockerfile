FROM jluraschi/multiverse-k8s:version-0.0.1

RUN rm ~/*
COPY ./excersises ${HOME}
