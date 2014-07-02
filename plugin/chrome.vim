if exists("g:loaded_ChromeRepl") || &cp
  finish
endif
let g:loaded_ChromeRepl = 1

let s:plugindir = expand('<sfile>:p:h')

function! ChromeRepl_SendToChrome() range
  let tonode = join(getline(a:firstline, a:lastline), "\n")
  let script = s:plugindir . '/repl.js'
  python import vim, subprocess
  python p=subprocess.Popen(["node", vim.eval('script')], stdin=subprocess.PIPE, stdout=subprocess.PIPE)
  python p.stdin.write(vim.eval('tonode'))
  python p.stdin.close()
  let result = pyeval('p.stdout.read()')

  if bufwinnr(bufnr("__JSOUT__")) == -1
    " Open a new split and set it up.
    botright 14split __JSOUT__
    execute "setlocal filetype=text"
    execute "setlocal nonumber"
    execute "setlocal norelativenumber"
    setlocal buftype=nofile
  else
    exe bufwinnr(bufnr("__JSOUT__")) . "wincmd w"
  endif

  execute "setlocal noreadonly"
  normal! ggdG
  call append(line('$'), split(result, '\v\n'))
  execute "setlocal readonly"
  exe "wincmd w"
endfunction

