-- Remaps for the Dasht plugin

-- searches related docset to current file 
vim.keymap.set("n", "<leader>k", ":Dasht<Space>") 
-- searches all docsets 
vim.keymap.set("n", "<leader><leader>k", ":Dasht!<Space>") 

-- below are possible mappings for the dasht plugin 
--
--
-- search docsets for selected text 

-- " search related docsets
-- vnoremap <silent> <Leader>K y:<C-U>call Dasht(getreg(0))<Return>

-- " search ALL the docsets
-- vnoremap <silent> <Leader><Leader>K y:<C-U>call Dasht(getreg(0), '!')<Return>

-- below section is specifying related docsets for searching 

-- let g:dasht_filetype_docsets = {} " filetype => list of docset name regexp

-- " For example: {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

--   " When in Elixir, also search Erlang:
--   let g:dasht_filetype_docsets['elixir'] = ['elixir', 'erlang']

--   " When in C++, also search C, Boost, and OpenGL:
--   let g:dasht_filetype_docsets['cpp'] = ['cpp', '^c$', 'boost', 'OpenGL']

--   " When in Python, also search NumPy, SciPy, and Pandas:
--   let g:dasht_filetype_docsets['python'] = ['python', '(num|sci)py', 'pandas']

--   " When in HTML, also search CSS, JavaScript, Bootstrap, and jQuery:
--   let g:dasht_filetype_docsets['html'] = ['html', 'css', 'js', 'bootstrap']

--   " When in Java, search Java SE11, but not JavaScript:
--   let g:dasht_filetype_docsets['java'] = ['java_se11']

-- " and so on... }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}" create window below current one (default)
--
--
--
-- configure where results are displayed 
-- let g:dasht_results_window = 'new'

-- " create window beside current one
-- let g:dasht_results_window = 'vnew'

-- " use current window to show results
-- let g:dasht_results_window = 'enew'

-- " create panel at left-most edge
-- let g:dasht_results_window = 'topleft vnew'

-- " create panel at right-most edge
-- let g:dasht_results_window = 'botright vnew'

-- " create new tab beside current one
-- let g:dasht_results_window = 'tabnew'}}}}}}}}}}}




