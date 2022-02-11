local _M = {
  terminal = os.getenv('TERMINAL') or 'kitty',
  editor = os.getenv('EDITOR') or 'nvim',
  browser = 'firefox',
  power_manager = 'xfce4-power-manager-settings'
}

_M.editor_cmd = _M.terminal .. ' -e ' .. _M.editor
_M.manual_cmd = _M.terminal .. ' - man awesome'

return _M
