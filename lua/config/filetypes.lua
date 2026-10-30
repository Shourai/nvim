-- Extra filetype detection
vim.filetype.add({
  extension = {
    -- otherwise empty new .tf files are detected as TinyFugue
    tf = "terraform",
  },
  pattern = {
    -- Ansible playbooks, roles and inventory vars (ansiblels attaches to yaml.ansible)
    [".*/playbooks?/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
    [".*/group_vars/.*"] = "yaml.ansible",
    [".*/host_vars/.*"] = "yaml.ansible",
    ["playbook.*%.ya?ml"] = "yaml.ansible",
    ["site%.ya?ml"] = "yaml.ansible",
  },
})
