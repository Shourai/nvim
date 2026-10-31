-- Extra filetype detection
vim.filetype.add({
  extension = {
    -- otherwise empty new .tf files are detected as TinyFugue
    tf = "terraform",
  },
  pattern = {
    -- Ansible content (ansiblels, ansible-lint and yamllint attach to yaml.ansible).
    -- Lua patterns have no alternation, so each role directory is listed separately.
    [".*/playbooks?/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/[^/]+/tasks/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/[^/]+/handlers/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/[^/]+/defaults/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/[^/]+/vars/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/[^/]+/meta/.*%.ya?ml"] = "yaml.ansible",
    -- group_vars/host_vars: YAML files, or extensionless ones (group_vars/all, all/vault);
    -- .json files there keep the json filetype
    [".*/group_vars/.*%.ya?ml"] = "yaml.ansible",
    [".*/group_vars/[^.]*"] = "yaml.ansible",
    [".*/host_vars/.*%.ya?ml"] = "yaml.ansible",
    [".*/host_vars/[^.]*"] = "yaml.ansible",
    ["playbook.*%.ya?ml"] = "yaml.ansible",
    ["site%.ya?ml"] = "yaml.ansible",
  },
})
