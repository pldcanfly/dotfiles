-- schema-companion source for Kubernetes manifests.
--
-- The plugin's built-in kubernetes matcher returns one per-kind schema for
-- every `apiVersion`/`kind` pair in the buffer and registers all of them for
-- the file. yamlls applies every registered schema to every document, so a
-- multi-document file (Deployment + Service) validates each document against
-- the other's schema and lights up with false positives.
--
-- yamlls has a dedicated Kubernetes mode instead: when the registered URI is
-- yannh's `<version>-standalone-strict/all.json` (that exact URL shape is what
-- its isKubernetes() check accepts) it picks the schema per document from
-- apiVersion/kind and falls back to the datreeio CRD catalog for CRDs. This
-- source keeps content-based detection but hands yamlls that one URL.

---@class schema_companion.Source
local M = {}

M.name = "Kubernetes"

M.config = {
	version = "master",
}

---@param config { version: string }
---@return schema_companion.Source
function M.setup(config)
	M.config = vim.tbl_deep_extend("force", {}, M.config, config or {})

	return M
end

---@param bufnr number
---@return boolean
local function looks_like_kubernetes(bufnr)
	local has_api_version, has_kind = false, false

	for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
		if line:match("^apiVersion:%s*%S") then
			has_api_version = true
		elseif line:match("^kind:%s*%S") then
			has_kind = true
		end

		if has_api_version and has_kind then
			return true
		end
	end

	return false
end

---@return schema_companion.Schema[]
function M:match(_, bufnr)
	if not looks_like_kubernetes(bufnr) then
		return {}
	end

	return {
		{
			name = ("Kubernetes [%s]"):format(self.config.version),
			uri = ("https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/%s-standalone-strict/all.json"):format(
				self.config.version
			),
			source = self.name,
		},
	}
end

return M
