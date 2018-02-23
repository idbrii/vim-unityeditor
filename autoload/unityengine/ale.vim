" Setup Ale linting system to work with Unity
" https://github.com/w0rp/ale

function! unityengine#ale#setup_ale(path_to_unity_project)
    if has("win32")
        let g:ale_cs_mcsc_assemblies = [ expand('$ProgramFiles/Unity/Editor/Data/Managed/UnityEngine.dll') ]
    elseif has("macos")
        let g:ale_cs_mcsc_assemblies = [ '/Applications/Unity/Unity.app/Contents/Frameworks/Managed/UnityEngine.dll' ]
    else
        " TODO: Guessing at Linux location
        let g:ale_cs_mcsc_assemblies = [ '/opt/UnityBeta/Editor/Data/Managed/UnityEngine.dll' ]
    endif
    let g:ale_cs_mcsc_assemblies += [ expand(a:path_to_unity_project .'/obj/Debug') ]
    if !executable('mcs')
        echomsg "You need Mono installed to use Ale for linting."
        echomsg "Mono that comes with Unity does not provide mcs."
        if has("win32")
            echomsg "If you have Mono installed and in your path, you may be hit by #1370. To work around it, add to your path:"
            exec 'echomsg "'. expand('<sfile>:h:h:h') .'/bin"'
        endif
    endif
endf

