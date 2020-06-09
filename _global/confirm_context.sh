#!/bin/bash

CURRENT_CONTEXT=$(kubectl config current-context | tr -d '\n')

if [[ "${CURRENT_CONTEXT}" = "" ]]; then
    echo "No current context => No issues"
    exit 0
fi

if [[ "${CURRENT_CONTEXT}" = *${1} ]]; then
    if [[ "${CURRENT_CONTEXT}" = *${2}* ]]; then
        echo "Current context '${CURRENT_CONTEXT}' ends with the input '${1}' and has the right account id ${2}"
    else
        echo -e "\n\n==============================================================\n\nCurrent context '${CURRENT_CONTEXT}' does not contain the right account ID '${2}'\n\n!!!!!!!! CHANGE YOU KUBECTL CONTEXT BEFORE PROCEEDING !!!!!!!!\n\n==============================================================\n\n"
        exit 1
    fi
else
    echo -e "\n\n==============================================================\n\nCurrent context '${CURRENT_CONTEXT}' does not end with the input '${1}'\n\n!!!!!!!! CHANGE YOU KUBECTL CONTEXT BEFORE PROCEEDING !!!!!!!!\n\n==============================================================\n\n"
    exit 1
fi
