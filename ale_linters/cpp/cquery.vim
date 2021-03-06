" Author: Ben Falconer <ben@falconers.me.uk>
" Description: A language server for C++

call ale#Set('cpp_cquery_executable', 'cquery')
call ale#Set('cpp_cquery_cache_directory', expand('~/.cache/cquery'))

function! ale_linters#cpp#cquery#GetProjectRoot(buffer) abort
    let l:project_root = ale#path#FindNearestFile(a:buffer, 'compile_commands.json')

    return !empty(l:project_root) ? fnamemodify(l:project_root, ':h') : ''
endfunction

function! ale_linters#cpp#cquery#GetInitializationOptions(buffer) abort
    return {'cacheDirectory': ale#Var(a:buffer, 'cpp_cquery_cache_directory')}
endfunction

call ale#linter#Define('cpp', {
\   'name': 'cquery',
\   'lsp': 'stdio',
\   'executable_callback': ale#VarFunc('cpp_cquery_executable'),
\   'command': '%e',
\   'project_root_callback': 'ale_linters#cpp#cquery#GetProjectRoot',
\   'initialization_options_callback': 'ale_linters#cpp#cquery#GetInitializationOptions',
\})
