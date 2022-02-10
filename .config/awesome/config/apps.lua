local _M = {
  terminal = os.getenv('TERMINAL') or 'kitty',
  editor = os.getenv('EDITOR') or 'nvim',
  browser = 'firefox'
}

_M.editor_cmd = _M.terminal .. ' -e ' .. _M.editor
_M.manual_cmd = _M.terminal .. ' - man awesom'

return _M
