"""Kubernetes client factory — in-cluster or kubeconfig."""

from __future__ import annotations

import os

from kubernetes import client, config
from kubernetes.config.config_exception import ConfigException


def load_k8s_config() -> None:
    """Load in-cluster config first, fall back to kubeconfig."""
    try:
        config.load_incluster_config()
    except ConfigException:
        kubeconfig = os.getenv("KUBECONFIG")
        if kubeconfig:
            config.load_kube_config(config_file=kubeconfig)
        else:
            config.load_kube_config()


def get_api_clients() -> tuple[client.CoreV1Api, client.AppsV1Api]:
    load_k8s_config()
    return client.CoreV1Api(), client.AppsV1Api()