# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

{{/*
Expand the name of the helm.
*/}}
{{- define "fluent-bit-syslog-to-aws-cloudtrail-data.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains helm name it will be used as a full name.
*/}}
{{- define "fluent-bit-syslog-to-aws-cloudtrail-data.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create helm name and version as used by the helm label.
*/}}
{{- define "fluent-bit-syslog-to-aws-cloudtrail-data.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "fluent-bit-syslog-to-aws-cloudtrail-data.labels" -}}
helm.sh/chart: {{ include "fluent-bit-syslog-to-aws-cloudtrail-data.chart" . }}
{{ include "fluent-bit-syslog-to-aws-cloudtrail-data.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "fluent-bit-syslog-to-aws-cloudtrail-data.selectorLabels" -}}
app.kubernetes.io/name: {{ include "fluent-bit-syslog-to-aws-cloudtrail-data.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fluent-bit-syslog-to-aws-cloudtrail-data.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "fluent-bit-syslog-to-aws-cloudtrail-data.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
