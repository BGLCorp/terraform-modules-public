#!/bin/bash

CURRENT_CONTEXT=$(kubectl config current-context | tr -d '\n')

if [[ "${CURRENT_CONTEXT}" = *${1} ]]; then
    echo "Current context '${CURRENT_CONTEXT}' ends with the input '${1}'"
else
    echo -e "\n\n==============================================================\n\nCurrent context '${CURRENT_CONTEXT}' does not end with the input '${1}'\n\n!!!!!!!! CHANGE YOU KUBECTL CONTEXT BEFORE PROCEEDING !!!!!!!!\n\n==============================================================\n\n"
    exit 1
fi
