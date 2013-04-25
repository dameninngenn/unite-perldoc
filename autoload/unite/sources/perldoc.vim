let s:source_perldoc = {
\   'name'           : 'perldoc',
\   'action_table'   : {},
\   'default_action' : {'common' : 'execute'}
\ }

function! s:source_perldoc.gather_candidates(args, context)
  let list = []
  let regexp = '^\s*use\s\zs\([^ ;]\+\)\ze'
  for line in getline(1, '$')
    if line =~# regexp
      let package_name = matchstr(line, regexp)
      call add(list, { 'word': package_name, 'source': 'perldoc', 'kind': 'common' })
    endif
  endfor
  return list
endfunction

let s:action_table = {}
let s:action_table.execute = {'description' : 'exec perldoc'}
function! s:action_table.execute.func(candidate)
  execute 'Perldoc ' . a:candidate.word
endfunction
let s:source_perldoc.action_table.common = s:action_table

function! unite#sources#perldoc#define()
  return s:source_perldoc
endfunction
