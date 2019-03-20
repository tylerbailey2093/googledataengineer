#!/bin/bash
set -e
#SET VARIABLES
PORT=1080
PORTTWO=8123
HOSTNAME=datascience-dev-m
PROJECT=cloud-engineer-dev
ZONE=us-central1-a
BUCKET=cloud-engineer-dev

echo "Creating new Dataproc cluster..."

gcloud dataproc clusters create datascience-dev \
    --project=${PROJECT} \
    --bucket=${BUCKET} \
    --zone=${ZONE} \
    --master-machine-type n1-highmem-16 \
    --worker-machine-type n1-standard-8 \
    --num-workers 4 \
    --num-preemptible-workers 2 \
    --initialization-actions gs://dataproc-initialization-actions/jupyter/jupyter.sh, \
                         gs://dataproc-initialization-actions/conda/bootstrap-conda.sh, \
                         gs://dataproc-initialization-actions/conda/install-conda-env.sh, \
                         gs://dataproc-initialization-actions/connectors/connectors.sh \
    --metadata "gcs-connector-version=1.9.11" \ 
    --metadata "bigquery-connector-version=0.13.0" \ 
    --metadata "enable-cloud-sql-hive-metastore=false" 