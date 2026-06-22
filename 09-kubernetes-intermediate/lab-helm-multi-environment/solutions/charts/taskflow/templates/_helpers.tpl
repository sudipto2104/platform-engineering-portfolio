{{- define "taskflow.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "taskflow.fullname" -}}
{{- printf "%s-%s" .Release.Name (include "taskflow.name" .) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "taskflow.labels" -}}
app.kubernetes.io/name: {{ include "taskflow.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: taskflow
environment: {{ .Values.global.environment }}
{{- end }}

{{- define "taskflow.api.labels" -}}
{{ include "taskflow.labels" . }}
app.kubernetes.io/component: api
{{- end }}

{{- define "taskflow.ui.labels" -}}
{{ include "taskflow.labels" . }}
app.kubernetes.io/component: ui
{{- end }}