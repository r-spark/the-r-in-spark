FROM jluraschi/multiverse-k8s:latest

RUN rm ~/*
COPY ./excersises ${HOME}
