{{/* Allow KubeVersion to be overridden. */}}
{{- define "metersphere.kubeVersion" -}}
  {{- default .Capabilities.KubeVersion.Version .Values.kubeVersionOverride -}}
{{- end -}}
{{/* Get Ingress API Version */}}
{{- define "metersphere.ingress.apiVersion" -}}
  {{- if .Capabilities.APIVersions.Has "networking.k8s.io/v1" -}}
    {{- print "networking.k8s.io/v1" -}}
  {{- else if .Capabilities.APIVersions.Has "networking.k8s.io/v1beta1" -}}
    {{- print "networking.k8s.io/v1beta1" -}}
  {{- else -}}
    {{- print "extensions/v1beta1" -}}
  {{- end -}}
{{- end -}}
{{- define "metersphere.ingress.service" -}}
{{- if .Capabilities.APIVersions.Has "networking.k8s.io/v1" -}}
- pathType: ImplementationSpecific
  backend:
    service:
      name: metersphere-server
      port:
        number: 8081
{{- else -}}
- backend:
    serviceName: metersphere-server
    servicePort: 8081
{{- end -}}
{{- end -}}
