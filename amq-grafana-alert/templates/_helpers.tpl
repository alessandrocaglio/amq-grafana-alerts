{{/*
Expand the name of the chart.
*/}}
{{- define "amq-grafana-alert.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "amq-grafana-alert.fullname" -}}
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
Create chart name and version as used by the chart label.
*/}}
{{- define "amq-grafana-alert.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "amq-grafana-alert.labels" -}}
helm.sh/chart: {{ include "amq-grafana-alert.chart" . }}
{{ include "amq-grafana-alert.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "amq-grafana-alert.selectorLabels" -}}
app.kubernetes.io/name: {{ include "amq-grafana-alert.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "amq-grafana-alert.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "amq-grafana-alert.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create dashboard name with namespace and service.
*/}}
{{- define "amq-grafana-alert.dashboard-name" -}}
{{- printf "%s-%s-qa" .Values.monitoredNamespace .Values.service | replace "*" "" | replace "." "" | replace "--" "-" | trunc 63 | trimSuffix "-" }}
{{- end }}
