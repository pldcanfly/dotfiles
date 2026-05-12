---@type vim.lsp.Config
return {
   cmd = { "yaml-language-server", "--stdio" },
   filetypes = { "yaml", "yaml.gitlab", "yaml.docker-compose" },
   root_markers = { ".git" },
   settings = {
      yaml = {
         validate = true,
         hover = true,
         completion = true,
         schemaStore = { enable = false, url = "" },
         schemas = require("schemastore").yaml.schemas({
            extra = {
               {
                  name = "Kubernetes 1.33 (strict)",
                  url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.33.0-standalone-strict/all.json",
                  fileMatch = { "*.yaml", "*.yml" },
               },
               {
                  name = "ArgoCD Application",
                  url = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json",
                  fileMatch = { "argocd/**/*.yaml", "**/argo-apps/**/*.yaml" },
               },
               {
                  name = "cert-manager Certificate",
                  url = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/cert-manager.io/certificate_v1.json",
                  fileMatch = { "**/certificates/*.yaml" },
               },
               {
                  name = "Prometheus ServiceMonitor",
                  url = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/monitoring.coreos.com/servicemonitor_v1.json",
                  fileMatch = { "**/servicemonitors/*.yaml" },
               },
            },
         }),
      },
   },
}
